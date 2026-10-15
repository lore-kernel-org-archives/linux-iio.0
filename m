Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E7C4C1504
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095510; cv=none; b=LoGFD2pQOcFbwWY7r2IClqcDyYRx8kDR6MJnO3+HFbYQ5Wd5AlAGA2mGmwr/Sp0ZKb0wADDQDy2X7N1V4RUUE3YN6RxkUkzJTDHHxZhTst9OAlpGchGca63THlQC3lUdeOMwYdQw8BUvoKQHAr6jTVpUN37yhrdAS5O1MLhq4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095510; c=relaxed/simple;
	bh=jrnECgNo7r0SpTQ7QJjUmrWEuJOPvNiFAXIlOfU9hrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIDywhPfy1dA2aawwSNOrJYjmyxwwkxV1Egr4u2KfR3DcfZG3ZJluGaRNz3rUz6+fGz5AwSkLrtDM10lFzlWgal4oUkRO7vMtMEDz1FuqB1czVRVwgw+g7RrX2p30e4o5wMVNGUrRcdIIfQlmewZahR0afXMwX2g0EVGJksRd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgv7fokC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgv7fokC"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so45830635e9.0
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792095507; x=1792700307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vQXuJ4chOqvfAgFEMLoAZXCDN0M97boWDwL0KicWGeY=;
        b=hgv7fokCP8byTSMm8RTIcRQEklTOndaeMv3f1zj7PC83ewt2Ldz538gCFUmYVXAmNs
         ns6tzccZFEK4BTw0WWx6zGZyY/yHOnK92Dd6Rfup6dcF+lrk6gPmjAcg4tJJBSjPALOe
         aus114ACbjJmMWHr+GAuaaooWD8q+ugSue4cfaz7UjFqrQhJgsxogTQa1JV2h2h870Td
         3+weRcaLcgjV1u/FUswo6AjFU54HgGUtaM0I2da76AbzHW5QbjhSj9PsVmeHVH2fhOao
         uoDOMDRk8iH18ij5TwayNHDKZjPk8jbTfAErTwPZgiXi8yRqXHA70+2WX5JiuAhADYun
         0HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095507; x=1792700307;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQXuJ4chOqvfAgFEMLoAZXCDN0M97boWDwL0KicWGeY=;
        b=w5erFXZPFOeRX8/W+pEJRSa0QY2a1HiWGoH8+oKx/zBWMUEXt5Pz+1djm/ZO/L9aUT
         ab3fF5siwCSf41ryqwI8022Jo0ytDcea/FswtKWWdelQRWNwlVGIKZVf4cJ30EwPsJXZ
         IKFUD1PQrNDbYYmoZMFDW/Y5JJM+Ek5xusTEpqEDsudaeI0pyYN3G4gSe9Ft5bSUzalz
         QKhkxpHTNzMsx5fif+SfgxA1bk8ZGnI5/EK7rgzPOo1qaf6xdiz6C4L3KE6UFwqfFCxI
         qK51PrCGV+aHOitk6wkuXkOVyUtkNvntBrsKNueKgBUjeSCYTe8ifDwUhBobqXqCwPYS
         IfDw==
X-Forwarded-Encrypted: i=1; AKwUvBxTM7rMEX2/dUgqDQYGt0eP9dQJFQ3FBNu6ZRm+9mElDd3jDZMuuMs76JZFDKJf2ZvdmnzXezSSxMs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaM3MZcRdR434cxYsqgF/u+sOrpGiql2InZ2gItdGfSvLMyrdu
	TVe9gnE+a2WXbpdmoKQ9Iuz1cmN8oJNk0eQvxwYKrAwwhKuJnaD1zbX+
X-Gm-Gg: AYBFou3r1PWK+eRFsos9D65zBKLmsxfu1OreMUZNcizdJjk9Bv1bv2lfH07A/aEHhkU
	Owb/K1bRxsamC683Uoa6DxUQ7WIaU87Ml5MQ4C8HqiqNKBHiHmwF2jfPCTKE727PNhWFIEorIUp
	BIlLLnR5zJ8esj1Iqr7GUaO8uVI3v2a3J0KDubnS9hXlziT6E80zRGIC+zBoUx7KbEKZyUqYnlg
	4FrM5ioqPLxQ4zc6KVbVY9yPUr7Y+pTFWlc+4Bw8eUVZvrTnLFDH9+Wug6ylIZadzFtsQnrI0Oc
	JFbNpKAYQ6k3ZD+cI1l3l9DxDf6S80oVQBZniNcG54R6dyQsD39ys5Hn02RRDnjenRQsqpod3Mh
	oRlBiktM+xUqnhCsFBcf86J/ysB0oV93ZsAN74F60bxM9eolWY3VbZGCQ2pO+M0NLXMf1AnT3Z7
	ISItPzdqsZAXOGjFWGGT8GaO99xbQtSRgSDL4asvshKIns+pJFNftQZLHkQGm6QD8yQsoEWbL6A
	wo6BscLkVKdQRppKCWj5QlFbrCRqrWC4GHXpW+FoJq2fM1372B5XRPYHcWHgOgBfaoy4Xc/ha02
	VWTVc2U9/R0WeXJ2HNCipViP+xJ1zECjD461UEU9n2UBX+Kx1KUSUi12vjPqPG563l9Zd1nAzvq
	pW7hN6oLbULNCbIiePzkaBGqO3Raz57E=
X-Received: by 2002:a05:600c:4fcb:b0:4a0:1fe2:d4f1 with SMTP id 5b1f17b1804b1-4a18e4d1686mr398035745e9.28.1792095507004;
        Thu, 15 Oct 2026 13:18:27 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ab8bb2sm2616625e9.1.2026.10.15.13.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:18:26 -0700 (PDT)
Date: Thu, 15 Oct 2026 22:18:18 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Dingisoul <dingiso.kernel@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: mpu3050: add missing trigger cleanup on
 remove
Message-ID: <20261015221818.09527ff6@systembl0wer>
In-Reply-To: <20261015-mpu3050-fix-v2-1-53f73581e62c@gmail.com>
References: <20261015-mpu3050-fix-v2-1-53f73581e62c@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 21:58:35 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> The mpu3050_trigger_probe() function registers a trigger but
> mpu3050_common_remove() and error paths in mpu3050_common_probe() forget
> to clean it up, causing a use-after-free bug.
> 
> Add the missing iio_trigger_unregister() function. Additionally, change
> the mpu3050_trigger_probe() function to assign trig only after it is
> registered successfully to prevent a null pointer dereference using a
> local struct iio_trigger.
> 
> Reported-by: Dingisoul <dingiso.kernel@gmail.com>
> Closes: https://lore.kernel.org/all/20261010203601.1686148-1-dingiso.kernel@gmail.com/
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

Dingisoul, any chance you can test this?

Q to others: better to leave the driver running in this weird
polling mode as it is now or return on trigger register failure
as Nuno suggests?

Thanks.

-- 
Kind regards,
Joshua Crofts
