Return-Path: <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH 0/3] add support for Allwinner SoCs ADC
To: Chen-Yu Tsai <wens@csie.org>
References: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
 <CAGb2v67pK1Gkqxy2LJ0MMVry4P5C0RTqVGPHhqq+4jOFvvEA7g@mail.gmail.com>
Cc: jdelvare@suse.com, Guenter Roeck <linux@roeck-us.net>, jic23@kernel.org,
 knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Lee Jones <lee.jones@linaro.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 =?UTF-8?Q?Antoine_T=c3=a9nart?= <antoine.tenart@free-electrons.com>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <57763BB3.20706@free-electrons.com>
Date: Fri, 1 Jul 2016 11:45:23 +0200
MIME-Version: 1.0
In-Reply-To: <CAGb2v67pK1Gkqxy2LJ0MMVry4P5C0RTqVGPHhqq+4jOFvvEA7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 29/06/2016 05:28, Chen-Yu Tsai wrote:
> Hi,
> 
> On Tue, Jun 28, 2016 at 4:45 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
>> The Allwinner SoCs all have an ADC that can also act as a touchscreen controller
>> and a thermal sensor. The first four channels can be used either for the ADC or
>> the touchscreen and the fifth channel is used for the thermal sensor. We
>> currently have a driver for the two latter functions in
>> drivers/input/touchscreen/sun4i-ts.c but we don't have access to the ADC feature
>> at all.
>>
>> This adds initial support for Allwinner SoCs ADC with all features. Yet, the
>> touchscreen is not implemented but will be added later. To switch between
>> touchscreen and ADC modes, you need to poke few bits in registers and
>> (de)activate an interrupt (pen-up).
>> A MFD is provided to let the input driver activate the pen-up interrupt through
>> virtual interrupt, poke few bits via regmap and read data from the ADC driver
>> while both (and iio_hwmon) are probed by the MFD.
> 
> I take it that we are going to replace the original sun4i-ts driver
> with this new mfd one, and various sub device drivers?
> 

Yes, that's the spirit.

[...]

> One thing about iio-hwmon is that it doesn't support hwmon labels.
> Any chance you could improve this, so we see the same names in userspace?

Should be an easy patch: reading datasheet_name from iio_chan_spec of
the iio_channel in iio_hwmon_probe, if none then fall back to current
naming convention.

I don't think it is linked to this serie of patches so I prefer to look
at it later.

Thanks!
