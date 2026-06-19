Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C93590A9
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857211; cv=none; b=mb6pkVBpaPm2qTHYDxYNAvhRgxyMgKZXnSs8SJfNrK+ibY9QLe7TP6bYbsNqAe/BZ24bsL9Ro9Fc1UbEpYoDyi2gi4MqRuZHwrQyAvxQaJOyO3pmva1czkKEUJxJ3ex+NpzCs0IfO0Y49QBA+UaK578fPygq7ArXnAQ/7mJglmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857211; c=relaxed/simple;
	bh=gCgGhZxcCX97vGGYXaF2eIEVWkTppYl2ft7EmQaoBsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtUjolKOcidHJc1pYns0RMc6TMmWSqm9AGSwVxZzdLNtHAtKKyh4yYKsq2+zx2AGicOCGOIMSuP7Rl7HC58VrB7OOFd0nM3/GYD2LPQk2nyZ4f0R+ZF8yBv9kOk0auKnnqxVkfCBUDM4adW+CzVb7tnrryU5Z44Grb/bZiWI2Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiRdT5BK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiRdT5BK"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b3637b90so13509695e9.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781857209; x=1782462009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qndACge8E2dwyk77phkXRZGLcAuoAbBd4/2CqjC4bbw=;
        b=KiRdT5BKVWX0DUWW9iPS+cUiyGOVegIcGmtA2Bg5QK3QufbG3sIa1WJIYTWu6Vb/gA
         9YE1bX1HaIA7Sms+wrR1KO4PnpiXSLpfc7tRFPHTuGroS8g+xG45BQ3zWdSaN9UHleTA
         FenpkAsWnbQr4FlE7AUNnKD47rsJairafWyFikGFeFL/poRXUXPqtV6aoG5FTkAw3/aU
         4rV0+HVpqKusZMHiw/58sVTSVRK5rA9eFLjXT8vRHVfZTHthnIguBuUFQXBAM2eD8BNR
         gPeagAsu7XWqphj3Bxzpj2Fq8ceTfH+k7ldA0O3RuklOVlplN+YDe7Ydd2cas/kA6hF3
         7vJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781857209; x=1782462009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qndACge8E2dwyk77phkXRZGLcAuoAbBd4/2CqjC4bbw=;
        b=EFyTX6wtlOADUHTlLZZkKY/W7DrXjYaBm8V0D5mttZUM8F9wWbbaFx0b3xTw36SVOU
         1mG0blpUgLdu4BZ0/hkSD0vTIGynU7ZCPHpN0xJBFjOYK8+K0UPsg6KULb6FOrSYzoDZ
         +4gNgCDq/P32LJJpiaIX0a6EPgAIkctN5MKQ/pEEqEuW9KLP8hn7t8JnjATg/knlLUBG
         6X7gBqxA91lm9z4klromLvPZhcqrLLw8ryF12EpUijWVUBM1GEaQ8JpVDx0fCUzkZkSt
         MiwdOMozLmtZGoCeXLDdlW615VeRbEDGsK/qDzP5YIDLx3RJouTlG3Rf0gGtanCH8h8o
         CSuA==
X-Forwarded-Encrypted: i=1; AFNElJ9W9qw+iZ52XDEu4OZGjiGhx9gPFh6rzZLPK4G8YfzmGHOVNl2oVFE0ZfiNBnPeJpxUIrc7vnDQ5JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyxW9eOz7elpsAGF6mvHIDHiBlrXa7d5zeZ0Bp64Crq4C4RwzJ
	Dfo6XVoCYZ3EaQbtgO3dO0QED6NAnm4uDwtcQGrT9+1+vAt+mUsdjzmi
X-Gm-Gg: AfdE7cm2XQi1uobEUcrR7MzTWkUvNF+SwA7DVkUKWFvqoZHE+Q3EU7vzhbxa9tOm2We
	H67mLNhBVH+G0mnX6U6zUQJZBowO05LQh4UxhBvXYDEPdUvgSbIC5ryfHBn0xWgw2g8yV8MtfbR
	1GRDTmWrObF1KsbDYZ96gFM8LzEK3RxmyQ/ab/q31WFB3nUu0ALHT7oURv/oNtTvoIx08f70EBr
	bThJNZePojjuTLMpW3nfsW0nUu+S1hXnvU9Yoh+sa58/7wEaQTTah+edF6Nhu1a4Gh+u3Bxkpu/
	xG6sWSMzNdrQeVwwjWDKQ2JcLVDFdxOukkaHITRuDB1xu7ZRjYHvGifQcJdFvueeqE1WMYqZD15
	RAAAdd5CHTg7XDNX91v0SwK4IrwnWNb+5q+Co/OsQD6PxV1X5qRi532ZHPtHBOE8FkU7qBwtFAi
	F3WwsnqlWP4ml6KwMYezlRrg3YXkTPNZ6PxtcMbNhw968u0P4eVXqnr/O+oC8pCY7CqOmiz1FV8
	2Xboctmhmsh4/WufB5+T9qMjE3/DM0IeQpWgQxIMt1Ry0hXu2xh9TcS3/YoJABbd6216bECCJfQ
	6uSqVSP/1NWHStSlIOkVzPMuhpIHl+qExiyBYxf26E44ZcdlX/0ALQw=
X-Received: by 2002:a05:600c:4fd4:b0:490:a296:fdad with SMTP id 5b1f17b1804b1-4923f56c05cmr42785305e9.24.1781857207177;
        Fri, 19 Jun 2026 01:20:07 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a04c15sm6087226f8f.3.2026.06.19.01.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 01:20:06 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:20:06 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <tobias.sperling@softing.com>
Subject: Re: [PATCH] ti-ads7138: Disable STATS_EN bit while reading
 conversion results
Message-ID: <20260619102006.000007f2@gmail.com>
In-Reply-To: <20260619075646.4100193-1-paul.geurts@prodrive-technologies.com>
References: <20260619075646.4100193-1-paul.geurts@prodrive-technologies.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 09:56:46 +0200
Paul Geurts <paul.geurts@prodrive-technologies.com> wrote:

> The device might update channel data while it's read by the host,
> providing a data race. Disable the update of the channel stats before
> reading the values.
> 
> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
> Fixes: 93a39542d3c3 ("iio: adc: Add driver for ADS7128 / ADS7138")
> ---

Don't forget to add the iio: prefix to the subject/commit title.

>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		/* Disable statistics update so the value is not updated mid read */
> +		ret = ads7138_i2c_clear_bit(data->client, ADS7138_REG_GENERAL_CFG,
> +					    ADS7138_GENERAL_CFG_STATS_EN);

You're not checking the value of ret here :(

>  		ret = ads7138_i2c_read_block(data->client,
>  					     ADS7138_REG_RECENT_LSB_CH(chan->channel),
>  					     values, ARRAY_SIZE(values));

Additionally, since you've added a i2c_set_bit function below,
you're not checking the return value of the i2c_read_block function.
Instead of returning the return value if an error occurs, the values
variable will remain uninitialized, causing a kernel stack leak.

> +		/* Enable statistics update after read */
> +		ret = ads7138_i2c_set_bit(data->client, ADS7138_REG_GENERAL_CFG,
> +					  ADS7138_GENERAL_CFG_STATS_EN);
>  		if (ret)
>  			return ret;
>  

-- 
Kind regards

CJD
