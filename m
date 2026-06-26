Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14B23FAE1A
	for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490497; cv=none; b=m2N4O1OM5+PIt17QAko7iX+RACl7beSF5A5CwYhgsIBlf8pMvVoSVzapfFh/IhDjgC4ZcAG13xtc0Z/KpZZfKgwcVjS6Zr/u0BllDqM6tMjrG0GrggaF9abZ7gC8ZmyZJF/tzXWrHEN43lmLyUp9BXdXTz+j4cunt1lnqITH6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490497; c=relaxed/simple;
	bh=qWsL8L9cq1iMKYS6Yx1aLr3DUOughAfk0agu5ZwgUjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jr8oRGuoYBuDfKymRpkRGFAHm74WeC7ywNL48aseUnZEieJolG7hTAODbHgsWp+hdcdBnNHerk4aVn/GiNrQDTJV32iDBwYsUyIAylwEE5oNzAUYfPU5sZ49ini+1/N7IaWR9HYYSdJ0DZYq5amiJ/VepVmRtupi0w6RK33MtAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yfe9dYMd; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfe9dYMd"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e6dcc22cbcso888277a34.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782490495; x=1783095295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9fg6CPH5fXaDARyBWa0tR4+RNpX2W01JudkDFTpO7A=;
        b=Yfe9dYMdTNGpReBX7Uma2JUAGGmYHpBuEAhRGa0UtMf1xRV9P0vZDMoObknTawFt1M
         NyvdC5w7fH7mNaSOZx9ni5pj4kzpFTRPGiZPNFA9tKBuorbHM2Ho3DA7cn7yrLG2f1oo
         MhNv5T5Z3z9eEz17dC1D7cIWlyXJZ4MVAFJmfENOwbjCxB9sM1LIjapgghz36b0nXVKB
         7q5PHh4v0MrVNSlju0bjexZBbXonNAjrqPW98Pmsqs5chpbEK7O8b3wTwWaoBil3I31i
         UOvgo6ATOC6L2RFX2B0g8vO60VLwlIMx3O5v2sybn9SQ9nqObVvFoqbnRJvAAschPuFG
         IHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782490495; x=1783095295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j9fg6CPH5fXaDARyBWa0tR4+RNpX2W01JudkDFTpO7A=;
        b=cgMM/CDBf1FyKGlk2A7fnn7u6v+w78hjxrbl91bffQx5pbd6XEfjPx8WQXsHuE3oR6
         aiOp40HiM5mJqMHLqlanU211ZQGsSJQxPGUo+qbFuDZDHYzxid+/q9VodhUkumi6Vt4V
         cDAUCFKTND98Ssm9mTYGVY578wzkXcAwg6RcdPIKqvbWvYYwEZ+I+bbM6p91JDtyI1oj
         ffMV9/odSMmw9moaKN1IJAakDhFV/jTpv02JrA1Hn+Ms5du4r0TTaADUgOn65udGvWrw
         F+bKwoi14zOMF9znQcWAPSzNBK9RyMV4KWVpwjsln9lh80iCkmJBrR4NNCQKxmsZvObS
         hfDg==
X-Gm-Message-State: AOJu0YwfdjSQJHcPhCows45pdRnl06T7eMkF3eTY3UXGwrFQ2H4g2XiM
	1mYtNny1H5dIV24UriAjICq0uj5pNbLQSXauAgoHLdi8qY+DB6iykOk2GyzpI59Y
X-Gm-Gg: AfdE7cnnACBbEEuH3w4iAlXE+rg1yLODIY8a4YTp/8QEXmsFPDtv6uH9plkPttD8qq5
	Lbm/we8CdXua248naU378nSEbcUWgr0wagsh7W1OUorfOIbB7PWycQbPGwBQbqCSWLEXkMZ9OQT
	SCPNT1LmfjepTUoa15fWrJAfTgR0g/M9LQUqUKCxtADfgh+jwe5irbybBeoC542e276wFjIdMlv
	KUqmVRvRD0/RAE5mHp/3ZxnP4niUmJBeuH2Li3U8V3Ew4V2y17821D/HwmCC/RuT0ngirwcQNYb
	19eK/0L7l+MfO0Ms8lonfKyR0zwo3pc5ABlN2PLaPb488WcRlnYUJjPGFUwDiUfSZI3dVzxlE/G
	bKVw6WJR8rzkegPChOOUno0J+scxtmphP/Vv0os6sI0jCcZnPcWJZVnzPR9FPBl7rQcwkD5AWin
	R5OzNaRbMHpyk=
X-Received: by 2002:a05:6830:6d05:b0:7e7:57d8:a8c2 with SMTP id 46e09a7af769-7e99c35dd5cmr6634868a34.12.1782490494903;
        Fri, 26 Jun 2026 09:14:54 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa579235sm1970211a34.1.2026.06.26.09.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:14:54 -0700 (PDT)
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
Subject: [PATCH V15 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Date: Fri, 26 Jun 2026 11:12:23 -0500
Message-ID: <20260626161230.93069-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626161230.93069-1-macroalpha82@gmail.com>
References: <20260626161230.93069-1-macroalpha82@gmail.com>
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
very different register layout. An interrupt is not required for this
specific implementation and is not present on my test hardware
(a 42607p).

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

