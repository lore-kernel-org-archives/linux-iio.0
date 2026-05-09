Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295F37267A
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778364425; cv=none; b=Jsz+JK64GFx3k2yjgYIxo7PTRcTL3v1J5X+KlHcdUOcbmadUEbkE8qCZtP9EVSH5gplWN8kkTOYGrAMibsQi6g/xUbIkejPLlTfE4OLn8IwQvDjH8E3hUtjRnR9uN8ktzgfIA3r3Agd6JYaR5fzG9+0acSEKbAcVK6HZIW4rn8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778364425; c=relaxed/simple;
	bh=xYyxxtDlsONFPs1wxs7WBi3U24/H7vuYm+AFdU2VYCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNBByaDKpu9ltcn6gw7NGhK6vMJ81wVOwtUCpauL5UIFnjYdV1chTAaSgzLyy55IOztTc3xzdMbWHeF1DI0yaESJAGBS5v1USpPvCIcto/awwjm4sFsWDjvrG1ssDl5roH6N7Fx/L5XPCJX707pdzShB1egPEp9T+5IjGC3qOjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=q+OMnOdy; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="q+OMnOdy"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6967080e6c0so1855726eaf.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 15:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778364421; x=1778969221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bCT3ubr3H1wQ17zOsYqif8TnMtNy7ycioefPRWsFsA=;
        b=q+OMnOdyPAPrBpb+UHQN3e3avpyFE3nhiRY9VDxIEMskImjj6KSCSEoCvTgDKU/vm1
         h0p79/MsnNp2dxGDmOzIz9dZ5c3cZRD/97dxfNmWfviJyY4HQFinOGLyw1Gx8W0s/t9+
         uWJPJEuPAN7zsYBPzGe7cQ+ttUh9wJwhVKlgLTlETbHE/U1eFOpR773izdR4KSK1hYFP
         Rf6QgFSU7O/xzSGaVvH+sXQ42jxTTH85rv9+9PvPzOv6YZie/jzMOwlc+pm8l0xPT/Io
         9IKKhjj4f/n3mHlJ6uXkdjbNXgmCjBBsvfvOE6nideaWYlvqERts99800vx/yYy5evWQ
         Ignw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778364421; x=1778969221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bCT3ubr3H1wQ17zOsYqif8TnMtNy7ycioefPRWsFsA=;
        b=VBD2KpUYsT1Q3yKMxX2hrckMb1CZ59KnapJiVBBk/rz1ivShlzBkoGTerXoz3nJQpA
         cfvYxZ9omcoOPoYAQT3prB+p0hkX3nYnBmxl9Q8JWFva3lTF0JyX2/3ukox15WNPUTMo
         /L8WLK4CQrghsViVlt2GwLC8bbg6e9/qXvaWsUYugroR2RIA6EY4/nrZp2Ooe88pjoqa
         avvaCZwEyR55zFpHueq6GZAIPxC70M5W5jL3JbEm1k86MuNvuCcQIxOYKcyFWR3/V0tC
         U9trr88HEyF1bMLmHBfG6ZNJl0LkrX3lGLCCAOkOCEdZY4y5I6dMqowfsY5XcbHEUfSp
         DbQQ==
X-Gm-Message-State: AOJu0Yz8xMtxoxHZ6t2UiW58z4NGqhHRwpgMwWRNmezXf87LDQcj6obR
	bG4r4037Qy8Q/3aQhpA2qFkZIC0CfondXrAfPaCyX8pyeX7hDxnZxzW+yy20uNljD6k=
X-Gm-Gg: Acq92OEuhZNWAn5l1yHk1KDAnOWYU07m3wGzWRiQDIog57Eikg2r/zZ+105ReRORR/a
	YN6hNzsJ0q/pV/KqExOBV9FsWk3bRCUDogYuSbvDnIt4kt8C3msNvG4NgD1htIjsscrzECXfHdj
	ldP/0eqQZZbCKEyxnmfhZRtvP/4Zn+n55NIVDkFf9f7bt9/qU7D00N24PPIU+daUs8W/kyNnUk4
	pxLoM9qFdRWypJZwju3fN+orb4OxLRBKIDoR6XCHr537ouz4EwByLzDdBk1kRXhP2JFQO8ofYoM
	ZCUbkwUOOI/1S35Ycj5jtPA/xYt8W9HaWPQY9IDmDn0YzB6wW60ugr89uFWvYc8SEVH2Rq87PDR
	N+mR1w60HOY2Iw0FKIb463/8bjOdCu+i9HdPLOddsQMS5BstODuSRaQnE74CrzxuHzQ5NsKUEny
	JJyLP/dLM+4uqPG662Rvl2UiBsl57MLVde5z5/ZDPOo3XM2yyMeaABegiwZk4qWZtbtRFifBY=
X-Received: by 2002:a05:6820:1987:b0:694:9fa0:aa4a with SMTP id 006d021491bc7-69998d31d1emr10956693eaf.44.1778364421638;
        Sat, 09 May 2026 15:07:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:12a0:9178:ab4:39cc? ([2600:8803:e7e4:500:12a0:9178:ab4:39cc])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25c9a23fsm3260297eaf.7.2026.05.09.15.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 15:07:00 -0700 (PDT)
Message-ID: <87e5f4e6-557d-4036-8e6a-8abceff58154@baylibre.com>
Date: Sat, 9 May 2026 17:06:58 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iio: magnetometer: add MEMSIC MMC5983MA driver
To: Vladislav Kulikov <vlad.kulikov.c@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260507205033.951990-1-vlad.kulikov.c@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260507205033.951990-1-vlad.kulikov.c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 3:50 PM, Vladislav Kulikov wrote:
> Add an IIO driver for the MEMSIC MMC5983MA 3-axis magnetometer over
> I2C. The driver provides raw magnetic field readings with
> per-measurement SET/RESET offset cancellation, giving 18-bit output
> with a full-scale range of +/-8 Gauss.
> 
I wish all new drivers looked this good. :-)

Reviewed-by: David Lechner <dlechner@baylibre.com>


