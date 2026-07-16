Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A37332EC5;
	Thu, 16 Jul 2026 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192941; cv=none; b=kAmqyPZl5eEKV0yKtpv5gqiqZARpUKVa9KLssNhvhg4NJtapEMgXtmS1CHb0FjJZ8lM1xpjJ+K/L2X7PR7zULpobBcZk055GHyTwN7vj3pmidoQeL+0gQmOnZKoVKOQRajEINyqdf2JtslgSWSTS4r57+Xy0uavjHEqVKwZAL6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192941; c=relaxed/simple;
	bh=8gpf2u0nVssbIpYXbfiW7CRX7d6ODFtMXkv44gvc46U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=QTvi/4tQkISuw0wb59gtALp6h9qIqIGATVMVHiTXcWtW/WSeGaju9fyK6EAdUWDkL7wX9sTCEInOoLoihutBiTuudi9Nmlzi/aFJl572t4a7bTnHRUPtiv3QH3tokD3YBhH0J9vRXOc7apeQR7RAm6y/do5kTKSNVVTgFpAf4Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id B2247179;
	Thu, 16 Jul 2026 11:08:55 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 11:08:55 +0200
Message-Id: <DJZVLZ4LLD9E.3MPLYYXT1VQ9R@kernel.org>
Subject: Re: [PATCH v3 3/7] gpio: regmap: Add gpio_regmap_operation and
 write-enable support
Cc: <Michael.Hennerich@analog.com>, <afaerber@suse.com>, <andy@kernel.org>,
 <brgl@kernel.org>, <conor+dt@kernel.org>, <cy.huang@realtek.com>,
 <devicetree@vger.kernel.org>, <dlechner@baylibre.com>,
 <james.tai@realtek.com>, <jic23@kernel.org>, <krzk+dt@kernel.org>,
 <lars@metafoo.de>, <linus.walleij@linaro.org>, <linusw@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-realtek-soc@lists.infradead.org>,
 <mathieu.dubois-briand@bootlin.com>, <nuno.sa@analog.com>,
 <robh@kernel.org>, <stanley_chang@realtek.com>, <tychang@realtek.com>,
 <wbg@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Yu-Chun Lin"
 <eleanor.lin@realtek.com>
X-Mailer: aerc 0.20.0
References: <d301ba0cd45d49d59e6a014188306ec9@realtek.com>
 <20260716062614.1507243-1-eleanor.lin@realtek.com>
 <aliV4u6_xzx9D9Aq@ashevche-desk.local>
In-Reply-To: <aliV4u6_xzx9D9Aq@ashevche-desk.local>

On Thu Jul 16, 2026 at 10:27 AM CEST, Andy Shevchenko wrote:
> On Thu, Jul 16, 2026 at 02:26:14PM +0800, Yu-Chun Lin wrote:
>
> ...
>
>> >> > -     ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask)=
;
>> >> > +     ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_DIR_OP, ba=
se,
>> >> offset, &reg, &mask);
>> >> > +     if (ret)
>> >> > +             return ret;
>> >> > +
>> >> > +     ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_DIR_WREN_O=
P,
>> >> base, offset, &reg,
>> >> > +                                &wren_mask);
>> >>=20
>> >> What constrains these two to provide the same value back for reg?
>> >> To me it seems like the write enable might well be in a different reg=
ister.
>> >>=20
>> >> >       if (ret)
>> >> >               return ret;
>
> ...
>
>> >> > -     return regmap_update_bits(gpio->regmap, reg, mask, val);
>> >> > +     return regmap_update_bits(gpio->regmap, reg, mask | wren_mask=
,
>> >> > + val | wren_mask);
>> >> >  }
>> >> >
>> >> >  static int gpio_regmap_direction_input(struct gpio_chip *chip,
>> >
>> > My initial design indeed assumed that the WREN mask and Data mask resi=
de in
>> > the same register.
>> > =20
>> > Regarding WREN support, especially if WREN and Data use separate regis=
ters, I
>> > came up with three ideas. Which direction do you prefer?
>> > =20
>> > Approach 1: Provide Custom Callbacks in config (Let consumer driver ha=
ndle it)
>> > We can add '.set' and '.set_direction' function pointers in
>> > 'struct gpio_regmap_config'. If a driver requires WREN, it can impleme=
nt these
>> > callbacks itself.
>> >=20
>> > static void gpio_regmap_set(struct gpio_chip *chip, unsigned int offse=
t, int val)
>> > {
>> >         struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
>> > =20
>> >         /* If the driver provides a custom set (to handle WREN), deleg=
ate to it */
>> >         if (gpio->set) {
>> >                 gpio->set(chip, offset, val);
>> >                 return;
>> >         }
>> >         /* ... existing generic regmap logic ... */
>> > }
>> >
>> > Pros: Clean core, no need to touch existing drivers' xlate signature. =
The consumer
>> > driver handles its own locking for different registers.
>> > Cons: It feels a bit strange and inconsistent to expose only '.set' an=
d
>> > '.set_direction' overrides while keeping other operations entirely abs=
tracted.
>> > =20
>> > Approach 2: Handle separate WREN register in the core (with locking co=
ncerns)
>> > We keep the 'XX_WREN_OP' in 'xlate'. If someone needs WREN and 'wren_r=
eg !=3D reg',
>> > we write to both.
>> > =20
>> > static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset=
,
>> >                            int val)
>> > {
>> >         /* skip */
>> >         ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_WREN_OP, ba=
se, offset, &wren_reg,
>> >                                    &wren_mask);
>> >         if (ret =3D=3D -ENOTSUPP)
>> >                 has_wren =3D false;
>> >         else if (ret)
>> >                 return ret;
>> >=20
>> >        ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, of=
fset, &reg, &mask);
>> >=20
>> >        if (has_wren && reg =3D=3D wren_reg) {
>> >                mask |=3D wren_mask;
>> >                mask_val |=3D wren_mask;
>> >                has_wren =3D false;
>> >        }
>> >=20
>> >        if (has_wren)
>> >                ret =3D regmap_set_bits(gpio->regmap, wren_reg, wren_ma=
sk);=20
>> >=20
>> >         /* ignore input values which shadow the old output value */
>> >         if (gpio->reg_dat_base =3D=3D gpio->reg_set_base)
>> >                 ret =3D regmap_write_bits(gpio->regmap, reg, mask, mas=
k_val);
>> >         else
>> >                 ret =3D regmap_update_bits(gpio->regmap, reg, mask, ma=
sk_val);
>> > =20
>> >         return ret;
>> > }
>> > =20
>> > Pros: Keeps all WREN logic unified inside the core framework.
>> > Cons: Introduces a locking issue. writing to 'wren_reg' and then 'reg'=
 requires an
>> > external lock to be atomic, which seems to defeat the purpose of relyi=
ng on regmap's
>> > internal lock.=20
>> >=20
>> > Approach 3: Assume WREN and Data always share the same register
>> >=20
>> > static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset=
, int val)
>> > {
>> >         /* ... */
>> >         ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_WREN_OP, ba=
se, offset, &reg, &wren_mask);
>> >         if (ret =3D=3D -ENOTSUPP)
>> >                 wren_mask =3D 0;
>> >         else if (ret)
>> >                 return ret;
>> > =20
>> >         ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, o=
ffset, &reg, &mask);
>> > =20
>> >         ret =3D regmap_update_bits(gpio->regmap, reg, mask | wren_mask=
, mask_val | wren_mask);
>> >         return ret;
>> > }
>> > =20
>> > Regarding this approach, I would like to ask from your experience: Is =
it
>> > actually common for hardware designs to place WREN and Data bits in co=
mpletely
>> > different registers for GPIO operations?
>> >=20
>> > If they practically always share the same register, this simpler appro=
ach might
>> > suffice.
>>=20
>> If there are no further concerns, I will proceed with the third approach=
 and
>> send out v6.
>
> From the above list I tend to the approach 2, but this might require to h=
ave
> GPIO regmap level of locking. I'm a bit lost in the context, though. I as=
sume
> we need a fresh start, id est issue a v6 with approach 2 or 3 in place an=
d
> summarize the choices in the cover letter, so we can understand what has =
been
> considered.

I don't really like approach 3. You'd need to check if the regs of
both xlate calls are the same. With the sample code above, you
silently drop the first xlate'd reg.

And honestly, it really seems like a one-off. What controllers, are
there that need a write enable bit. The real problem seems to be
the assumption that we operate on just one bit. IOW we either set
mask or don't set mask in gpio_regmap_set().

For a more generic solution, we should be able to control the
written value. We could add another .value_xlate().

-michael
