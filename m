Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F687260D;
	Mon, 13 Jul 2026 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783903406; cv=none; b=E7ilxpsbDsSX94tucqqFAaZmqJrx4RqQZ5l9cavZfiXfDJ1FHyUZcdQ0iGEPwl+qS1KmsZdgsLkr12R2hU335ZHyW41z0LLY1nyNu1GNADEO5rz9VZAVuC8mBjKshPBf4uLDZDcPxvqlSfZoAfO9PgEyXXLxp96vNdfPwbuzaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783903406; c=relaxed/simple;
	bh=Qe1YVajBVfFa46Qb0giViqEZEVrKMabckpzs30VK83k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRoSFRKy3+xmYVWt/IJVhzhIO2v08a4agGShRTxDQc9WQxtQU6q+neaSxGuwTfQfNSJJVYmQmQpk1Z9WsUZQM3I+csn+F/LjZiXSawJ6OJ5wpfpabXLqqTKrb9UR5EN0Ng5b2xUpOE/FbiZCuPwPpsK8hWlivoC84nJQXlqPhfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc/p0sNl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc/p0sNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB6C1F000E9;
	Mon, 13 Jul 2026 00:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783903404;
	bh=/4BRVKFj2kFQN4Vewt990OZhy4LMBcmT/F9OJgLDq4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zc/p0sNla8NOV1Zyd9CEM5sjzdxRHUELpGy2V39kVc4k4ySimY54TM3UKFJfo3Twr
	 UsGDdRyEkAveuauqzqNh36vPCSoEptCE5C5LUVKN6NdD3F0V/ytJgz84URsAlV9z9O
	 H4vN2pJtGE8zdgKLFCnhiNcG5ZqxToWjW69Q574OqyWFpEco1izR7v9SxjD2LoZ/iy
	 uDUhLZarNJ9InZsZrrZIO5Xt8IYTuNnZhBfjWDdLrKLhIMcT4kSHnAtERPYlvgivzs
	 u/Fs/nNIbF/LmvaJWiZYGRwnvQZlwdmSTlqmWtBDFBSCzWcaHfhKf9Ayd6lqIC3AKu
	 IPuPFtlr6ygxQ==
Date: Mon, 13 Jul 2026 01:43:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] iio: light: opt4001: Fix incompatible pointer
 type passed to div_u64_rem()
Message-ID: <20260713014319.7033a06b@jic23-huawei>
In-Reply-To: <20260712202451.20822-3-nikhilgtr@gmail.com>
References: <20260712202451.20822-1-nikhilgtr@gmail.com>
	<20260712202451.20822-3-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 01:54:49 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> div_u64_rem() takes a u32 * for the remainder but is passed val2,
> which is an int *. Use a local u32 for the remainder and assign the
> result to *val2.
State what affect (if any) that has. 
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
Fix looks good, just add the tag for v2.

> ---
>  drivers/iio/light/opt4001.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
> index f2cf496cc243..bdb1eadbd450 100644
> --- a/drivers/iio/light/opt4001.c
> +++ b/drivers/iio/light/opt4001.c
> @@ -173,6 +173,7 @@ static int opt4001_read_lux_value(struct iio_dev *indio_dev,
>  	u8 crc;
>  	u8 calc_crc;
>  	u64 lux_raw;
> +	u32 rem;
>  	int ret;
>  
>  	ret = regmap_read(chip->regmap, OPT4001_LIGHT1_MSB, &light1);
> @@ -199,8 +200,8 @@ static int opt4001_read_lux_value(struct iio_dev *indio_dev,
>  
>  	lux_raw = lux_raw << exp;
>  	lux_raw = lux_raw * chip->chip_info->mul;
> -	*val = div_u64_rem(lux_raw, chip->chip_info->div, val2);
> -	*val2 = *val2 * 100;
> +	*val = div_u64_rem(lux_raw, chip->chip_info->div, &rem);
> +	*val2 = rem * 100;
>  
>  	return IIO_VAL_INT_PLUS_NANO;
>  }


L
