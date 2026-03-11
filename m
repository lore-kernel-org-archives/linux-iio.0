Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5BD3DFC99
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250919; cv=none; b=uV5oMESnmIKKiWFQCzOApFBWBmBUI9HiYsTPLuDJy+dYK1BjnsICV3hB1+UrJTgDiz1VJ1ZBoFSMsJpSnyEkQkIA/Wy0XQJLteIx4jQXPh3M3ZZMnsFAojRqdGdR42PNTXrNPjnfPDO0bJ4IMI3MQ5sxGetosVt+dRn8cj+zBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250919; c=relaxed/simple;
	bh=4nZuvbUqjhfDp6BOVYzplWM7RFT5DvpfdFBMDu8bvts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=una78y7+iloFdqP99NXrz0PS0fwjd945BflCrcAq4qbM42bZhQQQEhG+dhPCVTAVKQYS/GlLwcGXOLUX8q2I6humJByDOFdm4g2/N9ELqLcXeBvDXBDj9MSPW+eapT+cbX4nJElPrClvoB9uYbjKQF5Bsq5okXJmefwO9AFf3vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIwHzXz1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIwHzXz1"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ab232cc803so1066425ad.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773250918; x=1773855718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ph2g5RN9mr8K3HJuGfM5PK5AUTqoFlnuj09GuS3nMTQ=;
        b=iIwHzXz1pUtV9AmAO0oV8SoqTtlZMW46bUzWCPQ2hm1soFv9iFfeBaN+MPZZuO0U5X
         3uHLWJPdQwZ43eA4ZIdDhjFywDpRXd2/IucLPutIj5tnFyYb7y4iBSyuk2Lv1oeVDZSY
         wHIEJr/+aZYoIcfLUgr3XANmIG6+LoxnDhmshiPAK5XLf5v6PVlaI3n+jGg/hn0fEvit
         B/DE7uUtDborSiudgSMXqNQZMgf7natHwOxZ73UwiOx5/GyqBQGXUHnBdf3muKVbnWV+
         PKCFzegDGYrkVOZoGCtdcUmOo5lvTL9mb0FteIhxKXhIaEnQQ2xpaTKy8mtZjm1LkHNT
         mOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773250918; x=1773855718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph2g5RN9mr8K3HJuGfM5PK5AUTqoFlnuj09GuS3nMTQ=;
        b=TYR/PzVMKLGJ8Od4xEsRU50Ilz6CD2XpoUsaGj41Stpw3NsU+1sRkHBwyJV56c/J9S
         wtMtLmpE8EfQJLMXtod5DnGh/AKEjnnJ149iJOwqhuNu7mFiiKAjRkkCArt577w1JoAB
         LiWessMJBQjmVogPotH5rC9AR5nwt2Hlmxlf8x9e5mIsOfIez39Um5e4k95ipPVhM7I6
         56NAHhAVJWeZhCUR+JQ3XcOCq1MXWeQKg6b/FLshv29EnocCDNBqxg+S/Jx3JbbmIOuW
         pYhbYWIHXUT1Mnhc2e1yTUevilH/+acmwCIboGJK4tfnTP1GZskVePrUqXsTuK4RDv8j
         Elyg==
X-Forwarded-Encrypted: i=1; AJvYcCUkqrilVa5qWvIZcZB4GccoiPSMtcPCVs3aPfp02ciP3W9guEpJuzWP+tzexqg4tSocb9z86DktA3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzivGmF560IkZqBR6YIilAsIkwGab0/p6rD6k6bo1y1/7ZUtbL2
	fJjg2inHQKClz2pfoz7qqBmQk8H6v9CjUZN7ua3P2eI1Z4CmLQhVRUXO
X-Gm-Gg: ATEYQzyqW+fRcpVYjTHx5dDpwH1/yuxO8zfl45Y9JC5KCQZ4VESABTP5hjPRi6k05z9
	1+83W/R6Y7ypD0l12/oSxYN66lIwVhRJASk5Jk5phgpCifkBR/3OnKXLriyoNDzILJQ4AtSUZPQ
	6aEiqugY9ZdplQgUrziFAz32KoJFf20VjBFEJ3fYGFY3MjkHL7hQMu3QWluH3sn6n9E2fCPRG2z
	KVVp7neUcRCxc2H367zWtKZHZmuJI/lyTbcwXWtoYjGHLO/bCPNqlN4vEThstTtzIVWVKDPRzpw
	KnlnAhVmO46viFARvNFx8PH2u/t1cdQjokwLn4te9hJUa4bAuNqEIotTv10GeQaggMzJMIXRu19
	CuDyHW9ZYFCKCUUl6CFMxUHwHUcAAuo961FUxdzd8vwnE8qO9I9mtJki3ZVdpBFaxazFZKg54JI
	8DXAVYm3mTHS6pe8OefHnCNOjBn/kRvV69M7oHAL4qFMuk8eF5RaWpRNSfvTo=
X-Received: by 2002:a17:903:2b0c:b0:2ae:450c:951e with SMTP id d9443c01a7336-2aeae7d35b2mr32711335ad.17.1773250917582;
        Wed, 11 Mar 2026 10:41:57 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222dddsm40794985ad.19.2026.03.11.10.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:41:57 -0700 (PDT)
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
Subject: [PATCH v2] iio: ssp_sensors: simplify cleanup using __free
Date: Wed, 11 Mar 2026 23:11:51 +0530
Message-Id: <20260311174151.3441429-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
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
Changes in v2:
- split series to individual patch
- address review comment from Andy Shevchenko
- Link to v1 https://lore.kernel.org/all/20260310200513.2162018-3-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 6c81c0385fb5..4320061475e0 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -331,7 +331,6 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
 /* threaded irq */
 int ssp_irq_msg(struct ssp_data *data)
 {
-	char *buffer;
 	u8 msg_type;
 	int ret;
 	u16 length, msg_options;
@@ -375,7 +374,7 @@ int ssp_irq_msg(struct ssp_data *data)
 			 * but the slave should not send such ones - it is to
 			 * check but let's handle this
 			 */
-			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
+			char *buffer __free(kfree) = kmalloc(length, GFP_KERNEL | GFP_DMA);
 			if (!buffer) {
 				ret = -ENOMEM;
 				goto _unlock;
@@ -386,8 +385,6 @@ int ssp_irq_msg(struct ssp_data *data)
 			if (ret >= 0)
 				ret = -EPROTO;
 
-			kfree(buffer);
-
 			dev_err(SSP_DEV, "No match error %x\n",
 				msg_options);
 
@@ -420,22 +417,17 @@ int ssp_irq_msg(struct ssp_data *data)
 		mutex_unlock(&data->pending_lock);
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

