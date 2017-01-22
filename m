Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40570 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdAVOZM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 09:25:12 -0500
Subject: Re: [PATCH v2] iio: trigger: free trigger resource correctly
To: Alison Schofield <amsfield22@gmail.com>
References: <20170120034730.GA8864@d830.WORKGROUP>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8cf25699-4e6b-21cc-af4d-01212279ecd4@kernel.org>
Date: Sun, 22 Jan 2017 14:25:09 +0000
MIME-Version: 1.0
In-Reply-To: <20170120034730.GA8864@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/01/17 03:47, Alison Schofield wrote:
> These stand-alone trigger drivers were using iio_trigger_put()
> where they should have been using iio_trigger_free().  The
> iio_trigger_put() adds a module_put which is bad since they
> never did a module_get.
> 
> In the sysfs driver, module_get/put's are used as triggers are
> added & removed. This extra module_put() occurs on an error path
> in the probe routine (probably rare).
> 
> In the bfin-timer & interrupt trigger drivers, the module resources
> are not explicitly managed, so it's doing a put on something that
> was never get'd.  It occurs on the probe error path and on the
> remove path (not so rare).
> 
> Tested with the sysfs trigger driver.
> The bfin & interrupt drivers were build tested & inspected only.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
This is certainly more consistent. 
Lars, could you sanity check as well given the bfin timer is
in here.

Thanks,

Jonathan
> ---
> Changes in v2:
> Renamed probe jump label to say free instead of put.
> Added further explanation to commit log.
> 
> Note from v1:
> Patches to use devm_* funcs are ready to follow this for
> the interrupt & bfin-timer triggers.
> 
> 
>  drivers/iio/trigger/iio-trig-interrupt.c          | 8 ++++----
>  drivers/iio/trigger/iio-trig-sysfs.c              | 2 +-
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
> index 572bc6f..e18f12b 100644
> --- a/drivers/iio/trigger/iio-trig-interrupt.c
> +++ b/drivers/iio/trigger/iio-trig-interrupt.c
> @@ -58,7 +58,7 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>  	trig_info = kzalloc(sizeof(*trig_info), GFP_KERNEL);
>  	if (!trig_info) {
>  		ret = -ENOMEM;
> -		goto error_put_trigger;
> +		goto error_free_trigger;
>  	}
>  	iio_trigger_set_drvdata(trig, trig_info);
>  	trig_info->irq = irq;
> @@ -83,8 +83,8 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>  	free_irq(irq, trig);
>  error_free_trig_info:
>  	kfree(trig_info);
> -error_put_trigger:
> -	iio_trigger_put(trig);
> +error_free_trigger:
> +	iio_trigger_free(trig);
>  error_ret:
>  	return ret;
>  }
> @@ -99,7 +99,7 @@ static int iio_interrupt_trigger_remove(struct platform_device *pdev)
>  	iio_trigger_unregister(trig);
>  	free_irq(trig_info->irq, trig);
>  	kfree(trig_info);
> -	iio_trigger_put(trig);
> +	iio_trigger_free(trig);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
> index 3dfab2b..202e8b8 100644
> --- a/drivers/iio/trigger/iio-trig-sysfs.c
> +++ b/drivers/iio/trigger/iio-trig-sysfs.c
> @@ -174,7 +174,7 @@ static int iio_sysfs_trigger_probe(int id)
>  	return 0;
>  
>  out2:
> -	iio_trigger_put(t->trig);
> +	iio_trigger_free(t->trig);
>  free_t:
>  	kfree(t);
>  out1:
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index 9658f20..4e0b4ee 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -260,7 +260,7 @@ static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
>  out1:
>  	iio_trigger_unregister(st->trig);
>  out:
> -	iio_trigger_put(st->trig);
> +	iio_trigger_free(st->trig);
>  	return ret;
>  }
>  
> @@ -273,7 +273,7 @@ static int iio_bfin_tmr_trigger_remove(struct platform_device *pdev)
>  		peripheral_free(st->t->pin);
>  	free_irq(st->irq, st);
>  	iio_trigger_unregister(st->trig);
> -	iio_trigger_put(st->trig);
> +	iio_trigger_free(st->trig);
>  
>  	return 0;
>  }
> 

