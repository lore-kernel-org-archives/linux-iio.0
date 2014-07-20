Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:40867 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaGTPg4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Jul 2014 11:36:56 -0400
Message-ID: <53CBE2A4.6080709@kernel.org>
Date: Sun, 20 Jul 2014 16:39:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 6/6] iio: accel: kxcjk-1013: Increment ref counter for
 indio_dev->trig
References: <1405557754-19601-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1405557754-19601-6-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1405557754-19601-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/07/14 01:42, Srinivas Pandruvada wrote:
> Assigning indio_dev->trig is not a good idea, as this can result in
> wrong reference count for trigger device. If assigned, it is better to
> increment reference counter by calling iio_trigger_get.
> Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
> with Jonathan.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
I've parked the intervening patches to allow time for the runtime pm one
to sit on the list.

This one is a bug fix (and should have been earlier in the series!).
I've applied it to the togreg branch of iio.git.

Lars is of course correct that we could do this in a nicer fashion, but
I'd rather get the simple fix in place and tidy up later, than delay it
now.

Jonathan
> ---
>   drivers/iio/accel/kxcjk-1013.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index f5bb682..40ecf8b 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1020,6 +1020,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
>   		iio_trigger_set_drvdata(trig, indio_dev);
>   		data->trig = trig;
>   		indio_dev->trig = trig;
> +		iio_trigger_get(indio_dev->trig);
>
>   		ret = iio_trigger_register(trig);
>   		if (ret)
>

