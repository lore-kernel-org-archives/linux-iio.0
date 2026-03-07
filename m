Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A175330B2F;
	Sat,  7 Mar 2026 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881499; cv=none; b=HyyhjJPyOIHD/Us9Z589b3YdhboBVguaXX43cH7hql4lTSTAR2AAk2GrDd4cQGzc5kNewRMrcVSsIT+Z2H8MzvdJxQdtNlO9MEGJ1IzoKbUTTH+WS2X0FoMaFNS3zXH3fYdaMl7Uu5yCnjUU8WWBt1yRmIHyV/GcpGxhj3czFRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881499; c=relaxed/simple;
	bh=XP6D85GhIBaITwpzbgv/w6t/vLSCQdMXX2P7pdKHrRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/Bm4wnUY80TBKy9cz8+HwoFI594ta6YgJxpZlRtL2tCddq9ZiPckP5nctMlIm6E5yMCmqtzZ5x5F7yIy+uQ/p0/I8QyuUj7/fbiCezkd+ti/viRVrA0SoL79tbFp9N1NAJB/3dhTu58ouapNCLPIslPhNeO5RpmllnOEixt3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHkZWmAf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHkZWmAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2637FC19422;
	Sat,  7 Mar 2026 11:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772881498;
	bh=XP6D85GhIBaITwpzbgv/w6t/vLSCQdMXX2P7pdKHrRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fHkZWmAfmdokglinbp4GAEne3OLFd8hxurBOuHx1wfp3m027z6HQUarG5+zdfdnWX
	 Vd9yUvbRQwZuZu4kQZPMyeHaEmanoxKW2BSCugj+gPb2LC17doypUqmZCu1AS5oQVN
	 YcOslooCK6kEYLxMDUueIfg0sSTynGtHcUjSToe+8ENkS+mZBntSFHi41IYk2cP8WJ
	 FrwQG/jDm33MWB0kKBR+zqCL8ExXWs8hcjGgGlhHhkredJ8NfnyS3SgrjEpS3HeeXo
	 Jz/XqzBNZus8GdNFUG9lr2EFGXLyWcLDJ/9H0s6MrwjJmhWKy/f1mW/KKu9+t/0TRL
	 8KbYekSvPT9Kw==
Date: Sat, 7 Mar 2026 11:04:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Petre Rodan
 <petre.rodan@subdimension.ro>, Jorge Marques <jorge.marques@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: accel: adxl372: add support for ADXL371
Message-ID: <20260307110447.189b98c0@jic23-huawei>
In-Reply-To: <20260306151859.131934-5-antoniu.miclaus@analog.com>
References: <20260306151859.131934-1-antoniu.miclaus@analog.com>
	<20260306151859.131934-5-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Mar 2026 17:18:24 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the Analog Devices ADXL371, a +-200g 3-axis MEMS
> accelerometer sharing the same register map as the ADXL372 but with
> different ODR values (320/640/1280/2560/5120 Hz vs 400/800/1600/3200/
> 6400 Hz), different bandwidth values, and different timer scale
> factors for activity/inactivity detection.
> 
> Due to a silicon anomaly (er001) causing FIFO data misalignment on
> all current ADXL371 silicon, FIFO and triggered buffer support is
> disabled for the ADXL371 - only direct mode reads are supported.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
A couple of small formatting things. Otherwise looks good to me.

Thanks,

Jonathan

>  
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index adb9e42653f1..7a1ee2fef618 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * ADXL372 3-Axis Digital Accelerometer core driver
> + * ADXL371/ADXL372 3-Axis Digital Accelerometer core driver
>   *
>   * Copyright 2018 Analog Devices Inc.
>   */
> @@ -182,6 +182,14 @@ enum adxl372_odr {
>  	ADXL372_ODR_6400HZ,
>  };
>  
> +enum adxl371_odr {
> +	ADXL371_ODR_320HZ,
> +	ADXL371_ODR_640HZ,
> +	ADXL371_ODR_1280HZ,
> +	ADXL371_ODR_2560HZ,
> +	ADXL371_ODR_5120HZ,
Might be worth a
	ADXL371_ODR_NUM
entry so you can size the array from it below.

> +};
> +
>  enum adxl372_bandwidth {
>  	ADXL372_BW_200HZ,
>  	ADXL372_BW_400HZ,
> @@ -222,6 +230,37 @@ static const int adxl372_bw_freq_tbl[5] = {
>  	200, 400, 800, 1600, 3200,
>  };
>  
> +static const int adxl371_samp_freq_tbl[5] = {
> +	[ADXL371_ODR_320HZ] = 320,
> +	[ADXL371_ODR_640HZ] = 640,
> +	[ADXL371_ODR_1280HZ] = 1280,
> +	[ADXL371_ODR_2560HZ] = 2560,
> +	[ADXL371_ODR_5120HZ] = 5120,
> +};
> +
> +static const int adxl371_bw_freq_tbl[5] = {
> +	[ADXL371_ODR_320HZ] = 160,
> +	[ADXL371_ODR_640HZ] = 320,
> +	[ADXL371_ODR_1280HZ] = 640,
> +	[ADXL371_ODR_2560HZ] = 1280,
> +	[ADXL371_ODR_5120HZ] = 2560,
> +};
Style wise, why not do the same for adxl372_bw_freq_tbl[] as here?
I slightly prefer this style, but key is consistency so if you'd
gone the other way for both that would have been fine as well.

