Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598CA27AC45
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769851423; cv=none; b=pJ6K8+9uVNGUWSlrjDq7wYyc2z0goKcoH2PIVFcFONIneIBW1TI/DeFkN1P2mgKB9+48julvtl52jue64lexqZe4SOPckmX4zplXDTCluzVazTdKwV91CaCJEh1qfR8j/LzH9MDhP+qwPWa6P66kf8cYfpII1MurskYQ/hdPYTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769851423; c=relaxed/simple;
	bh=Zq9dL4a9lFvNQvrNiEvrmOyinYJAbpriZ3tT47d7HZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvTYKfZITPKZcQkv2dnicn+pQQrPbPtxIMClSZcFoSH9VJJLJQtCb6fli169ThhoDeYO/1xTyXM5YkFPDNMMpulsHspGENCA9dS25rOZiqaeDrjR7ZYZwOkP3G5JJl2JP044AM2XkzGJiRenkibMqMUlOZTE/ta09bO/pmke6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRjc7ru/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRjc7ru/"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so37851855e9.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 01:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769851421; x=1770456221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wHBcuwFJY03RKqIj/cElv3PBJyuiaW/qIgYAVlCyaxU=;
        b=fRjc7ru/prlRTZQ+HOpRVl0Qmd22OGJOigEejLuoKLnCgw8Fy/pZKW5vz4E1zYzauv
         9YtqmhyMM6V3FD26YMJnyxxR2T1SHqbw9cft2H3SHe+TZn/XfPaZxov6tdnBxyEBX0/K
         3n4kYYNWcwRC3/YvuDfI8UHKreCmaC98n/xkaVIQq5BiOHMQ1GT2+W2l1dgDejXEAXP7
         fBhA0CTajks9y1/XAT04cCboU5TjKbtFxsGfL1P44lgkSF8MOm8mBOG51VRX1OS084s/
         zMdxK3Va99oJXnUc+uLY46tXukhSB+Ohjopa/XaG/i0gQEAjRP7fhdzT593D+XNTcikJ
         aq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769851421; x=1770456221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHBcuwFJY03RKqIj/cElv3PBJyuiaW/qIgYAVlCyaxU=;
        b=hGcmX3Du6EI6UnbBjsxOEGBlOKGaYesE6e0rG/qzFOO8Hf9xpnWreAN8aPe2jp6ICq
         S2LawJUKuEnOCnW8drHhkv6u3f4CgXo2lKNivzHAm2oP8txro7DEL3K3MohVZDPwH0Qb
         2NeI1vRy+nDwOMUJ9dioX+Ouywu/+TT6Be+jQ8VNbux/cbjsc6sZFwWqJsJvzw3pmGqC
         3D/0qkhWV6TqRrQvgyqNnzhM6zz68EG69Z/pP9GzHHEhSKJYg5b5cxxpNDqb1Ts1Yl4o
         LhLYIC628u7fSRIh8aj1+xuk0oKdwBbIKykm8aYn3bj/sMQ31mqWy7RxjngtXGkeURMI
         tnyw==
X-Gm-Message-State: AOJu0YyF55G9QJEDgwhV/hBOQcl500q62WQ9XMa40++/rZwqt2+rRAj/
	M1KEIVX1rY99N1gnddX4Tsutx/S5WVg5ShI5og/vZ3pMYXK2d752tIKz
X-Gm-Gg: AZuq6aLJnvybt63WJ0nUIbC03CQKK+7shxS91GdVqX/mxrFXFe/nNzvtAEiNtY5BGAH
	6pZrlMkWrU3q9U3qHG1H5DroHlK9lsWVT6JYrzuE/nemR3N6C34ZEuXO+punVh43rGH//sdn0Id
	yRgOW3pekjDWce/RQM7d9e91bez4G253NuhALHY/SUmVoPgL6N9bBVOIY2NN4Ab5alMmuEOkKxb
	mAn6XMdmLGzrDsxw8LGuGmINbQL3uhqDcckjPv00BfSBG/k3Gi9XPffKgkz0XuA9fW6GLdKFFAy
	CguQrhAgAyL6lEtDuzUxsHzBwZSBGqztY/7JAMuHeqDFZHLRZgWx2MR7UOtIdXDUhG2wIT7JCp5
	o2unGITft7JYAG0VYqZYi8P2x6yityi0Y66QEQ1A8WRXZYQvwEwGDpvW5ylNAIVwHbgB8qlGSky
	C18NbbQci8iEpb9ENvZvjiThoi42knfS3ohFbq
X-Received: by 2002:a05:600c:34c1:b0:47e:e87b:af8 with SMTP id 5b1f17b1804b1-482db491f49mr60468535e9.21.1769851420572;
        Sat, 31 Jan 2026 01:23:40 -0800 (PST)
Received: from localhost.localdomain ([196.235.54.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee7d0sm341661745e9.4.2026.01.31.01.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 01:23:39 -0800 (PST)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: trigger: fix use-after-free in viio_trigger_alloc()
Date: Sat, 31 Jan 2026 10:23:33 +0100
Message-ID: <20260131092333.247931-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once `device_initialize()` is called, the reference count of the device
is set to 1. The memory associated with the device must then be
managed by the kobject reference counting.

In `viio_trigger_alloc()`, if `irq_alloc_descs()` or `kvasprintf()` fails,
the code currently calls `kfree()`. Using `kfree()` in this case bypasses
the device's release callback and can lead to a use-after-free or memory
corruption.

Fix this by calling `put_device()` instead of `kfree()`. This ensures that
the memory is freed properly via `iio_trig_release()` when the reference
count drops to zero.

Fixes: 2c99f1a09da3d ("iio: trigger: clean up viio_trigger_alloc()")

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..981e19757870 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -597,7 +597,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 free_descs:
 	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 free_trig:
-	kfree(trig);
+	put_device(&trig->dev);
 	return NULL;
 }
 
-- 
2.43.0

