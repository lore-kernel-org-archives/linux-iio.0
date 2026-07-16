Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33AE431A42
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226546; cv=none; b=Aojvu2mtc+0pJcWbzKYn7r/nMVcEjZ1xPTo0lN8c6sUJRXydmSf5lsK6/i9pXQVgpqINqG/0/5TkKJNunKXMaqkm6FVls7StFpMSB08NkkQpLyh5JYPNha7o1u7mQSqLDFqIMQAMNEvkXt7Yvfd1mqZXxHXq2OnSpD5PclSNzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226546; c=relaxed/simple;
	bh=O83F5mb4uMnJzmc2/msxYxrX+19vruTkQvaEJ7jBfs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXFHLaYruetCfYtsBoJwqUnmOTPXy1r3ngt28idy7OFovAmWsGiONDG8cfGfLtatY8itKHJs2xLdftesWVUpskfRQTLVocvl0m7n/m/PRFdJf2O/9wtgjPlS+T0+foj6uAd0qcPzAT3GozMq9n8fqKHjUKi1nuaoLn8oSZ4QZmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJYsl5nc; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJYsl5nc"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb68bdf53aso2792766a34.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784226542; x=1784831342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zeav82c+zHUEfGFTy6EKqJYIkUOVt3UnaQ/1FR4S0cQ=;
        b=iJYsl5nc/4wZQlij6A6Th/CJCdSW7FhLLvIJvqiR+V1oZ8soz7JOPIQc0mVyT5hpHV
         vrmNwz8zioB+UtKZ2R8rTfP9uPCx9OX9WH2ZqyfdaglLTRuPqZpWtGuMLXzXpz5Rvt2R
         xjgNkCARyhofE4KGZ98o/4nYWYOBInyKDrXp1VA12W4r9X7VF4ZDUEAhtdk0xhi/U/yR
         WiwqVIafbFoIIca8ou9qxZv/LQJS/GZg2ZtSPHTDfUrCiEmlj3BDqlX9D+Rlp3AtmnE4
         mwhPuFiiqhlJHgxgGgppEC2fkvkYEXVucvTQi/QS+1R2IiBr0zACqeiZR2Ji7qL9pXvZ
         pFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784226542; x=1784831342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zeav82c+zHUEfGFTy6EKqJYIkUOVt3UnaQ/1FR4S0cQ=;
        b=Cgh3qHLXhDZJgyKoORv8h5r1iX0mqxr3AzBHOGPDKv90S+43Y0ntZAV49rH2J35z/L
         nc85sMXhCZBvoS8FScNFQcpem9JqQVNZi8KIttytkQjyl3ijlWWSfNlIeWggLHILF55+
         MpycyzZjVt431lhjB95YrfDSogtcZMcmuaBK9ZY1+v7iBvfL2u7Rm62lsWNS2ujtj034
         qBj8JryTW77AKe/HukRmWZHSPDdZiQQqf21CgVQVooGqc/OYg28CSrkB973oW4nPk3mz
         CLmgmmWcswRzVHKzStWlg5SUm2DBrAG4MPm5NmoZ5FrjhpY1gU46Kk7uzkqa2Jm+gcBA
         4BFw==
X-Gm-Message-State: AOJu0Yw2DfF+smf8o4hAizwpsPpkzPhrHXqT8kLV5QQ9fV0Qs4WcB6+x
	cHK8JCyN+/jM/6nsg06U1qGN2lMMt2k1MUQ0VLINflfHDnLQnlvhyeqjcA0qJQ==
X-Gm-Gg: AfdE7cmZPZh/shTDFgqFR6bXoB+IJQKlEef+VhfgUT1XQtQwfhjWk3VNTY6T74smD6/
	QwXXiOl9oNXBTJRUhuHHL3x93GmPLQ9RmE+vqFEfUsSLvsg1lfGdbGMOjodDfJ/QPlbBl4YkKie
	78IqMkNjf7r63QCCGWbcBhbWGx41UkuZ9iCDwlaTgVb11XaKnAAdPBuOB8xXvZuVfydiI0SL2Iv
	tKYykQBqy1UdoqsrIgbdNH5ih6DmMAMvwfKbHCGG6nbXVoO/oeGWatLL5v35LfNp8id2zOiCzuY
	/P91DAgrbvkFedMTOXRyC/tSHBk9wfFqLKwgLYeBKyQ0vUQUd+ol90y0SEVb1vzuY8reLyUwUVb
	XoVWUVsKHPWJkHFag0lqMOkvo0ZrT19LklXTuzngM2XvBj1K1JOYNV++UvVLjvUd+hv02tsZgyi
	vj
X-Received: by 2002:a05:6830:6aeb:b0:7e9:cc39:2ef0 with SMTP id 46e09a7af769-7ec59cc5592mr5016777a34.18.1784226542136;
        Thu, 16 Jul 2026 11:29:02 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f6826sm19939993a34.27.2026.07.16.11.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 11:29:01 -0700 (PDT)
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
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V17 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Date: Thu, 16 Jul 2026 13:26:29 -0500
Message-ID: <20260716182637.24310-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716182637.24310-1-macroalpha82@gmail.com>
References: <20260716182637.24310-1-macroalpha82@gmail.com>
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
very different register layout. The icm42607 currently does not use an
interrupt because wake on movement and buffers are not supported, and
cannot be implemented on my test device which lacks an interrupt line.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
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

