Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE127AC4C;
	Sat, 16 May 2026 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778936796; cv=none; b=SPvJI+ReXCjK5pgciIe2DkqWYhoynhwRbetuL8S7M/5C465P+rBFDeC4wQyFD9JjFf9mTOvuZY4eorKtRhKtfAxcf303obg4F1AiQ0Iov9ONhIBgYEiOBn9CywB3Nhszqa6kZkC/kdGG0mTkVTi1pdyJpGm0nwUgegE5E7ZlGhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778936796; c=relaxed/simple;
	bh=kGjrg9HEee16ZE/0J4u4UCbiuzzjJatYpP/lAJnEWJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYX54vGE/TBmc2Nws1Agow4jQ5Cd3uj8O/3qhpAAd5nLxy/23Ek1IDWMbZXFLiQ3G5AqrceJFrpWRKEqzUVaOZJLhSBZ1W9uEFEkGabXPETxY9abFLGBOet9Lp0yMmom3nFUCNnBoFogFTmaf8w7qhIHV1WIK6Jo93EQbcXtu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2QOn+m4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2QOn+m4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5863C19425;
	Sat, 16 May 2026 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778936795;
	bh=kGjrg9HEee16ZE/0J4u4UCbiuzzjJatYpP/lAJnEWJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c2QOn+m4U+b1U9VXGf0VYBLxqu8BjCPd5Teo0zuCI+u4yMdKbiCI0l04YRtyrrsAo
	 LWsBMNKh637Cdouw5lES4dazPBcB0Z+MPL2CIbHV12RzT+XpEFy8vNqLEgYpyVuVfR
	 SJyH2Vg0dsDmXsR/jXYT7ipUKS89TXDcNmcJV+Vj+dr0IA5oAO2HbASBWN8/eb5zPT
	 D4epjv2F+2bLwbAQm/soIIKgMKrTItKyjFw4ZUDKLwVhUEgGWj+NJJJZZeBGt6XiVU
	 ZT+Hl0Ysr6ua32L7ZcRdIqEffDuIlZPqHL8bxv6nb2HCaHxjuMI15DGhJFS3QIIfR7
	 ULhV3NAapuC4A==
Date: Sat, 16 May 2026 14:06:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rishi Gupta
 <gupt21@gmail.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: veml6030: remove unnecessary read of
 IT index
Message-ID: <20260516140627.5c8912f7@jic23-huawei>
In-Reply-To: <20260514-veml6030-fixes-v2-2-abdd5837be50@gmail.com>
References: <20260514-veml6030-fixes-v2-0-abdd5837be50@gmail.com>
	<20260514-veml6030-fixes-v2-2-abdd5837be50@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 14:01:12 +1300
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This is dead code as the IT index is not used by gts to set the new scale.
> In its current form, the value is read but not used afterward. Remove
> the dead code.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Dropped previous version and picked this up instead.

Thanks,

Jonathan

> ---
>  drivers/iio/light/veml6030.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index da8c32cabfd6..2f9a25d59b71 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -521,13 +521,9 @@ static int veml6030_write_persistence(struct iio_dev *indio_dev,
>  
>  static int veml6030_set_scale(struct iio_dev *indio_dev, int val, int val2)
>  {
> -	int ret, gain_sel, it_idx, it_sel;
> +	int ret, gain_sel, it_sel;
>  	struct veml6030_data *data = iio_priv(indio_dev);
>  
> -	ret = regmap_field_read(data->rf.it, &it_idx);
> -	if (ret)
> -		return ret;
> -
>  	ret = iio_gts_find_gain_time_sel_for_scale(&data->gts, val, val2,
>  						   &gain_sel, &it_sel);
>  	if (ret)
> 

