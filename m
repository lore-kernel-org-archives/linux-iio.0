Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6504123EA83
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195053; cv=none; b=X+j9Wqv90EOsbH6LNumL3xEw7rJIQV5Kkv5zGGb7bSD0/yceQB++syTJcQdmN7ZkJSjk4flobVFDcbhXjndY11kUP0IAmCifGv03tYciOS+nfeNL1LmlYyBYkN03kIMJlWVukgIX1s6FReYlbOVCJYfK2EwGjlDRvqtiTvK/HI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195053; c=relaxed/simple;
	bh=xAFbynpKTVh6Vw7bXMrdyHnb0DdWHbz9KtRRo6HUdUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJ3Il4BJNKfWwZasJZqr0TW5gyzpLSKRQpIWOFqsKRjCXy9YAKTUrOrH2eBIkIpRRe9E+yrtpfb4fkcKY69fm2kfFK1IZvPfNyMMOc1VZQ7vKylIds9dt7whIAegfjtfQHh5xwME3UJ6JvoeZbeZslcImv+Y2Gul947HR4aqDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMUtFVKz; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMUtFVKz"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c795f441ff7so6361119a12.2
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777195051; x=1777799851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhgwqHOtN3JKEzMNmQQxavb3le5ueP3KVB1IfiCcbKI=;
        b=RMUtFVKzyuRXQtSFU18B3GnEVDnRSidKI9bCVH24MzxKZ40KHfXh+tF+NjhJ6bF0N2
         5SqVhAw88n0iBbo8SvecTz90/AiqUBtWf6DP3/qWz9ZOjrovvaVbgLs+b2i2qLBPGSp6
         W0zQSPgOkDIwLDL89u2h48/cV+zAgHHAFFWE8n3gSPEumPI08dAJ2VnQxgkZtXyNq+2m
         0wS4dS5M40WVsa1H5IGKxeNEplllE+b6mvttM+f6m3DoAe6esuJX1XOYo9q4CJD93PpE
         B5El7+U7eCcVxQMZj1Q/1nOnPa8FdM03PFgK2iVSK9lnPM0WKRyp057bMU8VEiO571aW
         0kMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195051; x=1777799851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NhgwqHOtN3JKEzMNmQQxavb3le5ueP3KVB1IfiCcbKI=;
        b=DnALVhp0ndML6yaCz1sYXz762qxzZrbaAsJq/TlZhvfc9FQMLwIt9sBunObOpoC6OJ
         KL0vwGhNLDyvNO1PiIO54cNJvjzwkWYknxqD804f1Y63EphOZ3ZuR4YmyHSit4tYYewx
         K3+6HYAlGraGyP08qVSJHCWb30mBNTnjYaAEN/gawoBhaOLemX0e0cg4rqKlBCVSw0lv
         173gEEHkUGCRnO0aDrMWKOSMRuKJJFcqiMVlsvwpBMDKhYI4EV2WNjPs7XpQagfnZosK
         4IQgwMU/xfsLmchvwRkAq9afoI0uzY5mlYQ/cltt1jIpNsngy0pIE4HxvrTqLIS4CYIN
         vQ7A==
X-Forwarded-Encrypted: i=1; AFNElJ9HYs7js8wWp5zVt3bpjC5H1MdeBIksd48di8yaXvFQ9JZQKyRrVjd7PMH/yH227X/VE6t3k3UoxqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwtvIjqhUw8FkEsLdvIHJyuaeoYbl/Gqsy+t4QTbITS1apDRjP
	POOiVmdvDOZOVzqIiBQNP9orJ6AeugOdUBKEEpWeIXtgG74nP0nUEbei
X-Gm-Gg: AeBDiet8h/kr1oTV4ISfT6oMIKE93ZSD89wuZOQZIks6t+BWn24Z29c7YaPiHBJhczM
	fmdu6J78gybk72R0LRQTzBABUYth5dXYxcRqURg8r4McalLxkMQtlsHHVQWB+t05BVf18RKwRLP
	Y1zDJdw+I3wdbXTl87xNA9o7J5kpZJ5WEV78qUtAimDW+h2AKI/8RfpyoX/VXbYIE/0I4o+1tmT
	nGcMkpDGV3Fczm7Jms9XM14W4CUHqlyVFvya41xJXCI7qPhox+IXY9QDOkFMCr44X71LI1VR+tv
	NVy76InqLRaWDfD9lBnt3qvZwlfahLVziP+FtMX2GfiA0CcZfBvrbc0e8m0XJGK5AN+I2Zpb4HN
	RiEttnNsKNITcmoXEQdP6p/13WBQqhR/1gcJAiZPECH0ASkAQ3+Sh1E9ZsQTLHLtIUyvCLyxT51
	LXgLc1736iIQ4UmBoHpwUzD4wZzQR7pM1mhCFsvHjYLNCjvv4+gndwh1W0vkI=
X-Received: by 2002:a05:6a20:7a8f:b0:3a3:170e:a4dd with SMTP id adf61e73a8af0-3a3170ef691mr13422896637.5.1777195051597;
        Sun, 26 Apr 2026 02:17:31 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e982fd3sm36145226b3a.10.2026.04.26.02.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:17:31 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	mingo@kernel.org,
	christophe.jaillet@wanadoo.fr,
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	kyungmin.park@samsung.com,
	k.wrona@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/9] iio: ssp_sensors: cancel delayed work_refresh on remove
Date: Sun, 26 Apr 2026 14:47:04 +0530
Message-Id: <20260426091710.3722035-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426091710.3722035-1-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
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

