Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9112C11FA;
	Thu, 16 Jul 2026 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183261; cv=none; b=aH1adM537poljI1ZzLQvrgPCzhq6kA5P6+tHpgzwWW437XaiSDzkMbwe3q5fkgfb30lrbipfd86jHNU4bKAdVD8rCWMeum1buHjSNgiRYbBVzcnwVZ5NeKbJsZ6U4NGq0tmPmnppRuJlqFKtG2VOOvoj/seJ8NRSWwAHS2j7g4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183261; c=relaxed/simple;
	bh=VEGCQA616zpgJx2Ani0WsRZAcwzbiIDqlj1EZLGZ7uM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SsKjYfYTUv+DlSm5vVrK+GqESPIz6mBWmkeDdBQnFBJEDH+Q5AuLO9B/qzM8qhq5gOkFfHyBWLSv+fMpwIbRHRlBXk1Pe2FGsmFYqAjCungNNDuLLsZv1fFFXtttyUeRJjhQsAJaKZ/dEoV+XuTo7T7UIHwx8nMbxSw6RL/vD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fBeupTKW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fBeupTKW"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66G6QGYf83437599, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784183176; bh=Y5XRNJnPZSAm5lm9IWfGalOvrFDddPu+vsDu/YFgQc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=fBeupTKWxRaRBWdddptFNMx+fjL1aA6jvZEhiWo8xxEpGRLymmABf0praAWzC3g5k
	 2cHUBltj+ZFZb3Qg6TcXr7ifpSJOs1tGxpDYZX0ZY2NkgYoL0iSUHrjoJ+03HtNxEF
	 9soMuSEBLZoQOXOAKVCuiw5YehRRF6QpmzX4CoHu4cLzLywNgvx9xLZt+0+drbx/y8
	 BNvaRbF6zQMmLzGS85PfCM6k1N0Fibv3tGTAgSqWP2WUH5sHO8FrDWPe0oFLC2Wtd+
	 vnbnCapIptOEC67x3wBP3WFhWrVDgP1qvaHkJnuUGqhHIFCTn1amJG9scr5LpVpb4l
	 LUknsjKR0nl1g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66G6QGYf83437599
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 14:26:16 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 16 Jul 2026 14:26:15 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 16 Jul 2026 14:26:14 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <eleanor.lin@realtek.com>
CC: <Michael.Hennerich@analog.com>, <afaerber@suse.com>, <andy@kernel.org>,
	<brgl@kernel.org>, <conor+dt@kernel.org>, <cy.huang@realtek.com>,
	<devicetree@vger.kernel.org>, <dlechner@baylibre.com>,
	<james.tai@realtek.com>, <jic23@kernel.org>, <krzk+dt@kernel.org>,
	<lars@metafoo.de>, <linus.walleij@linaro.org>, <linusw@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-realtek-soc@lists.infradead.org>, <mathieu.dubois-briand@bootlin.com>,
	<mwalle@kernel.org>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<stanley_chang@realtek.com>, <tychang@realtek.com>, <wbg@kernel.org>
Subject: RE: [PATCH v3 3/7] gpio: regmap: Add gpio_regmap_operation and write-enable support
Date: Thu, 16 Jul 2026 14:26:14 +0800
Message-ID: <20260716062614.1507243-1-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <d301ba0cd45d49d59e6a014188306ec9@realtek.com>
References: <d301ba0cd45d49d59e6a014188306ec9@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hi all,

>> > @@ -185,7 +218,7 @@ static int gpio_regmap_set_direction(struct
>> gpio_chip *chip,
>> >                                    unsigned int offset, bool output)
>> > {
>> >       struct gpio_regmap *gpio = gpiochip_get_data(chip);
>> > -     unsigned int base, val, reg, mask;
>> > +     unsigned int base, val, reg, mask, wren_mask;
>> >       int invert, ret;
>> >
>> >       if (gpio->reg_dir_out_base) {
>> > @@ -198,7 +231,12 @@ static int gpio_regmap_set_direction(struct
>> gpio_chip *chip,
>> >               return -ENOTSUPP;
>> >       }
>> >
>> > -     ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
>> > +     ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_DIR_OP, base,
>> offset, &reg, &mask);
>> > +     if (ret)
>> > +             return ret;
>> > +
>> > +     ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_DIR_WREN_OP,
>> base, offset, &reg,
>> > +                                &wren_mask);
>> 
>> What constrains these two to provide the same value back for reg?
>> To me it seems like the write enable might well be in a different register.
>> 
>> >       if (ret)
>> >               return ret;
>> >
>> > @@ -207,7 +245,7 @@ static int gpio_regmap_set_direction(struct
>> gpio_chip *chip,
>> >       else
>> >               val = output ? mask : 0;
>> >
>> > -     return regmap_update_bits(gpio->regmap, reg, mask, val);
>> > +     return regmap_update_bits(gpio->regmap, reg, mask | wren_mask,
>> > + val | wren_mask);
>> >  }
>> >
>> >  static int gpio_regmap_direction_input(struct gpio_chip *chip,
>
> My initial design indeed assumed that the WREN mask and Data mask reside in
> the same register.
>  
> Regarding WREN support, especially if WREN and Data use separate registers, I
> came up with three ideas. Which direction do you prefer?
>  
> Approach 1: Provide Custom Callbacks in config (Let consumer driver handle it)
> We can add '.set' and '.set_direction' function pointers in
> 'struct gpio_regmap_config'. If a driver requires WREN, it can implement these
> callbacks itself.
> 
> static void gpio_regmap_set(struct gpio_chip *chip, unsigned int offset, int val)
> {
>         struct gpio_regmap *gpio = gpiochip_get_data(chip);
>  
>         /* If the driver provides a custom set (to handle WREN), delegate to it */
>         if (gpio->set) {
>                 gpio->set(chip, offset, val);
>                 return;
>         }
>         /* ... existing generic regmap logic ... */
> }
>
> Pros: Clean core, no need to touch existing drivers' xlate signature. The consumer
> driver handles its own locking for different registers.
> Cons: It feels a bit strange and inconsistent to expose only '.set' and
> '.set_direction' overrides while keeping other operations entirely abstracted.
>  
> Approach 2: Handle separate WREN register in the core (with locking concerns)
> We keep the 'XX_WREN_OP' in 'xlate'. If someone needs WREN and 'wren_reg != reg',
> we write to both.
>  
> static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
>                            int val)
> {
>         /* skip */
>         ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_WREN_OP, base, offset, &wren_reg,
>                                    &wren_mask);
>         if (ret == -ENOTSUPP)
>                 has_wren = false;
>         else if (ret)
>                 return ret;
> 
>        ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset, &reg, &mask);
> 
>        if (has_wren && reg == wren_reg) {
>                mask |= wren_mask;
>                mask_val |= wren_mask;
>                has_wren = false;
>        }
> 
>        if (has_wren)
>                ret = regmap_set_bits(gpio->regmap, wren_reg, wren_mask); 
> 
>         /* ignore input values which shadow the old output value */
>         if (gpio->reg_dat_base == gpio->reg_set_base)
>                 ret = regmap_write_bits(gpio->regmap, reg, mask, mask_val);
>         else
>                 ret = regmap_update_bits(gpio->regmap, reg, mask, mask_val);
>  
>         return ret;
> }
>  
> Pros: Keeps all WREN logic unified inside the core framework.
> Cons: Introduces a locking issue. writing to 'wren_reg' and then 'reg' requires an
> external lock to be atomic, which seems to defeat the purpose of relying on regmap's
> internal lock. 
> 
> Approach 3: Assume WREN and Data always share the same register
> 
> static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset, int val)
> {
>         /* ... */
>         ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_WREN_OP, base, offset, &reg, &wren_mask);
>         if (ret == -ENOTSUPP)
>                 wren_mask = 0;
>         else if (ret)
>                 return ret;
>  
>         ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset, &reg, &mask);
>  
>         ret = regmap_update_bits(gpio->regmap, reg, mask | wren_mask, mask_val | wren_mask);
>         return ret;
> }
>  
> Regarding this approach, I would like to ask from your experience: Is it
> actually common for hardware designs to place WREN and Data bits in completely
> different registers for GPIO operations?
> 
> If they practically always share the same register, this simpler approach might
> suffice.
>  
> Best Regards,
> Yu Chun Lin
> 

If there are no further concerns, I will proceed with the third approach and
send out v6.

Thanks.
Yu-Chun
