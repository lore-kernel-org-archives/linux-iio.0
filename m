Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8B1435A8C
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377521; cv=none; b=O1vLIcF1y2MmP4ShRc6QSAaue5IIOJsZEEZ5vSuRX+NZxJrkSQOuOJh8Fmds79IkYWyn5qkwyerDI3sV3GDp4LfoXdmHChUw8XqYtc6GY39XO0Q0yUobmvM5Tt8NZ7idHpVH3eVtELYLpT5UQz0SxJbWuSJEBAe0HhB01R/zZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377521; c=relaxed/simple;
	bh=jWeZyr28m8yskca+XTLQ8cdBQeIR83/K2BY0vjpIBTA=;
	h=Message-ID:Date:From:To:CC:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqEoRcW2xf/Q7U+aDM8I4WPOnHB3D2xhKLoFx1cPYxQpXSrcI6shy4d4v3JEd6COxs0+Hg20BrGyLC1VLbSMaJexTLXSziEygNSVXPmuUj9J//+iMToSUoTqFXnMq2tGw/GPlbuuVHO10rsbqenNiKquoAcROwBHICy/GJ5tR/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9u/EePT; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9u/EePT"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39b1eb7bd9bso31035441fa.2
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 15:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783377518; x=1783982318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :subject:cc:to:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWeZyr28m8yskca+XTLQ8cdBQeIR83/K2BY0vjpIBTA=;
        b=c9u/EePTgX62Wto89EdBgvik+J5QUn39gKIvLp42iE7FXQl6p3rkAkxItDkbkiUZXu
         L+lTGwln01q1ibFwOg814jD39hz0LplHrwRE+EAdzLsjxWWCnno4g0V9KxcZX2y2SHWs
         YsL6r7+rT5r3t9TDZbd4KQf44a2yOFSt/qsvMuCPNtigxpIQs946gZ2ufYp3XDc/ZbE6
         FsQCet+netG7XD69sVONTOG4s0Uv0+/Kgs75PEIp65we3NLfy0Yool7wpbK7U5908tWA
         o0suPsmIS2s+deYnlwPvV2vWsLWUVpw2Me3JqTbyb27C/B14kF/yvZFmJACZT7pPC+N+
         yeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783377518; x=1783982318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :subject:cc:to:from:date:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jWeZyr28m8yskca+XTLQ8cdBQeIR83/K2BY0vjpIBTA=;
        b=fNgrQjVkRyPVjinXL6S4mVL2xTwrzralG2mfkL43TScZ+UupMfqt4kSBsgtiFd1rTM
         hRdKZqQNUxu6n5BMKSVxIXV54U76ZpY+mc40dl1EBKnIzsR61mxpTPzQBsTLqJmW2/uZ
         2bggg+5lIC6J69BywwRMx9vjPS0Ybx+KRVnozW4aGKovkGqCqRTRKnkbZoRMRp7WB76R
         avIQREEFY+12OC31JRv4wqh0eyZx6OlMjv7Tc91Um5odQkyKi4t6g5gPvjyQlStfO90X
         GbhFuFTh6JYrQidCxSqS02QHu6eX17Tb6JQmRImJ0H9P2669GVAsfRg7xIFgddj+C+Mt
         rsQg==
X-Gm-Message-State: AOJu0Yx/DmpYJ30l04ktK0usl/f4s2SVKwej974S06EULtpd/zsb0X3i
	HMwHkPsUTBx6nGBfr6NHAD+sQZPUjgq1WX1MAcPPQ+nE85hdhEcYDYPD/iYwA454110=
X-Gm-Gg: AfdE7ck6yH33PMt35D8D1uD/AXWPIIFgqPgcdwblCSqqnZTvh8F1oCoBt2GnyS3jfbQ
	ShaopGGxGBn+KpGpoCAOKyqDpHBASjUAeUNpYMF2fzq30g+xB61skPhRcG91G63xSm7zbJL77uC
	HiYG0ddAEy8gNpsIeO+ctLf1ZhBHrA8XXiyTqv6TvmSTzDLB5OGBLxTHq3rgWV7jWiFRt0vaCwC
	y/N0SMIyBMe1trn8RcjbKHVpIxyeVKJryQpV+yhosgU/u+o5DAxQlYpfUjhbnVCOgE75hBgU3lt
	z9lFtmCpp2j+J4N+2TI9hWumsGTFy+77B567OQ05/RETQgOQDVkNfxe3alLSDoqmvFnmZcNwLr+
	OrVwmWG4ujovLDFbAlfb8y3E7xm9DHrQpW+orylS6t8JQjuTW/DO8BKr6ONBC5y+ZGUT1G/G/tV
	xv05cgrA5tqg6rYoGAICmRxhU/9hOAl7pU/5qbRAolWXIdVFyRaK5sByE=
X-Received: by 2002:a05:6512:6308:b0:5ae:addb:d657 with SMTP id 2adb3069b0e04-5b007c0a5c3mr376025e87.27.1783377517447;
        Mon, 06 Jul 2026 15:38:37 -0700 (PDT)
Received: from reply_jonathan.eml (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bb735sm3200216e87.49.2026.07.06.15.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:38:36 -0700 (PDT)
Message-ID: <6a4c2e6c.e49deeb0.d08a9.bbaa@mx.google.com>
Date: Mon, 06 Jul 2026 15:38:36 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 0/3] iio: health: add MAX86150 ECG and PPG biosensor driver
In-Reply-To: <20260706185041.0e31ec94@jic23-huawei>
References: <20260706112254.1262002-1-shofiqtest@gmail.com> <20260706185041.0e31ec94@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jonathan,

You are right, and I apologize. I sent v6 before working through your
driver review, which wasted your time and the time of the other
reviewers. That was a mistake on my part.

v7 is ready and addresses all feedback from your July 2 driver review:
the driver has been rewritten to use the kfifo buffer pattern (like
MAX30100/MAX30102), the IIO_TRIGGER dependency has been removed,
register field macros have been renamed with the correct convention,
IIO_DMA_MINALIGN and IIO_DECLARE_BUFFER_WITH_TS are used,
regmap_noinc_read length is corrected, and the remaining style points
(fsleep, NSEC_PER_MSEC, regmap_set/clear_bits, goto cleanup) are all
addressed. The DT binding changes from your v5 review were already in v6.

I will send v7 shortly.

Md Shofiqul Islam

