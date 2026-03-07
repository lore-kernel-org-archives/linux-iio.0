Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C999234B1B4;
	Sat,  7 Mar 2026 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772880543; cv=none; b=ivebXv6LcnW2iSGQw2VQi7TYhg/qxMwKgFqgEZaMtomxat8GGX5x55+f2LrAPrxcvLX7O+nNxhHH0/4dkpvAZ4qlTUObBg3rxXmv2IHCLyKWyjGw1w2tZaeZqQQD4HKYX1YH5khdZmUQdzrrCId5zS6L75GlN2114L2YulCBOys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772880543; c=relaxed/simple;
	bh=dTjtLdqZ49UiLqUm21v/UMj0vg2Vv85RAZ5fDBe/UHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crauTpVtIvevsVTQGHxeGlnv8uFS6kfim1/DatOVt0XYEHauV3nJHsHYWQ4/9alOL1dT/Sx7oInxVrQDDwLgsxy4GFLWOrpgIheuwSLKxYVnTZZX6QpJVyDIP18+SmU27esbizqUIKU7sbysfhCKYYnZ+eI32mwLIwSLN4+sYrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giHWWH5L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giHWWH5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A88BC2BCAF;
	Sat,  7 Mar 2026 10:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772880543;
	bh=dTjtLdqZ49UiLqUm21v/UMj0vg2Vv85RAZ5fDBe/UHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=giHWWH5LWCu7LelKZ2tDgjVCfsPnYbCfqcZQjuVnuEuPk6y9XPRKuKlNOJJPDF/Ia
	 IzzLzU0jtLS2mwAh5XxiOay/BRy+0t6+JqkCi6gPGfB/SWDfwRZ/5x5P7rUQxmd0FL
	 eWsQX+OvodHIMalQUZawXeHsIHQHIgsR5L/JwcoV4hpvOnggg3ZweYa5rP6dN9G9sN
	 4R/kagct5+O2rL7OYyAaCb19jcmUFLSFUKfjADELBHYHOnaWAw0hukPV6FIuV4/XZh
	 wCNhV8g6x+DhOHKUI7R6WFRXgc2//UWo+wXLreeld7v79iwRI/EAsIffT8cDwEM+2f
	 CClrrhqVA1FFQ==
Date: Sat, 7 Mar 2026 10:48:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: max1363: Reformat enum and array
 initializers
Message-ID: <20260307104854.22e41099@jic23-huawei>
In-Reply-To: <20260307071555.14683-2-giorgitchankvetadze1997@gmail.com>
References: <20260307071555.14683-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Mar 2026 11:15:56 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> Reformat the device enum so each entry is on its own line and add a
> trailing comma to the final enumerator. Also reformat the nearby monitor
> speeds array for consistency.
> 
> No functional change.
> 
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Hi Giorgi

Seems like all comments have been addressed and looks good to me so
applied to the testing branch of iio.git.  As normal I'm fine rebasing that
for a few days if anyone wants to provide additional feedback or give
tags etc.

Thanks,

Jonathan

> ---
> v2:
>  - Address review comments from Andy Shevchenko and David Lechner
>  - Move all enum entries to separate lines
>  - Add trailing comma to final enum entry
>  - Reformat max1363_monitor_speeds[] initializer
>  
> drivers/iio/adc/max1363.c | 83 ++++++++++++++++++++-------------------
>  1 file changed, 43 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index d35f4487b2f9..207d1e960e21 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -637,48 +637,51 @@ static const enum max1363_modes max11644_mode_list[] = {
>  static const struct iio_chan_spec max11646_channels[] = MAX1363_2X_CHANS(10);
>  static const struct iio_chan_spec max11644_channels[] = MAX1363_2X_CHANS(12);
>  
> -enum { max1361,
> -       max1362,
> -       max1363,
> -       max1364,
> -       max1036,
> -       max1037,
> -       max1038,
> -       max1039,
> -       max1136,
> -       max1137,
> -       max1138,
> -       max1139,
> -       max1236,
> -       max1237,
> -       max1238,
> -       max1239,
> -       max11600,
> -       max11601,
> -       max11602,
> -       max11603,
> -       max11604,
> -       max11605,
> -       max11606,
> -       max11607,
> -       max11608,
> -       max11609,
> -       max11610,
> -       max11611,
> -       max11612,
> -       max11613,
> -       max11614,
> -       max11615,
> -       max11616,
> -       max11617,
> -       max11644,
> -       max11645,
> -       max11646,
> -       max11647
> +enum {
> +	max1361,
> +	max1362,
> +	max1363,
> +	max1364,
> +	max1036,
> +	max1037,
> +	max1038,
> +	max1039,
> +	max1136,
> +	max1137,
> +	max1138,
> +	max1139,
> +	max1236,
> +	max1237,
> +	max1238,
> +	max1239,
> +	max11600,
> +	max11601,
> +	max11602,
> +	max11603,
> +	max11604,
> +	max11605,
> +	max11606,
> +	max11607,
> +	max11608,
> +	max11609,
> +	max11610,
> +	max11611,
> +	max11612,
> +	max11613,
> +	max11614,
> +	max11615,
> +	max11616,
> +	max11617,
> +	max11644,
> +	max11645,
> +	max11646,
> +	max11647,
>  };
>  
> -static const int max1363_monitor_speeds[] = { 133000, 665000, 33300, 16600,
> -					      8300, 4200, 2000, 1000 };
> +static const int max1363_monitor_speeds[] = {
> +	133000, 665000, 33300, 16600,
> +	8300, 4200, 2000, 1000,
> +};
>  
>  static ssize_t max1363_monitor_show_freq(struct device *dev,
>  					struct device_attribute *attr,

