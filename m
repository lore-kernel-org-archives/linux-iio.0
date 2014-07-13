Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52158 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229AbaGMJEc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 13 Jul 2014 05:04:32 -0400
Message-ID: <53C24C25.5070805@kernel.org>
Date: Sun, 13 Jul 2014 10:06:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/8] iio: accel: bma180: Remove indio_dev->trig assignment
References: <1405098739-25470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1405098739-25470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/07/14 18:12, Srinivas Pandruvada wrote:
> This can result in wrong reference count for trigger device, leave the binding
> to user space via current_trigger sysfs entry.
> Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
> with Jonathan.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
The issue here is that this is a userspace ABI change.  I'd have love
to not have had these there in the first place, but now they are.
I think a better change would be to simply add a call to iio_trigger_get
in all these cases. That way it's effectively the same as the
> ---
>   drivers/iio/accel/bma180.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index a7e68c8..1595065 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -569,7 +569,6 @@ static int bma180_probe(struct i2c_client *client,
>   	trig->ops = &bma180_trigger_ops;
>   	iio_trigger_set_drvdata(trig, indio_dev);
>   	data->trig = trig;
> -	indio_dev->trig = trig;
>
>   	ret = iio_trigger_register(trig);
>   	if (ret)
>

