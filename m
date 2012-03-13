Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-216.synserver.de ([212.40.185.216]:1195 "EHLO
	smtp-out-213.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751885Ab2CMNha (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Mar 2012 09:37:30 -0400
Message-ID: <4F5F4E16.5020305@metafoo.de>
Date: Tue, 13 Mar 2012 14:39:34 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com,
	Marten Svanfeldt <marten@intuitiveaerial.com>
Subject: Re: [PATCH] IIO: trigger: Add hrtimer trigger
References: <1331644737-27822-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1331644737-27822-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/13/2012 02:18 PM, Lars-Peter Clausen wrote:
>[...]
> + static int __devinit iio_trig_hrtimer_probe(struct platform_device *pdev)
> +{
> [...]
> +
> +err_put_trigger:
> +	iio_put_trigger(trig);

Looking a bit closer a how iio triggers are managed I think I need to call
iio_free_trigger here instead of iio_put_trigger.

> +
> +	return ret;
> +}
> +
> +static int __devexit iio_trig_hrtimer_remove(struct platform_device *pdev)
> +{
> +	struct iio_hrtimer_trig_info *trig_info = platform_get_drvdata(pdev);
> +	struct iio_trigger *trig = trig_info->trigger;
> +
> +	hrtimer_cancel(&trig_info->timer);
> +	iio_trigger_unregister(trig);
> +

And I think here a iio_free_trigger is missing as well.
But it looks as if the existing trigger driver suffer from similar issues.

> +	return 0;
> +}
> +


