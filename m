Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE8D3E558D
	for <linux-iio@vger.kernel.org>; Thu,  8 Oct 2026 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446161; cv=none; b=Rbvc3NqyTDGDDdnGLYAIh179Akh4zR11NSJCRNUQ3bExjWivVqy3fl7u20x41sRdfq1k2fJ8ONoK8PNYYTuLEvRXiU28wbbOHJ0A83jWdlS4N7ejGE5C3uiMwFxCM/t/4ViV2fBL4CiV87bBASREfNz9vUH78Y3dZgsE4Dyis68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446161; c=relaxed/simple;
	bh=1eLsAsBcb3/SU5wMEmlWmiLY4M5auQ2xVNRdqlqUs4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4J9/q3W+/9oYnOLVyqvpVV9K/yEUp/L5iil/VIDMsKFXqQEYqfvuff1Ody3Umc5deGfCIiOLjNOHGBz8KjS7WqlQD+bsyLB0RxzH+n0sJliseogjj7KRznCogwnpds5AGK46X3bUs4GwPNHb1v2Z+yKnacUlBndPimHw8lhEvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPhLKAKL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPhLKAKL"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48c4649b3aaso1730394f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 08 Oct 2026 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446158; x=1792050958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RqJ80RZLGvdSDJWSa/30QB3K8CJAPo6KFuj937ftJzU=;
        b=PPhLKAKLe3Xj3jWLUOoBBNGiy5nU11Mdq8tEOP1WIqNd6b97t8C+0nqokWqG9J2cR2
         KParJi47v2JiNiCIh0v7u5ANu5urcvf5ZsBEBWKjAeOu2zRcIE4mNfdSdZu2uQUXRCQh
         1RWNVNHf36C7BhA781Ua1+oce37wOirjhHrtx1sItMEuPzLa6EI0neX+DO9L7ZPbW6xg
         BEj1zHerprEsF7mmOplUPasj817BHcBCeZ5sdlS3nMfdkNVqiJfJij9Px+SVohyig0k0
         cgo2EPgilaS0Vv5alzeroYb0VoojSzPeuXAlIMKJ18EvRZKsDfgvDWeZEHDWJcN0S3r5
         +jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446158; x=1792050958;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RqJ80RZLGvdSDJWSa/30QB3K8CJAPo6KFuj937ftJzU=;
        b=H8P7525dbHBLpefK8nxhOhXXbvo+i1AauN+ewBiKM8ydee43NgVlGP11qg4SnHrqW0
         wLINq3cIjG/l5q6BiBFtGwk/dTIvFMHCQsMTqKKt/ab50Z4WNZqtUze/AlDLYigx1Tsk
         +2w/jeotGWw1HE8udNm3MGYv78LsqhoWljn82PyXUTPktWlnGM8S6xsnxfiPW8vb3dSl
         zE4jqQ/DhIDAKwvdjlF2auTzhRuS815S2gWyyn7preTjGQzvX1h7Odu0zSowd0g8XZxI
         koRMQSuL+n43mzz1XICVfa7qt8v0s7Frou7TgAvvc8291dZhhlwNw26liqT9KrvCmbXq
         Oh8w==
X-Forwarded-Encrypted: i=1; AKwUvBz0nooGSaZNtW7TflF5U/w6NN3nfGJqkab3QUhBGF1ym9apWZHgiXFxP2wAoe4WgzuJUPZddvTdWBI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbtdo7OPb0ptDeKtTR9rtmKTbjXjq3FsLZsy4Z2f1wQ22NPbpO
	NYCLWfhyRw2jdB4wyrKgoPCeKzjM7Jln2tJCjDumY+hllr7IWiHCe+vR
X-Gm-Gg: AYBFou2UmgmH7tzbs3zxTfJ3sEJY1WoepVvrvhsZKRshAFiP0NCzHc3eMSJr8TiNJ19
	UWL/hUMPps4LzEru8imWDJ7nP1dHbYReHb5ywA2f6tq5CMgeZwR3NAOzfOU8J+x1LtKJzcfp7kW
	1epj008rJGJMqctreJzDSmRj3S6wUQbQ80ZfmevsoQxvAFYk847ovEt9e3aUiqfqJBZuvCe2FHG
	5owpC/pnKRCwpTLdN7b4YzaZRsW/DDURdqzbBoPQQFx2eG3zmlWsfPh+wDUdmBCKQKwVTkVYmxR
	B9toy3HCmRft+x8u4LUJ44qjw8cfBHCPlT8xxx8BCWVFwD9PyfdjUbTyFzG2OVM0SNirpFDyDxN
	iS+YrzKeIu2zSzBiRTMCYzvDAVvb4VGHjuU8tNnhcx5hmJ7fpqDA4KSpXRJa7f6OeZRCZKhT0Rp
	/prsHrpy38Yya7P+izek4QXT9/JUMBp+Qh3tO8b57eBhCCz/q9s2WV5r5CgjwWpa7rkUQJi/dPj
	tycV72mSKo5a3n4KeVTjIn9eCteEnxhSK7TW3d+h8CC0Y/Aug448xfsBXjVSDHSw+j7jY3A8mC1
	pI2rAFpS3NfrolOK+5novSANOhaBf2fL5pPWkjdJQsoFwMFmz+QsNag3Y8dudj8zXb0WBspAygF
	D/PiuKJeQkw6C5j7/6extktqTTRYndZu4mL2sHO2wjMVIHM+p4Ru7E8n4+wiCxTRGHo30BuOAs+
	0GPYp1fQ==
X-Received: by 2002:adf:ed4c:0:b0:487:1662:cf4c with SMTP id ffacd0b85a97d-48c72707d0fmr7555934f8f.7.1791446158003;
        Thu, 08 Oct 2026 00:55:58 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d31767sm10344398f8f.51.2026.10.08.00.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:55:57 -0700 (PDT)
Date: Thu, 8 Oct 2026 09:55:57 +0200
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
Message-ID: <20261008095557.0000617a@gmail.com>
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

Also for future reference, please don't send a new version as a
reply to the previous version, it breaks tooling :(

-- 
Kind regards,
Joshua Crofts
