Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778530F55F
	for <linux-iio@vger.kernel.org>; Tue,  7 Apr 2026 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552622; cv=none; b=HFUjFyjyrY5/XAG0XH8chk2gj4xSauJAvY1o1dn3w8Mdn3ZQSLzk2fasPOqFFhNdB3Cpn/h/7rz7vWy9ZACd4yFzuGeHpH0BxFm5FLr1CIp7wQvfax+ruE/q9OByP/NS+eGZenQ/XDMmI63fsG0m80xHrXnyrEASJkH7s0nQx1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552622; c=relaxed/simple;
	bh=07mnksjRAECz9KEzGYEsG8OXQtNC+gxUvs3Q+LCxCps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r8Yf/JnacjqwPHf7uN/zCnQkvn37pN/TRCMw0S35o2+35gbAWghiKVnfuwrK0nlwg8SZxJK93GxvVIoNNFRcnm+0IC8+JmpcNpTIm7U1jYZwUxiSOS6qODc9Nc0j4kQWhT03R9BcJACZJzHht39Iwa/APczhkJdhGuy0XD041hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6fgTB+P; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6fgTB+P"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b2429f98d0so30861375ad.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Apr 2026 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775552620; x=1776157420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy+3XZDh984s/a0Q0l2UTnOyBVTWE3owD5fCzymokpA=;
        b=X6fgTB+PGq7puHUyurnEhphkMr4KntkUrt3NeMpmKp3TsHDoVduigZC8S9SvTgzC1L
         cOJRq1HI11yvkpWQMSOLuuyau9wy3HkD4fvRvFXcpeOS2xlIdGlTVyzw6MvOx/8owhMK
         0ofb6y3aSzChXAbIWj3YMZaH1EyRWhAaQFn3DM81tZn2efMLOc9KQEnrLYCvKOLZ2jEQ
         t70JW5n7ExbuWKvDu2Zw4+r7fbZq62QjiOeP9Wn8VNCGyBx9itCwaypnL5qG2rhxbx01
         qJx9ZEMIRCCghqPr3Hc3yqjUR8o8LTPJQDDuhVz46PxzOx1gpnIv0AW1fe+scpCIbG3t
         9cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775552620; x=1776157420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy+3XZDh984s/a0Q0l2UTnOyBVTWE3owD5fCzymokpA=;
        b=YcjkpTSLAiFhaxYB+pDgi8o86xwL22KAUlyYIWhtlcQYhXVRi9Ngog3VfY9p0krJJJ
         0kyrIsVc7P+XoU3XvNaF5W4UZ+QzRKoFRUumiv38Y402/S08L4IQsJQ+kbXp4+dLgmxP
         hSL6WBE4YUxbJzKqMeyo9Sfc/QDHaKEJcCESSd24O3IdQb6fetuK0jxph4PnDCe8YD7i
         cFvmeOdFDEbdr2G6VrZE5PqpT2SIQKO0ca+HA09yeU/lSa1l7LJvGNqvVXrRYxE1f6SX
         MryK/CUbxIrg10KNWbzBLlyUGh+9IiS612d9BakLV/HWorchZ79mBsS9fsh0BzfVNxvB
         YH1A==
X-Gm-Message-State: AOJu0Yy5qVLkJSruWeI5d9NgB585PRHlqKTAUhqLSUeuKkzHBtjwA6b/
	UmrWtBGirgaazWxRY1S/iW7Z/PNYoYWMUZrSDhD1BTkOlPpbRb3zNxg5jyqIFPk=
X-Gm-Gg: AeBDies0bq47OLEFvvNEbtCjEVZXXVTTTUr8cduTr7ALrcYFh5lXR2lm4KGG8/XIH69
	GtOXjdWte7VMRSMcv4JDuIzDcNqlka2Nu+n1UNAfTeKavhxY3I8+bSpgF+tyDPEZOtGfXKpxUDI
	r+odVpbhXQ1PGlNn3uvH3xzjKkJARRJ32GxkMl1LYNIrEkDwR6n7dp91xP5FXhhPpaonDc4uYlp
	OaLPJH62ubotdzUWfVSfCumHeBzDsOdRSEEjBRJQ3JrcEVpiFg0b4wi0F11Lx2zKlZrP2uz8rwN
	kxPFmnIYsFtFhK+prqr1j1SjSTiBZ0wOQP9vdUpoCczE7AcpHn0f+h9Zf4Ib6UU5fiXsZKzj5mf
	RVnmn0IOVrlzyHZN401y95oKXg5o4ZNYD1JzpKaGxThn53N0DHZuJQJjqE/ni5oxCx7JjOXbIZg
	28kco5/2hTN4vUaerVB/L1A3FBfBlZpE2Y8Png+2FPBgT20AtA9gLaDNUETmTs2iNZuzhdfsNzg
	CdhBp+j706PH9ur9QgYu4dbkcuWvp3Ic7uJaA2y/VzE+q8CURygMAA+
X-Received: by 2002:a17:903:90b:b0:2b2:6df1:111c with SMTP id d9443c01a7336-2b2816c33a4mr168273595ad.19.1775552620265;
        Tue, 07 Apr 2026 02:03:40 -0700 (PDT)
Received: from nik.wlan.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749ce29esm176803695ad.81.2026.04.07.02.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:03:39 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH] iio: chemical: bme680: remove unused BME680_NUM_CHANNELS macro
Date: Tue,  7 Apr 2026 14:33:27 +0530
Message-ID: <20260407090327.4987-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BME680_NUM_CHANNELS macro is not used anywhere in the driver.
Remove it to avoid keeping dead code and to improve readability.

No functional change intended.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/chemical/bme680.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 7d86ed8b02e6..e10d3aaaca23 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -68,7 +68,6 @@
 /* Datasheet Section 1.1, Table 1 */
 #define BME680_STARTUP_TIME_US			2000
 
-#define BME680_NUM_CHANNELS			4
 #define BME680_NUM_BULK_READ_REGS		15
 
 /* Calibration Parameters */
-- 
2.43.0

