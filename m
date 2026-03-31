Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5343A6402
	for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774954415; cv=none; b=ulwnB1ySiYckeB142LBUs9FhQ3/d1gNFJJd9u8cUBHGq1SbFpPwlf7YG7byUbhHZy3wJ9q+roAv3bz7FTKiH4HEk0CMeGE1f9oYBS8wI9FtosMyqQM8YPI67hjcO+YS4j3STQvZsQgK8iI+S89dUOEILrO3UIYXuUSY9lPpPHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774954415; c=relaxed/simple;
	bh=1beTnN06koyNBSVTQfdbOfurajogUefCKLowuUktPxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSrwHOvgELponTbH6pVuatBhcZk6l1XF+Og42gdzyImxnIKlFVZWDc8GvQS0Y3mvK3FjljTvx+tX6LAxNinoomJVAeoucTkuwwYuvmPa/YFupBfYfqyO0SVql5JsSx4xhPKWWTnZsWxgr7Mz2XzuKjZ3YFddj3sf5Gp6IwOoK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acAC33ly; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acAC33ly"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfa33a983so1513794f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774954413; x=1775559213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7jBCp0gY6pbDMjUAdx0JWqcLwsV/+HgtxuJ3aV5c+VY=;
        b=acAC33ly1flH8GgTGCpLUYK/N4jVv3eo6hVG+BIL9AJgkG9ECToSYRXAK0Yns+9+Wr
         lGQTkZR2/rNtQqtQpnGW72WhT/c+fNqbHzr09iKfC3WWWBF3bn7YqDJ81b+470Q4c7wu
         IOsdsfrvgZM74TY0xGf9pLsYJzN/AWpqGpKqmImZLF9gFJRW/I2Wtj4GIAm5GJ4+M/yJ
         EmFpgR7pchLvAzL5QmyLzoOzT/LHwHKsIx8Y3OsbGVL0XeTeDR0IroPeWcpQF40OgQ0I
         rQCbelCLodEJ7wwa1rahoAZN8b+ZuBAAvi+3j+uk1xsTsDdWVFzN7YFxLR+/yIyX8RsI
         OqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774954413; x=1775559213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jBCp0gY6pbDMjUAdx0JWqcLwsV/+HgtxuJ3aV5c+VY=;
        b=s68mnZJCi20AwcaQgALgmpNYuQGsjNEmMYHw/+7HegC0jgvMuA7CUWglRceHJMoBDe
         isetCPWengQOyM5Z9+YnLQjcgZWDPUIS4MjzMffmOY4zDsBwEc9pGAGj90w4ZaPJ/9cQ
         GBfg1ak8nPbbVjGsJEaVkfD0K3nPo9+jNEvh5g1tRmec1Dm+Ih5mYVvW/HBOznN3d8ks
         BtrrUrfDxnu7RddXSbSkUj6tJStNaUzrNI9oiOdaINFdoXcJFBBp0Cgd9oX9Gu8SBEfi
         DQDQM7B7kXKT4wK33iLO0MD8HbZYGFuECnjY/2UKthR3Z9of1ksFkZXOw0IXSbYUqSDH
         pQGA==
X-Forwarded-Encrypted: i=1; AJvYcCUBDhJLJuoWIk9+Ni/ZamdHrrwOB1F+kRix4793zLoCPcqy4IyTEjewalNUYC9mxuBp3hTiiNVkPrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhaHRysWf/dCcranpuPMvxHjubcjgKiDebjpvs6D1xqrgUdPPA
	o5304aBExjNFuDVuQZXiGUV2RkmpbuF8rBfIhAGQ6uydaxovgPiMy9Q9
X-Gm-Gg: ATEYQzwbOEUYn1cYZNs56uIxljVRdsWW3gr22jX3uQidWrjA2tWM8TP/IA56wbqCdim
	wvWXx5oLj5+59QJKSHNt2K8OBz56kWdh01oi4GXuVHZMbNCr09P0ZDWA1arol9yXFKGbBd0Mdd4
	xQn9HaDN9R1rEP1Emf9zz2CAvPW33Tyv7JtAkc+13Dq0C1dZ99E5yq7matkmuO9nPtELppND1iG
	z9PXtSq/JA79bSd2qPSdvJldh8Ney9rMEyq3AfUSR5VJ7s0YeJzdIgk0yO2awspsg3nI0bRZPNV
	tTOTYeUl4mnQ6CSwe45czYhfGQGL+SUmzbOq8zuSAfnpOhZFUj9rPLtkoXmpqV7c+yTYR6doEpN
	gCsQ88AxRN69zN7TyNgl1AL5gg25SQvwpxLggAxSfAg/HtGBGmBbgLDXbNx/Vv1zsovv7LeYUIJ
	Yv1U58JsoqZznK5SKvsqk+lnSMxrwl0A==
X-Received: by 2002:a05:6000:18a9:b0:43d:29a:e42a with SMTP id ffacd0b85a97d-43d029ae49bmr9955894f8f.29.1774954412827;
        Tue, 31 Mar 2026 03:53:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2471ee2sm26444532f8f.29.2026.03.31.03.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 03:53:32 -0700 (PDT)
Date: Tue, 31 Mar 2026 13:53:29 +0300
From: Dan Carpenter <error27@gmail.com>
To: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] staging: iio: adc: ad7816: redefine mode
 constants to start from 0
Message-ID: <acunqXdKj7im8tH7@stanley.mountain>
References: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
 <20260330181710.23258-2-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330181710.23258-2-mdmahmudulhasan1511@gmail.com>

On Tue, Mar 31, 2026 at 12:17:07AM +0600, Md. Mahmudul Hasan Mabud wrote:
> Redefine AD7816_FULL and AD7816_PD constants to start from 0 instead
> of 1. This change is necessary to use these constants as direct
> indices for the mode string array and to align with standard
> indexing in modern sysfs helpers.
> 
> Signed-off-by: Md. Mahmudul Hasan Mabud <mdmahmudulhasan1511@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 172acf135..5acfceb90 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -22,8 +22,8 @@
>  /*
>   * AD7816 config masks
>   */
> -#define AD7816_FULL			0x1
> -#define AD7816_PD			0x2
> +#define AD7816_FULL			0
> +#define AD7816_PD			1

I don't love this.  AD7816_PD used to be related to the spec but now
it's just a random number which tricks you into thinking it has
meaning but it doesn't.

if (chip->mode == AD7816_PD) { /* operating mode 2 */

regards,
dan carpenter

