Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC3B3FCB15
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468357; cv=none; b=YR9NJUjWKEAQw6CY4MZtlDmMhWtpU3YTW+dm7Gqbv9BN6qEfYxtqPCQpRGj5jv3Syd3w2rp+n3dIKzXMcWmWSi8q5EamC+YwftNxKdepDCKA3zU+ThIMjcsg4LeZ8m8uCCGMXNI5+QV+Vjgqq7OwHW+riRzXBx38dAxkGNkgFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468357; c=relaxed/simple;
	bh=fWGvMB0529+KqskJr2b96xWa8ILHjZDiqPg+O+3WPto=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMBtooQ6gbzA17lGUkCxxLILypm9jxj28EcZBkKNHsK+DuFMZxHNWzpRG8aJbABA5CvkdUrvcnJ/NSEkcRVqAOAIqv7g2ZuqXJjrg1c+XQwmYDe0YUlus9zQe/ePTqP+q0HwSI5nZXFx2+RbruxH98tRDn1Mgpp6RhgrdwfRbUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUvHF11I; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUvHF11I"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so165892775e9.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777468355; x=1778073155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RtXpQh4GEacB0L6DkGGm0BSedZOwbSLQPV4PVoX+AQQ=;
        b=bUvHF11IqIVClLQ4SFIr4bqvRW+45IkN5G8n1Kb0Ddf54m4t251wZggBRykwVK8kBc
         +B8Diboq3/FpuqrNoOL/dotPITtHy1IEodpMSARY45YsaseI8NjfeZw+hEwVHYdvImde
         rbY4ozDj6Dk9I7/3ZEURbY5olDDTnFw476ez23WAzsFuS0Vi118NA+MMIC3VXNnwwx8i
         jsChRn2XeL5GyOzDmF7cIvavASLFaB8lDI/A5+/H3CXk2XWB4GsaVn0b2+t+f0FIAqSD
         jhFAOLAzzMrErcZ1ctGsIghCFqruf++uFadMP5G3ixLuEfnfTuhND7LLNlGnCKC6iHVD
         lWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468355; x=1778073155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtXpQh4GEacB0L6DkGGm0BSedZOwbSLQPV4PVoX+AQQ=;
        b=GTA0r7BkbcAmTYl4nbj0qzpWAG+KE9U4WAlyIGrvTSt1aG9DrY4Bwn8fvtRQECgnJJ
         keSRWaHTmA5nowHNC6tg3rHhEiSOyxr2kPa1J1euNex4oicIgyZfsgWjzuNQCI2zu/Jc
         xDeEnkHFbN/tSDkOa1t4yLio7gr3NZTZpiccWlkSHmxsKKGOz6xnFyl5cnxPnXDgPyrw
         sApIPkHKtGMrh62zmOO2YyUi/ZC9TpBolZB7D5sYj9XgdrW4i+6xxDhxoucjtc9UYQG3
         4812d2lIO1CvTSskxyMsyMiGQYzUp6TT6/JqIUoYM8Lh5cIUQQhu69gQvkNomMDvuyHU
         D5ZA==
X-Forwarded-Encrypted: i=1; AFNElJ/EH/zwaB1Y2qDDVonjkKikfdQLsAXe0zdCtIXmOBGtEt18h1rvIYhXo7s2/DrQeg3utYQX8s4f/Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpPXe3seb928mH6M5/oNZIHqL9L4H1txbLcSa2VVBSLSB17YRL
	X7B4TuvrgqWlzfuXiepcKOHttP3S+bBIMhZ/RVeW9QW/OsoxmvVpw75f
X-Gm-Gg: AeBDiesTGrWW2GWEtckAS+bTmPowhkpUUSQ+Wf13CZ9DHpFimovsm4Y7s7GsVtfcQ+3
	Fzcg+1iU4y94JOvL5lqHuFcGmnX07BQhoPgW8+BXVXN/CPwhHOiaxSUgX6Pq5rLS+sd50mS/vW6
	YyXLnTUPfK2zMKfUFXzhXTEroa19PCISwdB2+XvQ8GOHS+UxTPmqXUaCktGV4KAlKNHECkr7AzZ
	eMaiJW6rluPiQNlgan/R2CFWV3hh19N87+Ox2SM9z4mSWpQs57OYHvOo01ZJVQBTGPtMoML3geW
	JvEwSZZTlP8tnFfNQ4pmeMmOOISvd/MTw3ifsBowao29vTWBboPrM1UhFCDtqB9XRoa1JAVVpse
	g5vXFpj4J0XBkCW90PpoIR2+ux8iITXPYN6xrFNNKzrAdW0Ci/tfBOqfxQYHak23Y3efXMJOpsr
	oFLsQ/j4zjKexpRqmtgXdDJ5QxLO9UTIEX4GeqKQlNkqKL5D021ErJIB1UdtMESkYochpZNapon
	A9mmgtiZgwOhWzbVKeV6Xmt3N+74MpGll9VfapmWOee6vlbRuVubXTs13viaA==
X-Received: by 2002:a05:600c:1382:b0:48a:5574:3a5b with SMTP id 5b1f17b1804b1-48a77b216bamr115984205e9.27.1777468354322;
        Wed, 29 Apr 2026 06:12:34 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c584607sm53060675e9.8.2026.04.29.06.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:12:33 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 29 Apr 2026 14:12:32 +0100
To: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>, 
	Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Michael Auchter <michael.auchter@ni.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rodrigo Alencar <rdealencar@gmail.com>
Subject: Re: [PATCH v4 05/13] iio: dac: ad5686: fix overlapping DMA buffers
 in I2C read
Message-ID: <ydxol7bwgvhxrw2zafaplzvk4kmnbvj2lzyfioh2lhfrrrxx6o@zsbw4mtx7gly>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
 <20260429-ad5686-fixes-v4-5-bb8f1cbd68e1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-ad5686-fixes-v4-5-bb8f1cbd68e1@analog.com>

On 26/04/29 02:07PM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> The TX and RX buffers in ad5686_i2c_read() both reference data[0], causing
> byte d8[1] to be shared between the TX buffer and the RX buffer. I2C
> controller drivers that map all message buffers for DMA before initiating
> the hardware transaction will map overlapping memory ranges with
> conflicting DMA directions (DMA_TO_DEVICE and DMA_FROM_DEVICE). This issue
> was reported by sashiko.

Do we need a proper reported-by tag here?

> Fixes: 4177381b4401 ("iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R support")
> Signed-off-by: Rodrigo Alencar <rdealencar@gmail.com>
> ---
>  drivers/iio/dac/ad5696-i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index d3327bca0e07..d3b46496d67d 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -26,7 +26,7 @@ static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
>  			.addr = i2c->addr,
>  			.flags = i2c->flags | I2C_M_RD,
>  			.len = 2,
> -			.buf = (char *)&st->data[0].d16,
> +			.buf = (char *)&st->data[1].d16,
>  		},
>  	};
>  	int ret;
> @@ -39,7 +39,7 @@ static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
>  	if (ret < 0)
>  		return ret;
>  
> -	return be16_to_cpu(st->data[0].d16);
> +	return be16_to_cpu(st->data[1].d16);
>  }
>  
>  static int ad5686_i2c_write(struct ad5686_state *st,
> 
> -- 
> 2.43.0
> 
> 

-- 
Kind regards,

Rodrigo Alencar
