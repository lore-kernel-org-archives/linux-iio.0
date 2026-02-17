Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB93235DCE3
	for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333946; cv=none; b=O/hEkeZxEDYDii1OdI3rh6oLDwnj+qtGPgKAzJZZPFukLwf9U6MBjcK0oPT8qz19Zuv2q8+KZUh3zZb3DLtmu7FNLposWG+r91bTbl1/+8irA0HElgwpiJdNUBrngOCzDk/Bp778Lwx5vPqvBYsbQbv7Zi8RftPDhr+CPJ1ELds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333946; c=relaxed/simple;
	bh=E+mqOESSVBjSqiFnhnpG8g7Vrm1sJAcBoyOztPYkI9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BeCBfTGZu8micQP0gY0tv05tLQj4/+QxFHqhU2VjOGPuaQWj5ZU3RT5clojS68WMy03PsJ/5ayL79QrPyZVHvvkJbtfpRsMdU8QoU8Pm+rZWoUTx8X13Ar32/hxshG12c1RQ1zkkGnMSkho0mOXPYEyeQJoHBLsDYCE+2NAPW1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5S11HTn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5S11HTn"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3549bba5302so2484274a91.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 05:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771333945; x=1771938745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=shgQILtznBovwoTlB3ZwkWPGxdgyGAqq3XVFEoRE4u0=;
        b=J5S11HTndFmtH5fQWLFFzyyK3hmHPfC7gSwypUUmuH3tlXZ997g2tTaQwKh/p7fJ/r
         bGGiw65+5k8yH23jY9p+eGHRmW2s7QTd7S2WgkT+7J6vWHkGz7QtmZ1yWZEfXH+h+8Bs
         ZIozxpShXOprx28lNy0Qb+nh+5q5WdFo6zqG9yI7AhRqxGkStAjkscBuoUdMVUQB4vKp
         ClmNkTbNQ39opaSOmJRY/kb9pP52WkoFabKT2UtqlGdzzbwmCn/7anm2jCaz+tT1SMgY
         H3yqvt2jHJ51y9MEFmn6jEGWjsnjmBZ1s8tvY/B/wSv1ng/T+xL49++sAkqBIlWE02Ks
         g0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771333945; x=1771938745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shgQILtznBovwoTlB3ZwkWPGxdgyGAqq3XVFEoRE4u0=;
        b=KCW7QHn6x8jJ5SbOXaXecxYh364XsMrlGD9S6OyYenIC9+U3T7UPE/Ib7+cp3EmPD5
         u1VVybaVd5R/ZKLN2UMxlUyjfEWh8KcfhMVG2N8iSHVKUWNjkPbkXjy0qA9S9Wh2MsLA
         KocV+pGkz8gEKGSlo0Z1rYScOntvRC8C8CmoMkMwo8W6OCEgusAVomv41ZAohNmOKvtR
         iQelJB9Q0kTfreeUmJitGxAW7LDMI87B9OrqskD1hNXwVWcq3cp/oX01poqM5/B/+7zY
         lS1/Tfzlt1/2VvO6VzhNhxRxL6sUiqgOmyR6oq1BbOfM9LEaK4RJjTsqIRI5mmaf6jia
         rY0w==
X-Gm-Message-State: AOJu0Yxz4ENd1lqgzlM4HjYIF0TR7Dx8ubEW3rVvr14E6XitzAAAV40f
	d8n8APtlXD+UdYhRLObkMdFxvcdHymbH8O3clpoYpPLWDoXrYx05UJYs
X-Gm-Gg: AZuq6aIfU8/x1D0Xo+bdgwSb8vHPT6I/AWxs6us9QLZYtGJMLPQUc8kJwYycY4pCjQG
	tZ/FAt7oIityIS2SWsVrmRkl9Vtb+U0ThyvfXFzKt9dgRT472G9mjt9BfSLYrCMeNG/uugZWLhx
	iY1OvAHsrzsRrwLxIsmcJG7nr4lFb7fB80xx6+RaHRKx50Ru6aAJ7ffpH97vsKpbv3iiRan0/l0
	K6dTUxOS4+Y9esm8Zlu/F2TFoI4oQH3ANYLyNv9Je9l3raWiOJio4yyPlUYwvbexVeaQHFZ+3Nh
	VJ3/wyZ9FjFBS2HOxsJSK5GD+44O1nu1AU82IzGvEAn2pojCvWZRTGdyTaV+6577qBv2inpul/V
	fRsh5qBdlKcPBJV/SXUIYl3IuspdFqAf5zoC1NfhuKAT5wEtQuISrzJ+3McEUk52BHYSz8PiApw
	g2gVnSt1a9/Zgqh2C0FHOWIDTSHmLfVKF/exVPnQ50CRadumLpTp53AIqAaY+Rgg+tmszG3Fc+i
	Yl2DhQ51rWm1hSy
X-Received: by 2002:a17:90b:2c90:b0:34a:b8e0:dd64 with SMTP id 98e67ed59e1d1-356aaa9bb34mr10777742a91.1.1771333944790;
        Tue, 17 Feb 2026 05:12:24 -0800 (PST)
Received: from pranav.. ([2401:4900:79d5:5d22:bcf8:754:c50b:1bd6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567e7d95c0sm18752229a91.3.2026.02.17.05.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 05:12:24 -0800 (PST)
From: PranavKharche24 <pranavkharche7@gmail.com>
To: ribalda@kernel.org,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	PranavKharche24 <pranavkharche7@gmail.com>
Subject: [PATCH] dt-bindings: iio: dac: Fix typo in ti,dac7611.yaml
Date: Tue, 17 Feb 2026 18:41:32 +0530
Message-Id: <20260217131132.297180-1-pranavkharche7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in the description where "Is is" should be "It is".

Signed-off-by: PranavKharche24 <pranavkharche7@gmail.com>
---
 Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
index 20dd13706..624c640be 100644
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
@@ -9,7 +9,7 @@ title: Texas Instruments DAC7612 family of DACs
 description:
   The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with
   guaranteed 12-bit monotonicity performance over the industrial temperature
-  range. Is is programmable through an SPI interface.
+  range. It is programmable through an SPI interface.
 
 maintainers:
   - Ricardo Ribalda Delgado <ricardo@ribalda.com>
-- 
2.34.1

