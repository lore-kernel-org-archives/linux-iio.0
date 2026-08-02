Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B83B47DC
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684696; cv=none; b=e+FEvaN67jd5H6uDJwLumKMSI9tSumYPYCspsA6MZokxD3MdDjQRK54vnPQbeRmYiSpTC50WVjsf7KHTyEYwQXN9JqJn+ZMrrraZFDdmkJ1aXuqtZZ5ITPvvw1OoV28J1YV0l8ge/dzYBGTo9jobauVy76L2UZtFw5E61Gv8lhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684696; c=relaxed/simple;
	bh=px8dE3bxwRZq5Tg8BoYdcga/Yvyq8YGWjYTGt0qUMgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0VIJXKuHhOvPsXAN02WUjA5fV1K8pC/u+mKAduOEp3Rh1QZPYCguNeH6ywUtg7Slg8yOuJdnyQENIOHmq9djkKwjpuzh6PCvwJLKQVNhVTTaESlu2hCy4hPMRkxamXbpWEIfFMqdm4ca7w2BSFDulnBiLlxH3Gdt+IswzgUQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LBBOqr2R; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LBBOqr2R"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-448b89f700fso2572365fac.2
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785684692; x=1786289492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCFVPQGLGHHPRubIvlqdNztK/91BUJyCsT+AEegVq4Q=;
        b=LBBOqr2Ry9AS09q3WZUdYFRt5XI43M3AOxfE0+tF97+SospNqLGS0SZv+WEOA2CIka
         Dyitz0o5uxOKH2WEMmKgskEVXz5cKI8lruTaEFm9Pf7K332N10KFOJ08rH6+TtebnZYg
         GBEBZKpIWgLkaPqhXfP4PDG652wJibp5pyd7W/iuPOB53X3aShfxTCt/uIhDjFt/R667
         dKQ8RdNGZ7e9oNe7VRdpXVUJa0QHNRFV8q+q3hWRIge1AEBd492tcaOOz7MZccpcp/59
         SGQD6GDcPERhXDOs+zXn7B0Zp+5GKzWDSRi4LCxxAJdLqnexHgVQXEe0xxEigLP2vbfL
         h8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785684692; x=1786289492;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCFVPQGLGHHPRubIvlqdNztK/91BUJyCsT+AEegVq4Q=;
        b=WP83grYinqBXPhkannb6pokYIGKC57D3OQ5O+oNO2AMga+n/403ApcLIYLkZ2g/mVr
         YxGEpPOKgqwgCHnVBexboi+X1Vsdz3m0Bl01EMplZsqwCZh0YyaE7ySkPHhm9XHqlJrl
         DdJCE/oOwGNmioiJkxHA6CY6TtZfLx12YVkKvViwzf2nsmDlAx0a5+SAsQt5LAq9tbHz
         1wr1IL0gYgZ33nK/nkTU84JaWw9byGWVhrMv296CFV7IwOPMkYOl4tAhs74flxL6ph4K
         Dcjf1DrhfzEsOe3Urev5KvryXQkiXkgY2m45c9XMMhR+toxbgjReSejZuvyxfZ6KWAmI
         kqOQ==
X-Forwarded-Encrypted: i=1; AHgh+RqhEE7TQYb7Npxx/0w3gq36qk5Y+tD2mogItbDWKX6Um2a0qebmzlSWtmyHOU67dHX+mp8KHqCaSHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh3U5ShJ1YfDnEu7O8fPoI87PujaipwxHCXUta6CZabP815lR7
	X5gbLqUWjRFIj5NI/LCZIox0gjMxhWmxBVet3ztrKV4j3Nu05KbM/IM6C3Kss2Kw2F4=
X-Gm-Gg: AR+sD10KHPGsVplfFBUT4a/yB/iYqb+u8RoWwS0M0LqpT1q34K8iaqy8c4okkVNV8Ym
	G0sxj76kd1R/XrCNfrNc07OjDtgkcZVLU57gaMeOXS4uDjp5BvaJ3vNyTuCh4rgRWbFUWD2F+QS
	QYAQZHG5Uptq69fcvfknkSIPGFOe/MlpND4QTHg6+YA5j+ffG02zV46uth0lPNbdjDzqgK3TVJF
	3Natt7TPtQRwHcHrVVWYozOYN3f7aSqWr8vx/iqtNMLv8VXPcvy0PsMm1KDQWPXcMDbSXLsFTEr
	drySzi2Cn1Yc5T7bF6iIL2YKI9lMheY/WF/EX5pGpULYYrV3mB9JWtDFl3z98pFjjWd/+kQbisV
	+bkysQt8EzmgUI/XJUyLOG1jiEaNnHhJ1XICnzbljtmXfQkT2iODMaFK9gxa8yvOTdQMlNsSk1f
	tpRu2Hi2dyo910OCb01+f/yM2mYrDHRO1lawbf9NWHD6V1vBbJnjWzGtEAuBm3z3x+ZT0KDTEI6
	/b223m6MYbHV9rvfphWShqHmIIPRmP3k7IWpMw=
X-Received: by 2002:a05:6870:1256:b0:459:88c:12d0 with SMTP id 586e51a60fabf-459088c199dmr8364418fac.2.1785684692137;
        Sun, 02 Aug 2026 08:31:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3? ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f66c1d89sm6362690fac.13.2026.08.02.08.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 08:31:31 -0700 (PDT)
Message-ID: <0bde2343-8a70-44d4-9b27-8ce42c099309@baylibre.com>
Date: Sun, 2 Aug 2026 10:31:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: iio: ad7816: avoid DMA from stack in spi_read
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, jic23@kernel.org, gregkh@linuxfoundation.org
Cc: andy@kernel.org, linux@analog.com, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260802113840.17730-1-abdelnasserhussein11@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260802113840.17730-1-abdelnasserhussein11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/26 6:38 AM, Abdelnasser Hussein wrote:
> The SPI core may use DMA for transfers. Using a stack-allocated
> buffer for DMA is unsafe and can trigger faults when VMAP_STACK is
> enabled, since the stack is not guaranteed to be DMA-accessible.
> 
> Move the transfer buffer from the stack into the ad7816_chip_info
> structure so it has a stable lifetime suitable for DMA transfers.
> Mark the buffer with ____cacheline_aligned to ensure proper alignment
> for DMA operations.

Should also mention fixing the "wrong" sizeof() use in the spi_read()
call. It was the correct size, but the wrong variable was referenced.

> 

Probably deserves a Fixes: tag.

> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 0e32a2295990..fcaadebff0f4 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -50,6 +50,7 @@ struct ad7816_chip_info {
>  	u8  oti_data[AD7816_CS_MAX + 1];
>  	u8  channel_id;	/* 0 always be temperature */
>  	u8  mode;
> +	__be16 rx_buf ____cacheline_aligned;

In IIO, we have a special macro for this instead of `____cacheline_aligned`. 

__aligned(IIO_DMA_MINALIGN);

>  };
>  
>  enum ad7816_type {
> @@ -65,7 +66,6 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  {
>  	struct spi_device *spi_dev = chip->spi_dev;
>  	int ret;
> -	__be16 buf;
>  
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
> @@ -91,14 +91,12 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	gpiod_set_value(chip->rdwr_pin, 1);
> -	ret = spi_read(spi_dev, &buf, sizeof(*data));
> +	ret = spi_read(spi_dev, &chip->rx_buf, sizeof(chip->rx_buf));
>  	if (ret < 0) {
>  		dev_err(&spi_dev->dev, "SPI data read error\n");
>  		return ret;
>  	}
> -
> -	*data = be16_to_cpu(buf);
> -
> +	*data = be16_to_cpu(chip->rx_buf);
>  	return ret;
>  }
>  

