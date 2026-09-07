Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F322F4DF4AA
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792621; cv=none; b=JmG1iFIge2107Rt+9VOZjNB/RHRC52DyfGhHevq1bJWSwBZ8mQgwMmk05+Ed1umDqj/qPguw9Oyq55kpD0CwUGDSNT/SIRIFu6lCmDXth5yt/oCtusPdyul9akZ0GMfMhksdztEhXw7LJtOD+kRL26zMjHVhh3lniL7TXCsIiVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792621; c=relaxed/simple;
	bh=NyENwqYiXjV7+pyzMIE+mVeG1/8VVB7bn3DU67F8TGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPmCfWBaUo6T4YTHjDf4SDEefK82OpO5+yA+pdanDeUDwLCDn9TIPazPVuXORODj/vgD/4996drHN7QI9mlkb+AQga7g/tHFX5fYlALi9M6ceJV19+ZaohFB5hrRUB37Gen2wenTbcrQGPIzDUkaZc/Y0OMKcnOZs5gQyqfI8y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1AGL/59; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1AGL/59"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-482e067e908so3013611f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 07:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788792611; x=1789397411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yxN3NGbWp4Z4cW1QqlGymMDSYp6HB/CZBR9XQu9IyDM=;
        b=r1AGL/59pSAuWS/4zlG7UcNDCsCMkKPx0T0xi2+YdzGg2lIYRcZ60tHnExibHGtKcR
         AVozaHXV9zBiBveBh3EVUDkDdYCHe+AwpvfzuBafBxcd/2vJzUrGU/WgghNH+lstcsaf
         trjqUEoOaP7susV9apOydvid9DRg1H+sMtHmcvKIaESDXOb6Uqwew/5wh39pAWts/4N6
         OD6fd9vO15474KkzQsX37QUkQei/TZ7dDBmhRyVNVX9FOy3BBfW8X6mbSAarhlaqrOfl
         4bYRZdZcM3fryEG/6UfL+p46Rv7y9ZZ4WaW/jwAdft5JqI/m774mSA9Gj/pcbAqxbC2k
         BN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788792611; x=1789397411;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxN3NGbWp4Z4cW1QqlGymMDSYp6HB/CZBR9XQu9IyDM=;
        b=V5EckFjLJdoDCF0Dehd/yLGxF+TZljvKE55BQ/0zwpTyPJUW9eK5wYWn9vlh7CgyCd
         IEoRuDXlE5juWW8I1YoInHjH8brK0f9VL2hT74Konn62qYTO9oOiNsAB7kbUTZNjkC38
         FqzNtrs9dBz+jtb+XJs2nPCCAjfJFkyClYoGazYCFcU6lJc1B4LVXtCYRImrQua/f8G7
         4J4lEdhOCxau8UTbJBDClH/aksR5aqSITo7f09RBmDuTblLj5oGPB1ZRCW8nAM038bjM
         u0yd0Ocjb4D8tr32XOeIdlbTXTNJ/dOh62QbHWO93qK9CiFVcmnKt9+1VrHCsLrnhS5u
         hb/Q==
X-Forwarded-Encrypted: i=1; AKwUvBybD+/cHbCgPNrLDUEtv4j8kEY8/dA4XYUc+BfoTKVlxwxc1B0KVAJXwtHodm5xrZsRz3q63JOLYAA=@vger.kernel.org
X-Gm-Message-State: AFuF++m03aF4qBHaHoa/gjotHhMc9nrQGlzeVrEbiWXyky/wcwXy7c3G
	aW2vEgU+xWXOthoOiSH0oNi7FnU6BiYEjlU10esU9BApkYPJN4F5x6c8
X-Gm-Gg: AYBFou0VDqpQ9buqo5MpjZU18QRQhyPVEJK5q5jCsggkf7RfIoa7t2VQevbeeh6k2oP
	L0TlLdbT8E0FZMY1+o4FXMVOCnjebdzLs7LdLWmkbyLQvHsNBhMlILP1o1YXyLxQ/8gY/9wK81Z
	zKHsLHBzznsMusXoimSKmfDbUhZjdOyXWVXQSY9WrAhp8RUQNavM1tX2n5jv+j4W1c4KB/QP+Vf
	qAvnDD0LPsqF5mBe+8ehvxU5/Y7ZctT5pUleLSEGNZT+zH1b3rMCsbMz5vLBLYTvePDNdSx1Roj
	ixxzHLbSd0F1Bu2e2S7al0mY0MZNNRFhB0gE+kYGq+w++9KJyd0FanWGBRE8DkBFKMNo1KUuNdF
	LRgi9yDM5z/2e5jEbyvINybPIaf2CYU24mBHDUEaMJAdth7z8Az7z++s5/f6EL6ACGcRM5XpRRN
	YcDeM53eCRI+cLTjREOB3EDUBYOdkVzRlhepEsj/3jbGHOPFtH6xrVBClI70hrqilN6omH3rXh+
	W9EfxbYgqJyG4GDuZ52gvFrJkkRVn9pbCkMBTQCTUBiETUsCA/OH68WYHseW+0QDYARL5RM7xy8
	wbxy1GQ8B8LpiPq3049UsQPg4oCPptAdaPGYQQK083tGQHi54b7y59ntqWu5Z2eSg9QfrfGX2sM
	IV1DbEFpXb53ysfqL9HAiic+3dT4icJKIv0z/2q5p3A5dCq5W1nso10RBVN+OaDgy8fYQl/I=
X-Received: by 2002:a05:6000:1acf:b0:485:8a46:7062 with SMTP id ffacd0b85a97d-4858a467220mr21639400f8f.52.1788792610782;
        Mon, 07 Sep 2026 07:50:10 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b7bfasm29695161f8f.29.2026.09.07.07.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 07:50:10 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:50:09 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tsys02d: Fix state desynchronization
 on resolution write error
Message-ID: <20260907165009.0000035c@gmail.com>
In-Reply-To: <20260907085353.54477-1-salah.triki@gmail.com>
References: <20260907085353.54477-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 09:53:53 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> In tsys02d_write_raw(), dev_data->res_index is updated before checking
> the return value of ms_sensors_write_resolution(). If the hardware I2C
> write operation fails, dev_data->res_index remains updated with the
> new index despite the physical sensor remaining in its previous state.
> 
> This leads to a state desynchronization where subsequent reads via
> tsys02d_read_raw() return an incorrect sampling frequency.
> 
> Fix this by performing the I2C write first and updating dev_data->res_index
> only if ms_sensors_write_resolution() succeeds.
> 
> Fixes: 53bf4d067d51 ("Add tsys02d meas-spec driver support")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>

Was this found using an LLM or manually?

> ---
>  drivers/iio/temperature/tsys02d.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
> index 3ef72347456e..f50426beacdd 100644
> --- a/drivers/iio/temperature/tsys02d.c
> +++ b/drivers/iio/temperature/tsys02d.c
> @@ -73,8 +73,9 @@ static int tsys02d_write_raw(struct iio_dev *indio_dev,
>  		if (i < 0)
>  			return -EINVAL;
>  		mutex_lock(&dev_data->lock);
> -		dev_data->res_index = i;

+ blank line

>  		ret = ms_sensors_write_resolution(dev_data, i);
> +		if (!ret)
> +			dev_data->res_index = i;

+ blank line

>  		mutex_unlock(&dev_data->lock);
>  
>  		return ret;

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
