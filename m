Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E05D233134
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846075; cv=none; b=aJRr0O/uG3MO7SkO8kiES3FTVvlptuMS8ScdC0SAVepl/T0sKbFbXDJoHz2IQM8AsG+AL7Q6767go68ktOw3D7PxaLbj4dlHu1WSCb8lEDdi+1lCVq9X/jbUJsONH3cwIRw+0vSViqGnKVLsYpv6DKSO8K1TI3DCL7Fq9fJJeuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846075; c=relaxed/simple;
	bh=CkD6//8V94FznknCbIOJYRCz8ULjPJV4dnh8lRkdkPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuFAvuGWGWSmiwPhE5JVcLv3XJh1+Kt1B8jcqQOjogsrRDoXpa6bWJWyF+XauAd8FCmZF4QZ/ILLrZddDAFtsJHfSH9PSYyjJgP7WKIZ0bXYguIAK6oBlkRjZkL+2vWs7/ACTOWBcsYHC+pva66RJtsYDs+VITgKOcoEBt6Clkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=raRJA5nG; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raRJA5nG"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-57512b86273so8172737e0c.3
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 18:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779846073; x=1780450873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9H50iNGtKOm0zzGSjh1Nvv2QB7eK0iZJNgUcSL7MPk=;
        b=raRJA5nGoxG34lC77Ua/X2143pZ/yv/4vQiOT9VHM7AEI9Fj1WlKzRMRoU6IrMW3pK
         W/6HoRDLjc3MajsZAaMPJk2mYT5yH12K/C3rltL12YAJ+DdRRjsHO8Z1PhZx1C2juOrN
         Rhctl9EALk/V4pa8+PD3vzdKx/hvsZsDzzEkJELQlKzo21yUeSs0O9zFVvuvONgg8yp5
         nHlL3O4iAxgZNv8j4Qc0Wx2hiU1P8sfmVulsnFiKCusZCDiwHMWg347Qfmj8pJWwvtg/
         /gIY7e28cwjBoZBmOrxjsZggGEf/NJSbeCziRp7x5eH83jt+RvwcHtdcVGnvqYMAe6pt
         JXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779846073; x=1780450873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D9H50iNGtKOm0zzGSjh1Nvv2QB7eK0iZJNgUcSL7MPk=;
        b=Fbhyn1flO3GbPmL4uN8c89FL5NuukQ3t6i8N6t2x06U0Ksw4o7lLZn/N+0219S/Hms
         zq5pc3RdfzSahoGpu7KnFqgH4AdNjuOXIBgAW1Bj884syjAv9s3CoMekMXj1Wc0uFwPY
         YJsSDS2dbsbk002grc8VlOAqzck5cjXzf/4HQPFURnaHq7XTqnaUZ4gJNP/rgQKAARG1
         Vub73N6iS6yIT6WzF/m8WZeiXQBc4LdLzq6dBJE+XLQYU5B0l2WSgvQDpbyIkpzavqZl
         AJWc4w2DDl8mLkYIl1O5Wt9FyYIkISJRTSKCyz7p94eUycYtwESnelJ6oJV9LM9twN2i
         kepw==
X-Forwarded-Encrypted: i=1; AFNElJ+NNHlptBbOm81YgRXlElQJMetkQLsuKVcgVzOXN4LPvDpzbb0Wn0td4obf69oCYWPuh6lYHnQJ4S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGunlXRzol21pE26CpLBAkIY67LF1wJJGGad3IpvUm5CR7m7VA
	2b48tLdxnn1OQcZ3nbauAZvtP0CPEfgDEEphqfYNHzx4NNze7wkTxIGz
X-Gm-Gg: Acq92OHWPJ813C/jtQUBPU/EZ/6Ou5Q2OHWeFW1KG9/q8vsYDvqpHrN+CHTuV5NoB8X
	8rCoD1A9GsRus3BLsSkP4VHFyJ+xrtld1BIFdaYblT3cr6UtH6TcfKRSvB7XmO1AGpPuodQ0TvO
	/j0ZatlnS60OfNhgLoq07GGyvmpempdw/1nza2mVWO1lQdkU13kLpGPYtRkLH/8ipf3VDf3dPhs
	LIgJ2HEyYAkBRAN608PMFwOw9DKxuTPyTRMOE5PW0W2ir4oQg7FDg8X3e6FmSYkO8pMBCbIOZuT
	dK9k1Bin2bNngU8fFXEsSW1Cy0SxXRAeC3IvYhxIWn2hl4/zRC3wSgfKeaJCXmWWDJJk1goSHSz
	Jp2SZUGAfBz8ABui1cvJ07xl8uCq92BV8zgm/2uC4aDwbN5LCXKTycrYo4jdotSTCmRXEqbAcdn
	9ft4wa1Gy4wkafS1gPVDJ9fr6az7lhzHyAE4+cstq2E+BV8rhALQwrZ7Wcctk1Vk/UnHyCNL/Kh
	S4=
X-Received: by 2002:a05:6122:4885:b0:575:634a:a604 with SMTP id 71dfb90a1353d-5865fc03296mr12522692e0c.6.1779846072974;
        Tue, 26 May 2026 18:41:12 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:82a2:730:757b:d7ca:355])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f2f791d1sm18491348e0c.5.2026.05.26.18.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 18:41:12 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-kernel-mentees@lists.linux.dev,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] iio: adc: spear_adc: sort includes alphabetically
Date: Tue, 26 May 2026 22:36:39 -0300
Message-ID: <20260527014058.35265-2-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260527014058.35265-1-rodrigo.gobbi.7@gmail.com>
References: <20260527014058.35265-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort includes alphabetically, no functional change

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 drivers/iio/adc/spear_adc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 91995489bb1c..efde6afc54fd 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -5,19 +5,19 @@
  * Copyright 2012 Stefan Roese <sr@denx.de>
  */
 
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/io.h>
-#include <linux/bitfield.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/completion.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.48.1

