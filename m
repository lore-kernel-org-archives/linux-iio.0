Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE9377EBF
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599050; cv=none; b=pFxsvV83Kpv76P4QCUxWMatJ+YvMZzq0IM1jx+7IfBJQvcrzqpff5jqwp43YC+dbVevAl+FZXQvSGm+OCQurPV9e/9aRviAETyQpmPOPqnscwqQ+3CWdS0FHeC3fOl6wi0zr1jxzQSPoicq0IIqKTbhZ15W9EMoxZQqHk/zvmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599050; c=relaxed/simple;
	bh=8TJgdzfi3lZ9KzNdiFtjj5Yc9QYnAhTeVBftcJhqnLs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=EQw76U6uixLJtNGvMerzmzmkUhopnjI1vwrC/oV0Sm9AAojfJVtol7GIpLjtD2vExZSnga7BlRjMDHzlYUUUw/KJJ2F5JqAZPQSdYR1q2CH//+Tx2TvhinW7soTqDSaXQUQSHQvt0e5+ZDQADAxpfVTO4SlkKdsKBO/LjJRfU4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+e9oCsY; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+e9oCsY"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-13317450f83so3585112c88.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778599048; x=1779203848; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM9rz3n4Orrsu6iIEKdBnTkUTOxnT172ScZGK7tYZGU=;
        b=S+e9oCsYyA6nNEwHrL/bcEsY0mZNgHMr0WONJHhJwpkjlejJUaXaecXK8wLjIl8pEs
         VapRnUti+XxF8Pka0Woqr6pSngpUhoo5JCun2aV6dSS5FvfseX3MMRSekslU6kKU/fBc
         fgO5ujiM7DPitwoG/CrLYfO0iNTzDqQUn9YqMi27Cx6WLbFuD1e3iWUM+TlTGZbFyinS
         p3Bt+ruhengcT3Sxlxszn5sNXjQu/hSyRzSH+5uvSLgZx424NmX2t6+mZzNAKorc+3vs
         wT49ByvOpsNwuDmChIeER0s907M6ByNDUnNRpzi70ljuaBA+LHNNjviLpCngiH3bF7ne
         rDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778599048; x=1779203848;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BM9rz3n4Orrsu6iIEKdBnTkUTOxnT172ScZGK7tYZGU=;
        b=gXWJSvftfve3Kpjtnk63V31tYaDWZOVryLvApWxXzHJqPNlBgEEcrCcFNUEtDI7+da
         bsYg447zQJB+Co8ew7lkzr2gLAF5xVOMqFIg7kxIeF8DNex2ld/LOI8HP88/y4yZ0Ss/
         862xuYeB5zVEZb1wyQbpebn+kLBSvTNfH/1R74eVE6eEiR7LleUBKiR9CWINicNiPm2k
         aT0aNoTXV4Krs8tYqxGTDlYong46u8qVnu4S0ou5E8wyZNXpYYZH0IM1+5F2SdujDDtb
         u6S/PFJx/F3sPqxzfzPxdni7QthiBumqpFqJK0AXqUSoFcAyAeb6KJXxvZxXtgJVp2Ue
         nANQ==
X-Forwarded-Encrypted: i=1; AFNElJ86u1Cu1uq13YHBi9N8R/zF1AuE9Rxj1jFh/1coFbsozqtsM97jdO/35N3owYMTONPpB377Y0rZGEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWbKE9CrPAiQfp8EE/jTyDUg+FBcPPY7yWByV0wRcD94BLbVJ
	UauheYT9qxtPIFLr4YpmIU4dkQDcCA0jnAKCIVCb9YwVTT838l+OsqWL
X-Gm-Gg: Acq92OGrACeqA9XwS/0pe/VVWlaap1llKSlMe6w/pQRJJPYr+y5RcJIHDF1BoeE90h7
	DQnUDLd5TNaCy+3NW7tmusDY4qSLGKilYjZeuSGd4/9vo0UPupBZ9S0fHgzc0Y5LcN1kCLNEYLy
	uyMAndL/dh5m1ZBqbCUJbZSm3UzPcLInz71GdILppeiAd+3AULloLdSI6D84SkFSiSBlSuLby3I
	P41yPv5CE+qQ1w8t90zJGglSOTXwhurKe6ZCjwL9NpQHonbfCfBuZO2ReQPtnJ+5ezRfRPzAvKv
	LMJgOGW8mFsIeHWH8uogBMnOpmk3eDwJy8dInaNcj2gWMmHR5cuWPkD3T+FsyzjhFGWygkl6Fcq
	x/iDUnDe6JM7/RhNRil1yeWy1OGAyhNO+cRokfl3WOe084TkmNOAFBvTkS/ub9ZQHqsZCxO0Ruz
	N1q0p+AQRJO2JGJXQTueWRfhPpEQyy2RQOdkcG+w==
X-Received: by 2002:a05:7300:570c:b0:2f5:3641:f10f with SMTP id 5a478bee46e88-2f85e62de09mr9745239eec.31.1778599048157;
        Tue, 12 May 2026 08:17:28 -0700 (PDT)
Received: from localhost ([208.185.137.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d429asm18326586eec.12.2026.05.12.08.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 08:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 10:17:26 -0500
Message-Id: <DIGSQPV2STJK.2S7C67L7I0RTJ@gmail.com>
To: "Maxwell Doose" <m32285159@gmail.com>, <jic23@kernel.org>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Daniel Baluta"
 <daniel.baluta@intel.com>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: kmx61: Fix TOCTOU race condition
From: "Maxwell Doose" <m32285159@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260512120356.40839-1-m32285159@gmail.com>
In-Reply-To: <20260512120356.40839-1-m32285159@gmail.com>

On Tue May 12, 2026 at 7:03 AM CDT, Maxwell Doose wrote:
> A Time-of-check to Time-of-use race condition is present in
> kmx61_write_event_config(). Move the mutex_lock() call above it to fix
> it.
>
> Fixes: fd3ae7a9f21c ("iio: imu: kmx61: Add support for any motion trigger=
")
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  drivers/iio/imu/kmx61.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 3cd91d8a89ee..9aa00acc7f14 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -942,11 +942,13 @@ static int kmx61_write_event_config(struct iio_dev =
*indio_dev,
>  	struct kmx61_data *data =3D kmx61_get_data(indio_dev);
>  	int ret =3D 0;
> =20
> -	if (state && data->ev_enable_state)
> -		return 0;
> -
>  	mutex_lock(&data->lock);
> =20
> +	if (state && data->ev_enable_state) {
> +		ret =3D 0;
> +		goto err_unlock;
> +	}
> +
>  	if (!state && data->motion_trig_on) {
>  		data->ev_enable_state =3D false;
>  		goto err_unlock;

Whoops, forgot to add reported-by and closes tags, so:

Reported-by: sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260507223337.48437-1-m32285159%40g=
mail.com

best regards,
max
