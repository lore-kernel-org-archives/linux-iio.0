Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED669432E94
	for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421752; cv=none; b=i6utvNYUWuo+4yG/9yBtbQDpTowP9lU/53J+ph03PRiZmj08uRGUWJzP+e6nD8sNCQ1ALiqX53IfED7wSoYfdiCZEQwkCtBtnjg7RheoYd7uwC9uRuPx/hbwcOKCGPdZvygBqFbP4NHmabfMOwoytZYL4TQjMQKVAjc/bI/cC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421752; c=relaxed/simple;
	bh=NqbpnMEMVT6pZFLXx+aKwNvaoAIbJW/qveLfeiOxRIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e864qv1fk13MKM6SKlaXivmPwcMgjp4EwgjAMrZL3oV05UkHOnTdCh7WBWyDBG5o79ONTSSioKl68nb5yhC+s9RP6kVtUfWCAxmhXFseG0DmXJ/f/u/LQXIL3xHW/4dkZIWN9WvqtGBqrqFqgUnDzXitNO5iVva0IZNgnHR1Jr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObtGsHj0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObtGsHj0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49550ec592cso5252865e9.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785421749; x=1786026549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BiODsEReZFxde+7AXbuA9TsINgA6XK/L0TB2Iycg95w=;
        b=ObtGsHj0QvWvcoZk33Zg+k9Gq7cv5BR/IhtjjiVeCsXtGj4YQymEql1B/LXDsPxI4m
         dTCjsZbPVJZUdVrb76YDCZgHcJU55brKxrL3ANsz5OHLgSpEOvBu27eDE1JfqTVBsTRN
         TTs95OnE+8ajYmXxu9HIbBSCKA9gKp8Qsro+y1giT5C7OYfv0O8VIMHpgdztMGSymEsM
         Vu3923AoBJbvbbGD/YcdUv5lQ03VOql5Rt0Msyk8XrXKXA0qbq/CbUU+6YNBet0s5ZdK
         PDdZHkcsEu2zc7KugJbgYzd0+Ypfo2FC3jaApKyDCKz6abcIjNoKoXNlA3MUb1Skepqj
         JL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785421749; x=1786026549;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BiODsEReZFxde+7AXbuA9TsINgA6XK/L0TB2Iycg95w=;
        b=ijjs9cIcKLvZ1ApFuqCOpKMV7Eluv0gGQhX1+Ygj2gut0QAush77aGinlP0WXhWviO
         qAu7Bg+xoJoG29Hv+h+cOAk/7242UsAq7uf/9SSxl1x9xF+vMmRBMIQfvfnmopCqHJKj
         L7lTDUtdZ1cDB8tiixrHxZ85ntj6vbI5ChPUk32/hegW8WF89ZSFonzuxQUBoY1xGXbo
         p96DEqrAo42ZfUZSLIW3mT/nrDcx6QiwKXqOy5YXxcUs7d0iSOgRac8saoNsnE5iH5n8
         eMA+wTO9zixFY6K1uUdu9HdpDk9DxRFnCVnOsIW/xOIX41JQ3je7Gt9h/Ky6fuKKYiJm
         DCDQ==
X-Forwarded-Encrypted: i=1; AHgh+RodDmNL2c+HwOubgiOb/EFywa3PypQf6p6+zDha3Sn1KSd7+aWwqCTVGOtThp7e9iCcffNIq500z3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrcuBQ+Y6DTv8LsOLDWBeFkX0Z4C8fs/Udw6oIlCbK+yDilud
	dZsjTHKHlGLgXhKKo1o4CpX3TtY3JP/5p+4Uuro4mYvIPONRa50hPwN2
X-Gm-Gg: AR+sD13Wh+HWngDqIIbJulrtHsHsdgRll4vE1bS0sV6yEynrtKhBlODphO/GLNP5prf
	KFsylnn7tl2XIOQc/AE1w4jU/kf8VsoZa0qD0NlDpDN/RdTuTcyFz0+wdm93cAqxos0Q5YtmFBN
	ZDFwsgXyOjupmJKl53bitmenAF8+SVloCtuf2M1LbUfj8Elq0xAWaCUPhbHcNcq9ZDip0YYyN94
	J3B85kMtuynYQbLIKP9oufO/rAESd8CLouohAojT1As4a//qppjrKV843CNiXlkKlDg3CE0UIYe
	8Mss2gAMIANAYcAOh2ybFAhHOcDK4yzMMtW82DYmRkMP7k6xNXb6s1d8q27U1egPZ0tGWBoFMOn
	5Ykz0R4sUTteuOpB362McIPdl4LgMjvFUwH4zVJVUJ26vsoCiSInuLPBX3WCAB+M8F480IK1ABR
	Ol/fRHS0ZE+T8cgT3pxCwzoYlSd+ntl6TvednSRcFAS6w5kwzfvK+tzi6fbV4EbcuX7QIeF1ase
	DrqTm+MKCE8auEREg62wVAVx650Wlpy5kL2KYTwodD7n9QrPv8jJMCBXSXm3d3PT5L1kyEluzFW
	cfEiX35e7j52ku8mityiMSSi+pBypF3fNtWAEcvvkMznPH9KzPDghML4b1w6I+cHZ2S7Vba+RQQ
	YIEP/Co1wgiYP8kNm8xaeCyoPBuvTXBh17/N1IjbOVUTxB158fV4+PxrqUgI4GbMmmsuuFts=
X-Received: by 2002:a05:600c:1551:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49804c8f0d1mr8791095e9.0.1785421748939;
        Thu, 30 Jul 2026 07:29:08 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498010aae15sm66472515e9.13.2026.07.30.07.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:29:08 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:29:07 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, David Lechner
 <dlechner@baylibre.com>, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH v2] iio: adc: bcm_iproc_adc: Convert probe() to use
 dev_err_probe()
Message-ID: <20260730162907.0000588b@gmail.com>
In-Reply-To: <20260730140405.369634-2-mdshahid03@gmail.com>
References: <20260727034009.5c6b0be9@jic23-huawei>
	<20260730140405.369634-1-mdshahid03@gmail.com>
	<20260730140405.369634-2-mdshahid03@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 19:32:45 +0530
mdshahid03@gmail.com wrote:

> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Replace open-coded probe error handling with dev_err_probe() for
> resource acquisition and initialization failures.
> 
> This simplifies the error paths, avoids repetitive error handling,
> and automatically suppresses duplicate messages when -EPROBE_DEFER is
> returned while preserving the existing error messages.
> 
> Also remove the redundant error message after iproc_adc_enable(),
> allowing the error to be propagated without additional logging.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---

Hi Mohammad,

Please don't reply with a new patch version to to the previous patch,
it breaks tools like b4 and appears weird in people's email clients.

Since this is just a matter of resending, please send the patch again
(not replying to the previous thread) with the tag [RESEND PATCH] in
the subject instead.

Thanks

-- 
Kind regards,
Joshua Crofts
