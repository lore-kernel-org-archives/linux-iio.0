Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2F351C3D
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114248; cv=none; b=IYdDhuRiWTjU2qiEhELdJB5ylXG00W9aaYVgCt58ymx4ATnm/JHhvoS90i53tuz4fIoVx7B6mbeFYTApFsYZnvN0q3xMlpvmB5rEITcuCi71THkSai8X3rh6ZkBiP+xfo81qFKABKJR0e06sKxob7lMD4iAOAX/BzV4Ry+wWUVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114248; c=relaxed/simple;
	bh=fMKaNCHqvdnEkQNOcz/+Evogzl4yJdpF2G3aArECXqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikkic/2hN8nGZgRMxCpMJxa1oVbcEVQ6yHwWTwVxM5LnV/xrTj2cTSQ3sP2eVpCeDbbHZk8hLSA5tTHoXJ+NMJqo3vBE6zhFpSUQwOLPYBp98vYX1yCzb+WppOKMCj2TZnMoHVkclH4PAhGIjERzu38aRJWXG99/nGWNXJgjb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ4qCFJW; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ4qCFJW"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e6d991991dso5973702a34.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 10:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781114246; x=1781719046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG46e6wh0vfo+H1QfKvpne8/nrh3wipAUO48FCP+P1g=;
        b=QJ4qCFJWtF2rh27kcRgTB51mShC5m4HehjHsRdv7wIF5UD53F2dR/EpbOVTcTfusZv
         uotXBMhwizFawkHhTsgwZhHchPfpP8A+glOB4tYLmc0At8nhXDcVIDR3fO1nQ4b3JvVc
         vlilqUFBsgcrE+clC+iVb49Pd1AQ3AMyHNKBADrweECC45nGdrFrxo4H+Um51QsvOqzn
         zv93h0TJtFb5fEfqp9jgAN1kWEtIqywkv8uqytsCxjT5FqzAj7ekbTmrohn6bRxjVwjC
         puALmye3T+AnhrljzF4hfKF3Q56ZbbZ7F42flWHlH/++0nyB8rKVMhySXbdhuF14M1Hd
         cf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114246; x=1781719046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AG46e6wh0vfo+H1QfKvpne8/nrh3wipAUO48FCP+P1g=;
        b=AoPDNoEtZir09+gz27ihy+Q4IdeMzA6ULemSUYYHgSR5+uKhEDNdFRXVLMpRXSUrmb
         o5hbtu0lr6XPVp6IR/LjzAM/yiHf7Na+NWhM5bWhN81vV+I5QDgRBPPGv+ALJKY6smHo
         eVFcfgEH+JHmEB5F0e+KpPd7lW+4YHHiPVwU2i4KgDjSwzcoPKA8+WWsNCjkfBmF/PNf
         xM+4UPh4FJbWOcW7+dDv04uGRuWqNc5l/EB64cPvfHTnZeNAjOqhOJllixkGSaj2dS5w
         DKcXzMN8Y1T95fJHqKSfLzUN4mj+kdWtXJEp7fveV+P+K8ErRYW+I3ienQHj14ryEhhl
         7vbA==
X-Gm-Message-State: AOJu0YwdHq6cVZNqUKX539MSIzWyVqzMfVnwfzRl93H/hFKKCPGYJyZH
	5iOOA19YdbBZYVMWRxHxTKq0pGEbRcyd2QJPlo+pEfHMn0jV839FMJllD/QS9A==
X-Gm-Gg: Acq92OF1dys3tLk3q2lVyUCNtOntp7HSBVEEQsJUJQ0nM+mCOpwnc1hT1RYJZkl6bA3
	tjcGTPmj6D7njZFo88VvsMauLqGh4AkLbE9wv8Pc1nGbuX03IP479XPSKaFDQotEHV+psMCQY8g
	ix2AuVFP/HMUJFcKA/uAKVoOA2APQoa7mERWzVGrrjQsn2ynXGQ7zBxzOEFxDs3+fhFV0bOVyTB
	5xspqWdCZ7kDVp9DmKqFWlzHuYwpNQMCJbSuKnx2Phj4G0OCQMxq2YPsrw/PsvtkcmXN6ot5Jtl
	Op2v4HR9RvnGUrgisPUp/An/fqwxqDr2znyTpAme7JP6CSPNLGbFVn9kG5tOPa74//+9XnGpKlG
	6yLDdpsoIfiQ0aNF+RjijomwNr/hVxd0py9pi0EuIzqUGG/jzIemQySK4MPxl3DDimkxv+2cfcg
	biLxDhJBLhcg8/sbvzaa/sSv1wc6QIPXdG2evn0CK2qdaZ59Rv/7DZ2A==
X-Received: by 2002:a05:6820:4c89:b0:69e:283:abaf with SMTP id 006d021491bc7-69e68c07596mr16296123eaf.32.1781114246148;
        Wed, 10 Jun 2026 10:57:26 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:b86b:51ed:28ca:695f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7d4f449sm21180794fac.8.2026.06.10.10.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:57:25 -0700 (PDT)
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
Subject: [PATCH V11 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Date: Wed, 10 Jun 2026 12:54:46 -0500
Message-ID: <20260610175455.19006-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610175455.19006-1-macroalpha82@gmail.com>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
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

