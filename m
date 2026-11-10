Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794349079;
	b=cEsvot5+ie2Y+skCZQvY33gOOGqk1mQw5tbwj6qAQx3aAWZE+U5aDy5ztSFXlaoPEUau
	 z0E12zyU8AAA2sp3SxkTq2ftTJq4uDE9uJBFOhx4Xyhn5Rg06PaSQd+qYm+88T6owW5TY
	 D3deYVDzofYn6kLDsaqwEzFBpfeUVkXYxX68bHkYdY/mh+/gTqmMtgg64cf8npojtRyOb
	 lPJ90Dcq5TvlMX0e88HefCy+BXeXgg9sL9JrSrY9tcyFxAGynEGLDGJ/GIhCG92FFgK/r
	 y6S1YmSYspfkEjV5ONUWbXqJyb3/d5Ylxh6cnlWrHiMqZ96CYcSrXWgEY6qEqkpXAPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=02i7i9cjkQ0l1xG/vxLusXLi8Q7kHJn+CyNuXJvACWg=;
	b=GXGnLAtyMvBUccvPACwPQe0JaGroY7r7opytWqpdwBNLfRkM1m3BKPBcSqrczZc8nW6M
	 QJVzWbBtO7EKkIbEH/Lr+2+6pL1v1QA8Nnp29KlXSelWg9FZQOCbmRMcBsYWpVabIxexd
	 fbDIqRphZaVHmWnl3GTtD7cOGfuBaPvn8x8Z2sv85c/mLg296JqkahkJQbzUGf0jShb+C
	 xnjFcO4gaMyV8QmCidlpaLI9euet0rNe9b0RqpblCPw9LvVllWXrw5yDhxCSJiuZpnzVv
	 P+hRzI9Q/sF8PGqCsPzcGSyknAB2MOOJ7rA48cvfAZ7oGiqRr5+qzCS/UjhAnSrVB1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BxQyaK2M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD85606A321
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 22:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD85606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BxQyaK2M
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so2599708e87.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 14:17:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794349077; cv=none;
        d=google.com; s=arc-20260327;
        b=RaIGQBjrDTQcuxCWZXI+z2qjwJTxXuyLi8CxI0OXIGMxuancq+pqnQc15XOaPpIjTL
         aWa+TQciFdwJWm/DqoZn6B55UPGeJS8sn4gzR0CbANgtP8mbkRMLe0vJTaOyo8EXVAep
         n/ocQLs5pChH8hIUXx10ARizRdsX4NXesDNADitr/OzDkzNubLcybfhDhTYz5naeKt5d
         G5CJ0rTHSM1V18GDEeKmJr+KWV/jpsYJeUcX0ySMN07eAUbdUDF3h0sCqzHO5Q0Op7tc
         GD1tZCDXsR9I0hzJ0UkAvOyns/ox1Q89vFQxJ+ZM4MV4Ka5SNQZ6I1IUQ6khJGAicdAe
         79bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=02i7i9cjkQ0l1xG/vxLusXLi8Q7kHJn+CyNuXJvACWg=;
        fh=QS55Zbylbyxaf1h8nd1imUIBe7+XkBeIw4Xd3Egk9k8=;
        b=k4tp78TQ5io+iMCxBAZGO3Ed/fa9IJ69W6RPMCg/GfwgpSBHbL7cQ39+za68pfK5O8
         z77PfrzwjbU8/f9UyilC4UZrqWz/U1ksV7Cd1x/RqRw1GOBpHEBFYoQURaGC7LYy9gLW
         veHxejqdTbT/5qlwf4FF9Mfu2sohBggfc/HJ9qVICcB+SNjDfqikLsQDoXRviqCUKS1O
         d9Z/NoFve/BpVJ/Er46D4lL1MSo24ERbCThSUJus3ijrnSy40rwUSp12wgFUSXuPrllR
         joEAe3lUsxSMbzPcTfQD1gQo0TezS9lX2H6DjJfG+Y1/YkfwJO49GK4qbFASY3oZ8v97
         zaDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349077; x=1794953877; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=02i7i9cjkQ0l1xG/vxLusXLi8Q7kHJn+CyNuXJvACWg=;
        b=BxQyaK2Mn9tSTU/9hvBNh8ybXPMYM/ojoJdIu7M9FAU0h49Xskx1/DXCjezzpXjAN4
         3vKKe/1u+VfKueAsurkA8xktjffOOOm2QrDoT4D7KkByVAmg0D4ybvlY/zht5qvOp0FS
         e4qAPbfhno2O3bXcFgZf4sIrJMSpQRENWpA4Ddj2qbPypyqKGBKPuIOFrb3fsazp3cfL
         ZvNm5QSOWnv6wCmx3/HDP19D/rTRI4Kh7pWjRU+/llRDvIUo+SWjmVFRWfZzBAblTnot
         1Wpfo3aoL6AbvRIEPlISIbb66b37C3mABIIZFTnPpxcO/H2wx4wCFHaprz59m1c/9yh8
         lg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349077; x=1794953877;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=02i7i9cjkQ0l1xG/vxLusXLi8Q7kHJn+CyNuXJvACWg=;
        b=Bz47qnZApeqGePbOTPdtCVLgLnf37MLBvlPPrK+pYMydueMMGsSvHpCHRblyyRInZd
         nd6skrDqT6zPKdO9TyLmzxKsHz3+IDfBPk/NAS8mcZnLAMrwKKLcDVvtxUVeTDPAP1sg
         z0extuHFRt9SlBHN/JbQRmrAlRNAI2cIvCnsV1aeiRxRNlBOlNOzofQt1sJFydatub+P
         st7NcgsUBSx/7JNNQ2hne1HRkekYyQpH1hNlhwo5vSlwBlth1WoLVu+ARGgTTiMf3v4Z
         q6apFe6ZlxZaIvSmddr+xtWHtbOW1yrg5wL6vbWn+AgUW52U9QrpSsj1QI8MDYR4Uqq4
         0n9Q==
X-Forwarded-Encrypted: i=1; AL+hErF7SNdildCP+cbBVhRnE91dmWuJ7FFVQ+EfMioLpq7CD6t0CABwgPU3kfCrrtkJJOIfrEMUy983KOQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z80Ai9A3z6O/Z62Em3mcqDJ34pAp6FDyETYhWtP/4jKXn3WmiEX
	1JsIaVrMC6hbEcXlQsNwivDT30Xp+SnAquNAgnxj4WcvVcIGgzJhyEOeK4JVRCMJ8SZK2FVZFZd
	9Vn63h3VovE2A1KJomOxLDIQpo/E+3eI=
X-Gm-Gg: AYBFou3DNUeNAaRosu37VT8YtQMukWdMWHZ27vPL1RtKcti96lFGNSeIa/W9/sb1yji
	quq9VmgoQjkmNs0z6nGIfvanggpKbL0iACoTj3XdfokKN/0p7+qrhkdpK+9ay0IQc52CL1ccLzy
	xDr73/2uQatZr3/C/XocriIMH1ZMVt0jUxWWf3i0Ul4KqhCaxNOQxsR7qmsWFnfWZu7VqClIgrp
	a6bVJqv2a6MERPlaxYvPDWxJbbMTVGT19lAg14yAE0yJ22teG/znen2E0RQODrJUS52M0mpkfJX
	6oLGtvfj7TWyzGU9xpFYvP1a3C9afPl/tbKtO5Pj+IVJ79wVxQtQ+088q+tKHwwdBYS0snaoHL5
	dAGA9Yoaq4ys8Zh+S+BOu/5y9k2pc9fWElUw=
X-Received: by 2002:a05:6512:2c90:b0:5bf:ce24:2d20 with SMTP id
 2adb3069b0e04-5c15d6440e1mr116175e87.22.1794349076909; Tue, 10 Nov 2026
 14:17:56 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-adux1020-measure-fixes-v1-0-fe1ba63f28bc@gmail.com>
 <20261109-adux1020-measure-fixes-v1-1-fe1ba63f28bc@gmail.com>
 <avJcESOPo2nGq5wy@ashevche-desk.local> <CAJsKa+6JDCVLtWsfQ0gJzX185ywWiYA_FwbV52q=N7vzgRYDVA@mail.gmail.com>
 <avLvJK2SmQ5Gs9Xm@ashevche-desk.local>
In-Reply-To: <avLvJK2SmQ5Gs9Xm@ashevche-desk.local>
From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Date: Tue, 10 Nov 2026 22:17:44 +0000
X-Gm-Features: AclHuK_k9yIHYnPHS7nM8ZUoKth7wyFrromnKbRWlr2kRkXXPeI5VuvjQxGoL9A
Message-ID: <CAJsKa+6UT2cu3HBrjif_NZ+ZUZM-UaUcKmfhptUAa-cwbJ+VzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: light: adux1020: fix interrupt clear value on
 SMBus-only adapters
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Nov 2026 at 10:17, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Can you give a Kunit test case? Because regmap specifies the val_bits == 16.
> See also [3].

I read your analysis in [3] and I agree with it for the bus it
describes. regmap has two write paths though, selected in
__regmap_init() by what the bus provides [4]:

- a bus with raw .write/.read (regmap_i2c, used when the adapter has
  I2C_FUNC_I2C) goes through _regmap_bus_raw_write(), which uses
  format_val, so regmap_format_16_be() drops everything above 16 bits,
  as you describe;

- a bus with only .reg_write/.reg_read (regmap_smbus_word_swapped, used
  when the adapter only has I2C_FUNC_SMBUS_WORD_DATA) skips the format
  initialization and goes through _regmap_bus_reg_write() [5], which
  passes val to bus->reg_write() unmodified.
  regmap_smbus_word_write_swapped() then returns -EINVAL for
  val > 0xffff [6].

i2c-stub is SMBus only, so adux1020 takes the second path there.

The existing regmap KUnit buses match these two paths (regmap-ram is
reg_write only, regmap-raw-ram is formatted), so I added a test case for
each, writing 0xffffff0f to a regmap with val_bits = 16 and expecting
0xff0f on the bus:

    # raw_write_wider_than_val_bits: pass:10 fail:0 skip:0 total:10
    ok 37 raw_write_wider_than_val_bits

    # write_wider_than_val_bits: EXPECTATION FAILED at
drivers/base/regmap/regmap-kunit.c:342
    Expected 0xff0f == data->vals[param->from_reg], but
        0xff0f == 65295 (0xff0f)
        data->vals[param->from_reg] == 4294967055 (0xffffff0f)
    # write_wider_than_val_bits: pass:0 fail:10 skip:0 total:10
    not ok 2 write_wider_than_val_bits

I can send the test to Mark as an RFC, to ask whether regmap_write()
should mask the value to val_bits for reg_write buses, or reject it
consistently.

[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/regmap/regmap.c?h=v7.4-rc1#n963
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/regmap/regmap.c?h=v7.4-rc1#n2153
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/regmap/regmap-i2c.c?h=v7.4-rc1#n127

> > However, even if regmap changed, the driver would still be passing a
> > 32-bit value for a 16-bit register.
>
> Is it a problem?

Today it is on SMBus-only adapters, as above. If regmap ends up masking
the value, patch 1 could still be used as the fix for stable releases
since, from my understanding, small self-contained fixes are preferred
for backporting.

Best regards,
Raffaele
