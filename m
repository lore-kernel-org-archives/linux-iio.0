Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34462 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755160AbcHVNYR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Aug 2016 09:24:17 -0400
Date: Mon, 22 Aug 2016 09:24:09 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] iio: stx104: Add IIO support for the ADC channels
Message-ID: <20160822132409.GA9041@sophia>
References: <cover.1469468983.git.vilhelm.gray@gmail.com>
 <6d9544e530bf2d97175596f03a7d429f57153b40.1469468983.git.vilhelm.gray@gmail.com>
 <99c36f16-9f2c-383d-9f44-badeee523a5a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <99c36f16-9f2c-383d-9f44-badeee523a5a@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Aug 21, 2016 at 08:39:01PM +0100, Jonathan Cameron wrote:
>On 25/07/16 18:54, William Breathitt Gray wrote:
>> The Apex Embedded Systems STX104 features 16 channels of single-ended (8
>> channels of true differential) 16-bit analog input. Differential input
>> configuration may be selected via a physical jumper on the device.
>> Similarly, input polarity (unipolar/bipolar) is configured via a
>> physical jumper on the device.
>> 
>> Input gain selection is available to the user via software, thus
>> allowing eight possible input ranges: +-10V, +-5V, +-2.5V, +-1.25V,
>> 0 to 10V, 0 to 5V, 0 to 2.5V, and 0 to 1.25V. Four input gain
>> configurations are supported: x1, x2, x4, and x8.
>> 
>> This ADC resolution is 16-bits (1/65536 of full scale). Analog input
>> samples are taken on software trigger; neither FIFO sampling nor
>> interrupt triggering is supported by this driver.
>> 
>> The Apex Embedded Systems STX104 is primarily an analog-to-digital
>> converter device. The STX104 IIO driver was initially placed in the DAC
>> directory because only the DAC portion of the STX104 was supported at
>> the time. Now that ADC support has been added to the STX104 IIO driver,
>> the driver should be moved to the more appropriate ADC directory.
>> 
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>Hi William,
>
>I'd missed the odd use of an output channel to control scale.
>I'm guessing this is because we are looking at actual control of a front
>end separate amplifier on the board?  However as far as the driver is
>confirmed this is no different from any multi range ADC and so
>should be done with IIO_INFO_SCALE.
>
>Sorry for taking so long to get back to you.  Holiday season I'm afraid.
>
>Jonathan

>> +#define STX104_GAIN_CHAN {					\
>> +	.type = IIO_VOLTAGE,					\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),	\
>> +	.output = 1						\
>>  }
>
>I'm confused.  You have a separate output channel to control gain?
>Why... Variable gain devices are normally just represented via the
>info_mask element IIO_CHAN_INFO_SCALE as an info_mask_shared_by_type.

Hey Jonathan,

Thanks for getting back to me. I did have trouble figuring out the
proper way to expose the gain control for this device. Perhaps if I
describe the register interface it may make more sense.

The STX104 ADC input range may be probed with a read to register offset
11; bit 2 represents the ADC bipolar/unipolar configuration (ADBU),
while bits 1 and 0 represent the ADC gain setting. ADBU is configured by
physical jumper on the device, while the ADC gain setting is configured
in software via a register write.

ADC gain may be set with a write of bits 1 and 0 to register offset 11;
00 = gain of x1, 01 = gain of x2, 10 = gain of x4, 11 = gain of x8.
Writing to this register sets the analog input gain for all 8/16 analog
inputs.

Since the ADC gain setting applies to all analog inputs rather than
individual inputs separately, what is the proper way to expose this
option? Should I remove the STX104_GAIN_CHAN #define entirely and use
something like the following change instead:

	#define STX104_IN_CHAN(chan, diff) {				\
		.type = IIO_VOLTAGE,					\
		.channel = chan,					\
		.channel2 = chan,					\
		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
		.indexed = 1,						\
		.output = 0,						\
		.differential = diff					\
	}

Where the IIO_CHAN_INFO_SCALE now exposes the gain setting affecting all
analog inputs.

Thanks,

William Breathitt Gray
