Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520C5187DE
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788349; cv=none; b=Tesw5mZ6iCTpkCtKH0e8x/GD+adzteiOtnnrCh6nYTC4r7fMkcgKehGis8GQGYTrSTaYY1R7bFhlExE06ZvStjCVj4LPABd2ft4Hx+zJA1VWcwUEbDOVcHB88XdiwQXutsFZL3CnYW7STotk3yibG/WWr+ADyA6tiOLTa/CRJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788349; c=relaxed/simple;
	bh=Xvm4nW+2P4F0n2X493r3Kfa+UVebUnUFiPYaF5DZ4z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUWA8sdM/0QMZwvv+MDU4/f4bzUHDOxO3Vd4ws/Eyyr6jIe3Tey2ena57XLT0Kwac4CoS8Tc3U95NsCom5MDNHI6gtZ+Kooil7oWkktW9SDXRkFaiXOSIzp7B+doo/Oekw/oFRTgZ53WNnMMtUx7xxkr+IqVFr8qIanr8OGs9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMvqhd+2; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMvqhd+2"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8633a38df87so2405849b3a.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790788347; x=1791393147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=refqYpnhzgPaSHSNEFWOu6CJsyfTdwor7wN0Moi5irg=;
        b=qMvqhd+2ql8NSOMjioqrA6jn14+/vaYJ5Hrov1rja2UCuF5ypEH9NWcl31sPcqXRra
         5g51QyYJkp8hMwrF0UpumP+cPIapyT0veM92bFZ1NegM1bIs0lvWgkG5PIrgbAYvoFff
         bybDkOukqZUgbk/cqTTeKuxoxW1/iKC0YpdTX9yiCJz2n9igi2PBkLZa68fctjYSMQnj
         5k2TFsWrikbBaRH6t4DfeYRYgEiDKBKYFBkuQhterLiNJUsRYAW9D/QAC0mUqtScMulR
         /BH4alnmoXSqvME3Cn2zXIOkJBxa/SAqf6/4uEwgEr++hNMyTZxWo+kpnpsoiRDX4a4T
         2MbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790788347; x=1791393147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=refqYpnhzgPaSHSNEFWOu6CJsyfTdwor7wN0Moi5irg=;
        b=nqHXirVPYhMTt11ZT+zmUhMap7Q2hC5zpbVg1UQBkIlUhVtVjDISrznXmQtVptO2bC
         Gh3o1NiB0pNTwOD6nyXpeLNeHVHBe070fWu8bT+2g0NERc88uc3avEXEK7m/key8GXDV
         /6K189nMlDFcsk30y0j/7r53hnY7Lq+QEa6QBf69a2yED1//+QXaHP1gHHuJh36h4OoR
         3F2qnrTvFFPt328QNWfZCaVXK2YBz4ZPMVEeX2iJlUThzwG6Ofm8XSbufD5rtcQ24AhN
         AvEk4wD7EY/QzA1XE3jxV8IZ2p3Vb386ysvnB4VieaJyu1C45m8hoZ/F0vhTyAlNj8X1
         m7mg==
X-Forwarded-Encrypted: i=1; AKwUvBwhRj3sZOg0Ua0U76JPoicDeH+pO4nAgIwWHmdUqlbVo1KUvXIlqMLheOSNpmVlYaThEB5uGbbCYi8=@vger.kernel.org
X-Gm-Message-State: AFuF++m8rzn5Sy+pm7+SX+bS6dltC2Y2SQ0PO0TIoKh2TUVz88OTcZKr
	IF/7pDpYqNXcbJSRqzTOP+PHu59M32zFnj6ww48lAQRhVQQBj/gqZkMheeJpphIq/2w=
X-Gm-Gg: AYBFou19rG7qcAgvKEAeejFz8Fe7djYmscTLxaTJgXS9/QeKbWQsc3qg3ndce5Dmx+M
	ezCVqwfjWfAzLzYaKN4nsCP8jsvjydivQ0bblrPNyMm0TTbg8cNvfmZyhziES7X2KCCOBVNOP9v
	z0PE5n9GJ0/v6HORfiNh0ZoynbWE3mMas3b+OSyFdA0QIO6BX6t0nfSYjULAK79ApE+lSDQukOT
	0w7Qr8ncsS8Jjjwr2gr+eDaxPCvQbdO9gK7XZ76Z0bWUbL56O4gQNoU2Fpno7XqxLhuZVySHli4
	Rqp954knonC0jzczOVmyCQU60dcBDP99fHa++7k8rOxaHEYX1ZslysycyEL/gJSYJYd0JNQWaoQ
	wtzgr5pZ1WeQELVyUJalW0So/wJr+WF39WKDKhVwO0BZRIlq30yMaw9dXsLD1KBkQZ2H4JpJDrP
	IBhDNy58qVLLeQRY449B0yq0/ILkc7d1TS0Dv/ovLiWAfVI1FJ9NcqIpLK/jq6mm6YlVADMzEbL
	IonNblkCp6hncKbu2oQYsoHdxmpyfVv83dwqI7plJtJaoAS6zk=
X-Received: by 2002:a05:6a00:bb8d:b0:880:8c63:657e with SMTP id d2e1a72fcca58-8874d77fe18mr1519487b3a.13.1790788347310;
        Wed, 30 Sep 2026 10:12:27 -0700 (PDT)
Received: from debian.ari ([152.58.182.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887bc2bd404sm636872b3a.46.2026.09.30.10.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 10:12:26 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v5 02/10] iio: adc: ti-ads1015: sort headers alphabetically
Date: Wed, 30 Sep 2026 22:41:56 +0530
Message-Id: <20260930171204.12863-3-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260930171204.12863-1-architanant5@gmail.com>
References: <20260930171204.12863-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder include headers alphabetically to comply with the preferred
coding style and improve maintainability.

No functional changes.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 93a165c5416a..ef03b74bda3e 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -11,24 +11,24 @@
  *	* 0x4B - ADDR connected to SCL
  */
 
-#include <linux/module.h>
 #include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/irq.h>
-#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
-#include <linux/pm_runtime.h>
-#include <linux/mutex.h>
-#include <linux/delay.h>
 
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/types.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/types.h>
 
 #define ADS1015_DRV_NAME "ads1015"
 
-- 
2.39.5

