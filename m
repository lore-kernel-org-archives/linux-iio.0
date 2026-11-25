Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614904;
	b=OBvqcb5O0/UQDWSpTjHryox3W32Bphm8dTqGwfAeK+DU8C1cYGA1WNyy9N9eN3aEVEEm
	 A+M3+DcO5Qg/B0PPCcfE0KHsYy8glfRk9S/tjI7nGXPHEwBAEaFCZ/CELugdZkAsuJt6+
	 /zt8N3efiBrIG/t7p8nwuI47ZianY8/d6AmlPIozyztHbd1qal4q+gfTTbcFC4pylRbnf
	 h7H+mBD5YMGAQYSwuSmWjr+SneJgogXbsA+jEtiW6YCiqK/UQSzTZCLg4LA60cQKIiytG
	 M8RNtrLfM8fhrpb+gnFuQzQB35Mauzk63KwVCfSaUMATHCEBlQ6Z7VgytTXw8MEYvjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kdlCDf2dlFxOjylVGdoM/KhHearUI/+HreUvx630OTI=;
	b=rbxSAB/VKoL14nGJwiBXBvWRkc8pIIzuFPtDctNEY/+dDvPQ5Hh2OpuytFgCr0woqMtg
	 0tZv5JWJ0++ZPcpuug1zS4k3CBN7KMrCxFs8J/zRczZYWK/getpwzeD3LYUr05cdxLS/b
	 XGqicSCXqWBO/zDCvmpyhKj1a5QC7pZzHKDcksIZGao/Sz3yR97BcsVSdYiVZIXPW+tGk
	 jOG1rTc1quqMZkin462X4jazo3uGbudxPG61DQcejHIBsRlOpNN8NkDZ20Crk9xiFl2yQ
	 kNN8vNj1NIlX1cN8sKFDqbGfgW3A3uct6mm8DT35v36NHlndzAMk7i33zRs/yGhwmLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AP2C8OHG;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7EB606A31E
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 13:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D7EB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AP2C8OHG
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bba5e17cbeso6812385e9.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 05:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795614903; x=1796219703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kdlCDf2dlFxOjylVGdoM/KhHearUI/+HreUvx630OTI=;
        b=AP2C8OHGOl0DwkmI5Sp2NUj7zGMD39QQo6CwIEJJPM4DnRxUp9DuhQO+kVMWFqX1eW
         8ouMbFbawn0PB4Whn4akvv6M6cFSkVu2LSD7vl+5Kglbs2aHR8iKOmwOOqBSwKhcQucu
         XN1OX6tmqEHc+qyZM7KKhUhKpKCDIk22QX2iiFx5BlkVzv3f4Xcmn9lRfxmDtpH/ZEQI
         uvjJ9vHWIq1ytBPHXzwYockTaWaLwH0nB0hfvcclFww2HPmVUZJhiLybtT+ZjU6IMsX9
         C4IAvrEJPrn6n/TdFeD85cmg+WNo29CCk/L3LrBIQv453qWeD61l/d5bHXA30/PsGkgt
         UFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795614903; x=1796219703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kdlCDf2dlFxOjylVGdoM/KhHearUI/+HreUvx630OTI=;
        b=C+iFOQBEcMTUg7N1xRnHGWSloNzEsYxnbHSoGDRvpaP+VNEoOCvpEUwKLO5aa7ItYa
         rjVKWRnnQaq030FeWnuGcb5I14FivWAz6LYY+dpuyKGd5BaQdPjE1FDybZOx7NuEp6Zu
         2XYJsR2BImetk6cL8EefI7Y5shIgCDf4bMakHVFZaebRYI8iePQrKYdO7YSROmBDa+M2
         b+IbGOazAoPt/LYxo3c3Tp1h6JQ+xribfPjeQphnXMAmHc0rhGKJ2ZrWDqBPwxZmO/+5
         WGEZBdxGHijliOekvBu0fsiuH9T9oqvnUkCWsXU4rUA2i5ercJxb/WcBoaZvTYQy7Rx/
         f/Gg==
X-Forwarded-Encrypted: i=1; AL+hErE7Jfo0k6YM2I23c74qMlnHI41j25Il5lQqyhIl92NeBW4cLGSZrG9o8oywTU6DeLVM0dCIUXDZjqk=@vger.kernel.org
X-Gm-Message-State: APuU4Z82sSf59FjGIfvov2R95X1RWxltNoIGSKvNYuk+g28Hec6TRGje
	5cN92zD6X5Pfh7aOFLXChPRhNYlWidYeb0qg8hRCkFrh2TuXwqCMUZvkb0rudnJ8UuM=
X-Gm-Gg: AZFdTZcqacnBT6dt9Hj31XDy8c0GSv6f5E+eYvV/jlh+urGZTaEzF5+V4aahKQa1/+s
	x9qMK33FDMXM/RvkKF2g7EeM1XPxsVSWHXU1+5+vfKDu9O1rLLHGgrxX9P6OJ/SB9c9UJcg0t8x
	xX8qJB1qEYn742RtDYwNyxqPe9kn70pwV7XUBmlSoKx2mdXwn9+/JAM+cPtszitCpGAqBElZrgS
	PO5RaGVMBGMC70KCrfOL0Lmr/5p6xJdkiGzXPl0tFLIDuCxJGqo3krXA6aRwVFF66nwCqmY/Fd/
	C+Bfh/rrq+4RZcGEPjSE3R4LwZ6Yhk9hyxp79v/mXnB1DU3yJq3ZMGcWPWmkpm0Lry7ZPZ+se/K
	fNfmXU5wUo8GZAYAgViSUREP2CJ2JZGKYNfUIpWSv98l8l/ehkUJK5olehlDtkb5qwoMte+15un
	DscZXK7rkuuj8wFwdzAOKRfiR7WkCSJ8y9cKIOzhK6vUIDkwk/GGaIiRSC/KUTNV5ObugcXxo2A
	daDnunamiN2FKk4CH7XABri4CyqEuRUvHKz6qvj6/e6pWwM2dSO0ClSAckAGXNN1YB4ZZrTymPs
	2s3RwrJnROa9QGgc4T0BtXD5fyGi+ZYD0W9FVj8AsYNCiq11mAQQGBXFEaYO32AJ85NmDU0JdHD
	oHJZMD4uygIw=
X-Received: by 2002:a05:600c:8210:b0:4a2:1a:a116 with SMTP id 5b1f17b1804b1-4bb887865b5mr359907805e9.0.1795614902892;
        Wed, 25 Nov 2026 05:55:02 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm515864135e9.5.2026.11.25.05.55.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 05:55:02 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: fabrice.gasnier@foss.st.com
Cc: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] iio: adc: stm32: describe the STM32H7 temperature sensor calibration
Date: Wed, 25 Nov 2026 14:55:00 +0100
Message-ID: <20261125135500.5306-1-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <89f43760-01c7-43e8-9682-b7363ffc931f@foss.st.com>
References: <20261124202220.23721-1-gerard@teslabs.com> <89f43760-01c7-43e8-9682-b7363ffc931f@foss.st.com>
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

On 11/25/26 13:56, Fabrice Gasnier wrote:
> The DT is deprecated and are going to be removed [1].
>
> [1] https://lore.kernel.org/linux-arm-kernel/2afd5f78-0174-4955-8c1b-be18aea3800b@app.fastmail.com/
>
> So I'm not sure the dt-bindings update is useful.

Hi Fabrice,

Thanks, I wasn't aware of the removal. I'll drop the dtsi patch then.

The binding itself stays, as it covers the STM32MP1 ADCs too, and it is
used outside Linux: PebbleOS describes the STM32H747 with it, so the
temperature sensor calibration cells would still be useful there. Would
you be fine taking patch 1 alone? If so I'll send a v2 with just the
binding.

Best regards,
Gerard
