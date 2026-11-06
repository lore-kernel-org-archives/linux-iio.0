Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959233;
	b=pwg/24zAu0QEA6cPsYE7iN+SgTpR6gzN+conerKlZFZ2MY6Pdcv+PRCcfKP54RMaztej
	 k79HBCgNONdicmWrZSy8kakht6Tr+yhW10U66NGj7LW8MXFtKn83EqkgRRrMdRqk7y6m+
	 UY3DJ13E/zHzazCU28c0KSs5WLKTMTnSNcJeQHLVN/ERgrqFVrPRYteW13rsOyQBf8KVW
	 d8MY6BvhWTWzLh9r6fMbDtK90rNz/vagie26OGD9JjKgYr3KOVnJ5wwrqsBaf/u0zSmYN
	 yYk2jeTDJTO52Bx9cZ98unMI0ndIxjAHbSNYiNzTO4K8TOOnfODrwbfJuet5dcBoCZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yCBgBKMY+oy3XViUBHf7wx1cUIY9nYtt/kQ1CMxL0X8=;
	b=fQHSCI/iVz7kaKnu/uCN6WmCJzBsV/FUiugyBJ4vLMZgIlMSGuun7b2brSfBKIIZcD2I
	 gIDnsVv63idBnM22mfS2v+kYeEluU3J/B/JQhxQJUTDL1YUMQC3HoQdSnLUNj26bKGys2
	 YTfJiYv1G2Wy8OV1fcdufO/Xeo8Fe5jgBasuqdrZCdwnvUZ98YHe7VnRgmwu20yJSbGN4
	 Gk3+wgHexUzZSoyI7cBSl1q05vanDa/qGNHkk1TbNiBuhxQVRcMqgmoT/yxl1R2BVLIIy
	 30lQEiH1HkSqUOnR22APwdhzT3FqU6ywnSty0opoFjry1BwEuy/mqRj+Dj/O02JK+0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jOeFNwHa;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464C606A32D
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 10:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D464C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jOeFNwHa
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so4119545e9.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 02:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793959226; x=1794564026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yCBgBKMY+oy3XViUBHf7wx1cUIY9nYtt/kQ1CMxL0X8=;
        b=jOeFNwHao332HVD3QfiQaM5lk7vcAcuQZLCaMifPIknjCvH/ze3hFfWuBV4EoN7tMk
         wEoP/XwX4ULThqV1kMKSVTIyKos0MpEI9/DM853jGT8B7QZDLkJWTiv12Wf4NYzsPLyQ
         FnrFI0FMPmbRz2Y6dHMQ2pFDb+paJuVVTRzZdrhHt00cALOA+uVDF4nOEtghJt+1Qp0d
         KQM1ioBMXXiJUeyCl3m2BusET9eM7dvmLWYgyAMoVFBNIyR7KRbY19rKvslC07zpMwdw
         z1BhkBlaqompvfLdAX95pJqHTOLThpCQ2uHrbpMh2aRtIrZxi50iL47D5iHIE2IriNRQ
         XfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793959226; x=1794564026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yCBgBKMY+oy3XViUBHf7wx1cUIY9nYtt/kQ1CMxL0X8=;
        b=auluPzQviIbZ8Esr79YNoPZuZYrOMqjMtw6iblpwk22K+/ovTJbd5uFfSaiRyyTL37
         jBBvwk9tZgLfCpV6nvzkZyz81C5i5iFFH2Iij20mZ/sBMqR0Sn++rQFS2fxAHN3d/7bG
         kCLL+IP34j9lzNHKhZHIOpLr09obtZEiz5gB5WTgNDihitf41Lr5jF0jq4aX5oENP3od
         5lXgbGyjhJkWx3BVYDm0pVZP+Zlx2JDZ6XM+fITp1t31byJCWQ+r7uIUDLYQpsmZJ6l7
         RWb7Eh/IGP2woaCjYGIA41TdKeyBd6biYKYO4x/muujklVfxJdbpt9N7rzwmQqIwpwwL
         0rlg==
X-Forwarded-Encrypted: i=1; AKwUvBw7Jl664HU0kDErKYsrF/9fA6A099q9BYjQWPjbuDSfIkRkcf6KiE/LCijCZWVyocli8tDwllvBlJQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6e3H2/PoFzJOV+BpIiyIIpJFmLYccmTFARyFDRRRNC2ZarXGC
	k4OKX0DaoyHZ406knNCmTi4lz8PtauIfSjq74mCX6e+PG/D5Vo+QmOsVZtLwfB9fBLE=
X-Gm-Gg: AYBFou2vp8YrG8QB7ARzwQouvO9ndyWA0KwnFQfT8IZJ2yOcf7qPLw8Tv2KPtq1XFJv
	zJEYEYRIqrsPGt1tFqBvwreLcFmHOIsP4YYSxGK0OyFBa53LyoJDQD5EyCqOBA/tc9refz9SrjF
	Kk7VfXJRF6gT8OxpTlboWz+8+uPQa1xY8dwsZoxsYDG+qpQB2XCfpgdaVdx610P9ovAuaqIKlxC
	3jxRG/U3I/IEFVENPU1TaiYrkNKvIpoO9wMWmMNe+iUcVbAD2Oh8fSfq/Ow0XFse8rTD8KbOypi
	IjQVqhVTpP+emb1W+PNLcIW5jBfCxP778Qc0xgUTpBV4HyPFM1JJPoVzc/JkkFPmz66G7GozdB3
	M1w4XAvvGzFKsnZd4NBqZd3GdU8Yo7LLFJtFxGZ/lX5S73ZTMPI+emRo6avcmYZIvpYw7C0LHjq
	Hht8+uZeI7aoTAYidB143KycB6smFesmtpp9Ozli/oETYnO0D3VVLtKbvQJia2kVdObbnVcbN+A
	WmN9Bv5zzRAkLV+lL+Bq73ZyrxqHJHMOngxMnLC/NgqPKKYnbXeB6G44G/RzC/2070ZuY82Jirs
	MEdLMHqaftgbbZq5nTex/UGmscmiv68rviUc/URf0UToFVSMEnF9cD+AlFGUviwbpOqyIg==
X-Received: by 2002:a05:600c:4f55:b0:4a1:e69d:90e8 with SMTP id 5b1f17b1804b1-4b6df5eac54mr35512905e9.22.1793959225655;
        Fri, 06 Nov 2026 02:00:25 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:5c25:f8d1:d9d7:54c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d63b79sm2824397f8f.20.2026.11.06.02.00.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 02:00:25 -0800 (PST)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Joshua Crofts <crofts@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Date: Fri,  6 Nov 2026 10:59:09 +0100
Message-ID: <20261106095909.67659-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <eeec310a-a271-4e56-8958-a03318f07e82@kernel.org>
References: <20261105213210.87457-2-olivier@mgcrea.io> <49e69d9c-6cb1-453f-bbf5-e2202f97e4ef@kernel.org> <30B040B3-D371-443C-A66D-11EF89FC7C63@goldelico.com> <f74bf2cc-c459-4b9c-ad94-c60afcaed3cf@kernel.org> <05798D24-C5A7-41BD-8FDF-F7075F2F0D01@goldelico.com> <eeec310a-a271-4e56-8958-a03318f07e82@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

On 06/11/2026 09:23, Krzysztof Kozlowski wrote:
> On 06/11/2026 09:18, H. Nikolaus Schaller wrote:
>> So this tag should not simply be dropped but moved to the driver code.
> Yes, please. Thank you for testing, it is important and should be
> credited, just accordingly.

Right, my mistake, I carried it to both patches. Sorry about that.

Jonathan, could you drop Nikolaus's Tested-by from 1/2 when applying? It
stays on 2/2, which already has it. Or I can send a v6 with only that
change if you prefer,

Thanks,
Olivier
