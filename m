Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B09428473
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380418; cv=none; b=KiihAVZQYU9YOaG8euBI0p8oOoOnvYuZ2qf0prSwBNMULbl/I0Qk/C1PNpbnAFlEE3N0vgx4/9xPCTRGBIDAGNx3m5a9TfqgfXKFAajMDJiXDaDd1SzFQtp2ng/wgLpHWi5pxtEttIgrBKvQznNuegHD13TtnLBrKheTmWCso9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380418; c=relaxed/simple;
	bh=UeT8LyJ6LIXE+IjlooYgXtnFImoXnwlxSoofLNVryqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEfPpVHTBLczn13GWr1Lyr1w19y3XBwkbC8yJ3WUEU4kuAn4hqy+zdVpwK34PxfCt4eVdUkmp/Pad6LjytkRaU4+DQQNWpYdUDmh2h+lSoEQJUZveHSBO0FIoVBCD6NWyFd7NoiIE854mmt0AbwfBiYpVay9T06hNegSJI+/vWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/U/AE52; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/U/AE52"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7de4e6c5a30so3841768a34.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 05:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777380411; x=1777985211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fR850Eqwaqzi0InII1XrHEy0DbB20DDlrrvurFcFr28=;
        b=j/U/AE52XO98y+cmPRsZ43Gaxt9pVAfb2wHLwhv2XjaWcC++drzi5lb1NVcdcjLQov
         YYWdRVg/jm7q5l4rw0OOxTFjhfOn2zOq6QOTWHexf2N27mtSJhTt7jkiK8kowVWA7PJj
         tky9UOtCYyIQBQRapgx4o1v2bg5ieEbytK0Lq/+oDpkrN76u6SaDUPhjbTfuAaPjIyp5
         hb6gRN0gbrIEQ7wyaRH7dAxDS9rgXbnnVS7qC9eBWT4HcwV1APXdVjOSQlNwR7GSP9iE
         KcqEGCcqTKTyqcdJgrSnmQiwYJuJvtUdNMVAkySXukzKp1scXQK7HP9WQzMBdtW+O/gD
         hzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380411; x=1777985211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fR850Eqwaqzi0InII1XrHEy0DbB20DDlrrvurFcFr28=;
        b=o2ECmDAs6/uS6sT+z0hBNMSv+DIBJ7LjHFQE0YL2enoVzqrCltObgDHF9KeP4ZyzIE
         flOT2KL97IzkPNz/rG9bQ2+Lyn9z6hu3S8a2FId+DhUMsde9eOCTfMTUUqPXt3h6cP/Z
         Q011p61KZBRNikOoy/147gcz5U174REV4len2j+FSwAJ9mVE741uGoejkt6CJtTfazvQ
         tiRv72ankYH12QBUfhRKRXEZQXwM8j2x+QkTQ8/BBhZv0URXJY4A6WI3qA9UAx3UOxHB
         k+B8KHuKWRN56hecCtVPGYwk5rbSKsIuELimcKebIJNxX/bLhbqfSyqVF//Ers2yvul5
         rm+w==
X-Forwarded-Encrypted: i=1; AFNElJ+/chSDuElW374zzDmJXW4tiRHWMhTqHYRnGn91MaRVGNEXbvmUfxTOPODZXjprl7K1V70WDkH4WIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1dNZF2O4OPwK0EfWL1+EFsyUN2rQ1Tx+gB0tiPMd40ZI6+Jb
	LSOmTgCAzCKOIIpm0EQ60HwpxneOSAC4iJdUyJ3BOklvhCxgyEwmGwbBCHS9Ug==
X-Gm-Gg: AeBDieu5JTMFpcc+7HCzZn2ZiTa+HK+IpEBISWfzgfrk/9GvsoNF25v744W/CobcbDL
	0vA22JU6BqhHRW4GU041kl/4L4Vuzjc5t6OgF+bP+BBmM2STJyU+qMaoTtsYE0C+fz22hVVEgRL
	hs3k0xwtNUH4ac68qNvUYmqRo2KGqSgizArTYsGNWCaiDsaACwxu+6n20kVBqyeY8efviSRYPH9
	o0oqA5YEZYUjQ6kNySo01M7VM58VXzi7MOLTw9bByITO9Di2zg+R/M0+qsFox0eJQzd1YCr02el
	oKFd6lgBRMCJH/ygkkKkg9B/YKPImw+HASITtDpVR9UPmlW6OENLqbF3aFqK7/y/dYpeOtN9kPy
	ABNdxrouOwMZ5i//EloAdI/omAWxgAI/bjn5M2mzkPjG8WCtqyDkVisvoYDzwIl2ea/qKsvBKuj
	R0ytYUzy9N2E2iBaMEpgetve9y8bdTjAAX6ErxnpYLxnyb1aOUdDVXt4mli1j1dMR0gDTj
X-Received: by 2002:a05:6830:82e5:b0:7d9:7209:4378 with SMTP id 46e09a7af769-7de9a0c6b2cmr1909164a34.17.1777380410784;
        Tue, 28 Apr 2026 05:46:50 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7de986a5601sm1683041a34.19.2026.04.28.05.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:46:49 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: songqiang1304521@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] iio: magnetometer: rm3100: Use guard(mutex)() in rm3100_trigger_handler()
Date: Tue, 28 Apr 2026 07:46:44 -0500
Message-ID: <20260428124644.49707-5-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428124644.49707-1-m32285159@gmail.com>
References: <20260428124644.49707-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock() and mutex_unlock() calls in
rm3100_trigger_handler() with the more modern guard(mutex)(). This will
help modernize the driver and bring it up-to-date with modern available
macros/functions.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
  v2:
 - Switched out scoped_guard() for guard(mutex)().
 - Because of the replacement of scoped_guard(), fixed an error due to
   gotos bypassing __attribute__((cleanup)).

 drivers/iio/magnetometer/rm3100-core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index eb59ea8d5bf5..fdee82c1290f 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -459,11 +459,11 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
 	struct regmap *regmap = data->regmap;
 	int ret, i, bit;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	switch (scan_mask) {
 	case BIT(0) | BIT(1) | BIT(2):
 		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
-		mutex_unlock(&data->lock);
 		if (ret < 0)
 			goto done;
 		/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for paddings. */
@@ -472,21 +472,18 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
 		break;
 	case BIT(0) | BIT(1):
 		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
-		mutex_unlock(&data->lock);
 		if (ret < 0)
 			goto done;
 		memmove(data->buffer + 4, data->buffer + 3, 3);
 		break;
 	case BIT(1) | BIT(2):
 		ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
-		mutex_unlock(&data->lock);
 		if (ret < 0)
 			goto done;
 		memmove(data->buffer + 4, data->buffer + 3, 3);
 		break;
 	case BIT(0) | BIT(2):
 		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
-		mutex_unlock(&data->lock);
 		if (ret < 0)
 			goto done;
 		memmove(data->buffer + 4, data->buffer + 6, 3);
@@ -495,12 +492,9 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
 		for_each_set_bit(bit, &scan_mask, mask_len) {
 			ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * bit,
 					       data->buffer, 3);
-			if (ret < 0) {
-				mutex_unlock(&data->lock);
+			if (ret < 0)
 				goto done;
-			}
 		}
-		mutex_unlock(&data->lock);
 	}
 	/*
 	 * Always using the same buffer so that we wouldn't need to set the
-- 
2.53.0

