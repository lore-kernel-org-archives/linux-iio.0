Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37522 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817AbcBHRSi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2016 12:18:38 -0500
In-Reply-To: <20160208133507.GA13554@sophia>
References: <20160202233026.GA25092@sophia> <56B6465D.5030102@kernel.org> <20160208133507.GA13554@sophia>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: Add IIO support for the DAC on the Apex Embedded Systems STX104
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 08 Feb 2016 17:18:10 +0000
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <0B08C2AE-BEA6-454D-80AE-EDC0A2A20C6C@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 8 February 2016 13:35:07 GMT+00:00, William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>On Sat, Feb 06, 2016 at 07:15:41PM +0000, Jonathan Cameron wrote:
>>On 02/02/16 23:30, William Breathitt Gray wrote:
>>> The Apex Embedded Systems STX104 is a 16-channel 16-bit analog input
>and
>>> 2-channel 16-bit analog output PC/104 card. The STX104 incorporates
>a
>>> large one mega-sample FIFO.
>>> 
>>> This driver provides IIO support for the 2-channel DAC on the
>STX104.
>>> The base port address for the device may be configured via the
>>> stx104_base module parameter.
>>Nice looking product.
>>> 
>>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>>I'm a little out of my depth wrt to the lack of discoverability of
>>this so perhaps take comments related to that rather more loosely
>>than the IIO stuff.
>
>Unfortunately, the Apex Embedded Systems STX104 lacks hardware
>discoverability functionality; users are expected to manually set the
>base address of the card via physical jumpers, then point their
>software
>to match the set base address of the card.
>
>>Again, module parameter usage will restrict you to instantiating only
>>one instance.  Strikes me as a device where you might want more than
>one.
>>Does the hardware prevent this for some reason?
>
>That is a good point; I overlooked the fact that my current
>implementation restricts the module to only one instance. Since PC/104
>cards are effectively ISA cards, instead of the platform driver I will
>reimplement the module to use the ISA bus driver provided in the
>linux/isa.h file. I will also allow users to pass in a list of base
>addresses in order to support multiple instances.
Great.
>
>>> +#define STX104_CHAN(chan) {				\
>>> +	.type = IIO_VOLTAGE,				\
>>> +	.channel = chan,				\
>>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>>No information available on scale?
>
>I'm relatively new to the IIO subsystem, so let me know if I
>misunderstood: the scale member allows users to view what output range
>the device is set to use. The Apex Embedded Systems STX104 may be set
>to
>one of four output voltage range modes: +-10V, +-5V, 0-10V, and 0-5V.
>Unfortunately, these modes are configured via physical jumpers on the
>card -- and because the card provides no hardware functionality to
>probe
>for its configuration, the scale member should not be set since any
>value would be at best a guess.
You are correct. If unknown as here just not providing it is best option.
>
>>> +	const char *const name = dev_name(dev);
>>Personally I'd not bother with the local name variable but just use
>>dev_name(dev) inline.
>
>I'll incorporate this change in version 2 of this patch. 
>
>>> +static int stx104_remove(struct platform_device *pdev)
>>> +{
>>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>> +
>>> +	iio_device_unregister(indio_dev);
>>If there really is nothing to be done other than unregister, then
>>use devm_iio_device_register(...) and you can drop the remove
>entirely.
>
>Thanks, I wasn't aware of the devm_iio_device_register call! I'll
>incorporate this change in version 2 of this patch. 
>
>William Breathitt Gray

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
