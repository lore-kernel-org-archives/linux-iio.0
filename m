Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613288;
	b=Q2Vfssi0V6bKSn/xmN6JivNu1uFhn33Fo1rNt4eTh2oLWYxQCQu7aZwM37yo/IeP7ui3
	 oZwGRcQIxXEqFruwIA5GdsJwN/bowhzpZLUpk/sl5nyeRabHTISBY+EQ38RFix8+uUQN9
	 yAFCupRH2ERZO6NEoZweZpxzhvWCFNVCaey6wntWY0rhd15YSkegS3GvfOCGB5uScpGCc
	 YUwqprn89VbRhHC91eSosZMMw5aZx/ptSvis00pGGcSL37uF0FCxIdrz83nUHFI5tQJKa
	 wlORFSYag9ddzQjHsZS1yDWsvKw96IhrjbdCHhKFZ9zk3MOTj6TCWHoPSlETSiGeapA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OtPUqDZyVtIcqGyOAPlThzTdLirAyOMXz5cBBQz5KzQ=;
	b=Vg2BnM0Vzd2MnFdyisAHDc5ADN4r84y2ZZ/jVxGxA2f9KobEryKjyMsm5lp0QGT7wfTj
	 lHPl/aiJ9ZcE3BMjnIKI7sk3S0YwsiYtaq6iadAomAenyyXTuj144sbs2g5Jx/Na+Ee8t
	 vZe2pZYBNBTerxMDCGHuOjQRLhaNcuFM8mEDBM78HUBt4k1e264ybrzy1BoIuUdM1qCIT
	 1qfGt4Kd+DR3rx8Q8uRWL/y571WN+D/woaOqy+TaAoXFfrmnmac6QVE1gIsLYTJlA2QIX
	 FBBeJwEAeRkclA67x3qeovm3FWm+Arf59QPMhMaByyPJekk/mpbUQhpuvwYdYgPgtGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=InXOzShJ;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8609C606A329
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 09:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8609C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=InXOzShJ
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so17883955e9.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 01:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793613287; x=1794218087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OtPUqDZyVtIcqGyOAPlThzTdLirAyOMXz5cBBQz5KzQ=;
        b=InXOzShJ8qC8LKWA8u7NlxIxhNEUv4L9qlGVlMQLDnZHHT6a5GykEMJBpdh7+MCNFx
         TJQQfjXOOk+16e9ycoPKhLoiPI03FSngWDi4hbJBdATaMiJI/YZpQ0dlBTZS7AiroXxn
         1T8XhrkchWYp97mGIa9gNQ8s+9h1LKKTg49e3s15EIenuASA0/RBsqI6AUpQk6/uCf01
         GMaf+rYqx/oyamUqsDobhXKds9I3InYDnsj45ajqdwIxCartjWuKoMCMiuT7U3SbvJA+
         CanEoxdMHqoJv46XKQxz74jgwVEEJ9HKnHxmP6B5Q82dajvH7KDn7feCMaI7z/DppR/8
         spYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793613287; x=1794218087;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OtPUqDZyVtIcqGyOAPlThzTdLirAyOMXz5cBBQz5KzQ=;
        b=c657/Sw8D/9fPGijZMXCcvbYKT7YDNUOyfNyrMAudr9q0504wGqL217vbcO4vNpUMH
         x7kIkvkvSkbf+yaiA0q5yMxs2qlY+bYhN5I84FtJSFj7L9PiEyhimCYjE+tZEogticUY
         I8ano2Wu3UaM6rpKR/tm7w+D1uc2Gt8lvGL8T/NsHsg2InQTR9Rk2rPPtlWE9z9Vl9ik
         ieXF3AXdA9oD5RZuRx8AkncJwT5jFipoumh+vOQfqNvD4zkX7KFYYWU++AAvHMf2rF6T
         /oFPjGKQf5wVHdAXCuwgBzazAuRcG8XZT2i5edsFjyxwIiE2CowMyS5cuqzH5Ci1uvJo
         8spQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLHK1T7rRN9zNaheP6U19DdFYWxGP9S/jFo5arI7U6ddil0EdfPLgCW79eSlhB2A2vg2mjsjaNsqE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3EDKzZm9uHJY0yWa6mG5hisAO445uId0NUwJ7gCLlaNORiJpj
	VSUjWPh+xocu3bpMlIAHrHm6qniek2l5UE1rKaI2dDcSbfjmufJQoMMN
X-Gm-Gg: AYBFou2dDek5KUrfTREkgwLI6v3jQKMZqOttsiVZvvydrQo5ilXGS7UiADEXpUWKXgY
	vgn4/vTctuj+ZL00WjTtQ8KwGuZ5yYr/FSEhP/DaZPIIaOyDJ09z3Aa/eGPVXjz8Dy4YzoU7fmy
	dkpz1N2+CLwIVWZ8aNeyieM9B2gG6SXVRNMU19SsDYG+u07sel8Jx88sTxMYGJsOzrZqgm9/COS
	wgLNqnkURwxuhQ0X5sfrGzteXdDc5tGqSUkQYjIorh5YS07Xy98UjslGN+o6eAlfR/pn9uwKA1M
	x8DzZ5kWDJyQs+cVyFjkRaG+IaU29zGsY2Q9yGpJioKTZTC0I1RtvJzimQm0OFQ+Pgd24AIz7Kl
	8vUk47ZJNch6hiHuYdLZbedfHd5XZ0t4aBUD1qiGKPziTFl7TRwFzsjzY7EvT8Sjjvv8CgKjxSD
	Bq+BMOiqdN8CZTendiuxy4cw1xKfq2chu0uhmHZwp07LgJoCICwdhcLG5QM6pMiLC7CBcINWtmU
	DuLVQYzbdxoEZflgnec/LkPysyut68xCqJlIyNWFkzBRs+9VN1LllgflUN0DVzym1/ZeZO1QIaq
	vBM6TTKhxyueIb9qrl+TloViVDIgQCwloAjGxOl7NLjoxcjqFeRR8nbo1ayeUCR61zgR5AyslfY
	LUNueA7Brm35z0fHcXzfzqAwcrP8bKIv5Pjj+I6R0o4wjjuy2TeOsZFlOF/HVlA64Rxcr/pp3m9
	cILaWFW6dBTI8B/ux2T5fgcpv2HJIMMMjv+gR52EjW8/Th0PRkjEnwc9qhHYBfLvRGWyMPY8Lvt
	gQAB275uq0LcFqe73ldkQjF0erDWUuUZmWQ9A==
X-Received: by 2002:a05:600c:3b1a:b0:4a7:9044:a87 with SMTP id 5b1f17b1804b1-4ac18c73df6mr218130165e9.27.1793613286827;
        Mon, 02 Nov 2026 01:54:46 -0800 (PST)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf60f1076sm277729555e9.6.2026.11.02.01.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:54:46 -0800 (PST)
Date: Mon, 2 Nov 2026 10:54:39 +0100
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jaakko Koivisto <jmatko@utu.fi>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] iio: chemical: sgp40: Do not convert I2C errors
 to EIO
Message-ID: <20261102105439.00004b83@gmail.com>
In-Reply-To: <20261102091258.247402-2-jmatko@utu.fi>
References: <20261102091258.247402-1-jmatko@utu.fi>
	<20261102091258.247402-2-jmatko@utu.fi>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Nov 2026 11:12:54 +0200
Jaakko Koivisto <jmatko@utu.fi> wrote:

> Any negative error returned by i2c_master_send() in
> sgp40_measure_resistance_raw() was caught by the
> branch guarding against short sends, and the error
> was subsequently replaced with -EIO.

Please wrap the commit message to ~75 characters per line next
time. Otherwise LGTM.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

> Check for any negative errors first and propagate
> the error without conversion.
> 
> Fixes: 1081b9d97152 ("iio: chemical: Add driver support for sgp40")
>

Also, no blank lines in the tag block.

> Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
> ---
> Tested by forcing i2c clock to ground. The resulting ETIMEDOUT and
> EREMOTEIO are now correctly communicated to userspace instead of
> converting to EIO.
> 
>  drivers/iio/chemical/sgp40.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
> index b2b5e32a9eb2..3a239fb6847f 100644
> --- a/drivers/iio/chemical/sgp40.c
> +++ b/drivers/iio/chemical/sgp40.c
> @@ -187,6 +187,8 @@ static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance
>  	mutex_unlock(&data->lock);
>  
>  	ret = i2c_master_send(client, (const char *)&tg, sizeof(tg));
> +	if (ret < 0)
> +		return ret;
>  	if (ret != sizeof(tg)) {
>  		dev_warn(data->dev, "i2c_master_send ret: %d sizeof: %zu\n", ret, sizeof(tg));
>  		return -EIO;



-- 
Kind regards,
Joshua Crofts
