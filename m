Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D585119644B
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724743; cv=none; b=GZ3aFdPYHPGSZPGOvJnGjgceSm+BqppmrPLpPNa2u8Du4EswxYH3aTXE/JuPZUkzr8H+a5l1ATo9tWJ2NQbORP82AvYCP1A0ah59tGtmZosOM8Yin24K5bBK9d6t3QYgtoJXHH58WpUqxwKfqOmJkizfL0t1wxQToMZLbl3IEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724743; c=relaxed/simple;
	bh=4YMtTb6BZw7/KvQQ3Rjn73dfwepHKwZXqK1EeRb3H3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aV/90Moqy0nGMzv5EgVwDjdpOMbFh3LEjF+AMf+61QKu2n0zeJhxVQLUVeeDMHxGZj1qupoycoJpaeCvxIddqvQC3QNnnETZmHbitpwUsj3XpJ5omPUqM4HIJPuIjk5jytgUJ2qfhUPYvsxktQ1s+BBMYaq+PkUFIhvv0TeIfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsXq4SbZ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsXq4SbZ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f752b3423so2717751f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 05:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784724740; x=1785329540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zc+ooFC506wXtzMbnVheip7g9BASAwLTAxecQ3LZNUg=;
        b=lsXq4SbZimUVWazDQC37X25ZNwojs7KNP4MnYbZeWJbOzcHdnFT6PG7GCyY+qT3l25
         vwuQNEWiNvhepc3JbFN45AedXlTm/1OU5NoXFmPXdkQgmc3FR1yqzAAbq3cBeVIJD4yj
         efhWivqKh7iT+doHc6mxtYuvvY/C5Gp0hnzV7Yz/qxG/ogs1RhOJ/nBnrPMOa9FHrAC9
         bg4VC6CXR+6XkOLqNZsnq7Zkpk2XRh+WOpKzDKgf6LSHvST8Nz28As3VpVlPrD12OdX3
         6YBP5w7feJw0u1LTueD/3oCJ69Pi4xwu5JDCs+nqP3DgioSo0z/C87pwhXbelgClUfhF
         Ezmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784724740; x=1785329540;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zc+ooFC506wXtzMbnVheip7g9BASAwLTAxecQ3LZNUg=;
        b=lLARYafpQaRdRbyijFc1s/gc/uzM/dK0mMTTOLYvdpAyB4p8jL7a7w7BMOAs7DaG4y
         bMAo4Bcu8s8EM5RQ5IN3EtwNCxY0Gy0FOTAst0RxNGdCVCxmXWrK+S7APJ54ApnHlLxZ
         iWQTBQAZK+BFLfQCeONA/O6/GgQLGpKIUkh7KPxx5MhYU5WBeZjXWRn+tQJPBfiTGnJN
         zNUfaGCFdHH+QuDys1vuEca7Sy/Rf+IoS/gmbftB/WPzcpEm4zGyBIh6loIa1zXPVJiX
         nkB5NUZ1R1/UMdScmtWCUxhJ5pd8EjgRVqPrSlJVkhOYWgAm0yVdrU49O9Bl598StTCY
         kOUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqutxx6IXuhyZTRpkqaKDM+pyJ0poMmy11u8P8BVFc7P0R9VD2czms2qiaRPVQAHjkhcDESc1fDltg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlhoKBtGZVwc6i5eX0rx9n1OfcLM+heajIxPeyQbacCa+crqFi
	aVPeqmsucKcveKnpEmxMJyT8kDc7zvCGnsJoNxqc3KNAT4wKrV9jE2E8
X-Gm-Gg: AR+sD12ZIhuf8hBVAbQH2xxl5D8CtCIOXPttzu4M9XHl+xTg9Inbg6aAxEEQ74vnTag
	5KBUQ/f4p4301gApKcUJC0n2VVinVdo1ZqbBazClBnNQnZtaBAmEE6PCiNgrjnLOzMadqsq+I2/
	ZS1Atpko4LQDA2hzSUK63cwAFDvX0pa8N3wl0s7pbtr/xGMMsfp4dvFfQO/FSZOdBM6Tb3ckeah
	VqjQy26PuT6Lnw5NGsypX/5Y/npBRppGe+tZBL/r2U7Wm1tQZ513LKXGzre7m0cCDpqwn6GREdi
	WFRiS/1RYw5SKIIa1VTCmjcCyzadsb81bH1FJGx3RzXRhwVHtIxM7AdoG8guopqWjXJqn+Ojlcb
	qe3FzHj3Xqo5zVmxV/ZMWnQz33KUqemCxKJzKYznW+5bsP+IlSlDiybcU2ekR0WaLRyhdllGLvG
	74sCsNpBaJaD8mxldtTsrbjp9rPiSEozSu91GvN6x14Rw6D9iGHiDtPPY8K41i958N3EFGEurAt
	ehX6B9ZaC6uP6qiG0NxhUZmVEqurxEDCzOIrSFdTXEFyqn2/AUEEflCFNob5n84xkVMivHpbKvc
	Ro96fxDc5scxaAJ/8ZNWIRdKTlUkL0ajlyH7TZE0AnvCHpDK5CGi7dL9XNvEX+uITXEvPWRx7/d
	HY8pClpWTBN3H
X-Received: by 2002:a05:6000:2981:10b0:47e:f3d:2b3 with SMTP id ffacd0b85a97d-47f6232e25fmr21470731f8f.39.1784724739839;
        Wed, 22 Jul 2026 05:52:19 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5a2sm6324206f8f.7.2026.07.22.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 05:52:19 -0700 (PDT)
Date: Wed, 22 Jul 2026 14:52:18 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Andreas Brauchli
 <a.brauchli@elementarea.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: sgp30: Handle IAQ thread creation
 failure
Message-ID: <20260722145218.000030cc@gmail.com>
In-Reply-To: <20260722074837.2258269-1-lilinmao@kylinos.cn>
References: <20260722074837.2258269-1-lilinmao@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 15:48:37 +0800
Linmao Li <lilinmao@kylinos.cn> wrote:

> kthread_run() can fail and return an error pointer, but sgp_probe() stores
> it and returns success, so the device is registered without its IAQ thread
> and sgp_remove() later passes the error pointer to kthread_stop(). Return
> the error from probe instead.
> 
> Fixes: ce514124161a ("iio: chemical: sgp30: Support Sensirion SGP30/SGPC3 sensors")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/iio/chemical/sgp30.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
> index f10bbebc29e4..379c1c4af8d8 100644
> --- a/drivers/iio/chemical/sgp30.c
> +++ b/drivers/iio/chemical/sgp30.c
> @@ -548,6 +548,9 @@ static int sgp_probe(struct i2c_client *client)
>  
>  	data->iaq_thread = kthread_run(sgp_iaq_threadfn, data,
>  				       "%s-iaq", data->client->name);
> +	if (IS_ERR(data->iaq_thread))
> +		return dev_err_probe(dev, PTR_ERR(data->iaq_thread),
> +				     "failed to start IAQ thread\n");
>  
>  	return 0;
>  }

Good catch! This should also be marked for stable, perhaps Jonathan
can do that while applying.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
