Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E6D481A8C
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643807; cv=none; b=TXr+lPR+xpY4Erh+p/jCubJsvp7ZUwGOFbNKKhPGo77gQ6NRZSz+Ox6JyfnIG/FCgtiTm5BwRk+CXgWgRHR9LCVP27hPEj9p931W9iz8KbmUaHdW3IbmggfVc60InfDUT0Ej5zJ9VPommLitiuaYFqaPTVb+xOk9QPxVZNgt8zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643807; c=relaxed/simple;
	bh=YwrASEiFTPqOLvaKbo8DOfVrCjc8jkiSh0jyFtRu46I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgL+8uc34Ar7COCVwgxi1qJILd0W8WjsBODtHY2z7IgOsOktljBs1Q7DCFRKJwaLasOVMmYd27N+DsTd1ATUgKia/efru1sQKvQQ0vcbvXyUzox3Q07JRdRVxuKqosMwxMRDEl3OBWeGkrw92oybfjH1Bxg+K/5Zojes+mmq0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7Z4lUJT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7Z4lUJT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso4990485e9.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 04:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789643801; x=1790248601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Gq7s5uS4gkydY+KJLPBw60QeHf1NaLqQ1+aLcJdxtA=;
        b=g7Z4lUJTffclkMHTyi9MkwIXleeJf1LILjy3K5OMkXXcJ8N3VZCEDlOD1fFg9E3S+5
         ELjbiDkHO2r9j2sC2cbVNXOaa4c2ujJjzgZtONMDhvwXswhT49h7CBvuj6LNvLnVZv0l
         e6aktqgzpK3lpBEKlgI/C+Cxvf3dvC6uSDitqWZygdFUW+ggaNw56RYSrnVwFhjOg9tf
         eXfNNHmd1wjQlS6YTNSaLEuXhxV9wP3GGNs/BYaeLmqTmDF1zXnIb86PBSbyJaS/Eszq
         Q6Bve1yaJA5lJot8KP15vKeg43N181bhqhtwqvnI/08XkitbT1DbVg/T5pu0Ld1vZ9kL
         LNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643801; x=1790248601;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Gq7s5uS4gkydY+KJLPBw60QeHf1NaLqQ1+aLcJdxtA=;
        b=jREhBuI8KufLf9Go6ms6OvW43O5QMZjPQTC6nLuAFgV78hXSUc69KoE91mDTnF1s/y
         tdrynPR4fVN0MNqOEoi+9UQJymqpU6OA+m9InJ3SIeiYn49X1ZVsB5lVXi87KA6TmtOy
         bpdsMTnODAI7U1jSoOPPzGVOZ2hEnxoOlZjDAqOl0iR7JcNwuobXqg3WO0SaVy7qSF+W
         SlaiKXMjhhDCw9BuKlDcHHvYUslgwJeIBuL8bUdAhcwyw3ChCMNkZAapAwE8uLw9PQKG
         OVVjXEDSCJsX2Ly+nWmF4lXkCjWrfB8OfKpd7WKCHxBw8X0UhHko5VKPtWtbEMSWDyMF
         PM8A==
X-Forwarded-Encrypted: i=1; AKwUvBy/EfPV5jxgVPNQVzk29GInllE44MOP2CU44iPf8pHmYvaxOMsDj3fkznhAGHDhRupGCK2okTii+BA=@vger.kernel.org
X-Gm-Message-State: AFuF++kBxvK/W7+p/KpUr2Kh/OxX/r434KCME6uGirEeThdaHGl5n+JM
	5Fw6lB8Ac4O06fR+K0Q0DRYj26Kdxp2qMXcr0DfILiv3yvMwzoGv5jRt
X-Gm-Gg: AYBFou3mmHUsEAvr86ZxiAUKEFD1Q3+VmGzLOUB2WjSm5R9PQOm4cFCqRmfLGYXLMHa
	RhPD0ycaxOniGzXlXJ5ZvXg0RULRiM7UqXw/nbYe3VTTmy5wmAbQ9cYJjBL4PQUwBS6xXJsUzNq
	NjhZpmBcVxMgr7dUTt/PIDFuGnrPCYwdbloGvb3oQ4lOZTed+/i4rLbBiAOYNYosBftJllHoZYu
	iJMdNvPtLOFINw27ayeheEQo6ekgwNawU12dYYgYv0FFADi0IdC/A4ylza5cZToSRqObpuns4A/
	rwy1d57pRn6dKyup+dGU6mroDEqlOeeXyJ1ok42NXhOE7Pq9HlvdCHZWRshbZhEvi1kXIa5WPa9
	YMUYTkEzrvT8LPILwOfUTZ8UjUK28WndCRRWJYzambdIplnzRpIS91ge7vvj9Rd5/N7DUJUmjjA
	lG3mXyNuBe68/RfP53t7vmJsBFMP0hvTOBkd5UjlJwObgOtOCgp/M5yZqPUuI5JRq+9wA4VsT5p
	jKWOG/Bxy0DPzrj7DpyZYC8rDcbbrtetUsmznqN6C2XcC6jylskAOdu/lKKJi2shrNmS64akn0V
	nbDHPvtG0ObyqV35Ro6eTLFFSRJcf04HTJI9lX//uua1jm77CRQA2Nl9i2Y8XFdq4iyv8shsiwf
	UPUyq7KLGOMIL1OilSoaY5U7jHziWFYewhIK+x3gwMU0xedkPLx74r5npGA8Ix7hwgR+cUbQ0qa
	Js39Esp7BFxL09CIE=
X-Received: by 2002:a05:600c:8b8a:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-49eac46376fmr141199765e9.1.1789643800568;
        Thu, 17 Sep 2026 04:16:40 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1d0978sm66774905e9.2.2026.09.17.04.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:16:40 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:16:38 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: tsys02d: Fix state
 desynchronization on resolution write error
Message-ID: <20260917131638.000034e5@gmail.com>
In-Reply-To: <20260917091609.626043-1-salah.triki@gmail.com>
References: <20260917091609.626043-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 10:16:08 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> In tsys02d_write_raw(), dev_data->res_index is updated before checking
> the return value of ms_sensors_write_resolution(). If the hardware I2C
> write operation fails, dev_data->res_index remains updated with the
> new index despite the physical sensor remaining in its previous state.
> 
> This leads to a state desynchronization where subsequent reads via
> tsys02d_read_raw() return an incorrect sampling frequency.
> 
> Fix this by handling the error path first, updating dev_data->res_index
> only on success, and using guard(mutex) to clean up locking.
> 
> This was found through manual code review.
> 
> Fixes: 53bf4d067d51 ("Add tsys02d meas-spec driver support")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
> v1 -> v2:
>  - Use error-first pattern (if (ret) return ret) instead of if (!ret).
>  - Use guard(mutex) for clean locking and simplified return path.
>  - Add note stating the issue was found through manual code review.
>  - Add proper blank lines.
> 
>  drivers/iio/temperature/tsys02d.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
> index 3ef72347456e..20f67134affd 100644
> --- a/drivers/iio/temperature/tsys02d.c
> +++ b/drivers/iio/temperature/tsys02d.c
> @@ -72,12 +72,14 @@ static int tsys02d_write_raw(struct iio_dev *indio_dev,
>  				break;
>  		if (i < 0)
>  			return -EINVAL;
> -		mutex_lock(&dev_data->lock);
> -		dev_data->res_index = i;
> +
> +		guard(mutex)(&dev_data->lock);

Please wrap the case in curly brackets to define the scope for guard().

Additionally, add a <linux/cleanup.h> include. I recently removed kernel.h
from this driver and cleaned the headers, so I'd recommend basing this on
the iio/togreg branch to get the changes if you haven't yet.

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=6b5856d16c2e9213fd7eed8a4121aa3ad41081b4

>  		ret = ms_sensors_write_resolution(dev_data, i);
> -		mutex_unlock(&dev_data->lock);
> +		if (ret)
> +			return ret;
>  
> -		return ret;
> +		dev_data->res_index = i;

You're missing a return, this will just fall through to the default
case below.

>  	default:
>  		return -EINVAL;
>  	}



-- 
Kind regards,
Joshua Crofts
