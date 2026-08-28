Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1E231A23
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 04:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787890652; cv=none; b=Mfd9/uqLqr4WRUGTblZX9HHRHjCvVgGFMc/+dnR0fOjqGYHvbrJZNMSHJRxN9GvH6eNfByaaIpkOnlZ9P/bh3zZxWJt2sMOOd0XPeRVkMoj0WEb7iaudoSar2/IzE/PfRmnzYDvRoV3Wtgntquq5YVA/MvkH4c2l0wm2pulgrRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787890652; c=relaxed/simple;
	bh=pTqidcm3PAu7POfuygrHb1YbhgmYvPuj7LrPfVSm1kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5qomQi2DfSLC/t0iK3ydTvk9vciHdJIhJudy5QjVKmonT6RTf6fNITX1K8a6WjLCiNTYOEU+avzsAxvxiUVFRgznIl0VV5sWUH5DZqORs62odoz9xfmdyb4nrA/FO7BHIXtKt970lLyGxKrHfXzK67kclG6Hr7mEWWUL8WVs/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xa4MbNqS; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa4MbNqS"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so394424a12.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 21:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787890651; x=1788495451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gO0v4/V9YgV4PqtgQrf2yHSlli7ph+LMnJojXZKVqJY=;
        b=Xa4MbNqSKvXsKGW4bSdxAvYMg9nGINKU8AszGNhh4DjiKGYa4B6pzt1jb1agr1QebN
         feSOZsIzZFkt8dftkzdyLZgRnCRKc9YEJcHAaSPQ29BCiW4aMWBwT5Q0/Tm1lsp4HYNH
         d8dFA/9+tKqKGKvdDYkPw+mcLBqGoVh6TV9op0Lo5CVzXp3ApdHKw/YatDtFWiXVtWJ5
         1GZ4pBzPwn77WdE/+qmfApJbIDwHCDjGPlmJvYY2tPQOI33bv7bMlaxgGj2gzrdA1M+5
         XW8gamS5pbjXcVrp8zK3K4SfLy7YtF0aLFd5sEFVnlk6PTDIYMUpwMijx1E+Nm3b5hdN
         8tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787890651; x=1788495451;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gO0v4/V9YgV4PqtgQrf2yHSlli7ph+LMnJojXZKVqJY=;
        b=Kqsm6kUwsgRagzH6BOSwvleoATVBdNF9rJrgp0aDvGxDJfM1ok8JA5wnBODXzVVTEh
         Jj1WghBKG21K0x5W5lq9tCEwcF1WLRrjZ3tQLgATz21kfLoDHTU6Y8mWoIgdTEkt24LQ
         J9AxMEIzw+2tLuqh4GWP74T210yL1x7AVcjemz75h5YWlChAZVvPDu5vF0cg8FVhZPCw
         K5AEi80/Hp4V3+eUx3Y2rbyKDW5WeF5vm5pZnKv4pGuVo9wp/7KWXadD7J6hWpjsuXlr
         JNaQGG0OSiDlyG6qLoWijF0/5ys6dYqHvGqv6LikU8ybAVpXkW0N8xxbiiT9XnroxjcI
         wA0A==
X-Forwarded-Encrypted: i=1; AHgh+RrZM9o5+eguDYE//3s7fdg2R5W7ZTIXjpMW/+gJYsKzM0Re0zj695cBn+KekVdoqJabRbgoVoNFepM=@vger.kernel.org
X-Gm-Message-State: AFuF++lBrJovi+2g5H3ULM2wms+GneoQZJ5sOtk9AfzSEq2MOyKqe6ZL
	pLKjrV16iyiDh63Pv2W08r/d3tT6JsC0aHBbl337lzkmolnpQiTqc4hV
X-Gm-Gg: AR+sD13NdnG5D0oE2E0h12ZNJWCAeGhBR8an0Eqna9AON9FXmALdmYFBxDpSmupi8Do
	NGxn+PQLKVPGwmAt5o3UrKnBV6washn22Gsm9pNw7jd5ymjXztnAsH+c99UrW/ZdAF4bVkQFyG1
	H43fWHinXVJ5eshP/R63+Hplrj5iTFwZWnT2vjnUdzFIcv+HFZWkz+NeZXdNSGLXe3uTV9y3zeE
	vD3OKy6t0htvS7rxQrnGX1erNexXNOnKdpSLXyKf4A/g5psAw+flFx8zKAyaR/vZnFDAmgBHsAl
	05VmmczDgZ3OkgoDKsgeJG2a7ssL/uHHRLZKDm49iln9G+q1vAUiQWdT6vZYnxVzT3OD1Cqh/ii
	2gjPxtGZRbD7sY8YZqW2v3uK0OSB5L32FUm7PLs7Kc/IvT2Ckzd+1GbpjOxvgrtOyQtESGlbTaS
	BH1jebFFyVMM3r7SXaNy/JGYYueYApXmePV96je4zHgVQ/YPIt/JaXBtjXetd88kSMyG0xnw==
X-Received: by 2002:a17:90a:dfd0:b0:38e:b400:a860 with SMTP id 98e67ed59e1d1-396d0fccf78mr8786188a91.13.1787890650739;
        Thu, 27 Aug 2026 21:17:30 -0700 (PDT)
Received: from localhost ([2804:30c:97d:e800:9454:1179:18df:ab33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d1b38esm1896535c88.3.2026.08.27.21.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 21:17:30 -0700 (PDT)
Date: Fri, 28 Aug 2026 01:18:18 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 5/5] iio: light: stk3310: support the Sensortek
 STK36C61
Message-ID: <apEMCqQXyj1tAMoP@debian-BULLSEYE-live-builder-AMD64>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
 <20260826175409.326131-6-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826175409.326131-6-jorijnvdgraaf@catcrafts.net>

Hello Jorijn, few questions inline.

On 08/26, Jorijn van der Graaf wrote:
> The Sensortek STK36C61 is a 3-in-1 ambient light / proximity / RGB
> colour sensor (chip ID 0x95) found in the Fairphone 6. Its register
> interface is compatible with the feature set this driver uses: the
> STATE/FLAG bit layout, the data and threshold registers and the gain
> and integration-time fields, verified on that device (the ALS and
> proximity readings scale with their gain and integration-time fields,
> thresholds written through the event interface read back from the
> chip, and the FLAG near/far bit crosses with them). Add its chip ID to
> the known-ID list and the device table entries.
> 
...
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> ---
...
> @@ -417,10 +459,10 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
>  		mutex_unlock(&data->lock);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_INT_TIME:
> -		if (chan->type == IIO_LIGHT)
> -			ret = regmap_field_read(data->reg_als_it, &index);
> -		else
> +		if (chan->type == IIO_PROXIMITY)
>  			ret = regmap_field_read(data->reg_ps_it, &index);
> +		else
> +			ret = regmap_field_read(data->reg_als_it, &index);
The above seems unnecessary. Why changing the comparison from IIO_LIGHT to IIO_PROXIMITY?
After the proposed update we would have the integration time for both light and
intensity channels being read from the same register field?

>  		if (ret < 0)
>  			return ret;
>  
> @@ -428,10 +470,12 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
>  		*val2 = stk3310_it_table[index][1];
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_SCALE:
> -		if (chan->type == IIO_LIGHT)
> -			ret = regmap_field_read(data->reg_als_gain, &index);
> -		else
> +		if (chan->type == IIO_PROXIMITY)
>  			ret = regmap_field_read(data->reg_ps_gain, &index);
> +		else if (chan->channel2 == IIO_MOD_LIGHT_CLEAR)
> +			ret = regmap_field_read(data->reg_clear_gain, &index);
> +		else
> +			ret = regmap_field_read(data->reg_als_gain, &index);
Similar question here. What do we accomplish by comparing to proximity instead
of light? Is the gain info the same for light and intensity red/green/blue channels?

>  		if (ret < 0)
>  			return ret;
>  
> @@ -451,7 +495,8 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
>  	int index;
>  	struct stk3310_data *data = iio_priv(indio_dev);
>  
> -	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY)
> +	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY &&
> +	    chan->type != IIO_INTENSITY)
>  		return -EINVAL;
>  
>  	switch (mask) {
> @@ -462,10 +507,10 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
>  		if (index < 0)
>  			return -EINVAL;
>  		mutex_lock(&data->lock);
> -		if (chan->type == IIO_LIGHT)
> -			ret = regmap_field_write(data->reg_als_it, index);
> -		else
> +		if (chan->type == IIO_PROXIMITY)
>  			ret = regmap_field_write(data->reg_ps_it, index);
> +		else
> +			ret = regmap_field_write(data->reg_als_it, index);
Same pattern, same questions.

>  		if (ret < 0)
>  			dev_err(&data->client->dev,
>  				"sensor configuration failed\n");
> @@ -479,10 +524,12 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
>  		if (index < 0)
>  			return -EINVAL;
>  		mutex_lock(&data->lock);
> -		if (chan->type == IIO_LIGHT)
> -			ret = regmap_field_write(data->reg_als_gain, index);
> -		else
> +		if (chan->type == IIO_PROXIMITY)
>  			ret = regmap_field_write(data->reg_ps_gain, index);
> +		else if (chan->channel2 == IIO_MOD_LIGHT_CLEAR)
> +			ret = regmap_field_write(data->reg_clear_gain, index);
> +		else
> +			ret = regmap_field_write(data->reg_als_gain, index);
And here.

>  		if (ret < 0)
>  			dev_err(&data->client->dev,
>  				"sensor configuration failed\n");

With best regards,
Marcelo
