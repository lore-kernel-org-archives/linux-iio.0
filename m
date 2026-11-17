Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794944123;
	b=gYu+qnWv+eEiP9qzuVye5WDaQ1NyUji5U8LozUYYdcSF0HKXx9GiqYSxTDbp4l9f5oIH
	 FY/0npTByRD9urohR0dNqw5jiOJDA96U7HO1sY0nY73xeU3h4vvsSc3DEDX4rghSpisQr
	 7hlC6uBnYQ9cNuLQkOv2Xav/7lSEqOAH+vDUo05xiBwhlpcwtAKXiiEZALb81y6KKNp2i
	 /Sn2SlEl8p2xHVd8goeOJsxr7j3guvI2GDDlDxWWD5esyAdxJzgod31WZjFdTD6+voayj
	 hKarhV1r4mtxON4zDH5Q1UwPUHc5+GBFME8iByffzTRGrY5POFtbBP5MPoyCkJFvjxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944123;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=zZ7VovX7jN4uYMkhQWyK3ov4JdFyFshspRex+aWFMm0=;
	b=Rmhj2FD1PDyaSC9uXddjEuNXDv0FlQcC5dQdPHKhCRKrr36cQt3aBX6fQLKr5sseyqNJ
	 eIXH1VCgGQ3E1L85kF23lOfBJBw8noA205eLG+s8tALknPvuq0r6pe7ECWxyapcuCtXKH
	 rhrQmaxZZESatObwqYWRE0xlQ3rlamtGFgDPJaSErIi0IcWTV7BVOxmdWl8nXS97N5Zoh
	 O37da4Pn1mxAsdSrkJ14F3mj4sF6Rm6OtOxwq37HlEJyCv3aunIkXeyJf4+DCSVpfdI9G
	 1qmPsSA9t6u3PJ0PfizBTfNR48LjyoLttaCuGU6Be0pcHQmyuYRsa7z9Cjuo+ayD9HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17837606A31C
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 19:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17837606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso34185a91.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 11:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794944122; x=1795548922;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zZ7VovX7jN4uYMkhQWyK3ov4JdFyFshspRex+aWFMm0=;
        b=r7NY2P2H+5FRltReDTXcqx5ZxdR99beWqVfd+KvgnYuIfQzNRWpvMO8VIW55JtoD6d
         ARVvi4f7TaW87GsJThe5ol9/y0Zxy6wEwJ4uZxyHEP9+AMpOchpp4P2/7On4c0iUOZyk
         fdPjtOkNPfyvPETu9bW2lS4YBWgmPlEZSXMYqjst6xkyaW5PNujzOQ4CyesVF0skMXb4
         8Se80HxXozty3vTOJhI3NEnn0gJzbjCRV9nuFnd4vEwJaCkhpM817oYGl5qSnPeW8fUT
         etMWcjZMOwQkYR2MpA8NaCBo5Tx4MtL2wg6hSmx8kuJms/7KlcCSYv/ntd0ITMZQsTBS
         +JTg==
X-Forwarded-Encrypted: i=1; AL+hErEykasy3ju8jUflz7iHryQzauybd6jLt61XvAOO6l9pFXjaufIKG0agNKfc+Igyr91vhn0Ty4P4wi0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fTdwOjRb6UnTGJMUeECcdq3cV9wLtsQdprQNlVs/saIrpqLNz
	5ZMcWCUjaXGC+fNI9Vd8W0gpTjYcID44tZYVLXrpCUzEQ8/cyoP9lEYh6rqxUZfr
X-Gm-Gg: AZFdTZfaJ2I491QfI+PzO5GeBlxI2TozKxlOzUS0Q+BgjXp+Hr1jP1jTgMT7b0YxE7Z
	OMKcWR5Df/Z/VrniH3MaaCvcz2+K3KSrlxiATBNnDE7ghWOsASpdVvOjdWkDIqIfGZyYvdafe0y
	QVNL/Q20G8uWdUBScDNcUa/CdoSNM6KGFDwhk2E2PVYWOU27H1nBsaPzCdRdZwdI3K5/S1Hh/2n
	CfND5/yTkmaKbn5y2MXU8U1mkvMCXKVyg5B8N0tWxitVJY4GEKse1c3wNF0tqpWvVKVEQpbFktk
	Wzkst4bhwpl9wrOSyRUDM2rI5rilltWOcZyTWOGnEz1wxedo7xpvUkIUTw2Lu096cQBFzRyaIqO
	x8W9IRmCKHCHtFh/ht9xwiWQpz3FDYwtVOHiSzCDy8LzOoHeyl2K7FucNiaZarPRtDIu8MKU0hq
	okSxJZZCuMrk+kIjFY0FODOUcRlNSLMRP4iTMrSKdWtNevgi+51tJgZHtbMAviU8BNBiV71GefL
	x96xSn8sqoDIJL3crg7Lcgla+OmaVpSzn3ibzSpJ/c1DCQn8qnopgTVjsudEmwxe6rLTRhnNHEg
	FHRreiFNCGkSsyJ7n6wRmt5rEvDH8h6zyafwLJFqP264FqCbC0wODWVH6iL/y/v5LjTp39oiqM3
	7KehDIfKweXjh0EV3Ky8YNQ56aY+yTBVwYhNLj+RYePU7
X-Received: by 2002:a17:90b:4d81:b0:3ac:c005:cf07 with SMTP id 98e67ed59e1d1-3b3d07aa70emr412801a91.42.1794944122414;
        Tue, 17 Nov 2026 11:35:22 -0800 (PST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com. [74.125.82.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac606d8csm5635568a91.16.2026.11.17.11.35.21
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 11:35:21 -0800 (PST)
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-372bdb942dbso318204eec.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 11:35:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErECPb0c07Vr5wPeIOUE6wvNzGoDu/mWMZ04CmBqRFBkfxttZX8zj93VH7UBtSeZlkVueN89rQrrvr8=@vger.kernel.org
X-Received: by 2002:a05:693c:42c9:b0:381:4b4b:f96c with SMTP id
 5a478bee46e88-382827a7dfcmr296117eec.34.1794944120695; Tue, 17 Nov 2026
 11:35:20 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
 <20261116-iio-ad5246-v1-2-ef6b7c06d4b0@telaak.dev> <avwMpV3sCvMQNA0b@ashevche-desk.local>
In-Reply-To: <avwMpV3sCvMQNA0b@ashevche-desk.local>
From: Joseph Telaak <joseph@telaak.dev>
Date: Tue, 17 Nov 2026 14:35:09 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ7d4uZepoBqEJVcSb466fP=ZuRs=zREAcb3DzjvDA8Bjw@mail.gmail.com>
X-Gm-Features: Aa3M54pMmKLdjA0jFJLnsDDkzCIUJ6YpdPFI8j8vMI3OjOODp7f3IahMKvJGlo8
Message-ID: <CAPY4CJ7d4uZepoBqEJVcSb466fP=ZuRs=zREAcb3DzjvDA8Bjw@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: potentiometer: mcp4018: Report the available
 wiper positions
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 17, 2026, Andy Shevchenko wrote:
> Take a chance to add missing headers at the same time, id est
> + array_size.h // ARRAY_SIZE()
> + bits.h // BIT()

Will do in v2.
