Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4483DC4CE
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789810286; cv=none; b=ZF/Ehs9vAZLEq/q0d3etQJkCk7+7ga2Es4/OgwqUwJHhJP0BPRMaJP638HwN2VV8f4uqCi1PCJDbiTW8UBSLfEuocjU9RKiJmC5iTqlOBuzzmoiKMfDSEMxE5eXfiKfzxuufNZrPTnqtU9fF4vucGZapqfepJeSZCI6f/YTIl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789810286; c=relaxed/simple;
	bh=SNfprDKeEAk5wYlgA1hVVVIHsXt+aVLRxcUxr1jrF80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pq6kH9aYtlzOUkSn0Ab2m4nh72MvPirl4L0edsQrZ+H8jBmHZF+IahrYVyrqrqeBdo6CPNOpmduiNghrJIWfsXwyU6JuqRrkYZrcHs+y8dnw9XJNejzm8y8Gh7N2il1wb1S/KL/khFVuOXrqLP+nOtR8rJWvee2KBWSnj6lxkG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKn2xwFT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKn2xwFT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so10917695e9.0
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 02:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789810281; x=1790415081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+PkC9L5fOjPL6sBbulqfAvEH4cZDiVNQRsYYaLvTHWM=;
        b=DKn2xwFTnC+wJL22N5WBEj3tVZ5lfqG9qh1CAP7+ALustf/oXZJfmtLiZP6bSGOo2C
         YXuuB0C8hRkfK1e++b7vlapQtHhFkA5tm90+YGqjuiXsPymdUw2o3YpST+WmTpxMZWb8
         ZXzNqpkcV1a36y7fRsK0+PZf1CRLswvANx60aJwspyX2o7Px2GK3S22SV1Pyv4YW70ck
         /7Z0PEtVt9rxfwVQq6popeF/9rrRuX7RYFlzeaeKa4/q+rFHM2Lc9yNY+jLoZjfv0uvB
         hHAlAe+EIHnPgGm81aCFe9eHNifg9/WAI1uQ+SgCiswbfRW9/j3foRsN+03V2s5WhfBp
         597w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789810281; x=1790415081;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+PkC9L5fOjPL6sBbulqfAvEH4cZDiVNQRsYYaLvTHWM=;
        b=o8WIQtorl6ggO2BNurTl4+6e/RLu18ujGflUw2Z+dScICju1l4aONoOOfhr6t1i6P4
         QGP1eB67Llehvkc32J/6zztz7eJuIMoiKYpbUPCHsAnPyw70mOYIbECDKxwKYt2H2q76
         aqQkUy1SyA3W8N9Gv2LgJtafRsitsNV4zpWpxYa+XRMHzHpXQXiRNick384a6gCBDjxg
         djsqi15NG3HQ7nzx0XRjakNDQEdjEW/zrEfmqfDPHSnjE6J2qUpBaZwg+svIWBaoKUYP
         6p6SBp3ySJpIRaIjSFSziWDfaPo0t0Vnq/q8tWv7+3g3sxcuY4v5AAmr4IRlMOGHC/gS
         1pAw==
X-Forwarded-Encrypted: i=1; AKwUvBxh/H/KhRAenvoRm34tCKr5uDI1HvuYCgxSTPa1FHT92UmtRyYcbmZD/J83UMaOqr7ZaJvC+IeBG/c=@vger.kernel.org
X-Gm-Message-State: AFuF++kC9OgFXeMdbaUHmovTalwODK1zE9eyEYPc2O3hLMjGfCF1Luvw
	M68HnBEYCB98HC+4gjMBP94AexLWgCbCC9876aq5VklRs/u+4VDA2PDl
X-Gm-Gg: AYBFou2kgLHqdMwqNUv/gtDgGez5EOyPidCql59jo4TtVQlOQJqH+6lTPXMsMAAhknU
	ijppffQ2eS+wALKHspsaWIAiuzthMvNTflwjOvlCosYl2LSy+VHokQ70XzxMkno0gKOK9QhTMr3
	3EukkOnoNI3e3NlZG3DHH3osA0/yPh3V0G8cENsyUScSvC8AMp10o3pd2kjlOGs3R2TqBy2SJGS
	W0NpYmebZYFmTp2LeO21Ebt73m9qyUBKkLYi4krBac2ijkVX36BfP0RJyUszxMUICyjpqYyygZB
	QlaAqhm0lOGC8X2YkQ8O88F6p/ncdEduWLIDiqghnsaPmpqSNMUWPtRuChzqT9WmPLcW9YZzFXe
	vRSQgP8w70lDWJu6tO3qCnw857qj4GqdwLVw61qN8oS0NZFaAqgsihCzF26a37K59KiapFLzJry
	Xqz3QYVeizVobXZ5Kkrp2q3QdKaKwYickxdLiRiKEaF0T2hob4WBfWWFcfb71z5c29gszAuAaAk
	BRgoQI9Oy/TRunXlm0kCnI1KlkJoSoOcw//OhhCu2pJQPgX1f11c++8RqQfl72ilu60608bpJQd
	YmQHQAa0veaifzUPX4OqvWaGFy6PhFfXEXh3PXea2tUcV1W46e0tsICwLZ+xDWS61uC9k0kUrTf
	uHK7WgRwhAYYR77z7/w2EdwPj7pvQzF8=
X-Received: by 2002:a05:600c:8b61:b0:49e:69ff:c6b1 with SMTP id 5b1f17b1804b1-49fc5749edemr79130785e9.31.1789810281330;
        Sat, 19 Sep 2026 02:31:21 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd086ce9sm85591855e9.12.2026.09.19.02.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 02:31:21 -0700 (PDT)
Date: Sat, 19 Sep 2026 11:31:18 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7816: Protect sysfs attributes
 with mutex
Message-ID: <20260919113118.51036850@systembl0wer>
In-Reply-To: <20260919085513.9173-1-abdelnasserhussein11@gmail.com>
References: <20260919085513.9173-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 11:55:13 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

...

> @@ -143,6 +143,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7816_chip_info *chip = iio_priv(indio_dev);
>  
> +	guard(mutex)(&chip->lock);

+ Blank line.

>  	if (strcmp(buf, "full") == 0) {
>  		gpiod_set_value(chip->rdwr_pin, 1);
>  		chip->mode = AD7816_FULL;
> @@ -207,6 +208,7 @@ static ssize_t ad7816_store_channel(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> +	guard(mutex)(&chip->lock);

+ Blank line.

>  	chip->channel_id = data;

With these issues addressed,

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
