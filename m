Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9919A3F86E6
	for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402489; cv=none; b=IhTmDvIPl/yKb75JHf+slM8XQJWan6Ta30ZYeRWYhngApAqvCC9rX6T9UFK3twOVIzvnw5/e0m/ictp6J4J3TUctErerXBS6QujzqYQosIH/g7dZ8sAzOKjGOJrk94Ha+qlBoWtkHm2fdLA2Y+467ADAh53cm/JCt7X2xpS8mKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402489; c=relaxed/simple;
	bh=M+/PAVJ2gAZ4kK3oOTe43V7R/2O+Cd33fQCa5Ey1ibY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UV1nF0BEsEoadBoaY6+BKcdCHNT3gw6RoBbQT32X+gnl9bx+qhm8G/OLXOqC3/oj9o2rGgcB248/uCkHEt6wWSJZ719EKm89j/My0d8kB4ArYfnJNc9vwvXO/OMsIr74dj8ynY/a513lo4TmNsoRX5vEsJdQ1ae5YiRn9v2qRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=redi9EPG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="redi9EPG"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47de0093c42so1424785f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 02:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785402484; x=1786007284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+hYEchyjR6RQil9tXQuSoQDAkdD1UAk6MR7pBTmnoNA=;
        b=redi9EPG2RxZ3xcUCy6YnyXbMj8wIZ8iiryXuA/00MHvJ7cfXH1YBZn2rN0InuqSAh
         3vrjg0xtoySxthTBbACfqhio7vQPP67Po6Sm9VVtRuynh8LtkeYsEK7Tu864KY9amIKC
         rUpScKn9kkYvEWHu6HtrZQmp/y6UBVczKWBTDHO0j6fKFEnruyPR7E2lWti1ifteB/nb
         NDHfEQX27i9PbaAZOuJ/hJYlrNDm0wGpZ2lM9ea8B1f7mPvMq4DuVcBvBSzkFgsMkDU7
         lHtLA3UOPZ5ZLrF6yhaZNVRpxd/TRpqyLIAJ3Sh78yk8Mq1DyxJkbnV3ZW9ALITglTsf
         1zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785402484; x=1786007284;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+hYEchyjR6RQil9tXQuSoQDAkdD1UAk6MR7pBTmnoNA=;
        b=OH02BIoV/zt1aGKanOVgj0iAZzGSwZcYjO3cpRP0hhBlyEXbPMzBGq8YRIUuNMYS4a
         YNaoSpVpRcYSTm61AmocuIebpgw6jsLcSN6uDn0b29ntnU200tMYNjOL0QEd+CQzjb/C
         eSwoYDzWDBTyElhTQBVDkYQzERR6KaBzfvrRx+CF/LSO2tum4StL0PEeK8qxf2eKwCEh
         zO27WrXR49x47Oan7XNnG/Uz7uwE35XBEuOAyN1OfE0kWrNvZYxthZr0bs84175R+4Qg
         7pSdsjdWeeWD16fkpL+3h7VnOj5jLTeeCnqbK15Wk0wigpca7Pj8q+aSaRl51b78hE+Q
         iW+w==
X-Forwarded-Encrypted: i=1; AHgh+Rpoa7ezYp3EKYnWLOUgXntXkoehGQwZRdj14X8nT2ssW3zpzCEcil54jEbGsUgTDrmUkokPJbTcR1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNnm4Skm5Og1MF01mn2CXgkKLIQK4Sy/W6MNgkSZ/f0T/9Aly
	VFxA22DSk2INmeV16UW07zTzCU7tQryFZHe7dX7PjRgty68DaIyoWH0W
X-Gm-Gg: AR+sD10Q/Ei6pjC2VxN1sb2GhnZCIJj6EPbl37C5uPOnCjTFj14GX0c42bKXKZG2r+7
	gowfWNpFfcaw5ec4T8o2wojclEtAZXKpYjs0kYvZr8pIDhmFDfNIzsGFT1eb/wklvpV3/gGyPm1
	DNa/NEFAfSuMnI946ImrB27YDL92owFV84no5B28NEAlA/UBfFeCbNtcKrobnUu1Z2q3/mMLFcv
	8+zefFwE3DlSh/bl5l93XLdLx73RSFcy8Jm/IBiNM5y++4uB2XYVhETsJBF7YJey4DWg+m+7Tci
	7OOqBoQpnBnJA7nKuVbFjsMt+exQaM9NaIGSSGSLWgkz+GX3JYAwwI6PY0F+j1lVZuUNg3qUr0o
	fkrT5shMs839FCfSa6qAMKNBnXm9yFYhTPjjtNbWcnd/aWW8uyB5vRo2YxUafat/8WAMO+CC7MH
	C48Ps4LodJVM9gbwofEhE+sYECN22kweQtKhPbphyhVSDLB74t83gUiQqufwJUUni5wPAB0pIEz
	vc0vYRdn10Yb+990Ngg0KlFlVSIcl9ZHgq1323QkOdsYduh+kb3Dd2eEfZwno5UfD1UzkypXI9v
	zBjDQ8DBPMhbOsD+z0q+KVtU6nYcfZ72czWOj/9hVys3fLJLHD7u51aOsUI4z/S9N/Q1sIBOUwc
	EexAMVmISm11QZngaqAUGJhhQbi5PGH+PdPT4dm4unJhnyqJfNOHYdiGy+iIhl5gfwW/XMAo=
X-Received: by 2002:a05:6000:290b:b0:47f:776f:a468 with SMTP id ffacd0b85a97d-47fc82126demr2072121f8f.26.1785402483908;
        Thu, 30 Jul 2026 02:08:03 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d708bsm4856674f8f.6.2026.07.30.02.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:08:03 -0700 (PDT)
Date: Thu, 30 Jul 2026 11:06:58 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
Subject: Re: [PATCH v2] iio: light: veml3328: reshape scale array for
 readability
Message-ID: <20260730110658.0000759a@gmail.com>
In-Reply-To: <20260730082932.79484-3-giorgitchankvetadze1997@gmail.com>
References: <20260730082932.79484-3-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 12:29:34 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> 
> The veml3328_scale_vals array is declared as a flattened [4][8] array,
> so accessing a scale value requires calculating the offset of its
> (val, val2) pair using gain_inx * 2.
> 
> Reshape the array as [4][4][2], with separate dimensions for integration
> time, gain and the scale value pair. This removes the manual stride
> calculation and makes the relationship between the indexes and values
> explicit.
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
> ---

Okay, this is better than my original implementation. No idea what I was
doing...

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Thanks for improving my driver!

>  /* integration times in microseconds */
> @@ -184,9 +204,8 @@ static int veml3328_read_raw(struct iio_dev *indio_dev,
>  		if (it_inx >= ARRAY_SIZE(veml3328_it_times) || gain_inx >= 4)
>  			return -EINVAL;
>  
> -		/* Stride by 2 through the flattened array to match (val, val2) */
> -		*val = veml3328_scale_vals[it_inx][gain_inx * 2];
> -		*val2 = veml3328_scale_vals[it_inx][gain_inx * 2 + 1];
> +		*val = veml3328_scale_vals[it_inx][gain_inx][0];
> +		*val2 = veml3328_scale_vals[it_inx][gain_inx][1];
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
>  
> @@ -282,8 +301,8 @@ static int veml3328_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  
>  		for (i = 0; i < 4; i++) {

Given how annoying hard-coded values are, could you change the `i < 4` to
`i < ARRAY_SIZE(veml3328_scale_vals[it_inx])`? This should also be done for 
the subsequent -EINVAL check as well. Feel free to do a separate patch.

> -			if (val == veml3328_scale_vals[it_inx][i * 2] &&
> -			    val2 == veml3328_scale_vals[it_inx][i * 2 + 1])
> +			if (val == veml3328_scale_vals[it_inx][i][0] &&
> +			    val2 == veml3328_scale_vals[it_inx][i][1])
>  				break;
>  		}
>  



-- 
Kind regards,
Joshua Crofts
