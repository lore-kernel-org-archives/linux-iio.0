Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0596321F5E;
	Sun, 18 Oct 2026 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291950; cv=none; b=caTl5n3ed4dnPwSosViUWwu3in0LemVj5MxBRs8yuy+PGEEGMp3XmHujprf3+7H1MUcz9Fxa/LmAVg0QaXHGaZl3CPCZ4ihOpFjm8hD+BrHv8g2/GMJUnsiw48rZD59v09+qw0hc+4ldxUMoXD17Y6Bje4QV5/tPm5PxIiD+AJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291950; c=relaxed/simple;
	bh=vsYX/zqIOjVzPtAHPf/h747M9F2quzeEejVQhD02q5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l02x2jvZ551LwWyO3Zwsi2o/CtwjrO7SwJKDXNYmlUDaQYt9pZxOSavtkYZdriPlRLurxf+fL/k8B0BX023EdpMzA3RQk3aSw0+jWNh+t3iUQkNb+hW1hjo8NVgaD+S1bbydeVvMaH8S3lt/rJ2IHPm1tLCI6vqhrC5rxs+F9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZFlqre9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZFlqre9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1831F000C4;
	Sun, 18 Oct 2026 02:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792291949;
	bh=mYgo6vxvh6Mrw6u+dBdDyoGkpvhK74oOxrkPNKsjCA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kZFlqre9nr/KWI6RRUFRUf+rZCSv6h/dE93RDquUpp9PftJ8uLISVLlEqbulAkuGj
	 13BDTylWQzOWDAQDHh4+9gHYYw8MAjS8Y1yFm7IcbAgN81JPYVrQgAoKnXH7QMaGwn
	 DJB8wIkgEe2iUbUh7+HG4bCTticG0A340le+L8Tn4dxtzgQRkTU3HUIT3J/shVSD3d
	 PqEWnMAH6hXysLWg2m2sCDnxUx9D5AooeVwwkfg4Abx3i+LpTdDn/U6PzupG+dMavO
	 G1ftVeBk6PPDdzlqsrnG3WAWC8fXtpHV4MmMK9Nuq+RDqFGYoJ2TxijNyAjAK/D08W
	 GzdLiKfOx+sgA==
Date: Sun, 18 Oct 2026 03:52:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Jean-Baptiste Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, <kernel@axis.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 5/6] iio: imu: inv_icm42607: Implement MREGx register
 access
Message-ID: <20261018035221.55fac14d@jic23-hlaptop>
In-Reply-To: <20261009-b4-inv_icm42370p-v6-5-e53884f185ff@axis.com>
References: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
	<20261009-b4-inv_icm42370p-v6-5-e53884f185ff@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Just a couple of trivial notes.
The regmap on regmap solution is quite nice.
Might be worth making sure you run tests with lockdep
though just in case there are any nasties hiding in doing that!

Jonathan

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 75c9617e5d1e7..a4393b54cc108 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -18,63 +18,255 @@
>  #include <linux/time.h>
>  #include <linux/timekeeping.h>
>  #include <linux/types.h>
> +#include <linux/unaligned.h>
>  
>  #include <asm/byteorder.h>
>  
>  #include "inv_icm42607.h"
>  
> -static bool inv_icm42607_is_readable_reg(struct device *dev, unsigned int reg)
> +static int inv_icm42607_mclk_get(struct regmap *map, bool *idle_set)
>  {
> -	switch (reg) {
> -	case INV_ICM42607_REG_MCLK_RDY ... INV_ICM42607_REG_INT_CONFIG:
> -	case INV_ICM42607_REG_TEMP_DATA1 ... INV_ICM42607_REG_TMST_FSYNCL:
> -	case INV_ICM42607_REG_APEX_DATA4 ... INV_ICM42607_REG_INTF_CONFIG1:
> -	case INV_ICM42607_REG_INT_STATUS_DRDY ... INV_ICM42607_REG_FIFO_DATA:
> -	case INV_ICM42607_REG_WHOAMI:
> -		return true;
> +	unsigned int val;
> +	int ret, ret2;
> +
> +	*idle_set = false;
> +
> +	ret = regmap_test_bits(map, INV_ICM42607_REG_MCLK_RDY,
> +		       INV_ICM42607_MCLK_RDY_BIT);
Align as:
	ret = regmap_test_bits(map, INV_ICM42607_REG_MCLK_RDY,
			       INV_ICM42607_MCLK_RDY_BIT);
I think you lost a tab somewhere!

> +	if (ret < 0)
> +		return ret;
> +	if (ret)


> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> index 9f34199ce2949..61705b162f86f 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> @@ -12,6 +12,12 @@
>  
>  #include "inv_icm42607.h"
>  
> +const struct regmap_config inv_icm42607_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +EXPORT_SYMBOL_NS_GPL(inv_icm42607_regmap_config, "IIO_ICM42607");
I think sashiko had a comment on this being used from the SPI code
which is a problem if so.

Jonathan
