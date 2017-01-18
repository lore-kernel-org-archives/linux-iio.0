Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33886 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbdARKQd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2017 05:16:33 -0500
Date: Wed, 18 Jan 2017 11:16:28 +0100
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
Subject: Re: [PATCH v7 4/8] PWM: add PWM driver for STM32 plaftorm
Message-ID: <20170118101628.GG18989@ulmo.ba.sec>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-5-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
In-Reply-To: <1483608344-9012-5-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2017 at 10:25:40AM +0100, Benjamin Gaignard wrote:
[...]
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index f92dd41..88035c0 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -397,6 +397,15 @@ config PWM_STI
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sti.
> =20
> +config PWM_STM32
> +	tristate "STMicroelectronics STM32 PWM"
> +	depends on (ARCH_STM32 && OF && MFD_STM32_TIMERS) || COMPILE_TEST

One other thing: is the dependency on ARCH_STM32 and OF necessary here?
ARCH_STM32 and OF are both pulled in by MFD_STM32_TIMERS. The dependency
is probably fine for MFD_STM32_TIMERS, though even there && OF seems too
much, since it's already pulled in via ARCH_STM32 -> ARM_SINGLE_ARMV7M
-> USE_OF.

Thierry

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/QHwACgkQ3SOs138+
s6E5+w//XfwIArWYSDhzR6T8ZwuoV4vBM49Qt+985Fuqe1hkCfrKARb+cFPcAbyi
uXKIlnycXa26rzLgBQiyL6z77HKaiqNCxiNC7F3BKsX1FcVl1Pkk9cYiW23m5mv3
Zz5H+ztd/hvrQMEcg8MzB4wopJdh3iaj8097DFrsyGzUk1kQiUjTYCCyg2soaJ4L
XRUg5ny0QyXC9gap9Zk2i1tOyLU+VH1npkATEvU9Dac78qdO2kGz4h35XoTAvI5F
yCCdKSwNYf3/bBohximQjJNC2JM8loSUAiMa3HG6AKvPlXC10Lu8ZSbSZ5mfL3uS
lvi9StpErHXbEBlUBAPrkkcpTaQQN97odbtkf34dM9CfZCxPs+Bfm3KrnFpb6bM4
ZVjXIr67gjIpFiOSQ6INvzH0Q2Y1YtspMM0fMggUz/uzWftSwti6gz5Flk2z4ZFU
ZQhvJbYEYN6/n4VWEtruYIHQ822VwoWXPQ8Jupp/bJM99YHRe47XWoNittTUOjLq
RZoW+KwKwOPuSveUZN1xj1oPf6mnEOd1hzHRw54azcGHv3UpPknHcjCBtQFg+6kB
XFtDs4fESH4ZQnYQaghgL2XW/Ou2GIEpg8mT8wukPyTFzPTO94LrQNCNt6iNdIAh
ZLIkJN2J3acCCUn5wHk570ksT4Qm8sGOvhQg++w9ytx3oLjDC0s=
=QhbU
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--
