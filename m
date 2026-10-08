Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BEA3C13E0
	for <linux-iio@vger.kernel.org>; Thu,  8 Oct 2026 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446105; cv=none; b=sICeVUYrgIsJhMH5lnNPe+1gm/xkH2ivSoGynPkVAceTfIiHW87RnhNZc7z4vX7dISBzNgG6VXpozN5b5TkJ43bcR/jtxLZBXXsOMoALIqIx1mWAlPW5uUdWwKzC6laW1lbA6HesxRoli7tzckhIOSqa1r+QcPg9MM0m+Wb2N50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446105; c=relaxed/simple;
	bh=0sdnIgsW/7O1yxiEVd1NMidwd+7MWbZHjpGHHLdtTqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugMmb9QuSNgiLnROWWgFjNm5VyF660WhcpOKOnLhaQeWX0S5Mc/fN21QRTkP6eakx4JEtUHtItNtORI0qpMBa3fqOkTxtpwPBcNkefXv5eF4qurWNfkmpNg/Zq6riuYxcKHMdGBcmEzFlzm+eGaznExI3+ZR17SSkk0AEIScj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rU7WxcG9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rU7WxcG9"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso26441455e9.1
        for <linux-iio@vger.kernel.org>; Thu, 08 Oct 2026 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446100; x=1792050900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ee/nOmTXlnTKv+9t3QjlgWh7DWnVNJTswfF5DULCt7Y=;
        b=rU7WxcG9FQ0WfjIRwN1QBSLd274UzEmREVCwG86VNZzOQmO8RPn9nEwshv1ingB29r
         0PYo8nHouyZqKjpxwUniaw0Q1frLN44A4iCnB0GSPmqUU26Y9g1p4V388xwZZ5lKNxlM
         +28usrukC8nX4XDcLGN5p9H040pWwYFazZyi7R7pRVeRsKyTvFQk+bG3wbgw6rHoEBgr
         V8+EfHtLjTzet6Hlf2iricUGa+06RiMPap1ksxPcMF4kYjE8+YLf6PbcXEyBFsK9E0Hu
         Lb9X8JuE1DJgofXm1V1jcyouRR7iHGnMEjox1ekaezJRPn1vcS0dnwfLAKS36t7C5Jzj
         6ThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446100; x=1792050900;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ee/nOmTXlnTKv+9t3QjlgWh7DWnVNJTswfF5DULCt7Y=;
        b=AeeUFOzcB9PXVoZhQ+wBmrA60LWXzGO5fEXuoPMF1Bski9Vn34ufSThsR/COnksuXP
         VcMBdCoyBMmrd+A6rL2BvWtj7BajZWAYPpfzt6OYrfXMrzIK3jam73y2zixEfhnB5HoR
         +49euKrfFquX9MUf9yHNjJAO9vptVoLy1dRT2CMatgFHfXWPb1KigpeIq/BdKQJonZdm
         2j/1bjngeek1qhzl5RmHQn4JDKKLkvDcmi6sT4EfNYcRkmxI1p2hMMlIFMoeDW6KREvr
         LvzTw9qD+t/NkBTHxC5jReXv51EFUxenF5sf4Q6vZxj3ta8w3BEtB8egnOY1gvuHwhkB
         e95A==
X-Forwarded-Encrypted: i=1; AKwUvByHSboRP4gkJeeFMKjvzP0Fw/gfyobe2GADOUE9GrvN4tn+eHinyCACn4sSOvXpu+0dfKExSr82SvY=@vger.kernel.org
X-Gm-Message-State: AFuF++lr3RK4oY+VfTK7W/ZOTFB6DfrWFdoJipUOhQBGkdodO637YLrv
	CsMZcRXaX/OUVpkJirHjzuyWiRpWXC6HjcOfOMGA7KdDrtz5TsKLVJKl
X-Gm-Gg: AYBFou1y/zEgn+MiJsr1YTSXw3tI0p3vXNwTSUs7JCoWFScwwTZhSOw/Uyoz5HmXJvt
	0Vosr58AQ/QxG7hvvV4plzJf/g4mHAqMUvaSfzatXW2/60Rb6EYSrY00/AYcp23Nr94s4d5FkgL
	fK3OavuWMkojktD6al7KAQOA09g0g21MCxL/OckcDneEl0imbYDkPuiOKLSGsfkXZkikMRTbh9K
	NPaa+aP9xul/98aJ5ETL9AYtOS0oD3px791F+8kM8PR6urdBqowXix6okSvi4Uc670UaUtUyxu6
	2mTXQnvneeC7eXZLaXcvwTnKFbhUHhbKgieuOKbyWrDyZGkYtWyWd/letkMbx0N9GAUZo5bylkU
	mWHPdNINDGxyI1Yx+wX6jF4cKjEgqiynlpzbyQrlFRBU1lxpFknpBZ7IvG54sKngBPtOiBWB/08
	mqnNyFU94b54J9awjkwJV1ou/uNuub99VX6tq0LfnGwe3oxEC9eHmo41HhNIDr79nwefjA5iQd2
	NG3tpceBEUWc9PeHGVJi/PSIJ9Ppxchh4bP2q8VY9/85x21ICeZMEwir0YSmJHkwXBExiV1cw7X
	CHhVX4UBQQZzv8Y012iUu8Uc/I91Em0V6C6AumIs2iA+SyDl6xML60cdkhGT9ajnrYsvBGAoy9u
	UmPo7J9VGGRo77Go3/u1NX30680y1vvX4nGKoIFuGWV+BUqdGbu1Rh2/bgRLDRMZA42NrsW3JqQ
	01ezGX
X-Received: by 2002:a05:600c:4594:b0:4a0:1cfd:321 with SMTP id 5b1f17b1804b1-4a180313bbcmr78950685e9.12.1791446100084;
        Thu, 08 Oct 2026 00:55:00 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1245bsm9635929f8f.26.2026.10.08.00.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:54:59 -0700 (PDT)
Date: Thu, 8 Oct 2026 09:54:59 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Christopher Hoover <ch@murgatroid.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, nuno.sa@analog.com, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: hid-sensors: fix shared callbacks in
 temperature and humidity
Message-ID: <20261008095459.000023f9@gmail.com>
In-Reply-To: <20261007184423.622445-1-ch@murgatroid.com>
References: <20261007072329.27806-1-ch@murgatroid.com>
	<20261007184423.622445-1-ch@murgatroid.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Oct 2026 11:44:20 -0700
Christopher Hoover <ch@murgatroid.com> wrote:

> hid-sensor-temperature and hid-sensor-humidity share one static
> struct hid_sensor_hub_callbacks across instances and overwrite its pdev
> on every probe.  With two temperature sensors, reports for one go to
> the other's pdev; once that device is removed,
> temperature_capture_sample() dereferences NULL.  I hit this on 7.0
> with two uhid-created sensors.
> 
> Patches 2-3 make the callbacks per instance, as the other HID sensor
> drivers do.  Patch 1 makes sensor_hub_remove_callback() take
> pdata->lock, as sensor_hub_raw_event() does, so a report racing an
> unbind cannot call through the freed callbacks.
> 
> Changes in v2:
> - New patch 1, for the use-after-free on unbind found by the Sashiko
>   review of v1.
> 
> Christopher Hoover (3):
>   HID: hid-sensor-hub: Synchronize callback removal with raw events
>   iio: temperature: hid-sensor-temperature: Use per-instance callbacks
>   iio: humidity: hid-sensor-humidity: Use per-instance callbacks
> 
>  drivers/hid/hid-sensor-hub.c                     | 12 ++++++++++--
>  drivers/iio/humidity/hid-sensor-humidity.c       | 12 +++++-------
>  drivers/iio/temperature/hid-sensor-temperature.c | 12 +++++-------
>  3 files changed, 20 insertions(+), 16 deletions(-)
> 
> 
> base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
