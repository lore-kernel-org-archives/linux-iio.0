Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75EB3F8707;
	Thu, 16 Jul 2026 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199835; cv=none; b=qyLhiQxLU8VK9CaGr6dL7BCIV/3mjGolTQ5M+A/OQBFODoVKHp1wm3af4yoodmmAh6A3Jije+FkkRlSrbpO55SdkP4mIheaY8AgK1S++l4xvzuTyD/LOp6Hq73WX8ueJ6WDU1Xy0HHuspDxWBNSFSrBPyuYJalOYWRK2ekQinCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199835; c=relaxed/simple;
	bh=RChPHCJl/SnxG4TxVUgHq12/TFi+YR2Qt/FOzm0TNqo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=o2W4NKHZa75NmOKJprdEdgM0+/0iQt9e4rXdhkRrH/vkQr48kIH5EGQguLNdkpBnjVGMlt3ttxPvoUJGKBdW97ciaix+5MX23sABC2J87RyIRc5MDxOfyuUySi+7GfrfogQU5sT44/oLYPBjyRRRv2HYTsBU+84OTsn67G/yzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id BA6F22AA;
	Thu, 16 Jul 2026 13:03:50 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 13:03:50 +0200
Message-Id: <DJZY1YPMDLIN.3W0QOPEI9L8JA@kernel.org>
Cc: "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
 "afaerber@suse.com" <afaerber@suse.com>, "andy@kernel.org"
 <andy@kernel.org>, "brgl@kernel.org" <brgl@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 =?utf-8?b?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "dlechner@baylibre.com" <dlechner@baylibre.com>,
 =?utf-8?b?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linusw@kernel.org"
 <linusw@kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org"
 <linux-gpio@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-realtek-soc@lists.infradead.org"
 <linux-realtek-soc@lists.infradead.org>,
 "mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>,
 "nuno.sa@analog.com" <nuno.sa@analog.com>, "robh@kernel.org"
 <robh@kernel.org>, =?utf-8?b?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?=
 <stanley_chang@realtek.com>, =?utf-8?b?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?=
 <tychang@realtek.com>, "wbg@kernel.org" <wbg@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: =?utf-8?b?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>,
 "Andy Shevchenko" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 3/7] gpio: regmap: Add gpio_regmap_operation and
 write-enable support
X-Mailer: aerc 0.20.0
References: <d301ba0cd45d49d59e6a014188306ec9@realtek.com>
 <20260716062614.1507243-1-eleanor.lin@realtek.com>
 <aliV4u6_xzx9D9Aq@ashevche-desk.local>
 <DJZVLZ4LLD9E.3MPLYYXT1VQ9R@kernel.org>
 <alim_HGTD5RCupav@ashevche-desk.local>
 <9ee344c1d9c642bdb7d3b85bc922fe66@realtek.com>
In-Reply-To: <9ee344c1d9c642bdb7d3b85bc922fe66@realtek.com>

Hi,

On Thu Jul 16, 2026 at 12:47 PM CEST, Yu-Chun Lin [=E6=9E=97=E7=A5=90=E5=90=
=9B] wrote:
> I checked with our internal hardware engineers. The WREN bit was designed=
 to
> avoid race conditions, which requires both the data bit and the WREN bit =
to be
> updated simultaneously within the same register.

Your mail just arrived as I was writing my reply. So yeah, that's
basically what I was saying.

> I have a new idea that might be similar to Michael's suggestion.

If not almost exactly what I had in mind. :)

> We can
> introduce a new callback to allow the driver to intercept and modify the
> mask and the value. By doing so, the driver can determine the correspondi=
ng
> WREN bit based on the original mask, and assemble the WREN bit into this =
new
> callback function right before the final write API is executed.
>
> The idea looks like:
>
> static void gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
> 			   int val)
> {
> 	struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
> 	unsigned int base =3D gpio_regmap_addr(gpio->reg_set_base);
> 	unsigned int reg, mask, mask_val, wren_reg, wren_mask;
> 	int ret;
>
> 	ret =3D gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset, &re=
g, &mask);
> 	if (ret)
> 		return;
>
> 	if (val)
> 		mask_val =3D mask;
> 	else
> 		mask_val =3D 0;
>
>     /* Let the driver modify the mask and mask_val to include WREN */
> 	if (gpio->value_xlate) {
> 		ret =3D gpio->value_xlate(&mask, &mask_val);

Yeah, but you probably also have to pass gpio :) And at this point
I'd call it value not mask_val anymore. And the signature should
probably looks somthing like:

int (*value_xlate)(struct gpio_chip *chip, enum gpio_regmap_op
op, unsigned int offset, unsigned int reg, unsigned int mask,
unsigned int *value)

mask shouldn't need to be a pointer as you don't have to modify it,
do you? reg_mask_xlate, already does that.

-michael

> 		if (ret)
> 			return ret;
> 	}
>
> 	/* ignore input values which shadow the old output value */
> 	if (gpio->reg_dat_base =3D=3D gpio->reg_set_base)
> 		ret =3D regmap_write_bits(gpio->regmap, reg, mask, mask_val);
> 	else
> 		ret =3D regmap_update_bits(gpio->regmap, reg, mask, mask_val);
>
> 	return ret;
> }
>
> Best Regards,
> Yu-Chun

