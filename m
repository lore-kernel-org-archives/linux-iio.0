Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D3D3DE420
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866830; cv=none; b=ISS9qZKXdjRP5hXTG2attVaadQeyCyAlJ6Ziv9WS7efVhKxmksacxi9YAwfZSO++GL2YjZhbVn6qDqVAixggsuw8zk5yNA2g4LTv6vtulu5nCO5KWt01i0/G195TSW6oOE5wdQHv4XP8RiSfuTztGeo9XYg9Oo5uLcJ9Fqv0W1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866830; c=relaxed/simple;
	bh=xAFbynpKTVh6Vw7bXMrdyHnb0DdWHbz9KtRRo6HUdUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gYsDmubeT88GdiE05MBN2h9DyRn7gAod6e6esZk3SF6zBCfKvqmXt1YvKOs+OYGvBFiq97zs9jy1FyWP2Paa95P0B7WyQFHhwCes/0MfTKanOOHuxQW+3XsHS4eazT8dXjeB7+BZ+rCPvqJVA2lAz9AdBi75FLoFeNYtyV2PB6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTuePMTl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTuePMTl"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so73169b3a.3
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866828; x=1779471628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhgwqHOtN3JKEzMNmQQxavb3le5ueP3KVB1IfiCcbKI=;
        b=eTuePMTl6jvkqQ072wspk7h84eq+VpotdBf+Awm4lm805OWL07s3xzbk3bqdp8S93N
         WPo+w38MLvWAwseT8KDhFS2u1yl/AfO8ifI5nB17Zzl4DAx7E6veBm3B34tvSpKW+fd0
         B7ip/MC5kFMwMiJkIvR0zPfaW3EH13C3b9oJO/Y9a08B9sQ49UDkN+d6RO9f8ou4mmli
         jY0qXZqiiPn69inC1Db+ubvsC8QELpZjG64fWFAhKrR9sPQeachv97bbmNi+0batJRwF
         sYrlsv/rIB3dgpbaFjGv/Dnu8DwP17/vtJBMPqH2QTJx6L6DsbRzjyKdV50K+bVu4EQJ
         4+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866828; x=1779471628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NhgwqHOtN3JKEzMNmQQxavb3le5ueP3KVB1IfiCcbKI=;
        b=JVPBoaAj/57/XBSf8JzW6f/XglM4gcHL0jIiEjnXVCDPERk8R7pGBokD9g3UPBHCCg
         EJvThiNrzwdvsIYTVE5Gm2CXbdnAt6g8eIMN9f6+B2bcKXAQwyoajfDvMk8SW4PbKLwK
         wMWLF7IcmhqoWXTV01YeFRlMNTZ5LwMCXVR/8BC0oST70f/Xocer6gPFZNQNEXk+WZZK
         7RrKaQ6fxqnwGIkKrsTS1avM8Lr7hG9aE45j8W0MeuOkduNmDFPrui2XdK/LXFSH5HEm
         QADA/qH1//bCEJlaViO0FPTYLwlAjuy5+xn2ZXJNFFTCyWsdtWNpR4yVL+3XXQ571eb7
         9W5w==
X-Forwarded-Encrypted: i=1; AFNElJ8OU+16NMR+cc2Bd6SYCH6vTlg3hni39QD7svayAxT0M5du6TOdxOnsFSo47hF/awO5cxP1dAyZUJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFtXLkDPiJ+r8lW4Q5PeyCyf/aFXqKjIQzrYsKN68BoaTGXxVM
	1LX53Iu9uFOeegWA3q4mG9JBa1zJVOwyhQDkgZsM3tNOW3Tk+L9jrrcr
X-Gm-Gg: Acq92OERWR6mu+JYFNNPnhv3hl7syxcBkQ4Eeg5GDWUkBeogP7NhpyRyWEO3LGD2D2M
	/3al99Gvn4f61bcsAOeS0XNXPYqBYZtWAk08PJw28EImAGaQ2CEmUXb0JmrGZqCpKDGIRGq/k20
	XjInEV/1P4H5WdyOvrE07mmVCB6KjnZn+2h5v554bGtCUZCiOUv49R/Sooxe8ICzYkIQ6a0WLY0
	H1F9qyiLY2iel5PtBsNQEJNJLqIYZj6oW6upkGY3uCrAbxrbloDCfcguB6BFO8YYbT6jkEMtbmd
	NQ0os/9WBnlCS4QunLOJZRpNHiq+9KrIz1j8TGaRkcotsIj3s1el8NQkbrzBlgL9ArA9+z+fLWt
	ZXwVwaIRs5PCVPiBAu3Hj+HQuDc88yGBCrtV+Asl2HvhJOjLxKMVzd1n0FMFJSbGmq9YnqtYfzG
	7w3H5n70p8d61DyFr6H22mnRb9UcX2e/tluW0+GTqvILpskMqT
X-Received: by 2002:a05:6a00:94f9:b0:835:45bf:9660 with SMTP id d2e1a72fcca58-83f33df29e4mr6181616b3a.42.1778866828495;
        Fri, 15 May 2026 10:40:28 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2875f0fbsm5579034b3a.57.2026.05.15.10.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:40:28 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	tglx@kernel.org,
	christophe.jaillet@wanadoo.fr,
	mingo@kernel.org,
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/12] iio: ssp_sensors: cancel delayed work_refresh on remove
Date: Fri, 15 May 2026 23:10:06 +0530
Message-Id: <20260515174017.3962168-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515174017.3962168-1-sanjayembedded@gmail.com>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The work_refresh may still be pending or running when the device is
removed, cancel the delayed work_refresh in remove path.

Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 7d07fae295fd..51730dae5871 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -590,6 +590,7 @@ static void ssp_remove(struct spi_device *spi)
 	ssp_clean_pending_list(data);
 
 	free_irq(data->spi->irq, data);
+	cancel_delayed_work_sync(&data->work_refresh);
 
 	timer_delete_sync(&data->wdt_timer);
 	cancel_work_sync(&data->work_wdt);
-- 
2.34.1

