Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795311715;
	b=qnSksIQMwmZuG81lkt1FuFV1HmLSNj2R/2xQNB0S++9/LnBcybWIbN9hAZ2h8M8mMHHW
	 8Ri9oUieo4Zl1PFe/W3zDTqvKagHwm3skgmd1iHC+pwuNLPeIM2G7n7RI9j1uBHaErcti
	 fvQAGmnEoEPhF45j3vxHDcTfoku9UALxnIFGTCCVvNQc4V0seGjZ8T/xkZ8EnfwowoVMK
	 fQikFvI85WU1WHfSoTuL/485yuU1ognZfb79KVUuUypjSMgUFWRugol+xmkwryhcb81Yj
	 7VVY7kRbCnGTPsdKyhL7Uwjbns1TPht2nqXv2Ju9rwm3l3jPJRWGm2H6fLeq+CyUaRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795311715;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EE51FGywmKNIyzivecG4EuPCn4Tr1SfguQFjQwLn8tg=;
	b=nACcKvgl81Pt1hDmrD0UnReHMqBeW0+pClfEKkHPRuzK1trv4F4HlNCcd6vvZ9H+6o91
	 0T4eztDAyESqyqW1XuOS23ZrzVr6jCckjZWHmh3m16YN41sO1dCwc9YCkAN49eqKY7jQW
	 BASMv0TcWxrXJV3Uefrm0ctz3wl4ZO87FfLSJYHtUot7BrfsDxDOg8hWMKiHVLnnUV/hM
	 MBVVWYcMw2BqI5u4OH1n/t1xEBPku4VvR2qwuxPo0wa8pnkwoNAmUYBLN28ap/f7GXpK0
	 UhIslkLoLZjC1g7QWS8ppTDwDXi5kndB/uIg3GkfGECEcuf19IKsIf9/4BulMLIVfCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWAVZdKM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65716606A320;
	Sun, 22 Nov 2026 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWAVZdKM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76D31F000C0;
	Sun, 22 Nov 2026 01:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795311715;
	bh=EE51FGywmKNIyzivecG4EuPCn4Tr1SfguQFjQwLn8tg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OWAVZdKM2lxiTzvEW0znVaOuVHINDawBnsoZ3R69vcG/SN98leDBxC2oddwq50KKA
	 xwYybekufnPXNOICbSGEhGCu7PWaiZQJUMEsQGLtlfClkwoSX2afitjcR2HZpbrh3i
	 8OgYP1IMImyY+Il5VtHVvtxVP59gdvZM5qwmsq0I3VJplFOXVWHrqMDMDPGSw+XytF
	 yPAWTl+yK/Ivdx9SbRT++bG/lnn18Zr9dgunqzhW9mLRbnLhpZETB1lhYn6Y/pQlwg
	 nOn15ZwXsIj2OeQyK7L7KunsiqyylxT5R1DL2JQCN4teZGgW2luKpnub2am58A5Gpm
	 hPOtTfsny/23w==
Date: Sun, 22 Nov 2026 01:41:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Eddie James <eajames@linux.ibm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paulius Zaleckas
 <paulius.zaleckas@gmail.com>, Rupesh Majhi <zoone.rupert@gmail.com>, Joshua
 Crofts <crofts@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH 3/3] iio: pressure: dps310: add Goermicro SPL07-003
 support
Message-ID: <20261122014145.1bb27261@jic23-hlaptop>
In-Reply-To: <20261117083954.335814-4-jorijnvdgraaf@catcrafts.net>
References: <20261117083954.335814-1-jorijnvdgraaf@catcrafts.net>
	<20261117083954.335814-4-jorijnvdgraaf@catcrafts.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 09:39:54 +0100
Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net> wrote:

> The Goermicro SPL07-003 needs what the ZTS8032 chip data already
> describes: c31 and c40 in the pressure polynomial, and TMP_CFG bit 7, a
> rate bit on this chip too, left clear. Its TMP_EXT is MEAS_CFG bit 3 and
> stays at the reset value, the internal sensor the datasheet recommends.
> 
> Its c31 and c40 are 12 bit values packed into 0x22-0x24, where the
> ZTS8032 has 16 bit values in 0x22-0x25, so the coefficient block is 21
> bytes. Add a chip flag for that layout, the chip data and the I2C and OF
> IDs.
> 
> Tested on a Fairphone (Gen. 6). The DPS310 temperature workaround skips
> this unit: bit 1 of register 0x32 is set.
> 
> Datasheet: https://media.digikey.com/pdf/Data%20Sheets/Goertek%20Microelectronics%20PDFs/SPL07-003.pdf
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>

Applied with one minor tweak to the testing branch of iio.git. That means
they are queued up for the next merge window.

thanks,

Jonathan

> @@ -1495,12 +1517,14 @@ static int dps310_probe(struct i2c_client *client)
>  
>  static const struct i2c_device_id dps310_id[] = {
>  	{ .name = "dps310", .driver_data = (kernel_ulong_t)&dps310_chip_info },
> +	{ .name = "spl07-003", .driver_data = (kernel_ulong_t)&spl07_chip_info },

Only thing I tweaked was to swap the two above around so we are in the same order
in both tables. The reasoning being that all sorts of bugs are a result
of mismatched entrees and having them on same order makes that less likely.

>  	{ .name = "zts8032", .driver_data = (kernel_ulong_t)&zts8032_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, dps310_id);
>  
>  static const struct of_device_id dps310_of_match[] = {
> +	{ .compatible = "goermicro,spl07-003", .data = &spl07_chip_info },
>  	{ .compatible = "infineon,dps310", .data = &dps310_chip_info },
>  	{ .compatible = "zilltek,zts8032", .data = &zts8032_chip_info },
>  	{ }

