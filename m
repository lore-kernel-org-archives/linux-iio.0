Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559439CD01;
	Thu, 16 Jul 2026 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186140; cv=none; b=Q+QOd5Lxy34qYVJWgJdK5op3tgfipCC4n763q9tXzorBWDWLZvnSNp/+37XF5MphzH+J4w2DRdRk0rjgPcuc47Ryt9AVg9C0xWY5llZaDctcS9eYy1mMB9mFkdugMMAKlqFQ4SpivAZN15KXtfJ5wfTRHc71iOHPXqbd77ktyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186140; c=relaxed/simple;
	bh=WG82U4sThSimZ8pJp8bKDS4TEGZ6pt0UEc6gUospZ7w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=G4xtxooYEJx/wPUFZo22UhVObMgciEKP/AYZBX2piDsMkrnXGhmo16VHDhVo00DB7jeHKYTXbc/4feKhbuVV4GY7G2pAdXLvO496I69xirW5aWwRqtIy+y+e8ukAp6YNWel2g7kOS4Dq+ykfPf2n+cxd+1ne1/3LbNMslqxdjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 0BBAC282;
	Thu, 16 Jul 2026 09:15:30 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 09:15:29 +0200
Message-Id: <DJZT74OCHTA2.3LLOKE9Y2SBXO@kernel.org>
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
To: "Yu-Chun Lin" <eleanor.lin@realtek.com>
X-Mailer: aerc 0.20.0
References: <d301ba0cd45d49d59e6a014188306ec9@realtek.com>
 <20260716062614.1507243-1-eleanor.lin@realtek.com>
In-Reply-To: <20260716062614.1507243-1-eleanor.lin@realtek.com>

Hi,

On Thu Jul 16, 2026 at 8:26 AM CEST, Yu-Chun Lin wrote:
>>> > @@ -185,7 +218,7 @@ static int gpio_regmap_set_direction(struct
>>> gpio_chip *chip,
>>> >                                    unsigned int offset, bool output)
>>> > {
>>> >       struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
>>> > -     unsigned int base, val, reg, mask;
>>> > +     unsigned int base, val, reg, mask, wren_mask;
>>> >       int invert, ret;
>>> >
>>> >       if (gpio->reg_dir_out_base) {
>>> > @@ -198,7 +231,12 @@ static int gpio_regmap_set_direction(struct
>>> gpio_chip *chip,
>>> >               return -ENOTSUPP;
>>> >       }
>>> >
>>> > -     ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
>>> > +     ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_DIR_OP, base=
,
>>> offset, &reg, &mask);
>>> > +     if (ret)
>>> > +             return ret;
>>> > +
>>> > +     ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_DIR_WREN_OP,
>>> base, offset, &reg,
>>> > +                                &wren_mask);
>>>=20
>>> What constrains these two to provide the same value back for reg?
>>> To me it seems like the write enable might well be in a different regis=
ter.
>>>=20
>>> >       if (ret)
>>> >               return ret;
>>> >
>>> > @@ -207,7 +245,7 @@ static int gpio_regmap_set_direction(struct
>>> gpio_chip *chip,
>>> >       else
>>> >               val =3D output ? mask : 0;
>>> >
>>> > -     return regmap_update_bits(gpio->regmap, reg, mask, val);
>>> > +     return regmap_update_bits(gpio->regmap, reg, mask | wren_mask,
>>> > + val | wren_mask);
>>> >  }
>>> >
>>> >  static int gpio_regmap_direction_input(struct gpio_chip *chip,
>>
>> My initial design indeed assumed that the WREN mask and Data mask reside=
 in
>> the same register.
>> =20
>> Regarding WREN support, especially if WREN and Data use separate registe=
rs, I
>> came up with three ideas. Which direction do you prefer?
>> =20
>> Approach 1: Provide Custom Callbacks in config (Let consumer driver hand=
le it)
>> We can add '.set' and '.set_direction' function pointers in
>> 'struct gpio_regmap_config'. If a driver requires WREN, it can implement=
 these
>> callbacks itself.
>>=20
>> static void gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,=
 int val)
>> {
>>         struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
>> =20
>>         /* If the driver provides a custom set (to handle WREN), delegat=
e to it */
>>         if (gpio->set) {
>>                 gpio->set(chip, offset, val);
>>                 return;
>>         }
>>         /* ... existing generic regmap logic ... */
>> }
>>
>> Pros: Clean core, no need to touch existing drivers' xlate signature. Th=
e consumer
>> driver handles its own locking for different registers.
>> Cons: It feels a bit strange and inconsistent to expose only '.set' and
>> '.set_direction' overrides while keeping other operations entirely abstr=
acted.
>> =20
>> Approach 2: Handle separate WREN register in the core (with locking conc=
erns)
>> We keep the 'XX_WREN_OP' in 'xlate'. If someone needs WREN and 'wren_reg=
 !=3D reg',
>> we write to both.
>> =20
>> static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
>>                            int val)
>> {
>>         /* skip */
>>         ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_WREN_OP, base=
, offset, &wren_reg,
>>                                    &wren_mask);
>>         if (ret =3D=3D -ENOTSUPP)
>>                 has_wren =3D false;
>>         else if (ret)
>>                 return ret;
>>=20
>>        ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, offs=
et, &reg, &mask);
>>=20
>>        if (has_wren && reg =3D=3D wren_reg) {
>>                mask |=3D wren_mask;
>>                mask_val |=3D wren_mask;
>>                has_wren =3D false;
>>        }
>>=20
>>        if (has_wren)
>>                ret =3D regmap_set_bits(gpio->regmap, wren_reg, wren_mask=
);=20
>>=20
>>         /* ignore input values which shadow the old output value */
>>         if (gpio->reg_dat_base =3D=3D gpio->reg_set_base)
>>                 ret =3D regmap_write_bits(gpio->regmap, reg, mask, mask_=
val);
>>         else
>>                 ret =3D regmap_update_bits(gpio->regmap, reg, mask, mask=
_val);
>> =20
>>         return ret;
>> }
>> =20
>> Pros: Keeps all WREN logic unified inside the core framework.
>> Cons: Introduces a locking issue. writing to 'wren_reg' and then 'reg' r=
equires an
>> external lock to be atomic, which seems to defeat the purpose of relying=
 on regmap's
>> internal lock.=20
>>=20
>> Approach 3: Assume WREN and Data always share the same register
>>=20
>> static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset, =
int val)
>> {
>>         /* ... */
>>         ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_WREN_OP, base=
, offset, &reg, &wren_mask);
>>         if (ret =3D=3D -ENOTSUPP)
>>                 wren_mask =3D 0;
>>         else if (ret)
>>                 return ret;
>> =20
>>         ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, off=
set, &reg, &mask);
>> =20
>>         ret =3D regmap_update_bits(gpio->regmap, reg, mask | wren_mask, =
mask_val | wren_mask);
>>         return ret;
>> }
>> =20
>> Regarding this approach, I would like to ask from your experience: Is it
>> actually common for hardware designs to place WREN and Data bits in comp=
letely
>> different registers for GPIO operations?

I'd say that such a write enable bit by itself is pretty uncommon
for a gpio controller, regardless if it's in the same register or in
a different one.

>> If they practically always share the same register, this simpler approac=
h might
>> suffice.

It seems, that your hardware has it in one register. Why do you need
a separate mask anyway? Why can't the xlate callback just set the
bit in addition to the gpio bit? It looks like in the end you're
doing a "mask |  wren_mask" anyway. What am I missing here?

-michael
