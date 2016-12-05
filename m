Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35325 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbcLELXw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2016 06:23:52 -0500
Date: Mon, 5 Dec 2016 12:23:47 +0100
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
Message-ID: <20161205112347.GF19891@ulmo.ba.sec>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-4-git-send-email-benjamin.gaignard@st.com>
 <20161205065350.GA18069@ulmo.ba.sec>
 <CA+M3ks4-JQNGYtdiXNj1J701x0njKD0_bf4yN1mLSjEcT2Z=6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
In-Reply-To: <CA+M3ks4-JQNGYtdiXNj1J701x0njKD0_bf4yN1mLSjEcT2Z=6A@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 12:08:32PM +0100, Benjamin Gaignard wrote:
> 2016-12-05 7:53 GMT+01:00 Thierry Reding <thierry.reding@gmail.com>:
> > On Fri, Dec 02, 2016 at 11:17:18AM +0100, Benjamin Gaignard wrote:
> >> Define bindings for pwm-stm32
> >>
> >> version 2:
> >> - use parameters instead of compatible of handle the hardware configur=
ation
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >> ---
> >>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 38 +++++++++++++=
+++++++++
> >>  1 file changed, 38 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Doc=
umentation/devicetree/bindings/pwm/pwm-stm32.txt
> >> new file mode 100644
> >> index 0000000..575b9fb
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> >> @@ -0,0 +1,38 @@
> >> +STMicroelectronics PWM driver bindings for STM32
> >
> > Technically this bindings describe devices, so "driver binding" is a
> > somewhat odd wording. Perhaps:
> >
> >         STMicroelectronics STM32 General Purpose Timer PWM bindings
> >
> > ?
>  done
>=20
> >
> >> +
> >> +Must be a sub-node of STM32 general purpose timer driver
> >> +Parent node properties are describe in ../mfd/stm32-general-purpose-t=
imer.txt
> >
> > Again, "driver parent node" is odd. Perhaps:
> >
> >         Must be a sub-node of an STM32 General Purpose Timer device tree
> >         node. See ../mfd/stm32-general-purpose-timer.txt for details ab=
out
> >         the parent node.
> >
> > ?
>=20
> done
>=20
> >
> >> +Required parameters:
> >> +- compatible:                Must be "st,stm32-pwm"
> >> +- pinctrl-names:     Set to "default".
> >> +- pinctrl-0:                 List of phandles pointing to pin configu=
ration nodes
> >> +                     for PWM module.
> >> +                     For Pinctrl properties, please refer to [1].
> >
> > Your indentation and capitalization are inconsistent. Also, please refer
> > to the pinctrl bindings by relative path and inline, rather than as a
> > footnote reference.
>=20
> OK
>=20
> >
> >> +
> >> +Optional parameters:
> >> +- st,breakinput:     Set if the hardware have break input capabilities
> >> +- st,breakinput-polarity: Set break input polarity. Default is 0
> >> +                      The value define the active polarity:
> >> +                       - 0 (active LOW)
> >> +                       - 1 (active HIGH)
> >
> > Could we fold these into a single property? If st,breakinput-polarity is
> > not present it could simply mean that there is no break input, and if it
> > is present you don't have to rely on a default.
>=20
> I need to know if I have to activate breakinput feature and on which level
> I will rewrite it like that:
> Optional parameters:
> - st,breakinput-polarity-high: Set if break input polarity is active
> on high level.
> - st,breakinput-polarity-high: Set if break input polarity is active
> on low level.

How is that different from a single property:

	Optional properties:
	- st,breakinput-polarity: If present, a break input is available
	    for the channel. In that case the property value denotes the
	    polarity of the break input:
	    - 0: active low
	    - 1: active high

?

> > The pwm- prefix is rather redundant since the node is already named pwm.
> > Why not simply st,channels? Or simply channels, since it's not really
> > anything specific to this hardware.
> >
> > Come to think of it, might be worth having a discussion with our DT
> > gurus about what their stance is on using the # as prefix for numbers
> > (such as in #address-cells or #size-cells). This could be #channels to
> > mark it more explicitly as representing a count.
> >
> >> +- st,32bits-counter: Set if the hardware have a 32 bits counter
> >> +- st,complementary:  Set if the hardware have complementary output ch=
annels
> >
> > "hardware has" and also maybe mention explicitly that this is a boolean
> > property. Otherwise people might be left wondering what it should be set
> > to. Or maybe word this differently to imply that it's boolean:
> >
> >         - st,32bits-counter: if present, the hardware has a 32 bit coun=
ter
> >         - st,complementary: if present, the hardware has a complementary
> >                             output channel
>=20
> I found a way to detect, at probe time, the number of channels, counter s=
ize,
> break input capability and complementary channels so I will remove
> "st,breakinput", "st,32bits-counter", "st,complementary" and "st,pwm-num-=
chan"
> parameters

Oh hey, that's very neat. I suppose in that case my comment above about
the break input polarity is somewhat obsoleted. Still I think you won't
need two properties. Instead you can follow what other similar
properties have done: choose a default (often low-active) and have a
single optional property to override the default (often high-active).

In your case:

	- st,breakinput-active-high: Some channels have a break input,
	    whose polarity will be active low by default. If this
	    property is present, the channel will be configured with an
	    active high polarity for the break input.

Thierry

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYRU5DAAoJEN0jrNd/PrOhIVoP/ipDyPxMSX0731YW9Usinhih
5JOvAkw5VKbaGp8GML4ezlggBmhZW4UeuMxI02SIh3B6JIYt28xotd05O+bOi4fD
yycXmeJcOi6685EMFwz+WFJ3M23RLOXDSc3Mef3jbuqMRvwEws02W4rS2oUIUMpi
q/eIfb9XksFWsYJttX4KN+MN6kxRBfYKpohhdWiQAZX36ngwILqYKTvvBOp3Mi95
FujKj2TTzh99ouQdavT0Vp6xajCBdky2qHcYiH1UxaF/lRQfm0oTxhrcbdxw2pj4
TQppkREfpNyjYcJV+JpO2gKIDFomh9M30zt8crzNlCcbLgKE5v4XjuSA4Dk1w30/
ok2OxZZq5mX7q9K1NAklwwLQADA3epgAfrI21MFbdCBltt/DbpiClI37hz5gYRcW
EAucoQ9BxxuSz26wdV1UmCEzkm6DRYNbyN8h9etQRcSZkYa3ntABeHjG/NE5yfuF
xxhBAH61VH4bXz+3W5NlYmBN0NYKGYvmnaSnS3rk25Ysxq9XbjspL++U9ExuLfbo
WngusY8g8aIZkAHvZ3M8Poq1sKcYq7QYJYcVT/vlcnjrCbVfZh4K8ELdBZzI0VuE
/ESrdeICKPIdZXbopwLtnwxpGDfLOHLN4WE04Dbjic8JZokdYJsaZ2K6b/hw0ocQ
n4h9h1N2nQGTG9TOLQax
=C85s
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--
