Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614226;
	b=BFoeKReHRCHUmXUkfplO0XC02b7NJ5DFFmfapqRu0c3F5DrnKvt+xXSgfyuTjctB6cYe
	 fJhVtMzJNC1BaKSJIDyKR20AxgRcz29cdgMzLjA+2SuaKZFxw/4wp/c51zukI8jZt7PNA
	 ZqXnCCfBnI8s1INvG7KRBJjrsEdXLQChMCkv6YypOqzJutcD8r+susuM9hte1mjvGvKMC
	 2936l9YS6h2RoG8KMcMmFNTpsE87uJpVqn/EEttx76zuGKj2QiWgRjj/B/G8Du3B61bvk
	 t1l/2aphdG9OS/EV99LK1ah6kXmjwkxx3FBWIG1Yeqnz6Cps1//+1q5FqpRFLaSOOKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RSJYmaISXsmdeU0k7vVhoRXjClhB0xd4jwuJdTsnvJo=;
	b=ew+gOyxZCwHfZD2DSm5jMndX5IW/5ZBSbElgzU8w1RxP0E9Lml11HOxsUdMnwJHcz4f7
	 CJ3Uhn5lQ1Gpfc1GL/dFr09ntxEip/tIwaSNvMfVdFkqrQ9eEiO166DRxVAC74sMiIjq4
	 lZtWN3Q0k7KxJURhxpQkPmZk+SsX0rS2CIXxqfsRA9H1OntcgSqAJqr4kKhSqOsF/lkaW
	 p6UCjo2dHNLZP3h7KrTUh7cqkUceLryabmHxM5qtMTv56TiOXZcgJFSwJxxijKKYPjbHW
	 1GeMzapYHKfD6kwEd5i8u70ZV5+Kz6rHzIiV6DEk9s7K88l5DL6dn2aBsaBWTgnHP7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pjw+Ekos;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0825606A329
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 10:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0825606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pjw+Ekos
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a214af2076so20929355e9.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 02:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793614224; x=1794219024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RSJYmaISXsmdeU0k7vVhoRXjClhB0xd4jwuJdTsnvJo=;
        b=Pjw+Ekosqpjil9Ujkz6gDujlvkioE1rjXDOcEI57C9dVybzaUxMIVDh5xIqD4lXSOY
         nJs4PAzDIU56SRCob9N//o/URb5AtTb1siN2T9A+lKtsCuhawH1HiASExLHqd7UBSP0a
         ioDAYOdTNhwbfhyoGKi3v9U8mD1drZ+Sp5mevYtPcrFWMi1Fu30NpY6NSYIUZCrwCfvC
         et0QmaRnb/RfsVsg80tnu4uAN30pBnR4uszN1UKvQEAB1rrcPSt+qS+9dDX8VpFR+Um1
         fyENeAVhU80o8j7ymRsx5/W+CNJZMRR+vgGTFuMZQumxezqry2PnleGqXFLRbX3gCul/
         ELdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793614224; x=1794219024;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RSJYmaISXsmdeU0k7vVhoRXjClhB0xd4jwuJdTsnvJo=;
        b=l/MmjyYYuug5gm4POIwVFk+CCavD5ff4SZZMv0oS9XFmj6fahuBasR2ju7xiZzORJY
         2etN69DmOuOkeMTFJPPTeRPVoy4Z1o4HeSif72NkGC2HW1Ve/X7Kr7AO5Ho/KzSSTNU9
         Ke37nR+OCm/Ekatq+aO4LaP6QRegAs0iyKeH+YaAUwC89Wb3C7LqL2JWrTXAniJVQAS0
         TNhhKygS8hoxixOB/ArjaySl5FVfA3dsZQdbldHRCH8+utszvAzHs/jAiADg/2d3UMqn
         NdPwfIwR7hMe0Se694QWdurzMFclUrqN09C5uBkBvGiFpLGlFN9e4iasCgLL+9ZuhfxP
         w93g==
X-Forwarded-Encrypted: i=1; AKwUvBwxWQ7ilhZzkzgsFqWZTV35/iqN91IQKVd5GzoGBsFvlyPE9Dy4qVVNqC/dq07/VgNMllV3L6t2RUY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfr6ppWSk3tDsrGkyDGzHrVwyTmBwO3RXVSXtNhlAT+uPxEMJT
	d64wuz0lyhY5E45qf2rn5VWRBDbX1J7vMV/Samr74tfUIeX0zFuAx6tb
X-Gm-Gg: AYBFou3jdK72AAAW3yuQVJRggshntXFJk1QTyMVmtlo+tlcwLiDgviqoqr5skYt4OQe
	BO+rsTjf93NdlyMXLsz11nPwfm1O6sQIQOnkL/WM8302pGEcgXGzau06B+TyVCwZyrMTdJtTJGP
	Gq0F8ouQmW1OxFKNJVhkUN//551JTdUyJoQxOPQrOUPINcVUbvdmUKGD+KpGIal9Dnm5hmgnvnu
	18cH+H6MUR50ngadosbDJY/4N8o3o5pzFpnujNIZsOMY1+OTNiWYlhLgcjR8DnM+p8YfCZk4Elx
	xFbw2tD+24NaucwBcLf8qtlSfyzW0PjhsYnjex+4KaOIB2se3cnMsMihSG7nyyL3Bi0DZ7fRZLz
	XCM8vtSyMBLFpM8gh6qSe8+VdO7dnWI3Vwz4atomqjTN9ELVSakp27mhF6pp4MN9/HI7HKxLrjV
	q3HUQWcl9fR1lMz2l+mwgwS2aoXN/CVDv412u9PVcTHY0XIJFvHw/BSCCv7H61CP5sg4roE8H7x
	SLDfKA3vLznfAPbfhND9/SvexlkaurfOCBxt3foJJT+6bcjU9OnCfcQUk/PT9W7nNxpXRqIcnJk
	xjS5tkTHTZpyD6lUsZcy2zNAXofW8GTpodxHSPaoZ5CmDMFFvcxEyVEbM3RUOFx7kZk0/4g5Hsu
	WPwHDDCdeVC4VwsttfufbhGbmJvY2B2FMYTzx4b4oO0QMWEqngR7OgVCz2pk2Cb4aCk1uUX2EFw
	enUIzj/0hv5PKw+lfZ2ZMQgj3TZe6ktLNb/tWO3lOPovy7TaptZ9faxOb0kxh/XfdqzooVm6TDv
	plqtqUbUlADnMy1LX8tMi/mxOaJW05lVQI9zIs=
X-Received: by 2002:a05:600c:190f:b0:4a2:1a:a11d with SMTP id 5b1f17b1804b1-4ac1275c26emr202981795e9.0.1793614223900;
        Mon, 02 Nov 2026 02:10:23 -0800 (PST)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe885d91esm192351215e9.0.2026.11.02.02.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:10:23 -0800 (PST)
Date: Mon, 2 Nov 2026 11:10:20 +0100
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jaakko Koivisto <jmatko@utu.fi>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] iio: chemical: sgp40: Replace manual locking
 with guard()
Message-ID: <20261102111020.00000194@gmail.com>
In-Reply-To: <20261102091258.247402-3-jmatko@utu.fi>
References: <20261102091258.247402-1-jmatko@utu.fi>
	<20261102091258.247402-3-jmatko@utu.fi>
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

On Mon, 2 Nov 2026 11:12:55 +0200
Jaakko Koivisto <jmatko@utu.fi> wrote:

> Replace manual mutex_lock() and mutex_unlock() with RAII-style
> guard(mutex)().
> 
> Extend the lock in sgp40_measure_resistance_raw() to cover the
> I2C send and receive cycle, preventing I/O-errors if the device
> is currently running a command, or clobbering the output of a previous
> command if a new command is issued during the sleep-period between
> i2c_master_send() and i2c_master_recv().
> 
> Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
> ---
>  drivers/iio/chemical/sgp40.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
> index 3a239fb6847f..080d51f9f53c 100644
> --- a/drivers/iio/chemical/sgp40.c
> +++ b/drivers/iio/chemical/sgp40.c
> @@ -148,9 +148,8 @@ static int sgp40_calc_voc(struct sgp40_data *data, u16 resistance_raw, int *voc)
>  	u32 exp = 0;

+ #include <linux/cleanup.h>

>  	/* we calculate as a multiple of 16384 (2^14) */
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);

Blank lines around any guard() statement. You want to emphasize the fact
that guard is being utilized.

>  	x = ((int)resistance_raw - data->res_calibbias) * 106;
> -	mutex_unlock(&data->lock);

If only a segment of the code has to hold a lock it's better to use
scoped_guard() instead of regular guard().

>  
>  	/* voc = 500 / (1 + e^x) */
>  	exp = sgp40_exp(x, SGP40_CALC_POWER, 18);
> @@ -172,7 +171,7 @@ static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance
>  	struct sgp40_tg_measure tg = {.command = {0x26, 0x0F}};
>  	struct sgp40_tg_result tgres;
>  

-- 
Kind regards,
Joshua Crofts
