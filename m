Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EFD3AB269
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209718; cv=none; b=cfo7AFRnfAi3jykD/XQ+W2r7LQuSg5GHbUxBpDiQWMjLv2nR/1AP5V2UKklwshexJYPAN4scx/zljwjZZWdaetfnvzzJXOZOtWh1AxTmo0AEw3542JyNX89wi5knovOXrtSCaaqPN2v+K0HwavbXEgpQa7hwqQDdWC5cgi6l7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209718; c=relaxed/simple;
	bh=fMKaNCHqvdnEkQNOcz/+Evogzl4yJdpF2G3aArECXqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbmLtQ7wXWJyJsahP+FbPcOBsYp4SGrDh6E4aD0RDBTCVQsC61QT+O7vohx9M5FlYSHlO8f6nrPtcX5ignK2qp9HKDoCT6ucS2zQ0IXCDEGepBBGASC0SHogBTpuvFpvPXC92ns04JlTgAzG7vCOlHEM1LuiPqCrELeTmj993QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IADPiKbd; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IADPiKbd"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-43d2ff651f2so271158fac.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781209716; x=1781814516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG46e6wh0vfo+H1QfKvpne8/nrh3wipAUO48FCP+P1g=;
        b=IADPiKbdaOS+6TmS1BOdm/8aiB+cw+a2F8RY++/6yDKB1lwxYdVvQ029JnToG2XwYH
         LP6knBI/YP/jHSDV19Or1kgVl+lheRJgJf/k442fsQC1aQwQ+JsnQUNZV2oQCyhUjiBQ
         MwE17w8j13x/9EldJ8Locul3cNvIr5dPWmrFUH3oDCbvj2i7suhaSCgYNHcdhMhgn2C9
         K1XeMw8Gyefrf32ULXzqvT1e1wuKHTDAPJfsQ56QslbQumtwUrbZAUuPcpnXtEnGqprO
         eCvucVHSlZP5S3ToYvKfpxg/WAiw3zkbPcKQkksbpV576BT8kkaMVa5GD0k07sYh0kco
         VBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209716; x=1781814516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AG46e6wh0vfo+H1QfKvpne8/nrh3wipAUO48FCP+P1g=;
        b=e48nI1bQQEebiCpbM3FTg7ms98QNoZ0F5yjjkgDfUW6GKYNOC/ZFeCI3VcHcDHA/QG
         O8p1CdJvItYaYnYTlZAoaZAxeV1Q/hkXpTPyiHYN1yWRzRu2y2lX6FHzyqvEr56ea0sX
         YT1ECskz3gc13Om9Nc1a9ks2aEJHLDgtixRx02auryypuLYJ2vU8SU4L/7b6MfWLXNEt
         0k2uijxnTjLDDE5A9nFwUyPsaxZqexGHJCWp1aLVsjpzywoLFuje62spB9v8kvq0AgOR
         V2ym/9g2SSp+NGpOVUQeILsW7QWA2sB7FBR4+Kytb9X7xMMVEM9s+Cl5hSgwHoWNbCkg
         KIRQ==
X-Gm-Message-State: AOJu0YyPDc/ZJn2delluVKiHafwY/mYSP4kXk9uSG7mGP7bwnYjkL09/
	THB0zPL8yAtETos+hbIRkzMYI5jTYFi/mRlcJkdPxx9knP39Z6RBCEdZ5heC8gFP
X-Gm-Gg: Acq92OGCDAKsinM5jGFqewIGDLA3jIXjMpwupj07iV8n6gv3PMTPFcDkRXfTMIXG1oe
	+sJYUgLMV3Vb0JzeSx5IDsm4SNOkBMIuAcsxIeifS9gXKh6pMGiDU56gW9W0cB7xdYFL9hyS7Q+
	LDb6EGl5T+HWCWpqynNpSWk52mfoY8ye2Sl0GgcAOWBwvvJPnJAFVBFuyxOWwpPMB2O7RBZD+R4
	mbcNmbdD8avAC63GHNJcTBB1JttRpmWefnUy8Jr2XiLXJOieOjuGL6crrFG3fLD54dgGMA41Zvq
	tDvbPi/KA+HiC7zcp4Qv7wP7MeFU/RTlawD//KMbSUZhNLZGHu6Dpebb8Ug9PaOHysalrggwOt5
	Y3leDwjDiS2cKiyAsFs7OnnK2965W7LkDTMxqCNG3f5OHo0A+KVgN7XchYO2jAcWAOtgaWCfENe
	592U9CDvNHIHYbTlD8mrOqPRSeSVfoyWVb
X-Received: by 2002:a05:6870:f289:b0:43d:2d44:5ec0 with SMTP id 586e51a60fabf-44241d43bdbmr2944367fac.26.1781209715705;
        Thu, 11 Jun 2026 13:28:35 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44244cd05c9sm1796134fac.18.2026.06.11.13.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:28:35 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V12 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Date: Thu, 11 Jun 2026 15:25:59 -0500
Message-ID: <20260611202607.85376-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611202607.85376-1-macroalpha82@gmail.com>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the ICM42607 and ICM42607P inertial measurement unit.

This device is functionally very similar to the icm42600 series with a
very different register layout. The driver does not require an
interrupt for these specific chip revisions.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/iio/imu/invensense,icm42600.yaml  | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 9b2af104f186..81b6e85decd5 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -30,6 +30,8 @@ properties:
       - invensense,icm42600
       - invensense,icm42602
       - invensense,icm42605
+      - invensense,icm42607
+      - invensense,icm42607p
       - invensense,icm42622
       - invensense,icm42631
       - invensense,icm42686
@@ -67,10 +69,24 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - invensense,icm42600
+              - invensense,icm42602
+              - invensense,icm42605
+              - invensense,icm42622
+              - invensense,icm42631
+              - invensense,icm42686
+              - invensense,icm42688
+    then:
+      required:
+        - interrupts
 
 unevaluatedProperties: false
 
-- 
2.43.0

