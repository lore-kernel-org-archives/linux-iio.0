Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FDA3BB12E
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913006; cv=none; b=Un8K1ycK82W+hOigNJrdTmw7qtGZ9jd8xcfWEMQ4aUYU6PZZBm7hWLW6M2u/5T4PAu8VOVztQ6OgHTJ/n7LRIPVmn1XtoqM5f15ZPufsLul57l25NLWVbYjoSZrM6YueGTybqSrXapVxT+5HEXDaWFD6cwLj9vFAnx7m8xNmtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913006; c=relaxed/simple;
	bh=sQ0DrK/meoKXlIMLY9EOTIfgJUW3PiYFbYQPcRmdNbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNX1K/yceHod/KdFIJdWLMj+5sOGkCGPCE78QKabr5LeLzsQVHKgctpPewDOqkl7pRTyj5DSm6T3Pf/f+EybakahhX1d2js9IjovvQ5Uz4+m9YQFeT8nVtY2KLO3jbrScT6MrkbmgyW0RBGI53A7QYtkbB1KSg44vKYXpkYIStQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5roeAWp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5roeAWp"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef616daf6so3701228f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 03:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780913003; x=1781517803; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hbg+XsAQtNwIT/IgmjGtiGvSVfX8n41fjWe9/FHO3E8=;
        b=E5roeAWp8aCh3dbYyiM+B1nHQgJ/jslzkJihd5YZvM52RZkL2YmI0fwx2CzR8xzA5y
         MsqWNvAUdfcY+luD3Dl/1buPQn+b3F6mZED3vUZWwO+Bc/ov61EEvgUBs7QmUWhk/GPB
         8CehifH9pt7LPqGmShzDfStYFGU9bBSTKtsfHx5lRvFF/djN8A1a9kPxugVc2f0uniGF
         NdYvhvoiO/e+SqGiaCdyqU0gSYi/JfZtEN/oG/5xGHfPJQTV+LlFF9iUyIOF/B5FKSE2
         5rXUcIp3/7EAwETn51zX2USQ5XadpBeHOGU/7s8P+LXmQL20L7o2tdHtXw2sqoy8alDz
         qCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913003; x=1781517803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbg+XsAQtNwIT/IgmjGtiGvSVfX8n41fjWe9/FHO3E8=;
        b=o/sTB6hM5Cxy0M7o6vlgXeaGHErcv+/QOGq/Tsaw4jzOtijOWja9MrgpY4LD4DwmgT
         dJlqepO7x/EKOVMZkPdFuSIDVupKjtyVerYJjFbQMjIwEtQ6ZHWDG2Q5A/qK0erdWRUL
         1NKLBQnhUmtCzyMQ+N4OapCsoRDmw4dO6WYrwNGrKDzF7b+s5VUsMLQxL6BbnmaPCVpA
         P0iclaph1npEUfaRappU7m/eidf9+2G94mshrkosnsr0oEY29ZaQssaB20eP+hNGPO00
         owSq/brHbucz4ShoII3kLhnIxm1zOH7b/HsKN+x1zk6GKHNXI+fh7e3ej+IGZ9pXXBBZ
         6GIA==
X-Forwarded-Encrypted: i=1; AFNElJ82Xgp4miOvrWMHnAXDiplmCZDKhElGEKhZI4kRMdkeS/ei5U9HX48iYXlAlY7tTXDdmbfh3ziUh28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTt6LbidwLNnF+FLo8x9B8wRuUkgzYTyjJ1PJnagg5v7uxwe2
	p07s83R01+z6pnoVKeGd6fbHPiSk3VXQY8l/v2FUzHZaALrAh/F82HSo
X-Gm-Gg: Acq92OGyZH7LUdDM/CogNR+L+l9kr4lSHmBExf/XCZhnNBrtfRj7yiyz+5Gad/+FrGy
	qI3/MaqC0TZcD1/lOmAf8LbCL0w6/5HNObAIDrUUj+0yUvP9wH/Pax3praKAmip7bBvKRevjC+C
	0Vo2m2cwk5HcwmAVerMV+UpiRR3jHTvCII2mawKfX6hC465AJkyCdtrNj3bM4zAlR96k8wMGd1m
	OpSkYdxEdLz/2oRnwcDaGR7cznx9JAEuBKFEjy4lhVv+aZeeIe9CtA/1TnarmCTyTpsKkqE7vZ3
	m0RoBXJ/n2vVItYpTi6632PX19ch+2GGFdiKW8e2UBW+nVLOwgSnkh2FIxjw9tUk7z36o7C7xqj
	Ck5MQVm4kHRhfPHsQh/BPXB0R0r1pdBWf56VDWOVvJVZyCfHU4wxUlD3vQjILxFVHoNo1W/uGdj
	Se/eW/EC/jlPFaOZzHtlL4HJ7JLquuG7K7gara
X-Received: by 2002:adf:ed49:0:b0:45e:d3d4:c230 with SMTP id ffacd0b85a97d-460306278afmr15922438f8f.38.1780913002949;
        Mon, 08 Jun 2026 03:03:22 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm39414940f8f.10.2026.06.08.03.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:03:22 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:04:23 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: radu.sabau@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: allow COMPILE_TEST in isolation
Message-ID: <aiaTVDWpKECtZPyz@nsa>
References: <20260608-ad_sigma_delta_spi-v1-1-61e37666d9b6@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608-ad_sigma_delta_spi-v1-1-61e37666d9b6@analog.com>

On Mon, Jun 08, 2026 at 12:02:54PM +0300, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> AD_SIGMA_DELTA is a hidden tristate that can only be enabled by
> selecting drivers (AD7124, AD7192, etc.), all of which require SPI.
> This prevents compile-testing the library code directly with allmodconfig
> or by manually enabling it with COMPILE_TEST.
> 
> Add a prompt string guarded by "if COMPILE_TEST" so the symbol becomes
> directly selectable when COMPILE_TEST is set.
> 
> Also add an explicit "depends on SPI" since the ad_sigma_delta library
> directly calls SPI core symbols such as spi_bus_lock(), spi_bus_unlock(),
> and spi_sync_locked().
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---

LGTM,

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a9dedbb8eb46..329d1f6e5106 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -33,7 +33,8 @@ config AB8500_GPADC
>  	  and USB voltages integral to the U8500 platform.
>  
>  config AD_SIGMA_DELTA
> -	tristate
> +	tristate "Analog Devices Sigma-Delta Modulator support" if COMPILE_TEST
> +	depends on SPI
>  	select IIO_BUFFER
>  	select IIO_BUFFER_DMAENGINE
>  	select IIO_TRIGGERED_BUFFER
> 
> ---
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> change-id: 20260608-ad_sigma_delta_spi-6063f200195b
> 
> Best regards,
> -- 
> Radu Sabau <radu.sabau@analog.com>
> 
> 
