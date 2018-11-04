Return-Path: <SRS0=wKiL=NP=googlemail.com=martin.blumenstingl@kernel.org>
MIME-Version: 1.0
References: <20181103231024.659-1-martin.blumenstingl@googlemail.com>
 <20181103231024.659-3-martin.blumenstingl@googlemail.com> <20181104170041.1fcc4932@archlinux>
In-Reply-To: <20181104170041.1fcc4932@archlinux>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 4 Nov 2018 23:36:10 +0100
Message-ID: <CAFBinCB4bByOqXbUJEv2-fMKWDett-ym++7=x87tDWD4BTQ7QA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: meson-saradc: add support for the chip's
 temperature sensor
To: jic23@kernel.org
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, robh+dt@kernel.org, pmeerw@pmeerw.net,
	lars@metafoo.de, knaack.h@gmx.de
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On Sun, Nov 4, 2018 at 6:00 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun,  4 Nov 2018 00:10:24 +0100
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > Channel 6 of the SAR ADC can be switched between two inputs:
> > SAR_ADC_CH6 input (an actual pad on the SoC) and the signal from the
> > temperature sensor inside the SoC.
> >
> > To get usable results from the temperature sensor we need to read the
> > corresponding calibration data from the eFuse and pass it to the SAR ADC
> > registers. If the temperature sensor is not calibrated (the eFuse data
> > contains a bit for this) then the driver will only register the
> > iio_chan_spec's for voltage measurements.
> >
> > (bits [3:0]) and (on Meson8b and Meson8m2) to a scratch register in the
> > HHI region.
I missed this "fragment" (I wouldn't call it a sentence) when I sent the patch.
the next paragraph already contains an explanation about the TSC on
Meson8b and Meson8m2 as well as the HHI register area.
so this paragraph doesn't make any sense and should be removed. do you
want me to re-send this patch (or even the whole series) or can you
remove it? everything else is fine (I double-checked this time...)

> > This only enables the temperature sensor for the Meson8 SoC. Meson8b and
> > Meson8m2 SoCs can be supported in the future as well but we first need
> > a way to pass the fifth TSC (temperature sensor coefficient) bit to the
> > HHI register area (apart from that the infrastructure as already
> > implemented for Meson8 can be used). On the 64-bit SoCs (GXBB, GXL and
> > GXM) the temperature sensor inside SAR ADC is firmware-controlled (by
> > BL30, we can simply use the SCPI hwmon driver to get the chip
> > temperature).
> >
> > To keep the devicetree interface backwards compatible we simply skip the
> > temperature sensor initialization if no eFuse nvmem cell is passed via
> > devicetree.
> >
> > The public documentation for the SAR ADC IP block does not explain how
> > to use the registers to read the temperature. The logic from this patch
> > is based on reading and understanding Amlogic's GPL kernel sources.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Good detailed explanation.  Thanks.
you're welcome!
please see my comment above where I have to admit that not all of the
description is "good".

> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
that was quick - thank you!


Regards
Martin
