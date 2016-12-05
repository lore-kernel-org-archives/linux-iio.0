Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34818 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbcLEGxy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2016 01:53:54 -0500
Date: Mon, 5 Dec 2016 07:53:50 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        gerald.baeza@st.com, arnaud.pouliquen@st.com,
        linus.walleij@linaro.org, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3 3/7] PWM: add pwm-stm32 DT bindings
Message-ID: <20161205065350.GA18069@ulmo.ba.sec>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-4-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
In-Reply-To: <1480673842-20804-4-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2016 at 11:17:18AM +0100, Benjamin Gaignard wrote:
> Define bindings for pwm-stm32
>=20
> version 2:
> - use parameters instead of compatible of handle the hardware configurati=
on
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 38 ++++++++++++++++=
++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Docume=
ntation/devicetree/bindings/pwm/pwm-stm32.txt
> new file mode 100644
> index 0000000..575b9fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> @@ -0,0 +1,38 @@
> +STMicroelectronics PWM driver bindings for STM32

Technically this bindings describe devices, so "driver binding" is a
somewhat odd wording. Perhaps:

	STMicroelectronics STM32 General Purpose Timer PWM bindings

?

> +
> +Must be a sub-node of STM32 general purpose timer driver
> +Parent node properties are describe in ../mfd/stm32-general-purpose-time=
r.txt

Again, "driver parent node" is odd. Perhaps:

	Must be a sub-node of an STM32 General Purpose Timer device tree
	node. See ../mfd/stm32-general-purpose-timer.txt for details about
	the parent node.

?

> +Required parameters:
> +- compatible:		Must be "st,stm32-pwm"
> +- pinctrl-names: 	Set to "default".
> +- pinctrl-0: 		List of phandles pointing to pin configuration nodes
> +			for PWM module.
> +			For Pinctrl properties, please refer to [1].

Your indentation and capitalization are inconsistent. Also, please refer
to the pinctrl bindings by relative path and inline, rather than as a
footnote reference.

> +
> +Optional parameters:
> +- st,breakinput:	Set if the hardware have break input capabilities
> +- st,breakinput-polarity: Set break input polarity. Default is 0
> +			 The value define the active polarity:
> +			  - 0 (active LOW)
> +			  - 1 (active HIGH)

Could we fold these into a single property? If st,breakinput-polarity is
not present it could simply mean that there is no break input, and if it
is present you don't have to rely on a default.

> +- st,pwm-num-chan:	Number of available PWM channels.  Default is 0.

The pwm- prefix is rather redundant since the node is already named pwm.
Why not simply st,channels? Or simply channels, since it's not really
anything specific to this hardware.

Come to think of it, might be worth having a discussion with our DT
gurus about what their stance is on using the # as prefix for numbers
(such as in #address-cells or #size-cells). This could be #channels to
mark it more explicitly as representing a count.

> +- st,32bits-counter:	Set if the hardware have a 32 bits counter
> +- st,complementary:	Set if the hardware have complementary output channe=
ls

"hardware has" and also maybe mention explicitly that this is a boolean
property. Otherwise people might be left wondering what it should be set
to. Or maybe word this differently to imply that it's boolean:

	- st,32bits-counter: if present, the hardware has a 32 bit counter
	- st,complementary: if present, the hardware has a complementary
	                    output channel

Thierry

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYRQ77AAoJEN0jrNd/PrOhOBgP/28PHXhXGflOwIPIw+NEH8Gc
kk0pZoSr1PXL4IjdXS6Kb//qZPjZ/eMTKhpEmqsB3fQQDVaFrPaEMukdiZgc3utQ
SJSR6uIlhDSdFeUojY6EwQ8GmGy90G1V/fDoRmshgmXSEyssxY9o75EpbADax/T6
6HEljxgJOlQ1g6xdIeGkr3CCm4Y2EWF1u7gOJ9wj/YOPSFbzZcbdEqVrP7m448vN
iRdG0cFgJXfGXGrj58g1Wg/oZN8lVQ8qu60ryyE5zg8iZi9QG5SyQGLpOIDnvauT
Gr+8q2VO138SKS1CMRt/ikveB+LC1ewh/UDDx32+ey1oqVlWAGzaGw6b+tdiqEnD
LvCRRtYRdENtvyELdzMCHRVZ2d0kDmpNKdKk07WCPVebbRS88RTZi5ETLHlOIH1h
n0EtU/D4L7YiRCuUiszTRtaP8euQ1JSYOd/W0r8XOObfUazK3NZLyhQZBZ1BPOgn
N/uX/B7wUa/pOaGfzZhkNQnq9+qozB8STLsuwUmzrKFIbnEP6k5mWr4LQNGYx7gd
IOdwf0CU+UaHTYrEDD2NOuzBFEaJD7+UWXjN7K+oS9hhB/F/B+oRjs/GH/iaD12F
JYMiMgpSK3wzqJzizk2Hy1hPILD5lKYVo4vg7nFlolLWq+MYCcCRf1Hg7ujjnL0v
ypLoafI4gGOAvqXIypwc
=gtLz
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
