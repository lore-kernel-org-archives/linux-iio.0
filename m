Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193AF3955C2
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779629339; cv=none; b=iltsIjO8pEXOVq33Xz8JEfC3zpPa2WpgEs8OVyCnoHJ/4N8DNVgOmTRXvB4eoaIriFrV+8urajWOgswZH37017vQ+dWgSzbqo//+7/1UMAICDU490kizKwY96A2lqxFJTQ0psliIPWx43V4p/cjSZTmxSMu2cOxlB5mp5waxCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779629339; c=relaxed/simple;
	bh=K5joXiGigHY4AX80TpszLLsv1e0MQCIb5XR5UlRJug8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTcLaUH5NUY9heQvWnzCaIUgtPmhhL0Yt8pLUwlJxdtkYyZaRt1bWd2TJ5+q4QSNf0RskhH+3fzIx6FA+62Sr0A9ZftF0RpJzz56frTOg729RDcYWpr9/Cctr+yodwwS/4j+8jZZwkesQHyRrJxYSdPJjVTaQw5XJKjaZFcg/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eE9mjigx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eE9mjigx"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba21d32776so64490915ad.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 06:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779629337; x=1780234137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewEUZMFUPji4t9hkw5T9WDC0gsus4wg45o/DJDgsA2k=;
        b=eE9mjigx21k+xriwULpq2uqzlrez/gYAlO3QPrzJXSAh1f4D27zIddoi6pPQum8mbN
         TTl7ToNWnUl/KP2DVak2a7wi/UaZL+5pwoF74GqXGkx5PWfmyeUcqGHhMuwkIuJ6jmfM
         fC3JvVe9s8BpSJJukiy1hEwaSHSvAi7C9EObjKU1S9t/vl1sIVJG+9mtaJPuou4Dd/jP
         dcNQ1QvXyUd/kIsPweyrdk2LpCTt2FxhKqcU6JOI51IkkDHVQXN0S4zNxfwma8ZY7nBi
         xf+T9BxhhCl9O0i6hR1owvcqjRy6Emy0R3wAfYUkztOuLsCbuOzDtLu0MoblUt/apOhY
         ompQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779629337; x=1780234137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ewEUZMFUPji4t9hkw5T9WDC0gsus4wg45o/DJDgsA2k=;
        b=rGQnBO6S2R8l4LIrucN0jfA7fIWtcaDX5GLAO1aOT7acqYXqfqlNi65usygnfzr4NU
         kH/XESImtRKbRyp5lLkNX4iUr+AKWrsIfAu+eNj1vIM2zWmSGQ5j+62IDaefhxZB/QWk
         E/pBOr2RwHwwOlYzVWUkv6UgtwmsabdDhBUO4x7wSJJ++nKHfx4gsfR78eqvnT5VZLi6
         whwj6SYN3cfZC2VQf4M7Hr07MWqshICyXjhrrWJHX0nfv6CiE23tUtmqcEw3djLBX+HH
         dJ2AXMxsGS2TILDKhpS9KK0QyiAcNdfW3Ei9MGdQcshZCe6D7bMI0FNutbQyojFfa4aH
         ex4Q==
X-Gm-Message-State: AOJu0Yzqqo6K+mIbyQRIl/IzKlEmEvyvewoyXN68CdAnu8th0Y9iDecP
	BSwTINlNWL7+BzF7cONDgdioS9/dPfVjbTVffUBubvJa6S2wdmFZokyA
X-Gm-Gg: Acq92OFVaDmHJHK0frVaSdMztUURTqbBgOWbfO6xScanZzzKbtTB4tkgE7BMwwRB6C7
	1hrcxN0KRbsz/r7aUnaslH+Owf7tU6y1XyopzgMhdbokaBpNYJu1hk5TuZfDoIKaoXv3iShs7b+
	ZvrpWS1yytbND0CBSyy1ArCh66toThcDkhLJUtB78lHQWnREDeWuLq5P6nXBmgNHQpEZUi+82Tp
	QGZAJrK4R2KFqMW5flEsaFYybJz5CJLF35DtdLr6/f+VGvAPKyPVtbIFVwK9zd0ZQI9Rgkn+LEK
	CVCWoPCXHNyUnL+JVhzTdh7UUGBXwqGKrejkhsxLqR6xr/yIxBwx66PnQCq67osBu7jSpAbvxI2
	F7bMj4C/NIrOp5AZmASY/tzfTpb/oOyHbvLb2fw/ajHcyfMrQgPwtqUfFujIj95czuScteVhTYu
	nge+LrKcVBeYa8Li/+4/XmPogm4fsyL5jtdTw9L/2mkULtOR4bbqCPedjzS7Ia5A==
X-Received: by 2002:a17:903:11c4:b0:2be:260a:592e with SMTP id d9443c01a7336-2beb031b1e9mr110031255ad.1.1779629337390;
        Sun, 24 May 2026 06:28:57 -0700 (PDT)
Received: from 192.168.1.3 ([2001:448a:2003:4286:c553:4edf:bb9:bbd2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56f4343sm91197175ad.36.2026.05.24.06.28.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 06:28:56 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	Brandon Saint-John <branstj@gmail.com>,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH v3 4/4] iio: position: as5600: add Kconfig and Makefile entries
Date: Sun, 24 May 2026 20:28:23 +0700
Message-ID: <20260524132824.54918-5-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add build system integration for the AS5600 Rust IIO driver.
CONFIG_AS5600 depends on I2C, IIO, and RUST.

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 drivers/iio/position/Kconfig  | 14 ++++++++++++++
 drivers/iio/position/Makefile |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
index 1576a6380b53..dab9310e8079 100644
--- a/drivers/iio/position/Kconfig
+++ b/drivers/iio/position/Kconfig
@@ -6,6 +6,20 @@
 
 menu "Linear and angular position sensors"
 
+config AS5600
+	tristate "ams AS5600 magnetic rotary position sensor"
+	depends on I2C && RUST
+	help
+	  Say Y here to build support for the ams AS5600 12-bit
+	  magnetic rotary position sensor with IIO channel support
+	  (in_angl_raw and in_angl_scale).
+
+	  This is a Rust driver that exposes the 12-bit raw angle
+	  and radian scale via the IIO subsystem.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called as5600.
+
 config IQS624_POS
 	tristate "Azoteq IQS624/625 angular position sensors"
 	depends on MFD_IQS62X || COMPILE_TEST
diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
index d70902f2979d..2d26f6d6ace3 100644
--- a/drivers/iio/position/Makefile
+++ b/drivers/iio/position/Makefile
@@ -4,5 +4,6 @@
 
 # When adding new entries keep the list in alphabetical order
 
+obj-$(CONFIG_AS5600) += as5600.o
 obj-$(CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE) += hid-sensor-custom-intel-hinge.o
 obj-$(CONFIG_IQS624_POS)	+= iqs624-pos.o
-- 
2.50.0

