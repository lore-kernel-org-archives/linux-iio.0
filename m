Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-166.synserver.de ([212.40.185.166]:1032 "EHLO
	smtp-out-165.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753221Ab3I1KMG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2013 06:12:06 -0400
Message-ID: <5246ABDB.5090005@metafoo.de>
Date: Sat, 28 Sep 2013 12:13:47 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:trigger: Added iio-hrtimer-trigger
References: <1380014789-8636-1-git-send-email-denis.ciocca@st.com> <1380014789-8636-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1380014789-8636-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/24/2013 11:26 AM, Denis CIOCCA wrote:
> This patch adds high resolution timer trigger support for iio framework.
> 

I think the driver is mostly fine (a couple of minor comments inline). But
maybe we should give some more though how we want to deal with the creation
and deletion of software triggers like this one. Half of the code in this
drivers is boiler plate code copied from the sysfs trigger and is dealing
with creating and deleting the triggers.

[...]
> diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
> index 0694dae..4e1876d 100644
> --- a/drivers/iio/trigger/Makefile
> +++ b/drivers/iio/trigger/Makefile
> @@ -5,3 +5,4 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
>  obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
> +obj-$(CONFIG_IIO_HRTIMER_TRIGGER) += iio-trig-hrtimer.o

Alphabetical order, please.

[...]
> +static ssize_t iio_hrtimer_trigger_set_freq_value(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	int ret;
> +	u16 frequency;
> +	struct iio_trigger *trig = to_iio_trigger(dev);
> +	struct iio_hrtimer_trigger_data *trig_data =
> +						iio_trigger_get_drvdata(trig);
> +
> +	ret = kstrtou16(buf, 10, &frequency);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (frequency > MAX_UNSIGNED_INT16)

Will never be true with frequency being a u16.

> +		return -EINVAL;
> +
> +	trig_data->freq = frequency;
> +
> +	if (frequency)
> +		trig_data->period =
> +				ktime_set(0, NSEC_PER_SEC / trig_data->freq);
> +
> +	return len;
> +}
[...]
> +
> +enum hrtimer_restart iio_hrtimer_trigger_func(struct hrtimer *timer)
> +{
> +	struct iio_hrtimer_trigger_data *trig_data;
> +
> +	trig_data = container_of(timer, struct iio_hrtimer_trigger_data, timer);
> +
> +	hrtimer_forward_now(timer, trig_data->period);
> +	iio_trigger_poll(trig_data->trig, 0);

iio_trigger_poll(trig_data->trig, iio_get_time_ns());

> +
> +	return HRTIMER_RESTART;
> +}
[...]

