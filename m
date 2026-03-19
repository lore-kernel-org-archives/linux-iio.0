Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C23CF68D
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921553; cv=none; b=c54aGN9Xf/8CEno+54jPqAsA5Tsf4hnsDHjMTufYqfpo6ve+4Ss3M2y/34PMyvVBH8XbIu967BgGmu4wwX3HELtjPZHAcF8iPC4v2g+JB+DLZVbNyqr95WqV4BHmEPdundI5Jzw/mlEn88SYulNIXLrbzM7YbFjVIuU5DMP/b6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921553; c=relaxed/simple;
	bh=aiPXxbkBtL2g1i14xqt2LGY7RPn85iUFNe9a0NClGa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQgoi2iaPUKcPB5F0iv20j0UdosMAeMgwMRH9c8+l0RKKDXDsA8FjneKdYTNgKDKtYszesTUkXLuLQig8uwEfD2S9uASw+ryhXBjbJRkTOe2UR6WKpft4oYI31r8DGMmGGIEZ0xpobp4Ny5xrFVv74+urmEndre+SoemBsOm/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwXrFg59; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwXrFg59"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9825ba7e8dso36719366b.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 04:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773921548; x=1774526348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZa0s7hz2156Ccpdoak30m2Gw7JDYqAQedbI9A51ZyU=;
        b=jwXrFg5916CCvzLfTU0t6sbRD+c7bpyZTKNdYFN3nwU52oGcjtegr1wh7G2cQLyPoc
         TaRQR4cDmr40W7OatWJ76qncMx0H12GXhR7oonw2qjjHtwFNwQfmc8gabdZwI8xgbtEY
         2/AGBzv1m9TC38AAqiwBbymy54FmRJu5Fcma7/0YJgYAKFi+OafHExB1nFaBO/q3YP4f
         ov76Qf52i9tXV+ilupxpyridYtx43+zMxGTTo8mMD30MCUQpo1rZKiQgy0l1idVvAGF8
         Sfb620oTBsEGo8w/HEwm8zck8uynOVgBpKZnKi5qI+a1wDKTsYyn3qc5nxV9vp73gUyD
         SxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773921548; x=1774526348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cZa0s7hz2156Ccpdoak30m2Gw7JDYqAQedbI9A51ZyU=;
        b=VW1Mgx9H+FVC7CCkjphF49GSfZ6fftdsX4GTNb7Yaneo/iS7H9yt1T/zSuVgdBxd5y
         nUTEEdjTWaBReNrxWjjPchrgQLARIq2G8wLwnqCDr2CnLlaQCDEkZA/JD0LPFo65U0Vx
         DU/XkjkAbjoaIWj1YEl41qc4gHKpnWeL6JtnaAn3ookpz6dJgZ2oVZnkZfl+oWYFr9tp
         U209kJ76LML4QIL0SkW/UhU+4CKboLgILyNrBSI6Xlv0/D5cP/T5TqZiezbwBhNVT5cr
         yODDfN+Dlhcmfh3Gt9+0/U3DBugHAj1KmvgLAa8A25buVNWBe79DhYIlyr3m5oM1EYay
         5Ttg==
X-Gm-Message-State: AOJu0YxO5W8VV2QbAcv8JuvxNmDAyHzU1YZ3itX3E8RwXSJc9XossSal
	81Cl+C7enJp47UogkrbVMWEb3VDNJ1FqaOMNNDp2KDncaKoEKFVqVlXn
X-Gm-Gg: ATEYQzzAc4t02+dHxT68fAOMHiJBYZaIntahfOsbFXKOfy1AibQmM8+rwH38djOG9uu
	np0euoqtL+J/rQblD5tilC8l099hOCZcywTcYrOfkmCzy6vfEgzvvIzQGJZAAIiR+LvQ/2xt2F1
	hEoWxX7rvC5nvC4rnkk/J5O5RwT9hXNGw8c5w2vJIGYRs9zK300yhdUMeZvp2Xdj6o0ejqy7WP2
	N3KltZHm/4LlgyEfKaGCGMDjEyHOXtAWgmgk6H5DS3SjLkuLtQzedkSlfbk86GcDNbwUKsVPWD/
	2aPSGh4Elw4gdcth0DoVQMdlip/FHb/b3dLuEMjcfmA1Th6TBnTt/oElBCDfGleiM4XE4hPcwOB
	3Rwu1PZkCiSwVA6zh+fc9V9SBiR1g0KADxznEe/lYBNv9/kgdbbB1VjUaj1zHlTc2jwjsB8uwxa
	Hu/90rZ2h78uTpxDC6Ip0mdVGmmoam3M1v+Lxn
X-Received: by 2002:a17:907:728e:b0:b98:667:2e1d with SMTP id a640c23a62f3a-b9806672ff4mr337932966b.25.1773921547845;
        Thu, 19 Mar 2026 04:59:07 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f16d3380sm461399166b.42.2026.03.19.04.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 04:59:07 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Thu, 19 Mar 2026 13:58:39 +0200
Subject: [PATCH v5 1/8] dt-bindings: iio: light: vcnl4000: add regulators
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-vcnl4000-regulators-v5-1-a025d3332805@gmail.com>
References: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
In-Reply-To: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

These sensors can accept 2 supplies - one for the sensor and one for IR
LED [1]. Add supply properties for the sensor - 2 for the sensors and
one external, for their open drain interrupt line, to ensure the sensor
is powered on before proceeding with setup.

[1] https://www.vishay.com/docs/84274/vcnl4040.pdf

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
index 2ba4d5de4ec4..44882a90bc76 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
@@ -33,6 +33,10 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+  vio-supply: true
+  vled-supply: true
+
   reg:
     maxItems: 1
 
@@ -54,6 +58,9 @@ examples:
             compatible = "vishay,vcnl4200";
             reg = <0x51>;
             proximity-near-level = <220>;
+            vdd-supply = <&reg_vdd>;
+            vddio-supply = <&reg_vddio>;
+            vled-supply = <&reg_vled>;
         };
     };
 ...

-- 
2.53.0

