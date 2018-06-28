({
    startListening: function (component, event, helper) {


    	var accounts = component.get("c.getRefreshedAccount");

    	accounts.setCallback(this, function(a){
    		component.set("v.acc", a.getReturnValue());
    	});
        //enqueueAction é necessário para disparar ações
    	$A.enqueueAction(accounts);

        var sessionAction = component.get("c.getUserSession");

        sessionAction.setCallback(this, function (a) {
            var sid = a.getReturnValue();

            $.cometd.init({
                url: '/cometd/39.0',
                requestHeaders: {Authorization: 'OAuth ' + sid},
                appendMessageTypeToURL: false,
                logLevel: [ "warn" | "info" | "debug"]
            });
            // subscribe = retorno do Canal
            $.cometd.subscribe('/topic/RefreshAccounts', $A.getCallback(function (message) {

            	console.log(message);

            	var toastEvent = $A.get("e.force:showToast");
		        toastEvent.setParams({
		            "title": "Novo cliente criado!",
		            "message": "Veja o Painel",
		            "type": "informational",
		            "duration" : 1000
		        });
		        toastEvent.fire();

                var sEvent = $A.get("e.c:StreamingAPIEvent");

                sEvent.setParams({
                    topic: 'The Topic',
                    data: message.data.sobject,
                    event: message.data.event
                }).fire();

                $A.get('e.force:refreshView').fire();


                var accounts = component.get("c.getRefreshedAccount");

		    	accounts.setCallback(this, function(a){
		    		component.set("v.acc", a.getReturnValue());
		    		document.getElementById('noty').play();
		    	});

		    	$A.enqueueAction(accounts);

            }));
            // Retorno de status da conexão
            $.cometd.addListener('/meta/connect', this, function(message){
            	console.log(message);
            });

            window.onbeforeunload = function () {
                $.cometd.disconnect();
            };
        });

        $A.enqueueAction(sessionAction);

    },
    handleShowNotificationEvent: function (component, event, helper) {

        var data = event.getParam('data') || '';

        if($A.util.isEmpty(data)){
            return;
        }

    }
})