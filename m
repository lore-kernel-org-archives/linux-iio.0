Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3945360722
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773579323; cv=none; b=Q8oi9qmtOYWVVbgLSoSa4JOA2oI1qZkOPcBn0IHv4VRvQP04Cjsp/26TkA3vY0hXCn8MJP/xhfVx1/CA2LkCnPHDpAotwuuPWxDSPnpty/jGQkj+o7BYAEZ6Ep+rjIgcbUELwmmWcWxivbbNxqDKvm+9o9WOuOF1WUs7praao9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773579323; c=relaxed/simple;
	bh=6BUGIOstW2vZf5Fg5Q9C072Q6s1sVkg8Nc0rjcwSUr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ecTIEvsbJB+HyA1c4gXHbHFi7DMhch1JTWj/SCkz+o/GxQikPlwYr0qRe+CJj/8axVD2orcC0VuhOsX/5z1Ayrh87p8C+b0am+ASx1ZWivV9ANS8eghWx68PTiinFLidNVAPHNz+pCeVoDo4y/lfBKovCLpikvXitriFdtBl8vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUwDrw/n; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUwDrw/n"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2addb31945aso28179855ad.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773579321; x=1774184121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLZpDDbWN0vi3irqI1yk9YDB07JE1mlsdid/bSE/hzs=;
        b=YUwDrw/n8w+k4hjjl28oeOzDM+OCZ5BkrB20G0bq37Mtwo/mz2uswjb3hJxNboHjLy
         m33b1/y+L1jv+Za8GMQK2bd19l3jo5tJqS2/yEZcs5y/FPNngiOjxpEwbjy6XUqy8DFX
         uVUcKT3QwjD1md1WcFMEAdp4ALUMfm4e7HSsfMaWcfcUu+mZ0cCIq6sZjW+4vfWdwk6R
         rLZorgrbnDsc+jZyr+y19LZRrqCU9YMI4QkDrtQ2VG4nl3cagy42Hn+F2TrrCDj5YiZg
         7mNm7LDRXNclYcBKc/u+fSZ1RCCZZRABp+k/CzLXZNwiW9nESwIk6OY+ic3yL1/CLVa/
         oWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773579321; x=1774184121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DLZpDDbWN0vi3irqI1yk9YDB07JE1mlsdid/bSE/hzs=;
        b=d7kLZcyPZI+Lv2t1x2whHW0JK8YSMr8YHFmgILEuJCHUB+f9ej6SFohRTC6gas3qQC
         NDghm0B2QnmqFADXuonY/dxLpi106yBPllSFH2CirPwnTOq/jGTqgV+vl8wH8ecB/9D+
         LXYfSp49e2h26kLrNb3TXLisTpHnkkXRn50+tD8AywSLHEWO1XoK1CyaW/eDARB2/cbJ
         0nPdGZTVgjnlnQUEQuI5iEIXL8j33G2gPMwxkoVU6tdOLq3JdDfrFeVpj1fpQ6rl9JE/
         bK8dzJafRbPOaKxm+6kBx+3ENC632D8mvCj+QZEFhMcSkQneoDAs0Mb8QpUvvlmMxfdb
         ZKUg==
X-Forwarded-Encrypted: i=1; AJvYcCWFx/WsmyU06nJBp9Awk+UwcGpAf4aVv51mw9tBhoRFuH7uIsPU+DJJiqZ852T2gOwP/paeAZVozC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZg+rWtau3rTRe3HHRQ9ADArHpSO+FKhtnJSb+bovvnQh+gBY
	v1z3Ywb68R6502f94mWwcWNjCJOO+Y4kOcFni1ov/Y+qto2FfMQZLZ9a
X-Gm-Gg: ATEYQzx9PudiMdAPFSO9zHuBAl+OQDnevxFkTQYyQGgGkY6hWh+0iJRI7j6S9NxVAx+
	6v9bWKiqtcAoiL6Ld0cNVke2x3afla0nbWOMjMyPi1wE/beKlTP8A5kHl0A0Z+sqHPSKnxB+4Cw
	dFlKtdHXnLOERy+Y6sxMly5XMiAG+Dp/aWrmNJteb22lFlpgAMUHjbe85XlnfqnnB1d9kPKbSLP
	yDJQDCVyB1oZw12Hgpa41+Z0f9kNbddPk1PqfI8OG9k/R2fwSWJB88+K+FnLW9eYR6ukJW2yktS
	n8ukXS7jI8zfed71DWRu9MuriLpDG+iGS2qbiF3Wg2ztPQWAkYMd3z8s92IIxlcdweU8wnc8pta
	cex4pwk42HP4odEnFSWShgtfupupQy6qACh/5MBImL8xiUJgD8x5A1eaA3ixfRMFbSs4ULfG5sg
	koQSgjVweLXBGx64EAcksAeZVhcLueaNOm4epBa0mvzGO2Oz4S
X-Received: by 2002:a17:903:1983:b0:2ae:a496:d66a with SMTP id d9443c01a7336-2aecaaad10dmr94111225ad.26.1773579321432;
        Sun, 15 Mar 2026 05:55:21 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece594b4fsm72931565ad.20.2026.03.15.05.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 05:55:21 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sanjayembeddedse@gmail.com
Subject: [PATCH v3 2/3] iio: ssp_sensors: simplify cleanup using __free
Date: Sun, 15 Mar 2026 18:25:08 +0530
Message-Id: <20260315125509.857195-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315125509.857195-1-sanjayembedded@gmail.com>
References: <20260315125509.857195-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace manual cleanup logic with __free attribute from cleanup.h. This
removes explicit kfree() calls and simplifies the error handling paths.

No functional change intended for kmalloc().

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v3:
- prepare series to have all respective cleanup API support for the ssp_sensors following input from Andy Shevchenko
- Link to v2 https://lore.kernel.org/all/20260311174151.3441429-1-sanjayembedded@gmail.com/
Changes in v2:
- split series to individual patch
- address review comment from Andy Shevchenko
- Link to v1 https://lore.kernel.org/all/20260310200513.2162018-3-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 87a38002b218..9df94bd02e3a 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -326,7 +326,6 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
 /* threaded irq */
 int ssp_irq_msg(struct ssp_data *data)
 {
-	char *buffer;
 	u8 msg_type;
 	int ret;
 	u16 length, msg_options;
@@ -370,7 +369,7 @@ int ssp_irq_msg(struct ssp_data *data)
 			 * but the slave should not send such ones - it is to
 			 * check but let's handle this
 			 */
-			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
+			char *buffer __free(kfree) = kmalloc(length, GFP_KERNEL | GFP_DMA);
 			if (!buffer)
 				return -ENOMEM;
 
@@ -379,8 +378,6 @@ int ssp_irq_msg(struct ssp_data *data)
 			if (ret >= 0)
 				ret = -EPROTO;
 
-			kfree(buffer);
-
 			dev_err(SSP_DEV, "No match error %x\n",
 				msg_options);
 
@@ -411,22 +408,17 @@ int ssp_irq_msg(struct ssp_data *data)
 				complete(msg->done);
 		break;
 	case SSP_HUB2AP_WRITE:
-		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
+		char *buffer __free(kfree) = kzalloc(length, GFP_KERNEL | GFP_DMA);
 		if (!buffer)
 			return -ENOMEM;
 
 		ret = spi_read(data->spi, buffer, length);
 		if (ret < 0) {
 			dev_err(SSP_DEV, "spi read fail\n");
-			kfree(buffer);
 			break;
 		}
 
-		ret = ssp_parse_dataframe(data, buffer, length);
-
-		kfree(buffer);
-		break;
-
+		return ssp_parse_dataframe(data, buffer, length);
 	default:
 		dev_err(SSP_DEV, "unknown msg type\n");
 		return -EPROTO;
-- 
2.34.1

