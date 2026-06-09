Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068A348C6C
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022170; cv=none; b=XLmSoa9/gRtRkTPq/x2jQQ2+ebdVdsYh6rTrEj7MzyMdQsC4e8kFq6Cgvgno/hcgqQoSokSlkTHcnR/Z3dtC5XNAiKOLHyRaHnbZKRxhc4bojysigyZRopGaqSC6xHMJ3ztfiejxi8GJzx0ZTys/2c/3hHgm44fpOi74i76kHIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022170; c=relaxed/simple;
	bh=BBJfUI2zXdYPvtD7vnqTs3Bc2wvnZAzUqtvUNsC0480=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=USuOOQ6ub4eepIqtX98EDlVFtpX3gI1shXnuAjLRZZABtnxz/bLIVoBkqUcDFlFFaIDCm8jWsarUf+w2nN4UCmzJprdvrpFEalzYpYQ47FJP3KqG3XCMrjUbQ98UHKiON7j1ibW6R6EMmH41aj4TTtpPV5tNTfh02yZE3V/MfFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ia0CHvf1; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Ia0CHvf1"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-486badc02ecso1322264b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781022165; x=1781626965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4cZzfc9MyNs9MhTESYDputWthSBFsNrc01XRKBY0nJA=;
        b=Ia0CHvf1mn0vquMxLkzvBhRAC3kS6orLHeZGQ+9zSKiwLNBP6R4g6ltAbYwiVJ5m/u
         /vJ+Sze/879z0+BJjwbyXyH/giGski8QFfXIDWjs75YmpLw45W0vniRGqprsKyDXUOjP
         AY1gd35nW/ZbFD2nN66ajEPiapyBiHxQeHn2xtLEuhGlnFpR0l6bSfkH0Kh4zz+jWr40
         TGCv29w+X486hH/C34h+3q/nkPDpQzhOfwI3UF6W+OuS83Ixh3nSJr+6tQhDTM8YTjX7
         yOTLGFfog2X7fMak0nuH1ILIyCWag/zV2lYI19dzBXJ53HrwXKyDQd7B9kf8p3OgGXo6
         ofLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022165; x=1781626965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cZzfc9MyNs9MhTESYDputWthSBFsNrc01XRKBY0nJA=;
        b=dKoxG/MXkHhmFcwgtTDF1J4BPUVG09ncZS+P9i6EWkmD2yMKV9ObwnpkZdk+XoYY44
         EymmBqLjYDqvGZaH2sQpaLojf4nfKgTiOAM6CWbrIVKAld3/D0G6nQ+5XB1/xu3FRgtr
         KZzDXNgddn/avevLKHt+5ZeZOWvvhKzCicAzstdr75NLV5vlDZaK1hhwd48fpeJvL7Nf
         lQcAkYFJ5DzWv2G3vIQm++ibMXfHgz9jUzxOE27kbYBaf3w0SRpKDsJig8YxOe/3szZz
         ylFZ5E9Bvb/+SNaAL7R/GBAgS2NBgrnintdk97GS8hggn7BB8HiyVV7Lm1ZIRZ5T1R/M
         XKNw==
X-Forwarded-Encrypted: i=1; AFNElJ+WlZ5IVhqWlSwfw93mSCg+xwsDEV58yYDIoBycuQgdgcuA+eKvQHgDh4SLBOyTwql4PiQFwt158fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO2mal9qa3p8g+mo0nzmtRbl4bnoAvntYsQqYyG+KrPaEiMWAD
	mPxWwNrp1vM9UeHEHzFHvvYHeiQ+udnmA/D8fqbiVWxAyUKFugFyAm3XROjqCRcUhTM=
X-Gm-Gg: Acq92OFL00AJH9dVc7YUJUVMY6OLsoE7779WTu9tQVhzKlzB55OBDtFBFxxIKwAd5JO
	3Ut8albfB+Z60vuvtPxTIYOLjN4jKnNDwj+6iqv0dc/RtBHN8ETts/7RRnrHItIYLHAG4U+HA43
	tEVZ5sQD4h9lV9JHazuwlVAgsoHSDM92rnfvuRJpxAI6juL9iKXcUlD+0sGPCznLxlt2mqrZ+7c
	YYtrJNsf/E0/gHHxDr8gaKs2n6aV6z3/OKDVEaGPpcosMHuFtSLtwL/TzKoSMYjHke8mcBc3HlE
	GRd8Xd5w6FAvjO/z4dGHzzX7fPmUb6CYdYqxg75xvt8kY3OE/hDQ2/Ed/7Qw6zQbaThda0m/x3N
	T6OLQKNxYJmQjM0vqjop7BKOdFLVEgAboDnckYIurYkmEV5aRdLeu2G4l8zymGGQDNsuPMdypB8
	az6878u7KaH5zDMgU9RNfCOIgBpHV+LiM+YqpmLh/ciPgbk0IDbPilFfDuaSNtmPUWBaVtAv8J+
	XbgVEJxd/sj
X-Received: by 2002:a05:6808:4feb:b0:485:3dd3:7727 with SMTP id 5614622812f47-4868dddb451mr12699969b6e.28.1781022165556;
        Tue, 09 Jun 2026 09:22:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:2516:8f73:2dbb:a61e? ([2600:8803:e7e4:500:2516:8f73:2dbb:a61e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a39fbsm16294587b6e.1.2026.06.09.09.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:22:45 -0700 (PDT)
Message-ID: <c9418ca9-5563-45a8-b995-d2bf7514d819@baylibre.com>
Date: Tue, 9 Jun 2026 11:22:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Replace Tomasz Duszynski as maintainer for SPS30
To: Maxwell Doose <m32285159@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260609161701.52513-2-m32285159@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260609161701.52513-2-m32285159@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/26 11:16 AM, Maxwell Doose wrote:
> Hi all.
> 
> This is basically the 2nd half of replacing Tomasz's entries, once
> again, in the SPS30 dt-bindings and his entry in MAINTAINERS. All of his
> entries across IIO appear to be dead, which is why this is being sent.
> Jonathan Cameron's approved of this [1] so his entries in iio are being
> replaced and an RFC regarding this topic with Tomasz Cced has been
> sitting on lore.kernel.org for about a month now.
> 
> Maxwell Doose (2):
>   dt-bindings: iio: sensirion,sps30: Add myself as maintainer
>   MAINTAINERS: Add myself as maintainer for SPS30
> 
>  .../devicetree/bindings/iio/chemical/sensirion,sps30.yaml       | 2 +-
>  MAINTAINERS                                                     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> [1] https://lore.kernel.org/linux-iio/20260609140712.2e5d1640@jic23-huawei/

Do you have this hardware?
