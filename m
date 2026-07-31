Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9D41D126
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507093; cv=none; b=sypVkbLxP1yx06o7dUnZZUmsN2UTCeaYWAQCHFdgIHoG6CHZZOG+WXiIqD3wrgQTdcphxDFd0/al8S7DP628S5mvEoqCSRdsRBXQyPO3WgRsRTtjXqnE7KyMF9J+t3Tq2nJ6Mp5wqnVR9gKfHK3hinlUSnY9AD6k5Ctt3wMIyMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507093; c=relaxed/simple;
	bh=QcfhcVT4fLpsSWuVJhNof9PQqGw8NjXiFiCRLj17V/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1ZHLW4tDz4D5pwM04D3aVBh49jrnbfRnFqsSwpJQ6kAcjyX+4fA0fmMw0zHu+QwNdHUcy4y1uxvHEqtp+qRCrK+97iNq7gMq2GnICKH6k80dXHv1rhir11nKeVD1vITyZBed1rJHBH35cH7FPuBE5XKH8TGlUSA7HmRTmgiO5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0pgXi2O; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0pgXi2O"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so506908f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785507090; x=1786111890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mutstjg8Bx5ogWkUe9a0r8ZjMMf7n8vHq8hP7WaWrX0=;
        b=A0pgXi2O5Q6Kd2Ym1GOv6fMbBmYylneE7uE++/Dd4NyyWVbppYtUE22X100fBpx4+I
         NLLs/65S3uAg+I+wU2jn07qq1Dgw+25BJ1aLMd0dfVFo4nIaDkg/qEYi3QSwRyRStOKj
         675kcmBkqNWDc8OPrzXV/eJf3Um76PlMc09oAtDNa0s+EQGgq7dQ1Rj5V/adYHioNHTX
         me4zdFBHtgV4zvQb25z4+lUDn4QWPZobC2CZqHEySRW4H+v6SSeKbnXCUev6mzetvjOY
         vzJ7I68MGRfMx7r2LUsHLeqTIcpNTpalJw6k5WW6y8J2qk2dZdYPX7ReQxbze27QDMwG
         ogCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507090; x=1786111890;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mutstjg8Bx5ogWkUe9a0r8ZjMMf7n8vHq8hP7WaWrX0=;
        b=JJtlQ4RTs39j79GiVJF1fSWJwFS0lFlLs9XUDJ/+POOu4UdueKNWQpzcOltsWKmh57
         LJS+OLh5D+Tk66SgYrZDnFEnMxv53eTSNQFUlEAVtmaCmtQCbueBQEE4pFpC4tO6pI14
         HcKYrjeyI1acd1i287nqTaX0p6RjxR6PwIllm9ZL/tCJEEDwXN0OHw3BZur945p6wUwb
         VWhJMY1bn2Z4iHOT36agShKQ7qIspXGleotwQefrbw+g4128gWzxeZ8RJRmLTML8deBW
         BVYtltoKml0n2kFpuG7COqKJjVhCav1X3xsV3uc4PzFiYs8DLR5Api7srVU6PdoUrOW+
         PzmA==
X-Forwarded-Encrypted: i=1; AHgh+Rpn1GZo3nziazavpzSuDsVZPMBEOWGoI4E9qiTlLRMWeyLMI6ujn+1jyONdTfZ1+Q6JILOdmTm9uaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJIYTQUvAYM8pn+6jafg5wEWBZ3XwjdHJOUlpNI3wpEiXI/pT
	yi4WDUxfItOI27RCfBsYpNkkF8hnS3tTcws6D/IbHGP1tjux2iF3XdTW
X-Gm-Gg: AR+sD113o5dWWRISsFWE1oZHjNpXJmnK3PFmvtoQDgQD2Na8T8wio8jBJZSS3+lt5xL
	zJ/W08XSUm2j5OvNh0PRVe9b/ELMRsskKdJ4pO/EIr+bmLTBLjbT5MmTYP3/I+Rv7PfOgWaPju6
	ONimiiZNir7+pDye8t1cwyOR8P3eiYXupENWX57q2xkLNF4C7IGJ7RWsuxA+J0Z9UATGp048IZb
	Jlr0uAyvsgmjtc/lo6xIveNfcx/0FKDMbTLD0iI4540axlWOHLTecx2wh5Zud7vDDlvrpTWbSqg
	Dl0mSbZy66GUzvm4Yaa8L64ZwZ+aARYMfSAd61ccJw6zVlxb3owqYFye6LDIUSSHKgB8hGOiOzs
	/1ccYftrn5vAKNX8AjHrBsqT6vq6W4sjqdf4L+LrgJNUvuKyEb65I+ft0hAUc5Cv7giGA9009Bc
	Wg0glw7PypVJYPNLeWdZzGRbvRDdYGDEnZa+VSsAZBOiKLBocVh9U8ukM78i2i7uI33ni150IQn
	GA+Pn4daiuxGdbaC1VnVKB/jLJeUWzsjVpDiSqwcv2QQHi9MQgph+W4unee+3PGphQ/vkFw6k4v
	5odJkLwRB1DhKMH/SQfUj3eAGusJ5BEoJajgHUQxSIzo+tOiSQaAbJM9AWnpSdkeIEXVcfxalIZ
	QyxWjsVsl8xySeoRegsOfcnAntbjUNC9VCfq1OIzpVsZ33/M2nXrxhK6DJJW2s6ckHHVKt/Q=
X-Received: by 2002:a05:6000:2408:b0:47f:8cf9:a12b with SMTP id ffacd0b85a97d-47fd2ab99ebmr5275934f8f.6.1785507089949;
        Fri, 31 Jul 2026 07:11:29 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4068fb7sm6050421f8f.0.2026.07.31.07.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:11:29 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:11:27 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: Kevin Tsai <ktsai@capellamicro.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
Subject: Re: [PATCH] iio: light: cm32181: return zero after writing
 calibscale
Message-ID: <20260731161127.00001478@gmail.com>
In-Reply-To: <20260731132048.199946-2-giorgitchankvetadze1997@gmail.com>
References: <20260731132048.199946-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 17:20:48 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> 
> The write_raw callback is documented to return 0 on success or a
> negative error code.  However, the IIO_CHAN_INFO_CALIBSCALE case
> returns 'val' (the user-supplied value) instead of 0.
> 
> Fix it by returning 0 on success, matching the behavior of other
> calibscale implementations in the subsystem.
> 
> Fixes: 971672c0b3cc ("iio: add Capella CM32181 ambient light sensor driver.")
> Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> ---

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
