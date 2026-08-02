Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3B126BF7
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785634428; cv=none; b=BRvEcUpFCGVyr6dswP0MCQDFs2gFMqJDaho+/yqWKs087wtLmWCJe4MHEYlWPPjt3S5SA531UKfQ4nMwPo1QwoY5UbitBVQdEZt3VwbTvDpkx1Sth4S4OqMd290TzPpAf711lgBoAkS34lkYbWnK7uYV5xuM/i3Ox1GwOhJkA/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785634428; c=relaxed/simple;
	bh=8XgKdcDVm1dedbv+A3HJy02Wfi+TEkX1z4ilW05XfLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RpM3lrmBqec3fbrKXiEiRonVgpjNUL0H05mwFLHUf5Vt7k98fFcE791QTafVC331k5RXhzrsbL2MKGzuw/kJR1M2wlUAv2w1IlDEd5l994QkP82B5MIZld3fFOayv/epMLu7ezOuEQkxn2NlZWFMmb7d1NcYXJrXUvtNcWDgMX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbDnsFJL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbDnsFJL"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cca0c5799eso18483195ad.0
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 18:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785634427; x=1786239227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YOIbm829ZfJ26Ah+Z6Fui0r72XIqQRshi3Akci2D9rM=;
        b=rbDnsFJL+4mI0e5oiF4So/F9XGQLzChFWbHhHdWimtDNPkCQfrUDjJkrjzuAzsQueR
         E3urQ+HBHhn0HAQrm4kUObd6NmBFyUrTeonwhulqrxh+EjnQDDgmii7NHmQKej27fB/f
         VbQAu0gYKBY8iw+MB8kEwdG/h7rv7Ip1Qks1HUVueqpGLpVcWmtdD/PUNZhauruIaNAX
         Y1GMRFBG3Vyd18mIRH0kLeF6AifmlfwqzYrgEUv8rv5jzAS7rObkQuhSf6NMIx/j96ul
         2rBe4VUKZbLyqcW14wbcGMv1wIS5tPmMbQdggXsINjJ2t5MbcN712AZSbmB9zhCJ1mzW
         9hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785634427; x=1786239227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YOIbm829ZfJ26Ah+Z6Fui0r72XIqQRshi3Akci2D9rM=;
        b=klNbyMKDhHJZD0Y02QVmJy1kQGkUNOrIBrgtoijDLngN1jnx97AnZfCp13KN4uj6Hf
         +2ll7FaJ+CshNLSXkwinKgjmP1TS0pJ4HagyPOWMTVvLnDha+hF4ix2+CNKtPLoDR8ZQ
         AOs22DtDOkUHE3PGpRtDFZ0kaf2DXEJtoJcTpNXVextPwzhUnyddAfb4y7CFCEfpcvnQ
         SFpRfxhJCo3bdKeBwIZnTl2Q0ArxzxEX1qbtmjTjHXq6wlm8mQn0hPRmJd4+Il351S2t
         Ju/zJ0DPRJQq4Vb0Xg+EuC/X1knKfpd34pdO5+b9JWNO8/ai0NJUR/Hap7/cWX8nyhHB
         k9LQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+FWKallluReRyNnsyoFj6pyGH5cva+mK9E1zzpWM1ePZjy6ITnLeai9ieWbJ00q1eow5X8bteHz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6dQavflhedzr+CTS1+jfrRsUFXqZa5ps7g+f6Ego1MFIzShqT
	C6T/mPv5VAEEdg6kd0WELoI9DE1Qf4iA47NU2N2prDnzSx/3loZ5qfyQ
X-Gm-Gg: AR+sD13zWXl/It2T76lKvAlW7qTykMVCFPQ5qBnNIkjphht6cCSvfEIKArftfLW1A1D
	YkGwjldoABoBhCceOgxZd9fWG/tuOfeJjalTP7y2V3k99JqkeKfGI4Nq0a5GrdfZRwSQ+mSdWZ7
	NXQSNWqqE3Bn4u+W//J7rRPvKemfKvLAiyOwniTL+ZfTOjOx12tpOsFsJ3nF5UKauiYxULs/I44
	kR2MpU+Y0BxNxkAtoBxR7tsM9SF6dgnevIzsfGLKduNhehNPBJ03swEsoat7ddGJJ6Wd4ZP+xr+
	YfR2HgsN3gfyflHiR3nw4G24D3957DzYnFeudixh3H5KB2xd9Tn7s8u5pBIK2qYw0BNahZzFyT2
	A/CUhHT0HgBhfEXjhXRMyrV49JYkOvt9ElqdRZ3OkVoPyIu4aG28PDhRteTP3dBIHVz0ePJn62t
	+ok3uhzjP4ScqE9xFz5FvfgDT2jCOsUMV2DVV1WCa/Z6pralEnco2u90Rf3IUQX1mXsmVe54K0F
	nRT0qbUZELQ3ACAIuBGPFWjFeCOcUeD42r7ygeSPyh3nyJD6GZsi1eIUfICKg==
X-Received: by 2002:a05:6a21:6b13:b0:3bf:c07b:a9ab with SMTP id adf61e73a8af0-3c92a8f3f66mr5088929637.55.1785634426934;
        Sat, 01 Aug 2026 18:33:46 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c1casm21757626eec.10.2026.08.01.18.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 18:33:46 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	u.kleine-koenig@baylibre.com,
	adinata.softwareengineer@gmail.com,
	dakr@kernel.org,
	bhelgaas@google.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] iio: humidity: htu21: Fix checkpatch tabstop warn
Date: Sun,  2 Aug 2026 09:33:31 +0800
Message-ID: <20260802013333.12689-1-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checkpatch warning:

WARNING:TABSTOP: Statements should start on a tabstop
+        }

WARNING:TABSTOP: Statements should start on a tabstop
+        }

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/humidity/htu21.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
index a9dbf08b4f1a..908661c64eb9 100644
--- a/drivers/iio/humidity/htu21.c
+++ b/drivers/iio/humidity/htu21.c
@@ -105,12 +105,12 @@ static const struct iio_chan_spec htu21_channels[] = {
 		.type = IIO_TEMP,
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_PROCESSED),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-	 },
+	},
 	{
 		.type = IIO_HUMIDITYRELATIVE,
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_PROCESSED),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-	 }
+	}
 };
 
 /*
@@ -122,7 +122,7 @@ static const struct iio_chan_spec ms8607_channels[] = {
 		.type = IIO_HUMIDITYRELATIVE,
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_PROCESSED),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-	 }
+	}
 };
 
 static ssize_t htu21_show_battery_low(struct device *dev,
-- 
2.47.3

