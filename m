Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C433DEDD
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 05:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441562; cv=none; b=qLxZzEapyyrStvyzHvoE2sgpHcSEy5LfecnUuQCiTENcC6gr1jWf8K/oM8CSFJRWyhqg+Jb2obpYVP06l2Wl5LOFsSDVYRZAuGVCWFTxPOOXLUQw2hzRwaWd5QNdYIL+ug41/R2kdc49SCADefzzbZUFPuZQNAt/APZl2Q9F6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441562; c=relaxed/simple;
	bh=OCr2Hcn0qix+hqJ1KxJxOzUQfs1MFEoU3VKInobzy38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3MT37MTStWA5kzYK1N+ZG17LTHRnaXhG2/r76EJl0FHG1+LrFmKTqSVUA0Y+141RTJoHN1n0t8gnOhdbNKitxkZwiWsm95C+cPzvf7UcT1CWLhES8QmS8PqL9W/MhumD+CrnzQoRKwEAWyAeqZjG3I1d8KTe+zep1hFi/JVOqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyiSOy/a; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyiSOy/a"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso9422280a91.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 22:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777441561; x=1778046361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHweuBk06mfMQKKsSg/CDUzFihaXXhNJibA/Sa+cnuQ=;
        b=GyiSOy/ab8c2XAf6pqJR2S24XrbGw0RSw5SL9oYsBpxAiqVcwlyLUKkNRyafkHe1T6
         HWyWO528qjNYxssuwf8YHH0EiaPP703mJuexNdYdjRPuoix3BHijzfGt1M23UJ0CrOEr
         MfE7u2HH4WO2uNl8NZID4pnVMVuhdBG6qWkeB/06/Wxq0+hLEpfyGPhO8UGVUCi6HSQ6
         n8CnudrkMvH/K0x9hC7HK/AuCgIvLu3LEs2OdIioyn7jNbid9BsKUoEXO+olWJ7fPz6T
         4ozF6NW5ZQHXwYIdQa/urzZIbFK79IdgS8c335BZuMKmmG2/Ax1oAWx1wP+vPi05ozKD
         ht3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777441561; x=1778046361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QHweuBk06mfMQKKsSg/CDUzFihaXXhNJibA/Sa+cnuQ=;
        b=CbgGR0M7Gl2QcAFIsm07S68STyoXVSM8ZezcsPLrVzLcPQZXAL8z3WPxATU0qZAqMh
         SwwpTn7GYuaVHqifg45aupJhp2kxEp0ozf4xAwZdaADiFHU3eRHi5S9N2WFT4JETHqN+
         0z9lRb7Pi3l1YTiQX9GlRdaTvkmkRU6JiPz/o1ZZfbr5uUpbrcPOorZIRGPxEonBat+9
         s0jadfBGewdhxU80Mlvr5h32hFqnK5dh6O6DipeNMef5SB3f9qJpr6yrRM2Emp4itCYh
         iGrsBA8zHXVJP1x49mPizsqQhmC+YmAYl5rf9DHO4o1Tzx/CBrz/X6eEFW8G/Jo8J0Nv
         UD1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9d6wInqzudw1Et/vX88j1JNYOokHU4RFkYxbPKGuFD4l4pNqR1+nLTzADEkXIIhkDx6q61JV5A5zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPCPzfrkByHyRfaXEYAhkanP0OdQJqfxZpsTKGifTuwWZpuFa9
	eufArRq1jx8+ItPBzYQ0aSP5sYtIc0Fhzc4J+eDxVLIIm7fMMGAWImd3IvGNuw==
X-Gm-Gg: AeBDiespEDu2puVp6r/H6K9rTKjsHxXj4wUkCSCgjjBP0gnsXmh4hlyKDlTHt8DyMFT
	7xQZ7CUYGscGO2moA+7IKLdRBruf5J+npW0Cl2HCVR4tnyVKJoPeN6SLmiLUQEZlrE/VK74zYzH
	VvZJSW98u9GHIJGuFcKpRKZ0XLgt8TbvXkYGSF6JmwbuerqpuSpcnWRW2J9Je07APqxn5IOpeE0
	JNCb5d6OlYggfP5RN+BU1UYDHTfkRKWkMFU3vLIMvX7ZXRIvKyraEyDCy2DAAP6CczJ8kTbLzzm
	WCxHhCbkiZwU/HDYMD6oVvkob9DL4yp/ER5ywL3ktQJLwv4ke6X0pQTrR+LKybZqyKRS+gtBWg2
	IX/LjO2i9+leIc5+ZpUUdDUGB2iopckR22lH6BwzvMHK4QVXvWMt9gUrI4Xu+vOiYqaVKK3OvV3
	DqgoYYNlcqCx6XXWOO14mYhj9ArKxqO2Lf/1+FSEfUaAvEn1zI96nll3D6HEU9QIDCn9O4zWLRt
	GUpEGDjfV6ZyDLF9+maeEPWMIE7/sVKyjIOsynabQoKoVvvBg==
X-Received: by 2002:a17:90b:38c4:b0:35f:bfdd:f5a1 with SMTP id 98e67ed59e1d1-3649204d630mr6255254a91.13.1777441561015;
        Tue, 28 Apr 2026 22:46:01 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:5fb:20b2:c2f6:85bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879656dsm9346365ad.25.2026.04.28.22.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 22:46:00 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/11] dt-bindings: iio: adc: hx711: add VSUP supply property
Date: Wed, 29 Apr 2026 11:15:35 +0530
Message-ID: <20260429054544.123862-3-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429054544.123862-1-piyushpatle228@gmail.com>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the optional VSUP supply used by the HX711 on-chip regulator.

Keep this separate from the HX710B support so the existing HX711
binding extension stands on its own.

No functional change for existing users.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
Changes in v5:
- New patch split out of the old combined binding update during review.
- Document the existing HX711-only VSUP supply separately from the new
  HX710B support.
Changes in v4:
- This property was part of the old combined binding patch.
Changes in v2:
- Document the optional VSUP supply for HX711 nodes.
---
Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 1ea60dff98d5..a8eaa1f18de5 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -33,6 +33,10 @@ properties:
     description:
       Analog supply voltage (AVDD).
 
+  vsup-supply:
+    description:
+      Supply voltage for the on-chip regulator (VSUP).
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
-- 
2.43.0
