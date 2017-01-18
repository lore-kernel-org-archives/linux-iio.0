Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36827 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756007AbdARLiD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2017 06:38:03 -0500
Date: Wed, 18 Jan 2017 12:37:59 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v7 4/8] PWM: add PWM driver for STM32 plaftorm
Message-ID: <20170118113759.GA16826@ulmo.ba.sec>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-5-git-send-email-benjamin.gaignard@st.com>
 <20170118100817.GF18989@ulmo.ba.sec>
 <CA+M3ks64VEE8a0oeiA8J-T5FDzwWTo=pdaMACy+pz7EyOQY-Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
In-Reply-To: <CA+M3ks64VEE8a0oeiA8J-T5FDzwWTo=pdaMACy+pz7EyOQY-Jg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 12:15:58PM +0100, Benjamin Gaignard wrote:
> 2017-01-18 11:08 GMT+01:00 Thierry Reding <thierry.reding@gmail.com>:
> > On Thu, Jan 05, 2017 at 10:25:40AM +0100, Benjamin Gaignard wrote:
[...]
> >> +static u32 active_channels(struct stm32_pwm *dev)
> >> +{
> >> +     u32 ccer;
> >> +
> >> +     regmap_read(dev->regmap, TIM_CCER, &ccer);
> >> +
> >> +     return ccer & TIM_CCER_CCXE;
> >> +}
> >
> > This looks like something that you could track in software, but this is
> > probably fine, too. Again, technically regmap_read() could fail, so you
> > might want to consider adding some code to handle it. In practice it
> > probably won't, so maybe you don't.
>=20
> TIM_CCER_CCXE is a value that IIO timer can also read (not write) so
> I have keep the same logic for pwm driver.

Would that not be racy? What happens if after active_channels() here,
the IIO timer modifies the TIM_CCER register?

> >> +     ret =3D stm32_pwm_config(chip, pwm, state->duty_cycle, state->pe=
riod);
> >> +     if (ret)
> >> +             return ret;
> >> +
> >> +     if (!enabled && state->enabled)
> >> +             ret =3D stm32_pwm_enable(chip, pwm);
> >> +
> >> +     return ret;
> >> +}
> >
> > Would it be possible to merge stm32_pwm_disable(), stm32_pwm_enable(),
> > stm32_pwm_set_polarity() and stm32_pwm_config() into stm32_pwm_apply()?
> > Part of the reason for the atomic API was to make it easier to write
> > these drivers, but your implementation effectively copies what the
> > transitional helpers do.
> >
> > It might not make a difference technically in your case, but I think
> > it'd make the implementation more compact and set a better example for
> > future reference.
>=20
> hmm... it will create a fat function with lot of where
> enabling/disabling/configuration
> will be mixed I'm really not convince that will more compact and readable.

I don't object to splitting this up into separate functions, I just
don't think the functions should correspond to the legacy ones. One
variant that I think could work out nicely would be to have one
function that precomputes the various values, call in from ->apply()
and then do only the register writes along with a couple of
conditionals depending on enable state, for example.

> >> +static const struct pwm_ops stm32pwm_ops =3D {
> >> +     .owner =3D THIS_MODULE,
> >> +     .apply =3D stm32_pwm_apply,
> >> +};
> >> +
> >> +static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
> >> +                                 int level, int filter)
> >> +{
> >> +     u32 bdtr =3D TIM_BDTR_BKE;
> >> +
> >> +     if (level)
> >> +             bdtr |=3D TIM_BDTR_BKP;
> >> +
> >> +     bdtr |=3D (filter & TIM_BDTR_BKF_MASK) << TIM_BDTR_BKF_SHIFT;
> >> +
> >> +     regmap_update_bits(priv->regmap,
> >> +                        TIM_BDTR, TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_B=
DTR_BKF,
> >> +                        bdtr);
> >> +
> >> +     regmap_read(priv->regmap, TIM_BDTR, &bdtr);
> >> +
> >> +     return (bdtr & TIM_BDTR_BKE) ? 0 : -EINVAL;
> >> +}
> >> +
> >> +static int stm32_pwm_set_breakinput2(struct stm32_pwm *priv,
> >> +                                  int level, int filter)
> >> +{
> >> +     u32 bdtr =3D TIM_BDTR_BK2E;
> >> +
> >> +     if (level)
> >> +             bdtr |=3D TIM_BDTR_BK2P;
> >> +
> >> +     bdtr |=3D (filter & TIM_BDTR_BKF_MASK) << TIM_BDTR_BK2F_SHIFT;
> >> +
> >> +     regmap_update_bits(priv->regmap,
> >> +                        TIM_BDTR, TIM_BDTR_BK2E |
> >> +                        TIM_BDTR_BK2P |
> >> +                        TIM_BDTR_BK2F,
> >> +                        bdtr);
> >> +
> >> +     regmap_read(priv->regmap, TIM_BDTR, &bdtr);
> >> +
> >> +     return (bdtr & TIM_BDTR_BK2E) ? 0 : -EINVAL;
> >> +}
> >
> > As far as I can tell the only difference here is the various bit
> > positions. Can you collapse the above two functions and add a new
> > parameter to unify some code?
>=20
> Yes it is all about bit shifting, I had try unify those two functions
> with index has additional parameter
> but it just add if() before each lines so no real benefit for code size.

How about if you precompute the values and masks? Something like:

	u32 bke =3D (index =3D=3D 0) ? ... : ...;
	u32 bkp =3D (index =3D=3D 0) ? ... : ...;
	u32 bkf =3D (index =3D=3D 0) ? ... : ...;
	u32 mask =3D (index =3D=3D 0) ? ... : ...;

	bdtr =3D bke | bkf;

	if (level)
		bdtr |=3D bkp;

	regmap_update_bits(priv->regmap, TIM_BDTR, mask, bdtr);

	regmap_read(priv->regmap, TIM_BDTR, &bdtr);

	return (bdtr & bke) ? 0 : -EINVAL;

?

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/U5QACgkQ3SOs138+
s6EQaw/6A5Lq/6+aW6RbpHpOY47xmaxjBMJt0KBCBJVnxlw/GWJKSf5AqTRfhZvi
wP5uo8eUOIjEdXtyBw4c7jUaz9OrJx64qtvwQq0KmLjH4Ix0t3mePVJZVI0LAHaD
FXFt9u1EXPLw3ruKR1YXlqwFWqOldlZxV3d45J45Q4d8Xl+daosSwBzX2Yy+bCzG
oB6JmbrRFFvEcX+kJMq1GlElzfBVqdfqymEZKvWsX4dl1uYV200Nh2cxUzB2RnVw
6gBBlOyPiFmJNMa3UrfW7yojrhN1IE9Sb6hwowjz/M2+re79b8Gu/BqssRdySc6Q
sLK1EWGLWkangoeTncdLL1o01n1obqyyHdKxBkq9Oi6YOY73nM1yvw4XQEjA8Chr
8Nn8tGgSeIqzRry56aY8wrNNulL3Fn+lT78sx2VCNQafDeOxAOY+Lrays6Ojy4Zq
+SY279iu0anM2+T9y88rr7h8aULeyZsn6SdFpCrdLtVmG83HiinYCsqGdccCkNzA
6nqarbgpoD7xfLUrMJtBjEIx93CiUts29GzMz+SXKYRFXVduNmD9qvgXKm6s4ZzY
0av2CjOqOu+IqOsik3iVrhluHMC7GFXHJCtXaKKznEx8Q7VwrxAosl58W2J3n2He
zM9YYvi1MG+ZngI+tjDiIKcty4DOUFHBmjo2pMYZRJzJ5wMcaBQ=
=Maik
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
