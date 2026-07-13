Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66938257851
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928571; cv=none; b=pMGuo9WvxGuf5nelgwtE4kg6BPk93uBkvxDbrccs/NC4EUvikOnIVsQ3aOMcofV4vI5FI25KRh1WU2frwWUNCO7AEwC4qoP7y6olHfMK+mLc+5PH+j/ND8JTxhZbbb9uE/d+B+R45Ts7RKqivSsuHuRfm4sVeX7hHAXxqRscLkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928571; c=relaxed/simple;
	bh=B9cRuOJInzXjAr/gtsT/q0sOde7tM4O1FOxmfrydyjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJbKGexrdIIDefPs16d12d02d41tGwH0g6B9tVVFIQflKBhZ+7sVec3AGEHCQxCWUhA8IyYGcgidXZu4kTvDyXby2JAWqWHT6/626mMLp7HzLDDHO89R9bzHfz6hnZVh1/7k93bUg58RJf/GE2ZPSg1h2s0ypCheEonwgCocddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c274Am6y; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c274Am6y"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-489f3611e0cso1946633b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 00:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783928567; x=1784533367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=35OANEN5n/JHrZGEEa6HAE0i5RpyFLJfFmXKL1lTnlU=;
        b=c274Am6ySYWDVsGIEDvrCSXizYBhbeHkYl4QEBl3Mf4OhTmhiHANzwOweo6PHKp5uS
         t9uUIIXNPJITIFrjkuqPY9TSZe2HD9JtBHiwGPfNQRHY30vQs3DyzOOJqKujvYMWLsQh
         C5/8u57/5h8y48CeJjl8PNaxDuOheB0zthOrcS32uYac37sBJK+HFmG2SVZ+OiXYy9Vy
         RioEyp06Aio5wAKcXrKWiiK4ww/rVn9i2gwYZICxRo9PgCwWz8RXgBqVhV/cmvZFA0rf
         BVtjftGZ5bbzWqSLSgnkkVYkkGS3tL+egSiAF4nd5zs8mBUk84MPrqDqG7i+iVo8fuTd
         ZQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928567; x=1784533367;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=35OANEN5n/JHrZGEEa6HAE0i5RpyFLJfFmXKL1lTnlU=;
        b=ePEyaymHCk8SrAKMT+ZRSqLj9A9+v3Mt9F4yDhIjAyN58lwpYfGSqnhNPibOwApqin
         ifVA5ms1uAdxG8Lz7QtpJsxm28wQA3vwIyoK7xqDKPPqADj08dRldJIi7ntpMtINFWrI
         53v21W+ycNccNigNPsq1JRV7YyNKv1KlTB7k+qRPZNXEbssU2Pb/GIIGea+jf0c4255D
         dxOpVZfvUeHX6voMXtv48vCINTrG32rk/pRIUpM4mfXFp0YeMp1+fZ0wCEmLqaFNDAfi
         GuAA5rDC0gdUs2ZSqD3KQbDuS45Kl5F5D/Mnfb6MGuwG9oNt+vBW8LpweScWh3rcLOKT
         22sA==
X-Forwarded-Encrypted: i=1; AFNElJ8uOsAAhnw2WppBhxFZ6ZqpgjvrnQBABQlTEkXE4AB1Vb5staHMcw08tjlktsnihlNkP5OPeHbsvvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIZ6ZTEuYfISCN4k9i6gxCPtV0GxVcRHX4Sgj4dQ2L2cjjYzz
	c6FYZAqLzXiHgHnsGZvOwyovXBqlVR5aIgHFEbxxMIs/tCsRPOGN0Jsa
X-Gm-Gg: AfdE7ckSbcFY178inK0zKsmZf0atbTls9IHxRNjYyRSfqFTKRcldaU/rtm6A+GuJhCE
	hfnNQjMjmqwL2KebZ+W3EkSpN4B51oA7103mtqrUu44B229uxl+2t+etB6dmWsoQvwt8/LY/7g9
	irIvL3Plg/lB6gsZb6fut52Db01JF4tju3bl8fskVtayLPWJmUisQwUyS0VcTh0R8sC5FZqfd/f
	BojdOS5wNqrSkFqR7czfOqwFuHM82XRRaiI416beTg6xitO3RM0rPKH1lQLbrvQWWu2sTdSQYTs
	+mAQ9z+uu1DWvuhy76BO0l288oFjGhizhq5l4Pg62+xeV53mHTzL0JA64ecvkuHNAmzPDHiowJr
	jIztEMEArojKbkHpkxDSf+HWbvCvVB/k0gzE44s8vHNSlj2O5yXHDMCd0NreN2l4oweuaZ0iCGj
	dUBaVl
X-Received: by 2002:a05:6808:300f:b0:49e:d43f:1b8d with SMTP id 5614622812f47-4a42ac4c42cmr4718484b6e.1.1783928567339;
        Mon, 13 Jul 2026 00:42:47 -0700 (PDT)
Received: from localhost ([74.80.182.78])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1b02e8e5asm12423999b6e.14.2026.07.13.00.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:42:45 -0700 (PDT)
Date: Mon, 13 Jul 2026 10:42:39 +0300
From: Dan Carpenter <error27@gmail.com>
To: Dylan Liu <pxyforeverlove1314@gmail.com>
Cc: Dylan Liu <dylanliu050903@protonmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Signed-off-by: Dylan Liu <dylanliu050903@protonmail.com>
Message-ID: <alSW7wR4XTKJqUU8@stanley.mountain>
References: <20260712141928.559844-1-dylanliu050903@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712141928.559844-1-dylanliu050903@protonmail.com>

On Sun, Jul 12, 2026 at 10:19:20PM +0800, Dylan Liu wrote:
> staging: iio: adt7316: Fix CamelCase naming for sysfs attributes
> 
> Fix multiple checkpatch.pl warnings complaining about CamelCase
> variable and function names.
> 
> In order to comply with standard Linux coding style and IIO ABI
> conventions, convert all uppercase abbreviations (AIN, DAC, Vref)
> in the adt7316 driver to lowercase snake_case.
> 
> Note that this patch changes the sysfs ABI for this driver, as
> the device attributes exposed to userspace are now lowercase
> (e.g., from 'AIN_internal_Vref' to 'ain_internal_vref'). This is
> necessary to bring the staging driver in line with the official
> IIO ABI.
> 
> Signed-off-by: Dylan Liu <dylanliu050903@protonmail.com>
> ---
>  drivers/staging/iio/addac/adt7316.c | 228 ++++++++++++++--------------
>  1 file changed, 114 insertions(+), 114 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 59fb3bd26bc1..845d79591128 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -663,7 +663,7 @@ static IIO_DEVICE_ATTR(da_high_resolution, 0644,
>  		adt7316_store_da_high_resolution,
>  		0);
>  
> -static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
> +static ssize_t adt7316_show_ain_internal_vref(struct device *dev,
>  					      struct device_attribute *attr,
>  					      char *buf)
>  {

These are scientific notation.  It's like making someone's
name lowercase to satisfy checkpatch.  The one rule is more important
than the other rule.

regards,
dan carpenter

