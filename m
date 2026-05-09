Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2036AB77
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778365870; cv=none; b=q+AVPJah2Kn4zQdrRPQI1ynE8DjqTuB/Hqxw8t0OQLmsmd0s86hgV5z6cmGlqGtu3r6ntYMe/rs+Soe5pDk1y0mBA7Odaj0hHx4qdccRPv85Ai/o65uyfWm3LmJU0uAzfA4XS5jaWyzSks8i/jo8vWY9K/LQjmy3iwQsPakF87E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778365870; c=relaxed/simple;
	bh=R8MHtyw3iUgVFaiy87HeuWdQOOUu7CPfgsXOVX8YVH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nv7nIv68+/3eEtCPyQ1CVidiURcgq/RGM0S1AA/UuG+ef/wN6X7p1a5prqa6bO7bebaw7U777kZ7WeO7jwmVFq0odCRI9dGSKNTMo94Ouy5LhmzJFrwr6eMXvJ8lLWDTFdpTrFxqldQ+Yrf2dSc9Swaj2DmPMQexfqhnEV/FqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=x4EOIbg0; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="x4EOIbg0"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dbd23bc684so1909174a34.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 15:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778365868; x=1778970668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OOHQiWAMyC4vDuld0j5M/eJDZswBebyHXatCRNu2gCc=;
        b=x4EOIbg0hMWcmd5dZM7MB96+L2rJ+gmreyufR2L+xnijpfI0JZS9i97HqzmtYC9XzP
         dx/kYOPitMFrvKRH4948PeVhD/Ws7dhgYtMfwVZCWFN0KEuBFpE7U5NqvKU0Itdy0nnG
         lnlkykjOu5WBDFXdatiY42qCYr/cHcvcSkJrCbKrvrCeimGp5ymLQmoZ93IUg3bMWAe2
         R+fJDJWF8sWAPkgovsQk4IGBue5y2O8YJwDJsi4zY36q3E24t1sxTTk0elHfGm746ofx
         ljxlKpwAUAPWxzqZGqc8CVadKc3v/YDuXYLFR4/x3LSbrqKpwzZFEivSGjHfJWhY/HPL
         /Arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778365868; x=1778970668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOHQiWAMyC4vDuld0j5M/eJDZswBebyHXatCRNu2gCc=;
        b=cJUEvoSajd1hDIGEAYHMd8j5/q4Fy/s5hmilhdMMjSZykpw9Q0lPP8a6qfuUdbPip2
         PZtKdfYmWkTUzqFFJDAz6HzlXpBWrAJGlcz64zSv8huITEvdwN+pmjduJIJXk/pT2Obx
         ggU8K2CPy1Mwt+4QSo8EYn4CObImJKpye3x2oIIdF4VHe9EA0UcKsp6PQrlNyN10RveT
         kCfDbwFeUswMYnp2FyW3CFkzM0Vn234Yatf5wMm7p7//X8jJN2+hg1kVZ1HGMzYP3cBO
         2StRKxm415FS8hWt4bKUC5T7/Upjg5nb4A1V9JwtoX1AHKF0i++oqPLhnp7cVnDN4Vcr
         JmcA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZFu3evi+wvMFurKVrmyY77c5LLlrslZjizqTim0jg8rplM2/Hw38v+Fn0ETs+9BeLDU2eFPbyQXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOEfw5aKJ6jYFTTjjKI3QMoM3ASerqx2QHmJZ8wWz2ZJd9hBQc
	p2GykR8zjT/9wakULKOnG5GiaatfVkLjaIvQPyE2GhcsAxDCN58AiP618PMdL4r/Wf1UeaqjHrt
	5QGGb
X-Gm-Gg: Acq92OGWFh7972KFws4YuqXbn+et4/xJhF2TA9F1vmWHQygXQMwD66yfhWq71pVvHSd
	LBScURDVnPRd37P6kJB8B8/vbeos0latKrbJd7nTZjd1PrQocd8CUoREAhayaLf6ek6nUcNXGSB
	hnq/ILsteBLuK+fAXnW6WkNnE3wDYPBQ4PyirjX0BA0RC+qgF7AZ37PISa5oC2ovHPM7VEjFgYE
	L5hcVwVrDp1JLUAfwIXAZoGPqfiUJWmMOeV6Y12VJErYzFrCgKzF/hWpMiqbj8D+ltPspTBs8RC
	dx2DYtVqhSYEeeir4AQEDmOCdTCEcNqtgF+fe6jOR4iF8sl8RqwowC1vDjuIHefhLOYbd9difc0
	X0I3KjwpMCG/RqaiMOQNe3Vq6pnhlLbbM73qfVkHmgkgg/Bm8raC2YlgFVMmf/Wy3OHvorckKyj
	/0IucREmqh309Lf2Pk805cvNENewykM2AgsKGip9iaN9zBwp0Lp1Gvi4hDyvru7iQaZBLU6xw=
X-Received: by 2002:a05:6820:2206:b0:699:b131:d589 with SMTP id 006d021491bc7-69b36ad3840mr2252792eaf.3.1778365867934;
        Sat, 09 May 2026 15:31:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:12a0:9178:ab4:39cc? ([2600:8803:e7e4:500:12a0:9178:ab4:39cc])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25dc00acsm3226661eaf.10.2026.05.09.15.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 15:31:06 -0700 (PDT)
Message-ID: <f3bb9f64-a0ef-4862-afdd-74ee39d7bfc1@baylibre.com>
Date: Sat, 9 May 2026 17:31:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 00/10] AD9910 Direct Digital Synthesizer
To: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/26 12:00 PM, Rodrigo Alencar via B4 Relay wrote:
> This patch series adds support for the Analog Devices AD9910 DDS.
> This is a RFC so that we can agree/discuss on the design that follows:
> 
> This is a follow-up of the V3 discussion. For V1, we reached into
> this channel composition agreement where physical channels may have
> sub-channels. That adds the flexibility necessary for this design.
> During V2, some feedback indicated that the ABI is too device-specific,
> so DRG/RAM destination and operating modes are configured through
> alternate paths and profile channels are created. In V3, there was
> further discussion on the ABI and on mode priority debug.
> 
What happened with the idea of adding a new attribute to show the
relationship of the sub-channels to the actual physical output
channels?

