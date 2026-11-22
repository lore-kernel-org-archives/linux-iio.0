Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795334911;
	b=4pGEaqDdqLSlrveCwxssF/SMdHZ7yGwB8lFRs11hQmQLOpGdjferhit5CQDsSq1Ea9l9
	 aDBZZfuz25FngZ2k55CxVr0QFCs3l76mTVsmp/ikZ75K389KOd+VGC/2MMmEGcwgTEQq9
	 /xL081qB4qOGDWZkvwWP7vduL38d562BwNQcNd2y5ybBaLno/orMvn3p7ZAXWTwEK1Xkh
	 p8S5umxYtcgDgorJR9qzf82MAdDUbWX6n/4r5R8D/qOL4q/OxVFgNgIupHNf/Ob3d/R4k
	 70nT7loV98bZdbvHoIPKI967pedOqRpw+HGpSK+iPW/Ec4v59Z4CjdD19WGr4lvEEoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795334911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g+JNwiCu6bm0rcLmuJWSYeAtStEl9n5lsa7a5i38a1Q=;
	b=BVSxEGuQ1vB+oKvr2G3FMKXKFCBk8VXgsaXi7pbbmoAz37zS5a48xlzvluS5MqxUbGTL
	 K4XwqlN9Ak/ksCQ+D6ph4swY1xqBDodFYnPu48Aq9JsJhomMtLVrjX7N2212aOPbI76Tl
	 sr4EpKvZnTiOPJxKTg7Ouw1LaG2xihmMc92fjiNJVvuTvL8Ll2n/hNAYfrWSUOLV7zwHM
	 5s2JmeYcCfQhg6NTAIX98jW7BRFUqK2Wv6dN0poPfDQbA058DDdkoMTGjhIz7Rd2z9ucP
	 LrG3S0SiziaH+BRituf+zl2fqN4dxUPwYWTRkdEilUASJfI1iviclqPWcdo2yqTuk3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gVmh4DO4;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FEA606A33A
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 08:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0FEA606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gVmh4DO4
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so3890843a12.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 00:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795334909; x=1795939709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g+JNwiCu6bm0rcLmuJWSYeAtStEl9n5lsa7a5i38a1Q=;
        b=gVmh4DO4zcFuVLCN6MTSTy/+0n5I9/HC2HAeGTKnEtGYEV9olxe43ouWELR70HVY1b
         8PFW1cmxOlQMuRah8QCAb0ftbRACIZBjBZ5M6oruHBdlh/DZC+bFpbzhWDvWsMhbQagV
         E9LSXw/f9CO7h7hDRz+pM40o/fOjXspY9EZybXzPPu4XAyrenSwqf32WIDqv4vPTwZZh
         cKB/GoZfl2gcopN1WR9m3OOUdumLMRP0Z3UqAWqCKD/RIo+wGMTuAy4GAXjA4WqQ6YUm
         XLyoXgtMEwPjvFbYXLLL5OwGyaSJfjBC7AYLiCz7aVrg5kQ6SWjxkNBddXwlNxk6kaCi
         6BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795334909; x=1795939709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g+JNwiCu6bm0rcLmuJWSYeAtStEl9n5lsa7a5i38a1Q=;
        b=PkZADnII7kiUHu+iX0jh3OgZ8RrGH4aMD3BBv6CjpwDMvom2FXERnku0/BZT4XqFex
         vqBjg+BFFW63Iy2JwuiqsbHWSlJ29sUlLsUai92XvWFj4s49h4P7j/FVshXJqDvY4T9K
         YRvfPkA+wKDDaWPoSilFBIkQ5YleQko4DWsEqEbmkeX08Rr7V8qjxxgTyCpNM22A3HBo
         iqq44dda1JBc9VynJKDyCQiluEUuW5Pm7ebJg/tze3WVZAjvGjaGv559s1md3yM4tBYE
         MZLhJrV1p3eQnDVSb2+ix80ZPtxpydJgul+a8WLcmTXOifJ2ujI391cZSvE1hascZUv3
         u9mA==
X-Gm-Message-State: APuU4Z+UIjLko0knK2aeYI8QTmkMFo+P4FXdp60AAKhFj0HtjDekYvj0
	EUbpIOfQ5fNIAVfngQSje17zZ5JpykeRHmopCAEoql4tgGkTKlkfCn3g
X-Gm-Gg: AZFdTZfdrDF/ghKU5gDlmIpwDso5KE6gEjzpTRGtgv/N5D+LMDM/j4bglOjzH/Ec2sZ
	rf9XQrOdxdkQh4takIhS0gW8RY7kmmf7wRGgrekM49jb54RAf/nuwV9mUhJDVjmUHwLgcI5Vt5J
	22IiDGj3ygtS4NYqgYA+oqPixIFOPCpWf+alCvE1OtnTgVQKMnkwcdZiyI6jFgouyRvTR5M2rtm
	3lcH617GcXzIAMcFRi0mkFTsOCFhrP9LkUohZ8IELUzyU1zOJ1oS8VJLjm8BkPqysnaAogvI/XI
	WqwCuobNUkxC1R8eraCnCw3qvKG6iHPH0ZEeUsv6x23wGRO1htiYdx1qrHzxS3BxocZp8bBke+7
	s7exM7vVXj/CZKfmbJlAkdFbUvMyz+QznGtX6DJoGnorgMhigNAqKQOlhBnkAUG8twmNG5r8VyN
	/81LKlM8Q5Q9DeBd3Ii0X2MvYO0rmAIvBQGxi2OEv2wqVX+wUv93zsrR/fmFXdYTXD2R3gSqoVf
	FH1bLBvK0g6UdDdX+c+hIlIwM5Dldb5CENV5JwQnMo1oiVLPu8CcESaUxnmxE1k7FQYjiWGNfHS
	4PdxSRCk9PzrT18p1Uwh0vkU7+MyyEzrM5VQPuMNdSYltrhW9QdtMu5B/dbdQyCSj/zNwlCMstb
	x6W1KzDdipg==
X-Received: by 2002:a05:6402:2709:b0:6ba:1de2:7d0 with SMTP id 4fb4d7f45d1cf-6ba37d63cc4mr5009231a12.11.1795334909034;
        Sun, 22 Nov 2026 00:08:29 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba3710601esm3596014a12.27.2026.11.22.00.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 00:08:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nikita Travkin <nikita@trvn.ru>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] dt-bindings: iio: light: ltr501: Document LTR659 proximity sensor
Date: Sun, 22 Nov 2026 10:07:52 +0200
Message-ID: <20261122080753.36349-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122080753.36349-1-clamor95@gmail.com>
References: <20261122080753.36349-1-clamor95@gmail.com>
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

The LTR-659PS-01 is a proximity sensor similar to the LTR-559ALS-01, but
without ambient light sensing support.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index 20abd7da080d6..85ac3b540c206 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -17,6 +17,7 @@ properties:
       - liteon,ltr329
       - liteon,ltr501
       - liteon,ltr559
+      - liteon,ltr659
 
   reg:
     maxItems: 1
-- 
2.53.0

