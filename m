Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE902D9ECB
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789913303; cv=none; b=cnBAtxP5bjpx4W17VliRgOM73kLxl2YXnbHaR9Rz25dlr613EHEbASTf1FFYl7UOPJuoF0jKXZknjxKIaNGpY2IbbZ7ua6fbmgX++/SCmrvyt4Fz7kFQAT1TNS1yY8rfqmGCdyozgEigMvKdjy7O5BYiyU5O+XlMMVPzfXQh6xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789913303; c=relaxed/simple;
	bh=bof09/06nPiQ4HzLqim9Sfhjmg3hRr1rOAzuadnmP+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICQeypH5ZKVcCZRsC7N+kQHSTyozy2lWxRsW2LpbA03tmhtrFNP7JsC8Mpm+MV86yr72GjN8TD4fTj1EYPfX46unHWfAKJ0DjJexvfBclsFywaALtUI8Z7gwHP6oGEM8M9Gx/tJ9PH/sUjdohw+4tpPgrGNlG4cZcsjC9odVQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FonyBhjo; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FonyBhjo"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so2014089a91.3
        for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789913302; x=1790518102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iyOmZAJ5EC0g24waSg1z6ypsi7AcrrbpqT6UrnwgkGA=;
        b=FonyBhjoMeC1jqWHAxmLeMtbVXfrqU+W7qQttCpdKcO+uKfaszWTqIBcm7RwHfVEd2
         UaQCTvt6r4wAdntCQDDdXfSf2olZcf4pjbRxkdvJLJU5hOU9vkn7uGqrRLJyP22pEyee
         m5lEJzy221Qq6tAQd1OIpMjbgi3OlIPb1yUFWcfkBun74PWVEGo86u1CJ4Opn0MYcSFr
         N1nkfDdFS8lcalJmFvfiaQNrYW0Vb+1j02Gdy+0ckc+MenoUBeD9lLFwmor9JQ03ZCMs
         D2/VJsYUTXRttYN6xjdQ2JBfaHjRoBGx+ntRarliDB9JXRg3qK+D4h04KShg8A54cXEH
         FYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789913302; x=1790518102;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iyOmZAJ5EC0g24waSg1z6ypsi7AcrrbpqT6UrnwgkGA=;
        b=Q9yRI0/mRBKsL5LLo6wShaqgvhvZnarEr6ntpi20XOLn0P24tONeAQ5tGQ5r1gyq2U
         zwTCr/24hUUP77PP4h+9o8ZCVXFh+UZv+OMpBiHP0wVap9MGoAzF+an6u9pl4WuhSrZs
         3r6bxPNcAXvg7UEZUUmzZmqmBWILIhDc6PMTqk0haLl8mRDxz0EYXGljrPyp48lNK60e
         8MIkIGcD4wYGHTsUIokBjNXZxO5hObOa7d6n0skBc/QnVHsL2lv96Xpbdb0Cx4++zu7x
         wSlPgGX9lvgF/+iFq6RHNhgKLnObwCA09Do9Hq1laYcIc7MZkcfrspquRjare/eecm8K
         poBA==
X-Forwarded-Encrypted: i=1; AKwUvBx/n4Q1FEyp5KR/aRxDgMfv0IlTHlcrJm9LTi+iHENqfzQWeeTJQWdmdlNI1N6EyQlxjVsKpcCzAck=@vger.kernel.org
X-Gm-Message-State: AFuF++nc0cqthDnxJjHgFM9ZgcdzZUQdpdNvuvCh2W3Hnnxh3MWaZ86C
	CHicLKQt5JaT3jO3HfPCmmZmb+7m2LwhGImFiZBMqLkvI9cFH2AwwOjc
X-Gm-Gg: AYBFou3gC225JgHWIohgzbih6M8zW6ExXH+/G5ViJBKwUErE/Zs4JPAgNYYKcyOuVqQ
	RyhMXZsN7Om3ANwJlvInSP8brBFLmD+RXUsbUZ5qTSsGtKI6Ktp15TEwQR4bXqmSTOf7ffluzWI
	PSybAgtLoj24e4iHTJqxequL4Y+jusPXnZoB3tho/B52w7qwOcQm212eUAWjIjCr1TuYQG41u+4
	Xkh7oFn4t6j96l6QrkAQoDiLBGX6BDJBcu0fuCFb7E1PSt+DkWVpxCMTXROPuv4gRaP0tJwhTIK
	7gYLYTFbClv9cIVXuCNB5rxQfQnBkyRucQ4DBkRhcWQ9AzOkRIyLN3wjWeZaXRYlK1stNSjp3HS
	sxT9MbKY4fHTx89FZgeCMu60KqCwl7UJaYrtwToKGiU6csLlhGVP+gglj/fGJWSc30ocd4RctkH
	N6yL6s8Zei3eEWDrJv5OC7vdANYHrYLGlMmnpmzk/PNrL8X4Bn+U3CYiZq5NcE4I11aPF3EKkLs
	PfZBABwshOU7SE=
X-Received: by 2002:a17:90b:3eca:b0:39e:6a7f:1dc6 with SMTP id 98e67ed59e1d1-39e6a7f2209mr7510006a91.34.1789913301817;
        Sun, 20 Sep 2026 07:08:21 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144e14dd04dsm2962133c88.7.2026.09.20.07.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 07:08:20 -0700 (PDT)
Date: Sun, 20 Sep 2026 11:09:27 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: imu: inv_icm42607: Implement MREGx register
 access
Message-ID: <aq_pFy46SirVu09b@debian-BULLSEYE-live-builder-AMD64>
References: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
 <20260917-b4-inv_icm42370p-v4-4-fd9373f123c9@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-inv_icm42370p-v4-4-fd9373f123c9@axis.com>

On 09/17, Kanak Shilledar wrote:
> The device supports indirect register access to different banks. A
> specific routine needs to be followed when accessing the registers in
> another bank as documented in the datasheet (section 13). This is
> required for accessing registers configured via the user and
> implementing buffer support. The implementation is inspired from the
> icm45600 driver. The banks are defined based on their initial bank
> access code which are written to the BLK_SEL_* regs. However, there is a
> variation for MREG1 as User Bank 0 and MREG1 both share the same 0x00,
> so User Bank 1 has 0x00 and MREG1 has 0x01. When MREG1 register is
> accessed, then BLK_SEL_* is written with 0x00 instead of 0x01.
> 
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> Assisted-by: LLM
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> ---
> LLM was used to implement the mreg back switching support.
...
>  
> -/* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
> +/*
> + * Virtual register addresses: bank id in the upper byte, register address in
> + * the lower byte. Bank 0 is directly addressable on the bus. MREG banks are
> + * reached through the BLK_SEL/MADDR/M indirect access window, one byte per
> + * transaction (datasheet section 13, no burst support).
> + *
> + * MREG1 programs BLK_SEL = 0x00, which collides with the direct bank, so it
> + * gets the distinct virtual id 0x01. MREG2 and MREG3 virtual ids match their
> + * BLK_SEL values.
> + */
> +#define INV_ICM42607_REG_BANK_MASK			GENMASK(15, 8)
> +#define INV_ICM42607_REG_ADDR_MASK			GENMASK(7, 0)
> +
> +#define INV_ICM42607_BANK0				0x0000
> +#define INV_ICM42607_MREG1				0x0100
> +#define INV_ICM42607_MREG2				0x2800
> +#define INV_ICM42607_MREG3				0x5000
> +
> +/* BLK_SEL value written to the device for each virtual bank id. */
> +#define INV_ICM42607_MREG1_BLK_SEL			0x00
> +#define INV_ICM42607_MREG2_BLK_SEL			0x28
> +#define INV_ICM42607_MREG3_BLK_SEL			0x50
> +
> +/*
> + * Datasheet section 13, Accessing MREGx Registers: no bus access for 10us
> + * after programming the indirect access window.
> + */
> +#define INV_ICM42607_MREG_ACCESS_DELAY_US		10
>  
>  /* Register Map for User Bank 0 */
It would help review if either the commit message or a comment here made it
clear Bank 0 register access is now going to be handled by the same routines
used by 16-bit virtual regmap_config. Replacing 0x00 by 0x0000 looks odd
otherwise.

> -#define INV_ICM42607_REG_MCLK_RDY			0x00
> +#define INV_ICM42607_REG_MCLK_RDY			0x0000
> +#define INV_ICM42607_MCLK_RDY_BIT			BIT(3)
>  
> -#define INV_ICM42607_REG_DEVICE_CONFIG			0x01
> +#define INV_ICM42607_REG_DEVICE_CONFIG			0x0001
>  #define INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE		BIT(2)
>  #define INV_ICM42607_DEVICE_CONFIG_SPI_MODE		BIT(0)
>  
...
> -static bool inv_icm42607_is_readable_reg(struct device *dev, unsigned int reg)
> +static int inv_icm42607_mclk_get(struct regmap *map, bool *idle_set)
>  {
> -	switch (reg) {
> -	case INV_ICM42607_REG_MCLK_RDY ... INV_ICM42607_REG_INT_CONFIG:
> -	case INV_ICM42607_REG_TEMP_DATA1 ... INV_ICM42607_REG_TMST_FSYNCL:
> -	case INV_ICM42607_REG_APEX_DATA4 ... INV_ICM42607_REG_INTF_CONFIG1:
> -	case INV_ICM42607_REG_INT_STATUS_DRDY ... INV_ICM42607_REG_FIFO_DATA:
> -	case INV_ICM42607_REG_WHOAMI:
> -		return true;
> +	unsigned int val;
> +	int ret;
> +
> +	*idle_set = false;
> +
> +	ret = regmap_read(map, INV_ICM42607_REG_MCLK_RDY, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & INV_ICM42607_MCLK_RDY_BIT)
> +		return 0;
> +
> +	/*
> +	 * Clock isn't running: we're either in Sleep mode or in Accel LP mode
> +	 * running on WUOSC. Force the RC oscillator on via IDLE and wait for
> +	 * MCLK_RDY. Datasheet gives 10us (accel startup) to 200us (accel
> +	 * transition from OFF) for this to complete.
> +	 */
> +	ret = regmap_set_bits(map, INV_ICM42607_REG_PWR_MGMT0,
> +			      INV_ICM42607_PWR_MGMT0_IDLE);
> +	if (ret)
> +		return ret;
> +
> +	*idle_set = true;
> +
> +	ret = regmap_read_poll_timeout(map, INV_ICM42607_REG_MCLK_RDY, val,
> +				       val & INV_ICM42607_MCLK_RDY_BIT, 10, 200);
> +	if (ret) {
> +		regmap_clear_bits(map, INV_ICM42607_REG_PWR_MGMT0,
> +				  INV_ICM42607_PWR_MGMT0_IDLE);
> +		*idle_set = false;
To fully handle the error path, it should also check regmap_clear_bits() return.
E.g.
		ret2 = regmap_clear_bits(map, INV_ICM42607_REG_PWR_MGMT0,
					 INV_ICM42607_PWR_MGMT0_IDLE);
		if (ret2)
			dev_err(...);
		else
			*idle_set = false;

>  	}
>  
> -	return false;
> +	return ret;
>  }
>  
