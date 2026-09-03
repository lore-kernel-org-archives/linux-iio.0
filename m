Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D70368D66
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788419160; cv=none; b=r50Ya9cc3hliYd8YVqVbsGYau6hMdgx/rL27vYOxiJRCa3frUJqSYm/3GxFr1j/sIrAenjNwtJv9Jhaz2Xy+oQA2qudYs/PpIUEd/m1cP222TJ6h2S1rE6PTt2GZxYc/Gl0XaFQljdjZTluRKRweNuxNxlNq+XTqz01dV0xt6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788419160; c=relaxed/simple;
	bh=h+V6qAtLqeW/WU/IZPbSmtZFHj0DhMBYDtjWmrniU0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HmleneMQvqL2OdNCaKEaNTEP17/sR6k4ZLvqmmQXOf4efWumLUtZT160xHK7eKD+gC3AKKhuQEoLsskDRHbBJcPjl0uZ0rK33Bpxo5u4xEcePJiJcfTc2KsYyLfKqKCFXbfSq5rXn2wsYZrs4tLPCXqPv/EJap3g5v1m6awIjhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agoXyZ6G; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agoXyZ6G"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so2148163a12.2
        for <linux-iio@vger.kernel.org>; Thu, 03 Sep 2026 00:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788419154; x=1789023954; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AR8htrDl8qSqroXyJFh5dXqeQpCBckfru3AXsX4Pm8E=;
        b=agoXyZ6GRTL1rOux0yJMK1YpjkKmWZRX1gZnFsc00IBxfp7hpkHvY4Xhf9SmiIL8OK
         pGfIqcp0eFor2kWcJJqST841DNTvPCgUiaORo87QuVYtUDKt3Oc2rgS12DIRX4/BuDIM
         wl/xgWTiCdbpBkVM7rfrajiLGq3AYq0Eqwe64HTEJlV3AZYgKpvDHEhPVNkn7KXhau5M
         gJ6ApEukrOVbW2cvswfGwyLY4kgczhQNqXWj/iHQwv8h8UCpwz2m/OAvElu3l8SePD3y
         kIyMXVu38l0KX0/dZqPeP9Vb9dD1k1X1QW7+IRU7mppLWumYFW7Pz5sitVzXHNowN6cQ
         xnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788419154; x=1789023954;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AR8htrDl8qSqroXyJFh5dXqeQpCBckfru3AXsX4Pm8E=;
        b=Epyo3BNB1e3HNLLJErULWV/nNsT1Kez35dgctzi19H+2PskzVrU/p75BRNyokIMHRA
         UTeAKqkACMHHSkFAY9wPVUIY62GUzcvJJWFnuKo3THXBZ+0B8iVxEvfmVr+XB0WiPuXx
         F3icynL1blTBp8JqIWY/iC9Fr6zDGlOaLgjq6UBVkMz6Y9ZEna9yC9wZJJnX5bDHIPI0
         xygjjou63FVfLh3BvIXXhzJSYBuGdkFRGE5DZzpMZkde1KeurGApQrcxo+JkPfS2aynn
         UdhNpgu/+XYBpwPVQ+P25B0xJOIof0i+i2IMS8i3Of1TKitDAmCdpzRvBv9qUXgrMAQj
         fK1A==
X-Gm-Message-State: AFuF++loHfFp9ARKYYmPGj3awVSljOIkpPrtGvJrSaqkpj7aUxYaAaEo
	DvWMIPKozwh7XZSY03+V5Ls1ezBtqObB43woXXrHnMzzY0MAfSb7qdG/
X-Gm-Gg: AYBFou0JtWWb3noV489AYeuqYJXnTrowXc+57+0zty5+ZUR4PnbrO1Uha17qVB4dJ/i
	YNeW1cI/0+P0e1sUImvxeJRIC7b4NHXU0XyznSKwjn2fAfFGwk/D5o3X9I9V9raovUJKQErBNNT
	fBsDoTUtrVgPTgTMaVrpdOw1QFdLJVTaF3r93kOeO8P6WP7LBYrGKjQ9p+BFf0Bo10Du8wZbAax
	Zik0nZx/vYYDpsh0+6TF9Ueudkt+XptzZWT+IItEAkIDC38Vnyi+8VIM1D05bxgSUsVI5bPdc+N
	Vp/BxranmoFklkFEFgZ3Evd1K2d4Z51QMmEpf1ouRiMDLZVC3SIfEFVleKLY4qnnPZkyk09ImVB
	aBoZGBAcLphRm0Y+Hi/FPQYKcuvnCjE6gWHwjaTKzhocEtSNGgRQysM2pbA0Yuh1E1crSs6O+tp
	PUwJDg64rHb+d3TURLF1NHKj8qbpKh/UBBstXw8gRQHj7Wx/QcRNz16+zRp3eeHBBBKeYEEUste
	81l7GGGwS8wVWpGge12qGJqHrmyyJLxaFBdlQ==
X-Received: by 2002:a05:6a21:1145:b0:3d1:be60:2816 with SMTP id adf61e73a8af0-3d9ad47baabmr16383423637.10.1788419154509;
        Thu, 03 Sep 2026 00:05:54 -0700 (PDT)
Received: from [192.168.20.42] (115-70-157-242.ip4.superloop.au. [115.70.157.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc43d4110aesm513114a12.20.2026.09.03.00.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:05:54 -0700 (PDT)
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
X-Google-Original-From: Tsz Shan Chan <tchan@jacques.com.au>
Date: Thu, 03 Sep 2026 17:05:35 +1000
Subject: [PATCH v2] iio: light: apds9306: fix default sampling frequency
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-apds9306-v2-1-e8673986ae56@jacques.com.au>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MSw6CMBSF4a2QO7akDx6WkfswDG7prdREiq0QD
 WHvVsYO/5OTb4NE0VOCrtgg0uqTD1MOeSpgGHG6EfM2N0guG665YjjbpBVvmCFrsDVtRbWGfJ8
 jOf8+qGufe/TpFeLnkFfxW/8gq2CCKXfWErFyom4udxyeC6VyCI8SF+j3ff8CLxe9RKUAAAA=
X-Change-ID: 20260903-apds9306-bedba7b74e59
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Tsz Shan Chan <tchan@jacques.com.au>
X-Mailer: b4 0.14.3

APDS9306_SAMP_FREQ_10HZ is defined as 0.

According to the datasheet (Broadcom AV02-4755EN,
https://docs.broadcom.com/doc/AV02-4755EN, page 11, ALS_MEAS_RATE),
bits[2:0] set the measurement rate:
- 000: 25ms  (40Hz)
- 001: 20ms  (20Hz)
- 010: 100ms (10Hz)

Change APDS9306_SAMP_FREQ_10HZ from 0 to 2 to write the correct value
for 10Hz.

Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
---
Changes in v2:
- Add datasheet link to commit message
- Remove blank line in the tag block
- Link to v1: https://lore.kernel.org/r/20260903-apds9306-v1-1-3f892aa4f156@jacques.com.au
---
 drivers/iio/light/apds9306.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index f681b02e4922..7dd41136734f 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -61,7 +61,7 @@
 #define APDS9306_NUM_REPEAT_RATES	7
 #define APDS9306_INT_SRC_CLEAR	0
 #define APDS9306_INT_SRC_ALS	1
-#define APDS9306_SAMP_FREQ_10HZ	0
+#define APDS9306_SAMP_FREQ_10HZ	2
 
 /**
  * struct part_id_gts_multiplier - Part no. and corresponding gts multiplier

---
base-commit: 940de590b839f71d6dc846160534bf202401b8b7
change-id: 20260903-apds9306-bedba7b74e59

Best regards,
-- 
Tsz Shan Chan <tchan@jacques.com.au>

