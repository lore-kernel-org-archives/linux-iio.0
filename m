Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794298340;
	b=fp9p8K0L+N+3aum8lqJW/5hQ5Kuxx43hUYya0eUhnyESI9RNQuNu5l5+Ye1uhQL2dC/1
	 hbKhOE2p07+Oupi2m/IwSEXUVNsj10EHrM2mVOyRwL67LefC2hjZsPnQbQT2dM1rQFDsH
	 Yc6JaWG9SZp3lB0GixQVeq2WR01KsWs0DY6pokJdHAzrh2UzVFVLK8GUDHsT8cz0du1es
	 kSbDrrWj2RBawAPeJrGEnDIn7ih/VBPKYRGoALyZ7ltHcPkHXqlWNgAKjAIBD9Yi0eNKf
	 f/BFMHaPwS9GiqckbEbarOwOTTIFyTwjExoPlFpGjd1WdfX1tZA+jMUtWgM9XzEcbzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=AB6UUbBEZNKWF17VDfnEudBTR1GYMwvjJYG/9/2B+hM=;
	b=Hm1z7DFlulKw7cdQArRrQQYxRRWIalqHXkJUtlM7Tn+ZpW+4d2JZk276dlZOLVFTvuu7
	 TtEFV/AEgzYGaus4HwvH5A2cBNdq9ognwkS0np+BS2BYcwh9hYiw+Xv66cNPiiLaGjInE
	 Sc2vlCa4qAzlx1KOpBb3kw3YgX94YmT983k0F4YoRuFQhiSRi+79WygDVlTPI+b5ex7kJ
	 iH80ofHai0M2sx7tZfxe/5aoL5HqMc2hCeN2TXl19SGldn5yaj9r2+2t4M5uxlkPm1cpk
	 YducOIGb5BRZ+/P0KnclG+b+rGUgEVKiaiLaGqLtwY9hr0S5GFGSLwRLEQBNoA4XBtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PArHeiqL;
	arc=fail smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9A606A31C
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 08:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12E9A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PArHeiqL
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso2182310e87.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 00:12:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794298338; cv=none;
        d=google.com; s=arc-20260327;
        b=KVz/vzVPVr0TcWfHSmqHLKHytfmwyniDzaepVXZLtiynD2krD53/gjZvfafR6izELL
         Rj1Y1+qCctMntAzV63BEBkw4lvaPSdSrGM6GT2QDBJ/rUJLtXwMIxXbgT2xtnxCKhvRa
         cRbURDQwCopnkByTodXhOPHoLnqEztclUldSntIKjhIfWz77YjKY6P5S749dQIsKj+MW
         3Zcn6pNYWtuuhwN3Ec1qfb/Oi28EoNHw8V8LpNI6hcZIX1aVY1RICtoK0lF2L6FIcCKH
         tn4pHSkOzzpHEswIW2MMnIkxV72/jfnmAd3DAdx3lpbsZznUYlxnB4fw5kXCp4c9rggE
         T3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AB6UUbBEZNKWF17VDfnEudBTR1GYMwvjJYG/9/2B+hM=;
        fh=aozTy5+fdwy3ws6VFxXYKDMI3jlSnDGJ+zsSGdv7bgA=;
        b=PGgPXuDD5v4Pwy8bA72t+hln9OugVbW3K2z8IzYu4jwFZKzQH/mXTbaO/jHyJ2ims8
         soK5PFLmPlkP9ma1o7rq1O9pQHhkr/CYRLtWpnccytxUMRdSCufNu5wo3EDJNr85PzeN
         2bhO+bFT3dFXzmlSxEiTeOzmKm7On5tV/R6lV8GyfL4xLLREgS2NqjDWVH3rE1sTKQAi
         LTGyydWePDWwx37tX9h+wIvNxa/WIwnUahSBrxivHlTBFgNDo0Ai+Lxdwo+xMxQ3l6h6
         VMKys8r5i9x6g0zXPz49AS5E33Y5SYlEWfeIOcZNrYVaDTFnjuW45JT0NEzc0nP2G9md
         8QhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794298338; x=1794903138; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AB6UUbBEZNKWF17VDfnEudBTR1GYMwvjJYG/9/2B+hM=;
        b=PArHeiqLOIqDA9K5txiDBN5A9Res+d70jB2RUUqytoPVSEhRmJDSGgR914oRUzvAwh
         fPd2nhIThsA0S4wUXzVP5IIbi2WroJK8kx5XrWM5lRiOjP5MKvwtxL0ZKrPpVAcBJ0jm
         9B1QZcIHUROOvVSwjYfWfnzzvwpG2IMvg9Ow3ZioaWxqIuGjOBIdOj1n5Ru+eZNx9TjW
         e/ARDi0E8moZY9tioNko71nfl1ldU4/iv/6h9fxSGzVIBY5Gf2EU1goVZYyZdgR58Lfu
         8D2A9McEpL34LunlVRyabP0xFKNUgSHCBFuRfzI+eOcIfZbWXLWk7sHeIyIUl22DvHq5
         XDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794298338; x=1794903138;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AB6UUbBEZNKWF17VDfnEudBTR1GYMwvjJYG/9/2B+hM=;
        b=od73DP5/2s/hxUYTi151ZragCdPJoQn7fug5sJk4RSe/5kxu05JrQ+xzG1W61oiQek
         Q67N4h66o1A/rQmNFUfRxgfvIAtVhHY2b18xASQv/vwHuXbfKJrcOSvvl2bJu1ZnjGtS
         7Qhq3OKU4wK1PnsRUvy2Ka0w4CKSfBkhH35CbPCoba5tVeBfTyyHqco7RiF6mJtjJzcl
         DWXuAyqFWql/b4Td42fd2oUEmfJjBI+Rtb3jo1DE4/DHuaGVKO714O/CuSGYGolSUdts
         ES1gPtA7heoYRjMWihEg6WFA1MFMikeY1hJ7Sn4kdv0YgHZyECI3nEMz+AdEoIK6b2pp
         6bUg==
X-Forwarded-Encrypted: i=1; AL+hErHn0lkmq3NIxd7pNAEloKoITKKZoLtV9uRkVSrH+mVvtaLSIg1YbzfRwRFyNYYgls0DDQEmFJ9RIhc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ig51zY7tkMXrl0zjH7MkWhKVhIPfgJ/NhDBI5bMqAiZxmSYJk
	f8iAdRyRcav0Ep+fz/UwzcN9nISkySbkV+2QcVDUog0gV7cU5ZabqCpVulCmGGR0GRRKWDwR6SL
	mBvCAWc2iJR158LTG/lgkBJKIyItcEwQlnYo1lAk=
X-Gm-Gg: AYBFou3YGJI6cddKc6hJrpM/vynaNVG8LIKtz8C6JK6iRMAldmTVEOyKQsP9fO/j0Rf
	M+pe3ebCadsVSwQ0FnBCJp5H8o0pwK7ULl9PETwNrcaEW66O3An+rpNuad9FZpsFtD5b8uHlAnZ
	CgCkBxCJovB3EY0Yfnk2fqi135ufmqS7PBM3x/pZT8V0arIRETdSChiQSk3dvJGzpOzoLUxQhC/
	fiPNCtHj+yEZgGUWrK9V+YkKlKzUlGjn5H6YxB8zus/mDfEmhYh33Z38s9sbssV1WBu+Uhd1ygI
	xqoadWvIOq2Xe4+SVH36FFPEqM+vw1lRGxJLPPfC9TVJ8PPoe6spWFLvm2/+qQcx0t2O2OxNYSE
	hE9VEBL+mVEERXi6uIB78JXKiKwcQGwJ7/Qs=
X-Received: by 2002:a05:6512:33cb:b0:5c0:b5c:408d with SMTP id
 2adb3069b0e04-5c156e3e8a0mr461922e87.6.1794298337806; Tue, 10 Nov 2026
 00:12:17 -0800 (PST)
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
 <20261109-adux1020-measure-fixes-v1-1-fe1ba63f28bc@gmail.com> <avJcESOPo2nGq5wy@ashevche-desk.local>
In-Reply-To: <avJcESOPo2nGq5wy@ashevche-desk.local>
From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Date: Tue, 10 Nov 2026 08:12:06 +0000
X-Gm-Features: AclHuK--YL6d7XaktwHV0yo6D6aDe9D2JvgZjf0sRInSEUEsIp9kqMvJFxZN6Yo
Message-ID: <CAJsKa+6JDCVLtWsfQ0gJzX185ywWiYA_FwbV52q=N7vzgRYDVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: light: adux1020: fix interrupt clear value on
 SMBus-only adapters
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 23:49, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Nov 09, 2026 at 11:39:02AM +0000, Raffaele Tranfaglia via B4 Relay wrote:
> >
> > adux1020_measure() clears the mode interrupt by writing the inverted
> > interrupt enable mask to INT_STATUS. The mask is a u16, but integer
> > promotion makes ~0x00f0 evaluate to 0xffffff0f, which does not fit in
> > the 16-bit register.
>
> Huh?! Where did you get it from? the mentioned promotion may only happen for
> a signed char which may not hold 0x00f0 in the first place. The above is some
> nonsense.

The integer promotions apply to all types with a rank lower than int
(e.g. char and short, signed or unsigned), as long as int can represent
all their values (C11 6.3.1.1p2 [1]). For ~ the standard says "The
integer promotions are performed on the operand" (6.5.3.3p4 [2]). So the
u16 0x00f0 becomes the int 0x000000f0, and ~ yields 0xffffff0f, which
regmap_write() receives as an unsigned int. sizeof(~v) is 4 for a u16 v.

It is also what I observed: with i2c-stub (SMBus only), every read of
in_proximity_raw fails with -EINVAL from the val > 0xffff check in
regmap_smbus_word_write_swapped(), and succeeds with this patch.

That said, I can reword the commit message to make this clearer.

[1] https://port70.net/~nsz/c/c11/n1570.html#6.3.1.1p2
[2] https://port70.net/~nsz/c/c11/n1570.html#6.5.3.3p4

> >       ret = regmap_write(data->regmap, ADUX1020_REG_INT_STATUS,
> > -                        (~adux1020_modes[mode].int_en));
> > +                        ~adux1020_modes[mode].int_en & 0xffff);
>
> On top of that regmap should limit the value to 16-bit anyway. If there is a
> problem in regmap to cut the upper bits, it should be addressed rather there.

Currently regmap is inconsistent here: the SMBus backends in
regmap-i2c.c (and regmap-fsi.c) reject out-of-range values with -EINVAL,
while the formatted plain I2C path silently truncates them. If you
think regmap_write() is the right place to mask the value to val_bits,
I can try to fix it there as a separate patch to regmap.

However, even if regmap changed, the driver would still be passing a
32-bit value for a 16-bit register. regmap_write() takes an unsigned
int, but logically it accepts values of the register width, so I think
the driver should be fixed in any case. From a quick search, this is
also what other drivers do when writing an inverted value to a narrower
register, e.g. ad4691 uses ~BIT(chan->channel) & GENMASK(15, 0) and
zpa2326 uses (u8)~ZPA2326_CTRL_REG1_MASK_DATA_READY. Fixing the driver
is also the change that can be backported cleanly through the Fixes:
tag.

--
Best regards,
Raffaele
