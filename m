Return-Path: <bigeasy@linutronix.de>
Message-ID: <51B582D3.1050501@linutronix.de>
Date: Mon, 10 Jun 2013 09:40:03 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH 12/22] iio/ti_tscadc: Update with IIO map interface
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-13-git-send-email-bigeasy@linutronix.de> <51B4B024.8070102@metafoo.de>
In-Reply-To: <51B4B024.8070102@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/09/2013 06:41 PM, Lars-Peter Clausen wrote:
> On 06/05/2013 06:24 PM, Sebastian Andrzej Siewior wrote:
> [...]
>> -	return indio_dev->num_channels;
>> +	adc_dev->map = kcalloc(channels + 1, sizeof(struct iio_map),
>> +			GFP_KERNEL);
>> +	if (adc_dev->map == NULL)
>> +		goto err_free_chan;
>> +
>> +	for (i = 0; i < channels; i++) {
>> +		adc_dev->map[i].adc_channel_label =
>> +			chan_array[i].datasheet_name;
>> +		adc_dev->map[i].consumer_dev_name = "any";
>> +		adc_dev->map[i].consumer_channel = chan_array[i].datasheet_name;
>> +	}
> 
> This is not the way the IIO map interface is supposed to be used and I doubt it
> will actually work at all. The map either needs to be provided by board code
> with the proper consumer device and channel name filled in or in your case
> where you use devicetree you don't need to provide a map at all since this will
> all be handled by the generic IIO devicetree bindings. So I'd just drop this patch.

The channels are not described in the device tree. If so how would that
be the case? Right now, I don't have any consumer. How do I test this
easily if this is done correctly?
If in doubt it will probably drop this until someone comes along who
actually needs this.

> 
> - Lars

Sebastian
