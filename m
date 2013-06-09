Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:59851 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752773Ab3FIQhv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jun 2013 12:37:51 -0400
Message-ID: <51B4B024.8070102@metafoo.de>
Date: Sun, 09 Jun 2013 18:41:08 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH 12/22] iio/ti_tscadc: Update with IIO map interface
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-13-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1370449495-29981-13-git-send-email-bigeasy@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/05/2013 06:24 PM, Sebastian Andrzej Siewior wrote:
[...]
> -	return indio_dev->num_channels;
> +	adc_dev->map = kcalloc(channels + 1, sizeof(struct iio_map),
> +			GFP_KERNEL);
> +	if (adc_dev->map == NULL)
> +		goto err_free_chan;
> +
> +	for (i = 0; i < channels; i++) {
> +		adc_dev->map[i].adc_channel_label =
> +			chan_array[i].datasheet_name;
> +		adc_dev->map[i].consumer_dev_name = "any";
> +		adc_dev->map[i].consumer_channel = chan_array[i].datasheet_name;
> +	}

This is not the way the IIO map interface is supposed to be used and I doubt it
will actually work at all. The map either needs to be provided by board code
with the proper consumer device and channel name filled in or in your case
where you use devicetree you don't need to provide a map at all since this will
all be handled by the generic IIO devicetree bindings. So I'd just drop this patch.

- Lars
