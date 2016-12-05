Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34519 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbcLELey (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2016 06:34:54 -0500
Date: Mon, 5 Dec 2016 12:30:58 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>, alexandre.torgue@st.com,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3 4/7] PWM: add pwm driver for stm32 plaftorm
Message-ID: <20161205113058.GG19891@ulmo.ba.sec>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-5-git-send-email-benjamin.gaignard@st.com>
 <20161205072357.GB18069@ulmo.ba.sec>
 <CA+M3ks7_utdw1c0A0m+RzuPTfvFAv5d8HoQvQDzXwHR8M6RKJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eMnpOGXCMazMAbfp"
In-Reply-To: <CA+M3ks7_utdw1c0A0m+RzuPTfvFAv5d8HoQvQDzXwHR8M6RKJA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--eMnpOGXCMazMAbfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 12:02:45PM +0100, Benjamin Gaignard wrote:
> 2016-12-05 8:23 GMT+01:00 Thierry Reding <thierry.reding@gmail.com>:
> > On Fri, Dec 02, 2016 at 11:17:19AM +0100, Benjamin Gaignard wrote:
> >> This driver add support for pwm driver on stm32 platform.
> >
> > "adds". Also please use PWM in prose because it's an abbreviation.
> >
> >> The SoC have multiple instances of the hardware IP and each
> >> of them could have small differences: number of channels,
> >> complementary output, counter register size...
> >> Use DT parameters to handle those differentes configuration
> >
> > "different configurations"
>=20
> ok
>=20
> >
> >>
> >> version 2:
> >> - only keep one comptatible
> >> - use DT paramaters to discover hardware block configuration
> >
> > "parameters"
>=20
> ok
>=20
> >
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >> ---
> >>  drivers/pwm/Kconfig     |   8 ++
> >>  drivers/pwm/Makefile    |   1 +
> >>  drivers/pwm/pwm-stm32.c | 285 +++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  3 files changed, 294 insertions(+)
> >>  create mode 100644 drivers/pwm/pwm-stm32.c
> >>
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index bf01288..a89fdba 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -388,6 +388,14 @@ config PWM_STI
> >>         To compile this driver as a module, choose M here: the module
> >>         will be called pwm-sti.
> >>
> >> +config PWM_STM32
> >> +     bool "STMicroelectronics STM32 PWM"
> >> +     depends on ARCH_STM32
> >> +     depends on OF
> >> +     select MFD_STM32_GP_TIMER
> >
> > Should that be a "depends on"?
>=20
> I think select is fine because the wanted feature is PWM not the mfd part

I think in that case you may want to hide the MFD Kconfig option. See
Documentation/kbuild/kconfig-language.txt (notes about select) for the
details.

[...]
> >> +};
> >> +
> >> +#define to_stm32_pwm_dev(x) container_of(chip, struct stm32_pwm_dev, =
chip)
> >
> > Please turn this into a static inline.
>=20
> with putting struct pwm_chip as first filed I will just cast the structure

Don't do that, please. container_of() is still preferred because it is
correct and won't break even if you (or somebody else) changes the order
in the future. The fact that it might be optimized away is a detail, or
a micro-optimization. Force-casting is a bad idea because it won't catch
errors if for some reason the field doesn't remain in the first position
forever.

> >> +static void stm32_pwm_disable(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
> >> +{
> >> +     u32 mask;
> >> +     struct stm32_pwm_dev *dev =3D to_stm32_pwm_dev(chip);
> >> +
> >> +     /* Disable channel */
> >> +     mask =3D TIM_CCER_CC1E << (pwm->hwpwm * 4);
> >> +     if (dev->caps & CAP_COMPLEMENTARY)
> >> +             mask |=3D TIM_CCER_CC1NE << (pwm->hwpwm * 4);
> >> +
> >> +     regmap_update_bits(dev->regmap, TIM_CCER, mask, 0);
> >> +
> >> +     /* When all channels are disabled, we can disable the controller=
 */
> >> +     if (!__active_channels(dev))
> >> +             regmap_update_bits(dev->regmap, TIM_CR1, TIM_CR1_CEN, 0);
> >> +
> >> +     clk_disable(dev->clk);
> >> +}
> >
> > All of the above can be folded into the ->apply() hook for atomic PWM
> > support.
> >
> > Also, in the above you use clk_enable() in the ->enable() callback and
> > clk_disable() in ->disable(). If you need the clock to access registers
> > you'll have to enabled it in the others as well because there are no
> > guarantees that configuration will only happen between ->enable() and
> > ->disable(). Atomic PWM simplifies this a bit, but you still need to be
> > careful about when to enable the clock in your ->apply() hook.
>=20
> I have used regmap functions enable/disable clk for me when accessing to
> the registers.
> I only have to take care of clk enable/disable when PWM state change.

Okay, that's fine then.

Thierry

--eMnpOGXCMazMAbfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYRU/xAAoJEN0jrNd/PrOhQ7gP/2H7UMJDOuzZrL6tqJuU6ehw
eeDhPWXMt1fTjsCf1gu2j/pz+Fh+CSmZ9Mgihm9GMNy9IHDPcSSPOgHsJ/HsVEnv
MQnJXrngiZ8e05+tuPuyg5g5VvDMUqtfj9Wiit/Lxsh0/QxnuAUOAJpAjiKsNswF
uBH7lOWeohq8hNe+EOG+0SNaHJSXoOra8UIk5R4KzBiMEhqIVEWlyTo7Ikeh+0ed
UL99+epSSO4sO6vJt2ku/az9jJ0rpGrTNYeaylNKT/0FSpkoCgls9fXsE32RSKTT
IJxgbSHxOKI0cy6u0GtHXV5dq+3lFwJw33mIBUfm4aoN04giak/j7qBFi/k1XWb9
H3h2npyFaDvzNnJdEmf7LDDrKOsstN/MqqThrICF40XTQnBNmIjLZb9eGBYxSNky
7BSAJ0GaCSmeLEPqleL+T7vsem2e/u8+sFfsGOuhj/zEF8UfTq1pVg4h1PVbac3s
/rUaX+Ap9ThmXiP94NjBi+EyUgfnREgb6N3WZeAEoZqz4TKKynHT3N0/fu89dywQ
aMpW61FHUaJbISXr+Ufn9MtjHTPWs5Nqu2m4ozimgIAdtl2tThmFbFFI5SOkL8Yz
W/E7k4dPR+0BUfpONDaGqpa/Q/g7KZTdMclyELtCIC5G8cpaloNQgrhlT4Qldo9L
/25TK7UBw2TSyDMCqebR
=llJ+
-----END PGP SIGNATURE-----

--eMnpOGXCMazMAbfp--
