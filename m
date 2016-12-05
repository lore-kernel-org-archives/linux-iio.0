Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34364 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbcLEMV5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2016 07:21:57 -0500
Date: Mon, 5 Dec 2016 13:21:24 +0100
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
Subject: Re: [PATCH v3 3/7] PWM: add pwm-stm32 DT bindings
Message-ID: <20161205122124.GA20856@ulmo.ba.sec>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-4-git-send-email-benjamin.gaignard@st.com>
 <20161205065350.GA18069@ulmo.ba.sec>
 <CA+M3ks4-JQNGYtdiXNj1J701x0njKD0_bf4yN1mLSjEcT2Z=6A@mail.gmail.com>
 <20161205112347.GF19891@ulmo.ba.sec>
 <CA+M3ks5j2e-EQEf74YSduboNnCiWC7+e_PD5aAz5XdFA1tGztQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
In-Reply-To: <CA+M3ks5j2e-EQEf74YSduboNnCiWC7+e_PD5aAz5XdFA1tGztQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 01:12:25PM +0100, Benjamin Gaignard wrote:
> 2016-12-05 12:23 GMT+01:00 Thierry Reding <thierry.reding@gmail.com>:
> > On Mon, Dec 05, 2016 at 12:08:32PM +0100, Benjamin Gaignard wrote:
> >> 2016-12-05 7:53 GMT+01:00 Thierry Reding <thierry.reding@gmail.com>:
> >> > On Fri, Dec 02, 2016 at 11:17:18AM +0100, Benjamin Gaignard wrote:
> >> >> Define bindings for pwm-stm32
> >> >>
> >> >> version 2:
> >> >> - use parameters instead of compatible of handle the hardware confi=
guration
> >> >>
> >> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >> >> ---
> >> >>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 38 ++++++++++=
++++++++++++
> >> >>  1 file changed, 38 insertions(+)
> >> >>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32=
=2Etxt
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/=
Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> >> >> new file mode 100644
> >> >> index 0000000..575b9fb
> >> >> --- /dev/null
> >> >> +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> >> >> @@ -0,0 +1,38 @@
> >> >> +STMicroelectronics PWM driver bindings for STM32
> >> >
> >> > Technically this bindings describe devices, so "driver binding" is a
> >> > somewhat odd wording. Perhaps:
> >> >
> >> >         STMicroelectronics STM32 General Purpose Timer PWM bindings
> >> >
> >> > ?
> >>  done
> >>
> >> >
> >> >> +
> >> >> +Must be a sub-node of STM32 general purpose timer driver
> >> >> +Parent node properties are describe in ../mfd/stm32-general-purpos=
e-timer.txt
> >> >
> >> > Again, "driver parent node" is odd. Perhaps:
> >> >
> >> >         Must be a sub-node of an STM32 General Purpose Timer device =
tree
> >> >         node. See ../mfd/stm32-general-purpose-timer.txt for details=
 about
> >> >         the parent node.
> >> >
> >> > ?
> >>
> >> done
> >>
> >> >
> >> >> +Required parameters:
> >> >> +- compatible:                Must be "st,stm32-pwm"
> >> >> +- pinctrl-names:     Set to "default".
> >> >> +- pinctrl-0:                 List of phandles pointing to pin conf=
iguration nodes
> >> >> +                     for PWM module.
> >> >> +                     For Pinctrl properties, please refer to [1].
> >> >
> >> > Your indentation and capitalization are inconsistent. Also, please r=
efer
> >> > to the pinctrl bindings by relative path and inline, rather than as a
> >> > footnote reference.
> >>
> >> OK
> >>
> >> >
> >> >> +
> >> >> +Optional parameters:
> >> >> +- st,breakinput:     Set if the hardware have break input capabili=
ties
> >> >> +- st,breakinput-polarity: Set break input polarity. Default is 0
> >> >> +                      The value define the active polarity:
> >> >> +                       - 0 (active LOW)
> >> >> +                       - 1 (active HIGH)
> >> >
> >> > Could we fold these into a single property? If st,breakinput-polarit=
y is
> >> > not present it could simply mean that there is no break input, and i=
f it
> >> > is present you don't have to rely on a default.
> >>
> >> I need to know if I have to activate breakinput feature and on which l=
evel
> >> I will rewrite it like that:
> >> Optional parameters:
> >> - st,breakinput-polarity-high: Set if break input polarity is active
> >> on high level.
> >> - st,breakinput-polarity-high: Set if break input polarity is active
> >> on low level.
> >
> > How is that different from a single property:
> >
> >         Optional properties:
> >         - st,breakinput-polarity: If present, a break input is available
> >             for the channel. In that case the property value denotes the
> >             polarity of the break input:
> >             - 0: active low
> >             - 1: active high
> >
> > ?
>=20
> For break input feature I need two information: do I have to active it
> and if activated
> on which level.
> I have two solutions:
> - one parameter with a value (0 or 1) -> st,breakinput-polarity
> - two parameters without value -> st,breakinput-active-high and
> st,breakinput-active-low
>=20
> By default break input feature is disabled

Right, what I was suggesting is that you use the first solution because
it's the typical way to use for tristate options. It's also much easier
to test for in practice because for the second solution you have to
parse two properties before you know whether it is active or not.

The second is typically the solution for required properties where only
one of the properties is used to override the default.

Thierry

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYRVvCAAoJEN0jrNd/PrOhujwP/1w8e4ZwTw+PKUVyCuMAieJ/
N7SeawE7FJdQlSSwp88c0WUvU3YqFp1YmUSl5d31g7GFcexV604PAqIqVbLAXSwY
ciCNoq9HEERpi6oIeJLet0h3PNSh5unLD/klVDSSVVAT5lMoUz8IuLtRnkjp8W/f
92Dem5Bb/61ewdpmjS9LeYyf6xHQV15yKHkuwRbNsnRWDrHa2LG4gjcwUVW9kQgr
5DTwAnszymhpj0AkXe6Zq58Oni2s7cZJ9xFHjwSaFeXzx8EsS24ZuqZpm7OgkcaX
4K/isEnx6+3YU7NenLolWsCMn69yhaaOOilK8a36P3nAJZWtSdls+798NDCVgghE
gfKXzQC9Lf4kJSthvJfgcULSOWrzJ4fUsXLmm7o7Z7/vMKSoU2FGadPuSW4Seezl
S7fAbn1k7o72Li+E3SdfT9s2jVvJn42Nmts//d+8sHFLH0CNS61Cuga52SPf0evd
+uwx0jIOqycsaJkCtTMiAfmeTJpRGf+2ilb1JFGnF4tVX2XExR0ET4mC9dMH/vte
bKE6DRrN8b1IZoN7VAWH6PCtux8meW0Fy7UnxA/NRmsYp+W2wwhaAEwUq0xi92wF
uhtjJM0fG/YEoUkqi2bhwlGxkOxljdQIE+TeG9PNfOG/uT1OaobEk0kT93d5joMT
CIJh3qnl/AsPpPr6+YXj
=iCYg
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
