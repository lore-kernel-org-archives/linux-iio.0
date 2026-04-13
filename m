Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC533DEAE8
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090676; cv=none; b=BOCY4MaSdmEbJl1P9w1CHPbV+szYeonzq7GfuyZCVOQsOWvQ5vsvTfUsUpC04Wnerp1jZrGBIDrDNKjs45SE+XKNg4y+WEHCf3fPgOhk8xfp4BByPPBfcZnUCc8zqJgRb90wsl8rUR0jxNsWid4ZGXjuyAQpWWQ4xWwzY733Z80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090676; c=relaxed/simple;
	bh=QRl8gcrKQiDt/r57omxpjL2otW3WYB/VKrpxLVNYHaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnBxGX9bA12144OsX8zbsfCd+6WNDZd8verZc43ZEYDVummqdP5laDmgp7isMvtB1arml9uk4hnlaZbC28g8sjEcL8LT/3mDCRcYVPsprzCA3oXgc+6oNC2qrmcL7aZe57QNdcs2jdIwp6xuYGfmLMdHOOGWbZQE/1TCRz7D9Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=hzcWu0cj; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="hzcWu0cj"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-46aa216a65aso2433562b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776090673; x=1776695473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sbtL9exLXOfF3sFOptQ/1hmTiwe+9sDQ4wSyERhs8TA=;
        b=hzcWu0cjfL21OFoY9NdUZnwbzzBEeg6JMZn8mFCK4UiHph4mB9sMfuCpPwtDqpKLfU
         q1ZaLr0a0yfm2ZGZHqNYpOO7Tyqtc2IAfJI90fOmCj0hIOq4rfyefNg+0zZnfx9cxhj3
         L+1csHjVPAizv2dvkLpVRaeJqucyx5OHOE+g5eLZ5iKDUnSW3o4wv6Lb1d1W1a7aN1Gn
         Df5dKNsIn9quPIgoVQOyy9er/KHaVWQ0CF/FLK5GZU17MNPpTpsTly7FgW4amtMuoWRU
         IIReg57QiXP+PA/naQopT+OHAG44CYPyeK7npqZUIBdYHgwiiZOCOlDPAhefGKoP3LM0
         LbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776090673; x=1776695473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbtL9exLXOfF3sFOptQ/1hmTiwe+9sDQ4wSyERhs8TA=;
        b=aaqfNxDVPf0pqpTjMb/DH2RSR25KamzYh83tCXR9w6s3MUUftuIiglvcZGwLEOfkqp
         X0MpbQtKiHzRcQb+QsvpQoZ7y2m6cZ+K1CP3Njpy2CQt2mYS7P8yp77I1SGq/+rMBLiV
         rtQ5zg7Iu2ToVHGyRIJl6AqdaFohnAYcPqvx7GsjbEJF23nvW3UGAuTAS/i/llpqZuAb
         bwmzSDBPUpY6MXHIsFRE/o97N3qOFafV72RYuBZUWjHzt2pipZ+JW35xpiW7tMF1jaMx
         GuxRSJulx/faocnnifd8Bqg4IklTQphGzRS9hSOlkuoJPtLRr8IZ3tYGEGME8qmkZ7T/
         gNHg==
X-Forwarded-Encrypted: i=1; AFNElJ8+5rsjEWSZr85cXmPdFz4LgKQPuwsMfZBiO0iFU/KEQe/dhUiK5RA6R0Q5/FFaU/65Sgi1Yq6YI48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTshzM2TyhGpcvVyI3SCrFhAympKAiIpR0jJNhSFDIOKasJPJZ
	+NoD2KWzuGXYKZQnDHDjdVzAOZk/ueDt6RFkoKpIdIPlLyrLZIdR5HTKhXTR7nldHo/yqS8TgKO
	1MJi0
X-Gm-Gg: AeBDietcTfUjhsBN16deh3HQN4C/yDV7ChSC3mKaQAZp1FRPIy0z5pID1jCPQLq5SD1
	LsllECU5zsFjG9I5aMLQUp4D9Licd8gw1vWF54rWUwW3Jn9Q677rfRphfNys70zwasjFUUz/qDU
	FQsTUCMQlhOMXRIZMtS7QmgSkXjd0r0iMcIdfRLuyIqQQRGNB5puOzzqoexiyJ3/4sk24r7eNkC
	L2tnPGbCAAKcnkWmQDVaAMiXzbbKmX/T6ACz0gufxgLPiHUNRSH7It9HnC/Yrgo7SyNuVBinIGb
	mr9g5OKXnfsmw/MIoiyCZ6aazvjOvIRxoIKplZVB8FAGMEYuOgLlV0s433o4JDTuYAf/IU75j2P
	67jY6cFETw03XqWvAisdAM2se4meuTgWL5EO4X59gI7zKhYORCr+yeP9aM8VwAjbOaAEIwK0p96
	mWOsAv5mKBUdYFqn3o7CNcLoQwsfblw1DmMnxc05cJHqY5+QksiIGjSy/Upfb7OKjPHk+jt7Q=
X-Received: by 2002:a05:6808:144f:b0:45f:3592:407 with SMTP id 5614622812f47-478a0d0db43mr6542715b6e.50.1776090672535;
        Mon, 13 Apr 2026 07:31:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1963:d48d:f7b2:862? ([2600:8803:e7e4:500:1963:d48d:f7b2:862])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a345fd71sm5991947b6e.13.2026.04.13.07.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 07:31:11 -0700 (PDT)
Message-ID: <8abcc3cf-32e8-4ca2-9c13-9f0c5b1c331e@baylibre.com>
Date: Mon, 13 Apr 2026 09:31:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: Add driver for PixArt PAJ7620
To: Harpreet Saini <sainiharpreet29@yahoo.com>, jic23@kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20260413000946.7880-1-sainiharpreet29.ref@yahoo.com>
 <20260413000946.7880-1-sainiharpreet29@yahoo.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260413000946.7880-1-sainiharpreet29@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/26 7:09 PM, Harpreet Saini wrote:
> Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>
> ---
> This is part 2 of a 2-patch series proposing a driver for the PixArt
> PAJ7620 gesture sensor. This patch adds the actual C driver, Kconfig 
> hooks, and Makefile integrations. The device tree bindings were submitted
> in the preceding patch.

Patches should be combined into a series with a cover letter.

The cover letter should explain clearly why this should be considered
for the IIO subsystem instead of the input subsystem. It doesn't seem
like there is a valid justification though.

> 
>  drivers/iio/light/Kconfig   |   7 +
>  drivers/iio/light/Makefile  |   1 +
>  drivers/iio/light/paj7620.c | 433 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 441 insertions(+)
>  create mode 100644 drivers/iio/light/paj7620.c

There is no IIO_LIGHT channel, so this does not look at all like
a light sensor.

