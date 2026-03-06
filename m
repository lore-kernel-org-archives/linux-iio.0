Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A156531A549
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835158; cv=none; b=Zy8a6P8KgjXoxDu2bvZ5kQbKKNBJEeRkWkUYWiuhAkRM1WOTP4hoJFO1K9GpeybanvD2JwPbk2f4i9E5ItOZcYJZAn92AV0UJKfHWDMpN8Hm4eaxX8faRZo3eZI2G/WeQrCU5JMrOTfm3b7DOgz9DoIpqZOmGo7DILNAc7m9dvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835158; c=relaxed/simple;
	bh=Hs+MBb04Lyzo880e9nk8eI+d8SukZx9jsCRlpJ45bJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bw3XI76Cea6vpz8zErjihi8q+rSsrB30tAnKnAQ4uiBlPkwgJfwjkXkWc/b5Rv/40LznOlvJ73RolnCOpBK76dvr999dkvuyyrGq4TS6a4ObBGt1+RCpH1WUhPwzU4LUsQLGtolkhewu43bqlsraztEtkdkvB+JvyCCdmKNtPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CcXROxbt; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CcXROxbt"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-414ffb4c0a0so3970493fac.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 14:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772835156; x=1773439956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ew/B/937aczEKs4JzvmAwfq3QMOO8uG9SLncMIG9tjs=;
        b=CcXROxbt2bAkgFlcCmE9Lm4MMFf8/neUtwRmGEm9cWGVZ5kOyEXqMUQtWDOELqD41w
         VZsXupT6jnjXDYmFWqXtL7GNj4t3JmgT8hSjEOSqJluLif1oFvBV9CcsJjkN9HNz7zzo
         hLsuhkmbDAD25FZXCagTkqksNeyxZvWeRv6ggUmq9F3AcDjbAUi4kOpkMwI6RgSElkA9
         c1BiKzivU/U630UZNQFD9M1BaeJRtdykQn5IUB0ktBPS4lqhSo//u52J9ck7Egv/yA3I
         /xmKtn4Sga2PVEZ7FxcPoxcwFNZO2TqVYXWrM5d4wXGDQTF7Ahmxa1vWOYqxcUWbNogr
         EKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835156; x=1773439956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ew/B/937aczEKs4JzvmAwfq3QMOO8uG9SLncMIG9tjs=;
        b=APHVOMT+gFNs1zE//bnXJQvUkPfFnXGFAkk5z5TXm6TrJfc9dgvThoAlcG4tLOhRmE
         yhQhfX87e8Ig0b+6XWbwuC8aKns/i2V5yl3uHsngeqhedSrp0eHJqF8hxUsRzDxFg6GO
         YJH9h0TNMRBx232epMykC8OuBr8Y1i035Lwt5A1V9s6DLVgF5VsnrkTbEp3yTM7TswT4
         8hvUUvVv4w6pLYXlHhJdSj4K8WJsepvmFLiY2cnPyZzmJBf055o8JcKirDTS3t2HR5Mm
         wbooUpsfzBnr8Hy1oeZiyy32wYrUgElIVWwtRMYWzI6Lu2fuqqmFbQ1rB19V7yJJkmlc
         4zGg==
X-Gm-Message-State: AOJu0Yz9Kn7kJLayDpsVxTYbq3wJZKBoQd5x2fSoab4uhLfIrxLUaqm3
	Z25y8O0GZIB5jM5kYGprkutCUlCoMLfycQENCb6bQvuLLvUqmVZTmz5CllBs+YoUZuY=
X-Gm-Gg: ATEYQzw9+4KOQwC8viIcz7kiqZj+8dLuYZRuI6++z9MsYGBR83TJFf7wmpM07HVENEx
	2gy2/i4Frx2rEm9B3mCm0r+IJsDU8DqUmYPcVXPEhYa68VwdbkIdlMNPIGVtXb1+fX2C9lwh6Ab
	I5DI13axUjYSKVJWiD4cr6nVtt/IDTltvGo/YQqBD/onBGC2Q7F+6irY13rwL/aSyzbhVaCBh3V
	s9+vLdH2KD5kesE9D2eSCDobb9mB3nLXYDdqhg10hOOpSFNkKy2TPDD0+ioLImnItyHGwCQ3uzP
	oLrlaSGf9E+LlYEalbw4QoyCrUf85NOobEryCubeKBD/K7YQfqau5KedFujs28u7MhVpUUR7jEg
	xplY1dybuyTf/WA+15dGaH+n6JqfweLFSPWgO/r+gC4IS5Yx8i7HA0H2TdCNLeA3IJtQRCLB6GW
	4obPeJE+E7QsAGmUulc3SfQvXrVgSX6s3QT4Cfsw/sryn4IX/L+yO9ngnvRS4fcIHEKvLpWOQX4
	Q==
X-Received: by 2002:a05:6820:450b:b0:677:8da:286d with SMTP id 006d021491bc7-67b9bd16918mr1703424eaf.49.1772835156649;
        Fri, 06 Mar 2026 14:12:36 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:6d78:b98b:fc05:ddbe? ([2600:8803:e7e4:500:6d78:b98b:fc05:ddbe])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67b9d517fb4sm1611438eaf.15.2026.03.06.14.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 14:12:36 -0800 (PST)
Message-ID: <8f532495-868b-4e69-bec0-0e6e12b7b959@baylibre.com>
Date: Fri, 6 Mar 2026 16:12:35 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: accel: adxl355: convert to guard(mutex)
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>,
 lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, puranjay@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d587dd07-ce23-49f1-9a38-ea741e4ef14c@baylibre.com>
 <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
 <20260306211152.65109-3-rajveer.chaudhari.linux@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260306211152.65109-3-rajveer.chaudhari.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 3:11 PM, Rajveer Chaudhari wrote:
> ---
>  drivers/iio/accel/adxl355_core.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> index 1c1d64d5cbcb..ef05178bff00 100644
> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/bits.h>
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>
> @@ -263,12 +264,11 @@ static int adxl355_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  	struct adxl355_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
>  				 ADXL355_POWER_CTL_DRDY_MSK,
>  				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK,
>  					    state ? 0 : 1));

Same principal applies here:

  	return regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
  				  ADXL355_POWER_CTL_DRDY_MSK,
  				  FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK,
  					     state ? 0 : 1));

Then we can remove `ret` entirely.

Similar changes can be made in most other functions as well.

> -	mutex_unlock(&data->lock);
>  
>  	return ret;
>  }

...

> @@ -448,16 +444,15 @@ static int adxl355_set_hpf_3db(struct adxl355_data *data,
>  {
>  	int ret;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	if (data->hpf_3db == hpf) {
> -		mutex_unlock(&data->lock);
>  		return 0;
>  	}
>  
>  	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
>  	if (ret)
> -		goto err_unlock;
> +		return ret;
>  
>  	ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
>  				 ADXL355_FILTER_HPF_MSK,
> @@ -471,13 +466,10 @@ static int adxl355_set_hpf_3db(struct adxl355_data *data,
>  	if (ret)
>  		goto err_set_opmode;

If we aren't getting rid of all of the gotos, we are doing it wrong.

Same applies in other functions as well.

>  
> -	mutex_unlock(&data->lock);
>  	return 0;
>  
>  err_set_opmode:
>  	adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> -err_unlock:
> -	mutex_unlock(&data->lock);
>  	return ret;
>  }
