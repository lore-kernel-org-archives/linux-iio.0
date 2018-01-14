Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752306AbeANLpc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jan 2018 06:45:32 -0500
Date: Sun, 14 Jan 2018 11:45:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marc CAPDEVILLE <m.capdeville@no-log.org>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/4] i2c-smbus : Add client discovered ARA support
Message-ID: <20180114114526.1ca2f5ff@archlinux>
In-Reply-To: <20180113133705.25044-1-m.capdeville@no-log.org>
References: <20180113133705.25044-1-m.capdeville@no-log.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 13 Jan 2018 14:37:02 +0100
Marc CAPDEVILLE <m.capdeville@no-log.org> wrote:

> This is from rfc by Alan Cox : https://patchwork.ozlabs.org/patch/381773
> 
> The idea is as follows (extract from above rfc) :
> - If an adapter knows about its ARA and smbus alerts then the adapter
>   creates its own interrupt handler as before
> 
> - If a client knows it needs smbus alerts it calls
>   i2c_require_smbus_alert(). This ensures that there is an ARA handler
>   registered and tells the client whether the adapter is handling it
>   anyway or not.
> 
> - When the client learns that an ARA event has occurred it calls
>   i2c_smbus_alert_event() which uses the existing ARA mechanism to kick
>   things off.
> 
> In addition, if a client have an irq line to trigger smbus alert, client
> driver register its irq with i2c_smbus_alert_add_irq() to the smbus alert
> driver to use the generic alert interrupt handler. On detach, the client
> must unregister its irq from the smbus alert driver with
> i2c_smbus_alert_free_irq().

A trivial comment inline...

Also, I think this whole thing could do with some documentation as it is
a little 'unusual'  :)

Perhaps put a cover letter explaining how whole series has changed as
well.

Jonathan

> 
> Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
> ---
>  drivers/i2c/i2c-core-smbus.c |  42 +++++++++++
>  drivers/i2c/i2c-smbus.c      | 171 +++++++++++++++++++++++++++++++++++++++++--
>  include/linux/i2c-smbus.h    |  22 ++++++
>  include/linux/i2c.h          |   2 +
>  4 files changed, 232 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index 1238c94fe5a1..0d84ac9669e9 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -659,6 +659,48 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
>  }
>  EXPORT_SYMBOL_GPL(i2c_setup_smbus_alert);
>  
> +/**
> + * i2c_require_smbus_alert - Client discovered SMBus alert
> + * @client: client requiring ARA support
> + *
> + * When a client needs an ARA it calls this method. If the bus adapter
> + * supports ARA and already knows how to do so then it will already have
> + * configured for ARA and this is a no-op. If not then we set up an ARA
> + * on the adapter.
> + *
> + * Return:
> + *	0 if ARA support already registered
> + *	1 if call register a new smbus_alert device
> + *	<0 on error
> + */
> +int i2c_require_smbus_alert(struct i2c_client *client)
> +{
> +	struct i2c_adapter *adapter = client->adapter;
> +	struct i2c_smbus_alert_setup setup;
> +	struct i2c_client *ara;
> +	int ret;
> +
> +	if (adapter->smbus_ara) {
> +		/*
> +		 * ARA is already known and handled by the adapter (ideal case)
> +		 * or another client has specified ARA is needed
> +		 */
> +		ret = 0;
> +	} else {
> +		/* First client requesting alert and no adapter has
> +		 * has setup one
> +		 */
> +		setup.irq = 0;
> +		ara = i2c_setup_smbus_alert(adapter, &setup);
> +		if (!ara)
> +			return -ENODEV;
> +		ret = 1;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(i2c_require_smbus_alert);
> +
>  #if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_OF)
>  int of_i2c_setup_smbus_alert(struct i2c_adapter *adapter)
>  {
> diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> index 5a1dd7f13bac..1699333ac950 100644
> --- a/drivers/i2c/i2c-smbus.c
> +++ b/drivers/i2c/i2c-smbus.c
> @@ -25,9 +25,16 @@
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
>  
> +struct i2c_smbus_irq_usage {
> +	struct list_head	list;
> +	int			irq;
> +	int			count;
> +};
> +
>  struct i2c_smbus_alert {
>  	struct work_struct	alert;
>  	struct i2c_client	*ara;		/* Alert response address */
> +	struct list_head	irq_usage;	/* irq usage list */
>  };
>  
>  struct alert_data {
> @@ -126,6 +133,124 @@ static void smbalert_work(struct work_struct *work)
>  
>  }
>  
> +/**
> + * i2c_smbus_alert_add_irq - Add a new irq handler to ARA client
> + * @client: The client which want to add an smbus alert irq handler
> + * @irq: The irq number to be added to the smbus alert device
> + * return: 0 if irq handler already exist, 1 if a new handler has been
> + *	   registered, <0 on error
> + *
> + * This is used by the smbalert_probe and by smbus client to check if an
> + * irq handler already exist for that irq and if not register a new one
> + * Clients must free their irq with i2c_smbus_alert_free_irq() on driver
> + * detach.
> + */
> +int i2c_smbus_alert_add_irq(struct i2c_client *client, int irq)
> +{
> +	int res;
> +	struct i2c_smbus_irq_usage *irq_usage;
> +	struct i2c_client *ara;
> +	struct i2c_smbus_alert *alert;
> +
> +	ara = client->adapter->smbus_ara;
> +	if (!ara)
> +		return -EINVAL;
> +
> +	alert = i2c_get_clientdata(client->adapter->smbus_ara);
> +	if (!alert)
> +		return -EINVAL;
> +
> +	if (!irq)
> +		return 0;
> +
> +	/* Check if handler exist for that irq */
> +	list_for_each_entry(irq_usage, &alert->irq_usage, list)
> +		if (irq_usage->irq == irq)
> +			break;
> +
> +	if (irq_usage->irq == irq) {
> +		irq_usage->count++;
> +	} else {
> +		/* setup a new handler for that irq */
> +		res = devm_request_threaded_irq(&ara->dev, irq,
> +						NULL, smbus_alert,
> +						IRQF_SHARED | IRQF_ONESHOT,
> +						"smbus_alert", alert);
> +		if (res)
> +			return res;
> +
> +		/* Add adapter irq number to used irq list with a count of 1 */
> +		irq_usage = devm_kmalloc(&ara->dev,
> +					 sizeof(struct i2c_smbus_irq_usage),
> +					 GFP_KERNEL);
> +		INIT_LIST_HEAD(&irq_usage->list);
> +		irq_usage->irq = irq;
> +		irq_usage->count = 1;
> +		list_add(&irq_usage->list, &alert->irq_usage);
> +
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +EXPORT_SYMBOL_GPL(i2c_smbus_alert_add_irq);
> +
> +/**
> + * i2c_smbus_alert_free_irq - free irq added with i2c_smbus_alert_add_irq()
> + * @client: The client which want to free its smbus alert irq
> + * @irq: The irq number to be freed
> + * return: 0 if irq handler still exist for other client,
> + *	   1 if client is the last one using this handler and handler have been
> + *	     removed,
> + *	   <0 on error.
> + *
> + * This is used by smbus clients to free their irq usage from smbus alert
> + * device.
> + */
> +int i2c_smbus_alert_free_irq(struct i2c_client *client, int irq)
> +{
> +	struct i2c_smbus_irq_usage *irq_usage;
> +	struct i2c_client *ara;
> +	struct i2c_smbus_alert *alert;
> +
> +	ara = client->adapter->smbus_ara;
> +	if (!ara)
> +		return -EINVAL;
> +
> +	alert = i2c_get_clientdata(client->adapter->smbus_ara);
> +	if (!alert)
> +		return -EINVAL;
> +
> +	if (!irq)
> +		return 0;
> +
> +	/* Check if handler exist for that irq */
> +	list_for_each_entry(irq_usage, &alert->irq_usage, list)
> +		if (irq_usage->irq == irq)
> +			break;
> +
> +	if (irq_usage->irq == irq) {
> +		irq_usage->count--;
> +		if (!irq_usage->count) {
/* 
 * usage
> +			/* usage count goes to 0
> +			 * so remove irq_usage from list
> +			 */
> +			list_del(&irq_usage->list);
> +			devm_kfree(&ara->dev, irq_usage);
> +
> +			/* remove irq handler */
> +			devm_free_irq(&ara->dev, irq, alert);
> +
> +			return 1;
> +		}
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(i2c_smbus_alert_free_irq);
> +
>  /* Setup SMBALERT# infrastructure */
>  static int smbalert_probe(struct i2c_client *ara,
>  			  const struct i2c_device_id *id)
> @@ -151,16 +276,18 @@ static int smbalert_probe(struct i2c_client *ara,
>  	INIT_WORK(&alert->alert, smbalert_work);
>  	alert->ara = ara;
>  
> +	INIT_LIST_HEAD(&alert->irq_usage);
> +
> +	i2c_set_clientdata(ara, alert);
> +
> +	ara->adapter->smbus_ara = ara;
> +
>  	if (irq > 0) {
> -		res = devm_request_threaded_irq(&ara->dev, irq,
> -						NULL, smbus_alert,
> -						IRQF_SHARED | IRQF_ONESHOT,
> -						"smbus_alert", alert);
> +		res = i2c_smbus_alert_add_irq(ara, irq);
>  		if (res)
>  			return res;
>  	}
>  
> -	i2c_set_clientdata(ara, alert);
>  	dev_info(&adapter->dev, "supports SMBALERT#\n");
>  
>  	return 0;
> @@ -172,6 +299,9 @@ static int smbalert_remove(struct i2c_client *ara)
>  	struct i2c_smbus_alert *alert = i2c_get_clientdata(ara);
>  
>  	cancel_work_sync(&alert->alert);
> +
> +	ara->adapter->smbus_ara = NULL;
> +
>  	return 0;
>  }
>  
> @@ -210,6 +340,37 @@ int i2c_handle_smbus_alert(struct i2c_client *ara)
>  }
>  EXPORT_SYMBOL_GPL(i2c_handle_smbus_alert);
>  
> +/**
> + * i2c_smbus_alert_event
> + * @client: the client who known of a probable ARA event
> + * Context: can't sleep
> + *
> + * Helper function to be called from an I2C device driver's interrupt
> + * handler. It will schedule the alert work, in turn calling the
> + * corresponding I2C device driver's alert function.
> + *
> + * It is assumed that client is an i2c client who previously call
> + * i2c_require_smbus_alert().
> + *
> + * return: <0 on error
> + */
> +int i2c_smbus_alert_event(struct i2c_client *client)
> +{
> +	struct i2c_client *ara;
> +	struct i2c_smbus_alert *alert;
> +
> +	ara = client->adapter->smbus_ara;
> +	if (!ara)
> +		return -EINVAL;
> +
> +	alert = i2c_get_clientdata(ara);
> +	if (!alert)
> +		return -EINVAL;
> +
> +	return schedule_work(&alert->alert);
> +}
> +EXPORT_SYMBOL_GPL(i2c_smbus_alert_event);
> +
>  module_i2c_driver(smbalert_driver);
>  
>  MODULE_AUTHOR("Jean Delvare <jdelvare@suse.de>");
> diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
> index fb0e040b1abb..cf777f29cc79 100644
> --- a/include/linux/i2c-smbus.h
> +++ b/include/linux/i2c-smbus.h
> @@ -47,6 +47,7 @@ struct i2c_smbus_alert_setup {
>  
>  struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
>  					 struct i2c_smbus_alert_setup *setup);
> +int i2c_require_smbus_alert(struct i2c_client *client);
>  int i2c_handle_smbus_alert(struct i2c_client *ara);
>  
>  #if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_OF)
> @@ -58,4 +59,25 @@ static inline int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_I2C_SMBUS)
> +int i2c_smbus_alert_add_irq(struct i2c_client *client, int irq);
> +int i2c_smbus_alert_free_irq(struct i2c_client *client, int irq);
> +int i2c_smbus_alert_event(struct i2c_client *client);
> +#else
> +static inline int i2c_smbus_alert_add_irq(struct i2c_client *client, int irq)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int i2c_smbus_alert_free_irq(struct i2c_client *client, int irq)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int i2c_smbus_alert_event(struct i2c_client *client)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
>  #endif /* _LINUX_I2C_SMBUS_H */
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 5d7f3c1853ae..7592dce12923 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -652,6 +652,8 @@ struct i2c_adapter {
>  	const struct i2c_adapter_quirks *quirks;
>  
>  	struct irq_domain *host_notify_domain;
> +
> +	struct i2c_client *smbus_ara;	/* ARA client address if any or NULL */
>  };
>  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
>  

