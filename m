Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B840863E;
	Thu, 16 Jul 2026 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202169; cv=none; b=A4l4oFJSTQN0O8fL8CvbjSNHbjdmB+MTR+v7P8zzLvr5Ns1KWRR6BtY82ySpDJx+4yCp51jTVuu3W7t6auqUMxMOW2AX8+rxr+PQxBTot8eivQkIxTOKmErXlP/xWaoMDXFeyUw/gs9z66XoHkofZ3ylWW3MmGBAgDevQdS06ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202169; c=relaxed/simple;
	bh=PBQlWJCk9cMAyUsTnpRIFnjmO6kFLFwLiyaWYbKlKug=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=N2JVTFPFxLGFOgHi0X6sOmiGZk88bCfjHb1eE3IyuVILsKZz3fZqdL6ncof3ZrXbIZxbhYJQ9+aZOgMHruvrK2FLYbokXlVvbH1O4wDWKB0FXq5XNz6Gx15TmruXjCodgu8R50sDnFGC7YD3e7ISdBuDG2YnAnzcsdzLlU/DnZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 77979167;
	Thu, 16 Jul 2026 13:42:44 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 13:42:44 +0200
Message-Id: <DJZYVQSJL0MO.143E5QFQRAXVV@kernel.org>
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
 <DJZY1YPMDLIN.3W0QOPEI9L8JA@kernel.org>
 <068b13e117464cf38b7b215eee72fe7a@realtek.com>
In-Reply-To: <068b13e117464cf38b7b215eee72fe7a@realtek.com>

Hi,

>> int (*value_xlate)(struct gpio_chip *chip, enum gpio_regmap_op op, unsig=
ned
>> int offset, unsigned int reg, unsigned int mask, unsigned int *value)
>>=20
>> mask shouldn't need to be a pointer as you don't have to modify it, do y=
ou?
>> reg_mask_xlate, already does that.
>>=20
>
> Actually, I do need to modify the 'mask', so it still needs to be passed
> as a pointer to this callback.
>
> Since the WREN enable bit and the data bit are located at different bit
> positions, the final 'mask' used in write API must be expanded to include
> both the WREN mask and the data mask.

You could still return both bits in the first xlate, no?

But yeah, that might be a bit asymmetrical and not intuitive. So
changing the mask (again) with the value sounds ok to me.

-michael

> Aside from needing 'mask' as a pointer, I completely agree with the rest =
of
> your suggested signature.
>
> Best Regards,
> Yu-Chun
>
>> -michael
>>=20
>> >               if (ret)
>> >                       return ret;
>> >       }
>> >
>> >       /* ignore input values which shadow the old output value */
>> >       if (gpio->reg_dat_base =3D=3D gpio->reg_set_base)
>> >               ret =3D regmap_write_bits(gpio->regmap, reg, mask,
>> mask_val);
>> >       else
>> >               ret =3D regmap_update_bits(gpio->regmap, reg, mask,
>> > mask_val);
>> >
>> >       return ret;
>> > }
>> >
>> > Best Regards,
>> > Yu-Chun

