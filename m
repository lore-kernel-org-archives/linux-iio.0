Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD89034751E
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 03:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780111219; cv=none; b=MZ8UXGX6pAWFH++1s2SO7Zg/F9Zga26wjCzW9oNr1bbu462/1YcfAbjPNwn51mRGOsT/j4e1xEx7YzTBtcIw2K5e1s/Tvag/Jz2JyC+/nYomymCEN8OEYvxv9bie379IExTbhQFj5irdUKIFcwmCoBnBavNe5Tqegkt5+a9tqog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780111219; c=relaxed/simple;
	bh=ali3E/hg4vHn9UGvEzEP5oXdYNgAoPZKzEmBLchdxhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9VdXP2Pp8NNBEAZSKdLgviYPPKhCficQsALKkYubb1A+9c38GQCv4anAGOpnOsedvX3+qpl5sG2hoqeWg1KTxKVFwOGuZe/CAvvZHlMNNMeeXS1JuCjgOXXbcspHo9UD6v5U86Vtbj6JsrG62TcrAIZaLOa0xcDl1I7HT9hAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1TZ0rX0; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1TZ0rX0"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69de16f5e80so1866915eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 20:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780111218; x=1780716018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OOgPw2rPQflxY/7r5kTsmWgQ4SuB53Q041epg5wdLY=;
        b=N1TZ0rX0dNW3vA0UXV+vF0R1Q2yY6R/OzQz44iseOpmab3ac6Q6jaVrq7nWga0RE1I
         D6ZLKJwGUMWcJcIp8iCuFZjEa2vC1Zo8InfH277s9vY51w9YB5+jhnSf9ez72WzeCS/W
         1+EjwVq2HQDF+k/rb2vwD8vbXqb4sKZC5MMxydQ54OsvAqjUN3dnZLvfiKYy0AQo1ilt
         SiKdj4awCiWZYe0ZIy7p+Zh1ANGsxhS+zRH3rH+r4WRatSlA9rNi4Di8oFb3me2psk0h
         MSPYNjVYInc9T/cMrc3s+tpGiUo55Yl03oalQtStg95WSG6N9gfCMx4qEhI2ugw1NGMD
         HK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780111218; x=1780716018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8OOgPw2rPQflxY/7r5kTsmWgQ4SuB53Q041epg5wdLY=;
        b=BgcaIX8/nBBKW7QoXIMOzUGWQuabTKdOqG6Kl/Y0Xjts55NwZthFDaspIgDxjYhrJJ
         LAWqQCRV6ybgWC06IugWay7NseBPShP+pUYdMBQSel2uOqinp2vkIer23cALP9bWxubv
         Dq2dkXr+S5y/nUJiG3XHusJTZlND0GYGiI4sbPpaSdjDi/r3O0tY9+qTAxuDITpX5Xxj
         MaW3OKzm6JrtrDY/8bBLjA7vn5wdLwzjCUQrQ/Vab6dVpfWYWZ7aKgWYAIwCGcX3xKso
         OgqqaBJnqDBwdOpbVjFnKzmI4S5IVvMq9iWZxHGympa6nnC/Qx96HpIkAjdL8P1+jMGl
         VuGA==
X-Gm-Message-State: AOJu0YwhFU1/P89AyrlkLrVXxe7uiycXbUkjlI6TGwsWYW5zLzAg0o3y
	N1/gh0zb10RySu3r7BBYUVqpT0dTK/3mcLe8RHGWe00mbGkSsz4UfltVjFHORutN
X-Gm-Gg: Acq92OGKFzNhMnwG+Xbpz9kVGWwlB3NlvySSWDkf5tNde4aTA2evW8uB5G0w9YnPyxH
	FxFoE4NUH+XZ+qWWjwbX4PT/VHTQJ1ubM8SSTc1h+p65AvWcKnF60B/hL68y8srTXBlo9wF4q3t
	2NyiGJPiGlAOA7AcF1L6hBMgrwkmsQRiHv+AuDlekIG6tYUmG6Jvb9wYSipPGE4u7s18gOs9iVZ
	6OSw3X3f4542KSfoWxw6mAbKXnSFnZOT4Pos6H1Pd0aw+FcW4y3aFoP3yU9a75sguedKTMUA5/n
	DZ1+3rbeHmkJ5s5y/CFlW8rTkU9BQJ9QPugnKrpSFxn8IrQVVSYAQFiJyIXZ34Mgx6F95tj45qe
	4enFpOJDL605cZEWteiFeIu5SkSnemOFe8o+SwbnB3XMqGcLwx6vjjaEPwK9ZHSffEANnqmJJIv
	LjpVLh2R2PLc8esdhseuK8nRUFJiPBeHwuRm7doOG1mQ==
X-Received: by 2002:a05:6820:2018:b0:69d:86a9:16da with SMTP id 006d021491bc7-69e103089femr1088667eaf.25.1780111217650;
        Fri, 29 May 2026 20:20:17 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e067e911csm2130737eaf.5.2026.05.29.20.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 20:20:16 -0700 (PDT)
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
Subject: [PATCH V9 02/11] dt-bindings: iio: imu: icm42600: Add icm42607 binding
Date: Fri, 29 May 2026 22:17:29 -0500
Message-ID: <20260530031739.109063-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530031739.109063-1-macroalpha82@gmail.com>
References: <20260530031739.109063-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add devicetree binding for the Invensense ICM42607 and Invensense
ICM42607P inertial measurement unit. This unit is a combined
accelerometer, gyroscope, and thermometer available via I2C or SPI.

This device is functionally very similar to the icm42600 series with a
very different register layout, however unlike the icm42600 driver we
require a interrupt-names property be present.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/iio/imu/invensense,icm42600.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 9b2af104f186..475a498207f9 100644
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
@@ -71,6 +73,16 @@ required:
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - invensense,icm42607
+              - invensense,icm42607p
+    then:
+      required:
+        - interrupt-names
 
 unevaluatedProperties: false
 
-- 
2.43.0

