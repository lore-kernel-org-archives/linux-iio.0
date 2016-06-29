Return-Path: <wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
References: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 29 Jun 2016 11:28:03 +0800
Message-ID: <CAGb2v67pK1Gkqxy2LJ0MMVry4P5C0RTqVGPHhqq+4jOFvvEA7g@mail.gmail.com>
Subject: Re: [PATCH 0/3] add support for Allwinner SoCs ADC
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jdelvare@suse.com, Guenter Roeck <linux@roeck-us.net>, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee.jones@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	=?UTF-8?Q?Antoine_T=C3=A9nart?= <antoine.tenart@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi,

On Tue, Jun 28, 2016 at 4:45 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The Allwinner SoCs all have an ADC that can also act as a touchscreen controller
> and a thermal sensor. The first four channels can be used either for the ADC or
> the touchscreen and the fifth channel is used for the thermal sensor. We
> currently have a driver for the two latter functions in
> drivers/input/touchscreen/sun4i-ts.c but we don't have access to the ADC feature
> at all.
>
> This adds initial support for Allwinner SoCs ADC with all features. Yet, the
> touchscreen is not implemented but will be added later. To switch between
> touchscreen and ADC modes, you need to poke few bits in registers and
> (de)activate an interrupt (pen-up).
> A MFD is provided to let the input driver activate the pen-up interrupt through
> virtual interrupt, poke few bits via regmap and read data from the ADC driver
> while both (and iio_hwmon) are probed by the MFD.

I take it that we are going to replace the original sun4i-ts driver
with this new mfd one, and various sub device drivers?

> There exists slight modifications between the different SoCs ADC like the
> address of some registers and the scale and offset to apply to thermal sensor
> raw values. These modifications are done by drivers on different
> platform_device_id passed by the MFD when probing subdrivers.
>
> This also modifies iio-hwmon to allow probe deferring when no iio channel is
> found. Currently when no iio channel is found, the probing of iio-hwmon fails.
> This is problematic when iio-hwmon probes before the iio driver could register
> iio channels to share.

One thing about iio-hwmon is that it doesn't support hwmon labels.
Any chance you could improve this, so we see the same names in userspace?

Thanks
ChenYu

>
> Quentin Schulz (3):
>   mfd: add support for Allwinner SoCs ADC
>   iio: adc: add support for Allwinner SoCs ADC
>   hwmon: iio_hwmon: defer probe when no channel is found
>
>  drivers/hwmon/iio_hwmon.c           |   5 +-
>  drivers/iio/adc/Kconfig             |  12 ++
>  drivers/iio/adc/Makefile            |   1 +
>  drivers/iio/adc/sunxi-gpadc-iio.c   | 371 ++++++++++++++++++++++++++++++++++++
>  drivers/mfd/Kconfig                 |  14 ++
>  drivers/mfd/Makefile                |   2 +
>  drivers/mfd/sunxi-gpadc-mfd.c       | 188 ++++++++++++++++++
>  include/linux/mfd/sunxi-gpadc-mfd.h |  14 ++
>  8 files changed, 606 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/adc/sunxi-gpadc-iio.c
>  create mode 100644 drivers/mfd/sunxi-gpadc-mfd.c
>  create mode 100644 include/linux/mfd/sunxi-gpadc-mfd.h
>
> --
> 2.5.0
>
