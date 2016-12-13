Return-Path: <SRS0=VaGG=X4=baylibre.com=bgolaszewski@kernel.org>
MIME-Version: 1.0
In-Reply-To: <c670d597-46b6-235f-545f-7136a3abff7f@metafoo.de>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
 <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de> <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com>
 <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de> <bf3dde7e-cee8-c54c-db93-447ffa063116@kernel.org>
 <CAMpxmJVJ+y9tRbRBsVg+i0EJO_6EFuvrypwC=ETnBWbMnxRFyg@mail.gmail.com> <c670d597-46b6-235f-545f-7136a3abff7f@metafoo.de>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 13 Dec 2016 15:28:22 +0100
Message-ID: <CAMpxmJVpj57s-m_FS58J+QWvu-MnVmaZP-6ECnYHeRVSCfd-Fw@mail.gmail.com>
Subject: Re: [PATCH] iio: misc: add a generic regulator driver
To: Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
	linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>,
	Neil Armstrong <narmstrong@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2016-12-12 18:15 GMT+01:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 12/06/2016 12:12 PM, Bartosz Golaszewski wrote:

[snip!]

>>
>> So the problem we have is not power-cycling the adc - it's
>> power-cycling the device connected to a probe on which there's an adc.
>> What I was trying to do was adding support for the power-switch on
>> baylibre-acme[1] probes.
>>
>> For example: we have a USB probe on which the VBUS signal goes through
>> a power load switch and than through the adc. The adc (in this case
>> ina226) is always powered on, while the fixed regulator I wanted to
>> enable/disable actually drives the power switch to cut/restore power
>> to the connected USB device i.e. there's no real regulator - just a
>> GPIO driving the power switch.
>>
>> A typical use case is measuring the power consumption of development
>> boards[2]. Rebooting them remotely using acme probes is already done,
>> but we're using the obsolete /sys/class/gpio interface.
>>
>> We're already using libiio to read the measured data from the power
>> monitor, that's why we'd like to use the iio framework for
>> power-cycling the devices as well. My question is: would bridging the
>> regulator framework be the right solution? Should we look for
>> something else? Bridge the GPIO framework instead?
>
> I wouldn't necessaries create bridge, but instead just use the GPIO
> framework directly.
>
> We now have the GPIO chardev interface which meant to be used to support
> application specific logic that control the GPIOs, but where you don't want
> to write a kernel driver.
>
> My idea was to add GPIOs and GPIO chips as high level object inside libiio
> that can be accessed through the same context as the IIO devices. Similar to
> the current IIO API you have a API for gpios that allows to enumerate the
> GPIO devices and their pins as well as modify the pin state.
>

+ Linus

While the new GPIO interface would be very convenient - in our case we
could simply name the lines appropriately in the device tree - I'm not
sure this would be the correct approach.

>From this year's ELCE in Berlin I remember Linus suggested during his
talk that it's always better to write a kernel driver. Also: this way
the relevant GPIO lines would not be reserved for exclusive use by
power switches.

Linus - do you have any thoughts/suggestions on that subject?

Best regards,
Bartosz Golaszewski
