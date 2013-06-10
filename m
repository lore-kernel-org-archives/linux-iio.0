Return-Path: <panto@antoniou-consulting.com>
Subject: Re: [PATCH 12/22] iio/ti_tscadc: Update with IIO map interface
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
From: Pantelis Antoniou <panto@antoniou-consulting.com>
In-Reply-To: <51B582D3.1050501@linutronix.de>
Date: Mon, 10 Jun 2013 11:10:17 +0300
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Samuel Ortiz <sameo@linux.intel.com>,
 Felipe Balbi <balbi@ti.com>,
 linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@cam.ac.uk>
Message-Id: <429732E1-5AEE-45AD-9BA8-3B5C6CD85867@antoniou-consulting.com>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-13-git-send-email-bigeasy@linutronix.de> <51B4B024.8070102@metafoo.de> <51B582D3.1050501@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Sebastian,

On Jun 10, 2013, at 10:40 AM, Sebastian Andrzej Siewior wrote:

> On 06/09/2013 06:41 PM, Lars-Peter Clausen wrote:
>> On 06/05/2013 06:24 PM, Sebastian Andrzej Siewior wrote:
>> [...]
>>> -	return indio_dev->num_channels;
>>> +	adc_dev->map =3D kcalloc(channels + 1, sizeof(struct iio_map),
>>> +			GFP_KERNEL);
>>> +	if (adc_dev->map =3D=3D NULL)
>>> +		goto err_free_chan;
>>> +
>>> +	for (i =3D 0; i < channels; i++) {
>>> +		adc_dev->map[i].adc_channel_label =3D
>>> +			chan_array[i].datasheet_name;
>>> +		adc_dev->map[i].consumer_dev_name =3D "any";
>>> +		adc_dev->map[i].consumer_channel =3D =
chan_array[i].datasheet_name;
>>> +	}
>>=20
>> This is not the way the IIO map interface is supposed to be used and =
I doubt it
>> will actually work at all. The map either needs to be provided by =
board code
>> with the proper consumer device and channel name filled in or in your =
case
>> where you use devicetree you don't need to provide a map at all since =
this will
>> all be handled by the generic IIO devicetree bindings. So I'd just =
drop this patch.
>=20
> The channels are not described in the device tree. If so how would =
that
> be the case? Right now, I don't have any consumer. How do I test this
> easily if this is done correctly?
> If in doubt it will probably drop this until someone comes along who
> actually needs this.
>=20

Please don't remove this immediately. We need the hardcoded names until
we use DT bindings that get a handle of the IIO channels.

I realize this is a temporary solution though until the driver is =
reworked
to use DT properly.

>>=20
>> - Lars
>=20
> Sebastian

Regards

-- Pantelis
