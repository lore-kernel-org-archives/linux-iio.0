Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36497 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475Ab3FZOuI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 26 Jun 2013 10:50:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1Urr2o-0002gZ-R2
	for linux-iio@vger.kernel.org; Wed, 26 Jun 2013 16:50:02 +0200
Received: from 217-67-201-162.itsa.net.pl ([217.67.201.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2013 16:50:02 +0200
Received: from j.anaszewski by 217-67-201-162.itsa.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2013 16:50:02 +0200
To: linux-iio@vger.kernel.org
From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH/RFC] iio: gp2ap002a00f: Add a driver for the device.
Date: Wed, 26 Jun 2013 16:49:06 +0200
Message-ID: <51CAFF62.5030707@samsung.com>
References: <51C58B62.30602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <51C58B62.30602@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/22/2013 01:32 PM, Jonathan Cameron wrote:
> Sorry, due to some local email weirdness I don't seem to have an original
> copy of this email, so have grabbed it from marc.info.
> This may mess up the thread handling for others.
>
>> Add a new driver for the ambient light/proximity sensor
>> device. The driver exposes three channels: light_clear
>> light_ir and proximity. It also supports high and low
>> ambient light threshold event and proximity detection
>> event.
>>
> Just to check, are you aware of the drive in drivers/input/misc?

Yes I am aware of it. I even got influenced by it to the extent
that I mistakenly adopted its name for my driver, which should be
gp2ap020a00f. The name will be corrected in the second version
of the patch. The gp2ap002a00f device seems not to have too much
in common with gp2ap020a00f.

> A few comments from a somewhat superficial review below.
>
[...]
>> +static const struct iio_chan_spec gp2ap002a00f_channels[] = {
>> +	{
>> +		.type = IIO_LIGHT,
>> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
>> +		.modified = 1,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> Just to confirm, you are providing no means at all of converting
> these channels to any form of standard unit?
> Without the datasheet I can't tell if this is because no conversion
> is provided.

Yes, this is intentional.

[...]
>> +	err = iio_triggered_buffer_setup(indio_dev, NULL,
>> +		&gp2ap002a00f_trigger_handler,&gp2ap002a00f_buffer_setup_ops);
>> +
> So this is a single irq line for events and dataready?
> I can't seem to find a decent datasheet online for this part which is
> always annoying!

The documentation I have for my disposal is confidential.
Yes, there is common interrupt line for events and data ready.
When threshold registers are filled with a value greater than 0
the interrupts are considered enabled. This has also side effect -
no interrupt is being generated when converted value is 0.

Thanks,
Jacek

