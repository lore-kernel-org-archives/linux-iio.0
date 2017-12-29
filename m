Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751067AbdL2NEL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 08:04:11 -0500
Date: Fri, 29 Dec 2017 13:04:06 +0000
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
Subject: Re: [PATCH v6 2/4] i2c-smbus : Add client discovered ARA support
Message-ID: <20171229130406.195d0f55@archlinux>
In-Reply-To: <20171225155723.6338-2-m.capdeville@no-log.org>
References: <20171225155723.6338-1-m.capdeville@no-log.org>
        <20171225155723.6338-2-m.capdeville@no-log.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 25 Dec 2017 16:57:21 +0100
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

A few minor things inline.  I'm not sure the balance between what is
done in driver and what is in the core is quite right yet.

Jonathan

> 
> Suggested-by: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
> ---
>  drivers/i2c/i2c-smbus.c   | 83 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c-smbus.h | 15 +++++++++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> index 5a1dd7f13bac..e97fbafd10ef 100644
> --- a/drivers/i2c/i2c-smbus.c
> +++ b/drivers/i2c/i2c-smbus.c
> @@ -161,6 +161,9 @@ static int smbalert_probe(struct i2c_client *ara,
>  	}
>  
>  	i2c_set_clientdata(ara, alert);
> +
> +	ara->adapter->smbus_ara = ara;
> +
>  	dev_info(&adapter->dev, "supports SMBALERT#\n");
>  
>  	return 0;
> @@ -172,6 +175,9 @@ static int smbalert_remove(struct i2c_client *ara)
>  	struct i2c_smbus_alert *alert = i2c_get_clientdata(ara);
>  
>  	cancel_work_sync(&alert->alert);
> +
> +	ara->adapter->smbus_ara = NULL;
> +
>  	return 0;
>  }
>  
> @@ -210,6 +216,83 @@ int i2c_handle_smbus_alert(struct i2c_client *ara)
>  }
>  EXPORT_SYMBOL_GPL(i2c_handle_smbus_alert);
>  
> +/*
/** It looks like kernel doc to me.
> + * i2c_require_smbus_alert - Client discovered SMBus alert
> + * @c: client requiring ARA
> + *
> + * When a client needs an ARA it calls this method. If the bus adapter
> + * supports ARA and already knows how to do so then it will already have
> + * configured for ARA and this is a no-op. If not then we set up an ARA
> + * on the adapter.
> + *
> + * We *cannot* simply register a new IRQ handler for this because we might
> + * have multiple GPIO interrupts to devices all of which trigger an ARA.
I'm a little confused by this comment.  Do you mean:

1. Same gpio irq is provided as as shared irq to a number of devices?
(In this case we are just aiming not to register the same IRQ multiple times
as each driver may have already done it?)  If it is this case, I think we
should be pushing the irq register and checking logic to the smbus core which
can then verify if it is the same interrupt or not? (could be case 2 below
in which case we need to register another handler).

2. Different gpio irqs provided to a number of devices on same bus with
   each acting as ARA interrupt?  (this is hideous so I hope not - but
   I would be surprised if we never see a board doing this)

> + *
> + * Return:
> + *	0 if ara support already registered
> + *	1 if call register a new smbus_alert device
> + *	<0 on error
> + */
> +int i2c_require_smbus_alert(struct i2c_client *client)
> +{
> +	struct i2c_adapter *adapter = client->adapter;
> +	struct i2c_smbus_alert_setup setup;
> +	struct i2c_client *ara;
> +
> +	/* ARA is already known and handled by the adapter (ideal case)

/*
 * ARA

> +	 * or another client has specified ARA is needed
> +	 */
> +	if (adapter->smbus_ara)
> +		return 0;
> +
> +	/* Client driven, do not set up a new IRQ handler */
> +	setup.irq = 0;
> +
> +	ara = i2c_setup_smbus_alert(adapter, &setup);
> +	if (!ara)
> +		return -ENODEV;
> +
> +	return 1;
> +}
> +EXPORT_SYMBOL_GPL(i2c_require_smbus_alert);
> +
> +/*

Fix this up (needs a short description) and make it kernel-doc /**

> + * i2c_smbus_alert_event
> + * @client: the client who known of a probable ara event
> + * Context: can't sleep
> + *
> + * Helper function to be called from an I2C device driver's interrupt
> + * handler. It will schedule the alert work, in turn calling the
> + * corresponding I2C device driver's alert function.
> + *
> + * It is assumed that client is an i2c client who previously call
> + * i2c_require_smbus_alert().
> + */
> +int i2c_smbus_alert_event(struct i2c_client *client)
> +{
> +	struct i2c_adapter *adapter;
> +	struct i2c_client *ara;
> +	struct i2c_smbus_alert *alert;
> +
> +	if (!client)
> +		return -EINVAL;
> +
> +	adapter = client->adapter;
> +	if (!adapter)
> +		return -EINVAL;
> +
> +	ara = adapter->smbus_ara;
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
> index fb0e040b1abb..49f362fa6ac5 100644
> --- a/include/linux/i2c-smbus.h
> +++ b/include/linux/i2c-smbus.h
> @@ -58,4 +58,19 @@ static inline int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_I2C_SMBUS)
> +int i2c_require_smbus_alert(struct i2c_client *client);
> +int i2c_smbus_alert_event(struct i2c_client *client);
> +#else
> +static inline int i2c_require_smbus_alert(struct i2c_client *client)
> +{
> +	return NULL;
> +}
> +
> +static inline int i2c_smbus_alert_event(struct i2c_client *client)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  #endif /* _LINUX_I2C_SMBUS_H */

