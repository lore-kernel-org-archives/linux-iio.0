Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6FC3F9F2E
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456442; cv=none; b=WyGPCPbAGKq4nCDjXWMMWFCFmcXTQZiJ5bQY9evUFNIiMhT7ofWwbB+Q5pS9VLPKtcsHem+nIU1sNOUpcyu0BZYMM2klZomEg1j7I1i81szzXk6+xAo493kYOwAnxMlbA5yZ3rHW5yBEm0PhtrtU+TUg+LP2DHs4NT3SsKA3Y5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456442; c=relaxed/simple;
	bh=vP8oQiJslzzQ2Fkhpbomhj+ca4RJ1V4UoBeyRtpGkbs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTevTazALGLzS4q/sa/VB4/wxpbmU15gOsOly1IXXkwWyTQaaiq/0xbHi0sOq0euAI/IYZsEt+YnzibHmltTNpkSAONxMcivtAxUkfSlQz9opdx4sK1qXnb5/Kw2mF5fdTKyZtgMCB+zgDMFuwIyKm1b7227Hv1Y1gsBSpZoUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slLZbx9k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slLZbx9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A91EC4CEF7;
	Wed, 25 Mar 2026 16:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456442;
	bh=vP8oQiJslzzQ2Fkhpbomhj+ca4RJ1V4UoBeyRtpGkbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=slLZbx9kk7j94/QvZPpNoh4i2FR+Tn5MLKYjwvZHnQl1lsJXUzClAy68chjEWAZ2D
	 sZXngYkwpbniNW2Lp9JUulARA/2oteFrR27tvoZPXfNHu5a14UqzniRvypPMkals/r
	 PagR/kuN56k366cG0eQvKLmjSw/sNwfv8VvQJFjWUaNWrBBUpyTw3Xd9XQ+syeq45z
	 /xrhJHEzMQk57H3nbgxCIcUDdnYst3sXn84C/ZxpemrrivBdWW+eyrrNdRrSb9GqXa
	 o6pYi5nYo6Zi3H9tbbuH9hvIngkUzd4OgGrY27kKHEcnKSa/1HMh9nUAj6l3pIClcP
	 2kzTD63q72K+A==
Date: Wed, 25 Mar 2026 16:33:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl380: fix typo in PART_ID register macro
Message-ID: <20260325163354.0565a9dd@jic23-huawei>
In-Reply-To: <20260325114251.20827-1-nikhilgtr@gmail.com>
References: <20260325114251.20827-1-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 17:12:51 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Fix a typo in the ADXL380_PART_ID_REG macro name where it was
> incorrectly defined as ADLX380_PART_ID_REG.
> 
> Also update its usage in adxl380_setup().
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
Applied. Thanks,
> ---
>  drivers/iio/accel/adxl380.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index 0cf3c6815829..d7c3dcf8b620 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -29,7 +29,7 @@
>  #define ADXL382_ID_VAL				382
>  
>  #define ADXL380_DEVID_AD_REG			0x00
> -#define ADLX380_PART_ID_REG			0x02
> +#define ADXL380_PART_ID_REG			0x02
>  
>  #define ADXL380_X_DATA_H_REG			0x15
>  #define ADXL380_Y_DATA_H_REG			0x17
> @@ -1773,7 +1773,7 @@ static int adxl380_setup(struct iio_dev *indio_dev)
>  	if (reg_val != ADXL380_DEVID_AD_VAL)
>  		dev_warn(st->dev, "Unknown chip id %x\n", reg_val);
>  
> -	ret = regmap_bulk_read(st->regmap, ADLX380_PART_ID_REG,
> +	ret = regmap_bulk_read(st->regmap, ADXL380_PART_ID_REG,
>  			       &st->transf_buf, 2);
>  	if (ret)
>  		return ret;

