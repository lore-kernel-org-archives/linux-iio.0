Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34136 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352Ab2DXIWF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Apr 2012 04:22:05 -0400
Message-ID: <4F9662A8.5020905@kernel.org>
Date: Tue, 24 Apr 2012 09:22:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] Move RTC trigger to in-core frequency support
References: <1334851538-21408-1-git-send-email-maxime.ripard@free-electrons.com> <1334851538-21408-3-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1334851538-21408-3-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/19/2012 5:05 PM, Maxime Ripard wrote:

The irony here is that I was going to suggest we droped this driver entirely
as I didn't think anyone was using it!  Guess they are given you've gone
to the effort of cleaning it up.

One trivial change inline. Otherwise looks good.
> Signed-off-by: Maxime Ripard<maxime.ripard@free-electrons.com>
> ---
>   .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   50 ++++----------------
>   1 files changed, 10 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> index a80cf67..ffabf80 100644
> --- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> +++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> @@ -24,7 +24,6 @@ static DEFINE_MUTEX(iio_prtc_trigger_list_lock);
>
>   struct iio_prtc_trigger_info {
>   	struct rtc_device *rtc;
> -	int frequency;
>   	struct rtc_task task;
>   };
>
> @@ -37,50 +36,19 @@ static int iio_trig_periodic_rtc_set_state(struct iio_trigger *trig, bool state)
>   	return rtc_irq_set_state(trig_info->rtc,&trig_info->task, state);
>   }
>
> -static ssize_t iio_trig_periodic_read_freq(struct device *dev,
> -					   struct device_attribute *attr,
> -					   char *buf)
> +static int update_infos(struct iio_trigger *trig, const unsigned long mask)
>   {
> -	struct iio_trigger *trig = dev_get_drvdata(dev);
>   	struct iio_prtc_trigger_info *trig_info = trig->private_data;
> -	return sprintf(buf, "%u\n", trig_info->frequency);
> -}
> -
> -static ssize_t iio_trig_periodic_write_freq(struct device *dev,
> -					    struct device_attribute *attr,
> -					    const char *buf,
> -					    size_t len)
> -{
> -	struct iio_trigger *trig = dev_get_drvdata(dev);
> -	struct iio_prtc_trigger_info *trig_info = trig->private_data;
> -	unsigned long val;
> -	int ret;
> -
> -	ret = strict_strtoul(buf, 10,&val);
> -	if (ret)
> -		goto error_ret;
> -
> -	ret = rtc_irq_set_freq(trig_info->rtc,&trig_info->task, val);
> -	if (ret)
> -		goto error_ret;
> -
> -	trig_info->frequency = val;
>
> -	return len;
> -
> -error_ret:
> -	return ret;
> +	switch (mask) {
> +	case IIO_TRIGGER_INFO_FREQUENCY:
> +		return rtc_irq_set_freq(trig_info->rtc,&trig_info->task,
> +					trig->frequency);
> +	default:
return -EINVAL.  Any other write is an error, not a clean return. Of course
it can't happen, but still best to be clear we aren't happy if it does!
> +		return 0;
> +	}
>   }
>
> -static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR,
> -	    iio_trig_periodic_read_freq,
> -	    iio_trig_periodic_write_freq);
> -
> -static struct attribute *iio_trig_prtc_attrs[] = {
> -	&dev_attr_frequency.attr,
> -	NULL,
> -};
> -
>   static const struct attribute_group iio_trig_prtc_attr_group = {
>   	.attrs = iio_trig_prtc_attrs,
>   };
> @@ -99,6 +67,7 @@ static void iio_prtc_trigger_poll(void *private_data)
>   static const struct iio_trigger_ops iio_prtc_trigger_ops = {
>   	.owner = THIS_MODULE,
>   	.set_trigger_state =&iio_trig_periodic_rtc_set_state,
> +	.update_infos =&iio_trig_periodic_rtc_update_infos,
>   };
>
>   static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
> @@ -124,6 +93,7 @@ static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
>   			ret = -ENOMEM;
>   			goto error_put_trigger_and_remove_from_list;
>   		}
> +		trig->info_mask = IIO_TRIGGER_INFO_FREQUENCY;
>   		trig->private_data = trig_info;
>   		trig->ops =&iio_prtc_trigger_ops;
>   		/* RTC access */

