Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE4339872
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959504; cv=none; b=L+Ta9tDjMssGS3leovcFKFuIXRLUY/PJBQ9GRi1/ADxl+uru6iX1SShtVurMjIsmVLSZp1j/2ec7Y6TRf5LWkprk4waky+3RqREW3OVZk4Pznb8cPd5kByqgozZP72xsJTd3oK+zw7jsO0pxyOhcCpE+nGIosa47xpcMimMlt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959504; c=relaxed/simple;
	bh=j/xGGVpfBmZ38fXC8JgNuKE6Pd+vPTqjmTMDjnqgZk4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkSLuKD0fA3Ux+dlmSQ/VP1dzDXkQoF3N6PPciOV2Ytw122PrBLpCe3abk8okbUVulZqgMNASP71jy/hUwg14PYlUCZAD9DiXSB2HLsm8PW8ur9bh4FZ85gQcYsjiJt0JTcN4g5FH1/2nZk2BUODMyDYUNnXWjCSKy62jJtPNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOopP5Le; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOopP5Le"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so769035e9.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783959501; x=1784564301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TbGjb/jMJnZzb2UpXKwZzIOhvZ257eTjhYHwFcycWxE=;
        b=KOopP5Lek6WwBkVP78wZIawLKodi3zHxJ8ipLT+pzfncbVPORan7bKbC/pxSFKaEAf
         R2hH9ufjSC48FbdymIqun3oH7vkyg+0S7P46qLJ0DuiHPbVypbotReu+4J8SVSe3Kx9g
         qRBqU1rshS7IpsGxaACI1ffgoJiofV1zj9/az25SHRVcaJqZx5cwcarVqdhYbh3wmrtC
         9RuYWevfr1+BiWjHGzMZO7E3YXlBBJrgLimCNSea9wDT4qfV45AAFsH7Llinz0LxJazx
         GuPQ8BnAFAQhoFJ6Qfoy2QUe7iItfn5Y1QJ5ZlGoIVJyzhpwDv52N4vfe3RdHrxPTF2c
         gWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959501; x=1784564301;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TbGjb/jMJnZzb2UpXKwZzIOhvZ257eTjhYHwFcycWxE=;
        b=ZrHv0xYvYBGUEIcelhtCijdkinz0vgf0GFYh8CMV0iqyWUl8zLaqtp5ZipXB6b/IU+
         ybwxpwCmXKTE/kmVtyazDawj8EK9SncJ95rxhK3fNL/RNrsWd1xEZPR0bAYhQv9i09YL
         RMKx0OczJhh48D16+yRdhRru24j/ZwSgW+R12prIaGwZFlPMNIJf+1BICCNzgdLwrCuu
         uOZxNyewnrBXSNc93Vp56XtJ8/OkItRVkBzlglotz6imIzR8QohOnExq0SQsipL5yHPF
         JMFIkln5tJzfUIAXx9Km2XmQy+s1gYs+G/G5NmYB9QRR0qPleHVjnbdu1wU/2x0fmjGZ
         GH3g==
X-Forwarded-Encrypted: i=1; AHgh+Ro0Bs2/o7NUZrwGctzJn9eiRmJfl/gJSOPvy0mJYO28w7z/aqaLZHh2h09Co8Kk/WmvvSDZjM26QiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsTq1d6M52TAci1y7FeEscTMr8+ej+snUNt7CPz37daYmTaNDr
	O7A6rORU/iH4Ugv/9mEAYvC6Qu5680VrGoIlhjOJptgTlXkK4+eBvgTd7pEKWC2o
X-Gm-Gg: AfdE7cnC0FJfrdkCQ5zlik+BMtEDwULrOgUQDHX6xpi03BERm23Yn2VlGO7gmd/H0sy
	G6IvbPstTOlz5VniYbTeyRLa8o3VSm6Ih4Rle1MfuA02mSTluNacXlRW4IDFrGFl43zglzl+uXM
	LyCE7ZAeVYptNtIQaZuq2Lwc0+5szRUzjcwTh1LSVMQ1wqkVeC6ftoGT0u5GhtWE3yFO/xwwUxP
	RMGx6jalF4n0pU0WtFlcT1cpqUfhZ3wQpLTjZF0pTTAqMWr4/WZNBXtgFMC0JiJUEPd5lgQn/IG
	luCuXDW10pshv/bIS42iEDl93ONwNg+2jRRnlBGKcRbUSGT7Of2kOebdA5prCwsNZRP0L5Eo7rV
	X9zjP6sMPWBICyrt1cXdKKSaRBBrotQPPwOn1eyH4rA5xPLbJNQYgt2xIgORKXEDjbT+19vM/Ga
	MGikdJzw2Y7q9bH6rJWX6HzxcddEmPhZKlE/WaolDoeWOgL82QTXxKbmwDOejXKJgD0t+BN5UfM
	e5/cR/rXriHjWmz4s8M5Vm98Js=
X-Received: by 2002:a05:600c:1392:b0:493:f753:24e8 with SMTP id 5b1f17b1804b1-493fed59338mr80519895e9.6.1783959500626;
        Mon, 13 Jul 2026 09:18:20 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32a2casm7873375e9.12.2026.07.13.09.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:18:19 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 13 Jul 2026 17:18:14 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 4/7] iio: dac: ad5686: implement new sync() op for the
 spi bus
Message-ID: <2shq75gvzzm27rodbgmtxkbgt5n2a7dafjc2mmkttwnshmhyqr@pdytastitwfm>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
 <20260710-ad5686-new-features-v7-4-1bcc8c280e4d@analog.com>
 <alM8M78O9-cRSxR-@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alM8M78O9-cRSxR-@ashevche-desk.local>

On 12/07/26 10:03, Andy Shevchenko wrote:
> On Fri, Jul 10, 2026 at 12:20:48PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Use of local SPI bus data to manage a collection of SPI transfers and
> > flush them to the SPI platform driver with the sync() operation. This
> > allows for faster handling of multiple channel DAC writes, avoiding kernel
> > overhead per spi_sync() call, which will be helpful when enabling
> > triggered buffer support.
> 
> ...
> 
> >  int ad5686_probe(struct device *dev,
> >  		 const struct ad5686_chip_info *chip_info,
> > -		 const char *name, const struct ad5686_bus_ops *ops)
> > +		 const char *name, const struct ad5686_bus_ops *ops,
> > +		 void *bus_data)
> 
> Can't you utilise the dev->platform_data for this? I believe it's exactly
> the case where it suits.

I could use dev_set_drvdata(), I understand that platform_data is to be injected
by the board/platform configuration.

SPI/I2C cores do write it, from the board-info structs at device creation:
    - drivers/spi/spi.c:835
	proxy->dev.platform_data = (void *) chip->platform_data; (from spi_board_info::platform_data)
    - drivers/i2c/i2c-core-base.c:973
	client->dev.platform_data = info->platform_data; (from i2c_board_info::platform_data)

After device creation, the core itself doesn't touch it.

-- 
Kind regards,

Rodrigo Alencar
