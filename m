Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36681 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbdARJY0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2017 04:24:26 -0500
Date: Wed, 18 Jan 2017 10:20:21 +0100
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
Subject: Re: [PATCH v7 3/8] PWM: add pwm-stm32 DT bindings
Message-ID: <20170118092021.GE18989@ulmo.ba.sec>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-4-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
In-Reply-To: <1483608344-9012-4-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2017 at 10:25:39AM +0100, Benjamin Gaignard wrote:
> Define bindings for pwm-stm32
>=20
> version 6:
> - change st,breakinput parameter format to make it usuable on stm32f7 too.
>=20
> version 2:
> - use parameters instead of compatible of handle the hardware configurati=
on
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 33 ++++++++++++++++=
++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Docume=
ntation/devicetree/bindings/pwm/pwm-stm32.txt
> new file mode 100644
> index 0000000..866f222
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> @@ -0,0 +1,33 @@
> +STMicroelectronics STM32 Timers PWM bindings
> +
> +Must be a sub-node of an STM32 Timers device tree node.
> +See ../mfd/stm32-timers.txt for details about the parent node.
> +
> +Required parameters:
> +- compatible:		Must be "st,stm32-pwm".
> +- pinctrl-names: 	Set to "default".
> +- pinctrl-0: 		List of phandles pointing to pin configuration nodes for =
PWM module.
> +			For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
> +
> +Optional parameters:
> +- st,breakinput:	Arrays of three u32 <index level filter> to describe br=
eak input configurations.
> +			"index" indicates on which break input the configuration should be ap=
plied.

It might be useful to specify what the valid values are for the break
input index.

Also, u32 is kind of a Linuxism, perhaps "Arrays of three cells"? Also,
does this mean there can be multiple entries? Such as 6 cells for two
configurations? What's the maximum number of such configurations?

If it's possible to specify multiple configurations, maybe a slightly
clearer wording would be: "One or more <index level filter> triplets to
describe..."

> +			"level" gives the active level (0=3Dlow or 1=3Dhigh) for this configu=
ration.

So how does this work exactly? "level" specifies the output level if the
filter value is matched?

> +			"filter" gives the filtering value to be applied.

Is this a single value at which "level" will be applied? Or is it an
upper/lower bound that can be used to restrict the output to "level" if
the signal goes beyond/below a certain threshold?

Maybe an example would clarify this. Or perhaps a reference to a manual
where a more in-depth description of this functionality can be found.

Thierry

--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/M1MACgkQ3SOs138+
s6FoGBAAoPA2amY+CvmCZQoYktOqkJpSoNPfge4/uzCau9x/jgz7gc2mRUhEYam3
qQUhkBtJ6npRcovfiad3Q8hHqBWeej0CO/TtTuFGBMRF7joYdZecy7BgskxuLS1g
9RM6ngvISwA63IkQ31JEMPgx51Z/Cg0mg4uql82r1oT5mb3kM0Y/f6lo58/lhhM0
3uppHrUWAIs/BdQ13q/MarMxZWfs5AMm5j+WWuKqoEQQM29HCEBy90tyDRD3Bwc9
FVIdnqGYulpgu+MgC8y/FF1t+woRE6kQp19YFsYMvCtpocv7qyANjgKKiTOCUhUG
+utVT9+yoS9U1iO1PXovtCMooryACfgqObuCPBAedOlx+K1MTqs8x1c9QbXWxJww
2KOHutj4qcqtYQVxLhE3JrMKrEr5dKnC+Q9bi5OBb3NylGokPUH2Q/g52che5ca0
CpJvHTcwOy8RM2CiVpLIbAboaUyA+mnpGeH6NnM/674PtZqRd258EH3Y7AZ8YezD
Ho0v6WolcYD9GfMe8EzrZAlHzM30w/fAT7vkykmxOVa9COXSYgPRK4XNPVYbCT9G
FKQ3UbjLe2Fp7xGioANMqGugRbLCa07F5uTj5VaryQPzVBHcB7adBHkiJuyq3Xrz
Mm3Xigav6FIjs+OxtxnHl/mY+xdCcYSJOOeR+I3/lMFPILvXCn0=
=t9ed
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--
