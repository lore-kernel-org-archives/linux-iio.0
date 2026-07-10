Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88728347FC4
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693341; cv=none; b=iXmg6QwztzNIdYktLTh59lUK2l93vENyiD2l0PkXa2otaX7AprCAxQyezPqSY3uo0G2ZAfP25djeEdVnucmih55NjcneY4O+Trv7ubgBVGTL9ztza1fyE0a+j7Tkqfz9YwwuyrzwXT/luFkuoKhONV/UMScAApwJB0d+PJ94Eb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693341; c=relaxed/simple;
	bh=6hgT5DK0oOq5/Wsou8lo8FKxq+iZjqEUc+JvtN+p1Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OjHj7awuYc6BEQElqIZvbN85sZsalEytghqqe8+JtRQzkN9o/Q8UgMYZ8d+SWtWuyHQuKj5EM3oRwd4G0rUI34ap73WAOni8qz59EU1GwxA+gK7MOFRIkESQJtA13h19m5ZnvdDx8gwaD4uZGr3OY8wOWiMlZtwY8dRK2pmliuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koa+HvEO; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koa+HvEO"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso648935a12.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783693340; x=1784298140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FoLPitrFKeUob810vvgoU4umxRfKuy0C/dr9NicwKbA=;
        b=koa+HvEO7lg9XcgkLN2/bl9mT5SeCgfUW5Wm50PElj0/sM7MUMXn80hRtUaLko99WZ
         mfZQtFGnh7XSERhoNftFrOx6u56h+Z2o1ct913mI2bVIv4TR5XFrqNimv+xCteqnhrd8
         TyqqJlgx3VVyYclVUidRgrsAt7KoXkwSVrxtUBaTEYIMitTaRz2OUs0kxPJWFfvFQkzK
         aHmsZPcWOga8y03UvuAvRS1uRg7T3hTAWMzOlFmCntmMEZnNFZT7QAxP+MMxZsBk1Xaw
         POwfKz2AWsJc8l9lKN5lL2MXrfvPm2RpriW1JcVmSuTdxHkm8a494oaUQJMhOf6Am93s
         ePlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783693340; x=1784298140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FoLPitrFKeUob810vvgoU4umxRfKuy0C/dr9NicwKbA=;
        b=MtzOCICbxu0/iUmPrTVPHThdVFfEZ9an6eGngtkTmVcIfk/Ynm2OA3T6bPpBtR4nGL
         fQycUu3BbXWn2s/2hFrxQ+u1U/HcarVSklxopJzV9IMQHq4LRzXNoSSQy+V2ElcbyK1z
         EU6ZJ546X83Mnp3VNuL5XkIVXvOcyGjr1HJ3hQM5RVjwMVBzWa8i124C2dUCz2CNNADa
         yEtaYWl6KhMOEDCLE0J1YNo+fLno7eftbxTGiH1c8o58Zrbo0rAzbYt/juch7hxY+p30
         zv8hoeLNFyOHNZBdn5xIcqAc8Fc0qQ81AZ5reMkGuJywj/obu63XXJOh355GwcNmAoRV
         gLlA==
X-Forwarded-Encrypted: i=1; AHgh+Rot3zVNudx1mIZslrNvXXu6yK6tG0D6C+vIaFnlxe8AFbPiW4HFwmhgFOw3VA39z2VJeg7b8kqqC88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTBowyebDX3BXvnLMXGfemzi2NYOpQmWGVb9OPRTd1U3AFnHOY
	H5WzoJllZ9ndARzetBGzGeB+8/ojpdpPi2kODebRlXJyXzZbjPMw3ZyQi1/eMri4
X-Gm-Gg: AfdE7clZKOjY3oR4kS7m+UmaeAxeOmYbBo820UsYAF57gILEJibTMs5QmSoNF9635Gp
	3VkT0Zt+SP9LDjV168IkUJQya+AP3bLizNaN4q80jwFammEWGFJ0eM8/rCq6pKL8S/ZJypGTTn4
	O0x1oZvHw8ynUo+kh+ijWOa/u1mC6WSgYnP5C1dbSLShoyd74elEzytLk1rLRn0Yz4Q6NxuqTmr
	urCtTT7InRISQDIgF4LSl2eA08APtwTJlABvv+1W+Vng05JJuxO9hysl17OzyXIVfLzMIOCoU55
	wjifpbvza/9ZqPLc28VF8mhHOJpq8f5e5NEnK0zO+eCh9awHUrc0+SKHtWPwT+CxMaDlT2lUpip
	JOQitjFwQ0qrsadwAJo6FABP6gPQC020GTDeBKcYU0BOWMzDVUXXFPquWZA25ocu946RN5nTgJr
	69s6ygWXmzAboTTGnaYuz+bvtykXdwSgcWuNrWeiB4rDTKo+MFZUNQpoY+sVbR1w==
X-Received: by 2002:a05:6a20:a124:b0:3bf:b089:c55e with SMTP id adf61e73a8af0-3c0bcc23bbfmr14504856637.52.1783693339957;
        Fri, 10 Jul 2026 07:22:19 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:5177:3103:5737:1752:bd47])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm45575083c88.12.2026.07.10.07.22.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 07:22:19 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iio: proximity: hx9023s: validate firmware size
Date: Fri, 10 Jul 2026 20:07:12 +0545
Message-ID: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hx9023s_send_cfg() copies the firmware into a counted flexible array and
then reads fixed offsets from the copied data before walking register/value
pairs starting at FW_DATA_OFFSET. A truncated firmware image can therefore
make the driver read past the copied buffer during probe-time configuration
loading.

Reject firmware images that cannot contain the fixed header, reject images
too large for the u16 fw_size field, and validate that the advertised
register count fits in the remaining payload.

Move release_firmware() to the callback so the firmware object is released
on all hx9023s_send_cfg() error paths.

Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index a6ff7cbe9e6..a2f9c077e58 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -18,6 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
+#include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -25,6 +26,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
@@ -1031,8 +1033,12 @@ static int hx9023s_bin_load(struct hx9023s_data *data, struct hx9023s_bin *bin)
 
 static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data)
 {
-	struct hx9023s_bin *bin __free(kfree) =
-		kzalloc(fw->size + sizeof(*bin), GFP_KERNEL);
+	struct hx9023s_bin *bin __free(kfree) = NULL;
+
+	if (fw->size < FW_DATA_OFFSET || fw->size > U16_MAX)
+		return -EINVAL;
+
+	bin = kzalloc(sizeof(*bin) + fw->size, GFP_KERNEL);
 	if (!bin)
 		return -ENOMEM;
 
@@ -1041,7 +1047,8 @@ static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data
 	bin->fw_ver = bin->data[FW_VER_OFFSET];
 	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
 
-	release_firmware(fw);
+	if (bin->reg_count > (bin->fw_size - FW_DATA_OFFSET) / 2)
+		return -EINVAL;
 
 	return hx9023s_bin_load(data, bin);
 }
@@ -1058,6 +1065,7 @@ static void hx9023s_cfg_update(const struct firmware *fw, void *context)
 	}
 
 	ret = hx9023s_send_cfg(fw, data);
+	release_firmware(fw);
 	if (ret) {
 		dev_warn(dev, "Firmware update failed: %d\n", ret);
 		goto no_fw;

base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
-- 
2.51.2

