Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728534DCE3
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 05:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229695; cv=none; b=gagWKxfOHcpM7+tsVgcS/iF4ht61ROZYLZcxR3pwaBGK0Cu0xZrQv5J/eHp/gcLPRTsHWUZBy0+sKDxIVfwWsBySIgr/ovKmqOJZ+/Pe+yxWWCtSWQbgDJL3tDtBxPX4vQ7AkXyRwZ53nd4RfJ+dsSy2d7ob4NGbmZAlAgRglZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229695; c=relaxed/simple;
	bh=DHw3mEf5E48IyzdwtirqKAzSFDKZSNiuWZlq+PA9dLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OiM7uEdYYDD9uQsdmqWoaQZkvNd5yCJORg7Pq05sPnJeb0+3tmb5x/yCCux+FrJnqBpdGc2luqeU38y7P1OocvQiCPwPcwzCZItBsBDZpwHG7fpOU3v1llBCYEp0966IOsQlB+GpFD/L/8YT9jsnT4IoFjk3iQeuTQW4jxq31IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYEv30OZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYEv30OZ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82f37c09352so2127251b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 22:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776229692; x=1776834492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJbFp8qVdfznQptGY6110Ovof+z5WvLikLykH1C45qI=;
        b=TYEv30OZGsIN7HXdUMpz5sydfgFoMHNn7kKLFVi6Po5oREFi9L+i/tj/+I25oOgT4C
         4PpY+QstOWVoABOB9EqXAcIhYOcjknmMWMPqYYzjrGGTjtTiR7cZV/48+uYukEISfsqF
         Q5c6Ux4Fyi7qEP5WvO9k1i/Xr4huQEFJ7gNRdhOhu3gkptTViNScXrHvkk4uffkLb9W3
         4Uj4fCIN/nMXaO8DJpqoedmYYaGamISQ5CUnCT5ojV6CUbfFHScXL1WneF014oF6fojM
         FKQKDGM0KM3pguJfYQG9GGgKQUnQdZDRNTd3qzqSXnnWWbgSP5Ca6dqvf2PQzFNGvzHn
         nneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229692; x=1776834492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dJbFp8qVdfznQptGY6110Ovof+z5WvLikLykH1C45qI=;
        b=FdWmeWUE5zYzbnZNoOvZVbZiUfc6huwQ6EalGQTHd2P/AYRMfZXOffLpWCOoPHIbMd
         wrMGyHYp/qxe+kNfKexvATTdKXfAysyKyvGgrzHVW27Fomml+d207DUApXOydnSOFPF4
         HN0FNuAUD3AJP1s8KA3PsItXTFEKAZTCbT9Y+29jeuRL9lcBQyQM4kMTdQzB92N4J0Jt
         vF/elO47D1fG3GOa6hvVuToB+zw1UoBZKkn/zmCGhYj3brfCaMXe0T4WhnQmY6+/fC6I
         P6QpQEJ+EcUYzq54YJFpQxCia1RLPEYYdlkCyVj/jWd+2uR+2dCrHMK8wcpJr6IVRk9I
         BtKw==
X-Forwarded-Encrypted: i=1; AFNElJ96saYaE5LYKbWpmxnyPuQpP1MC/8QLt+GplXKImOYr2zmi7XJotNP6YESHEbInKqxk81NVHmprjY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiin77T/4uDF6D940vpaWtT3FALFfKDduED1yZLM0/MFvAoDIe
	IH0t7VoOzHbr6hkAPQxVsGPavh9QpCHPlIaLwqmBvFmy0slncQfSDwkP
X-Gm-Gg: AeBDies3CgJgoaYNjSgzoqGTjzChalP/qEmPKCdUhA+Z4xWR00cOiWh4RSCiCdBCnG3
	t7pOnrCjbpFN+c2TbdvSh+hrBWmNx0gTAtXH65Hp8H/dbVDVjAjF+/c+p4DrppHq+PaRxS8mNmo
	8iWcnV61u4u4MdqbALNRfbhxfgLoCjrzU9DC5ly1VKHOXcX16Ruic2gnHLjDflMUGKcTLnsrhEO
	YLgTR1wItnzAWvh3FGhYbmENdyfVki2vkoCODOErKBLZ+/CRXQP0oF0gyEx7r9w8fpv4OpELymP
	l6n1MkcSEfmv7BNTi8wOjg1H+8Xnu9eqszMVqpNCUpJqd2eGdKTyNYa95ur2T+KQefjcbNxVDBv
	l1Ye38779g/5lNQFjouFWz3iTppeJCFp1Ezg36L0lM9y0aCO4mrm8CJH7lfrWjuJKU4EGwIEJDx
	E6QskFO4EYF0Pd0WIwXukFLMTTtb68ogWyC+Ol+RCMHVH+Jy2indTFbnwwvs8=
X-Received: by 2002:a05:6a00:6ca2:b0:81f:5acb:55fc with SMTP id d2e1a72fcca58-82f0d10b602mr15954138b3a.10.1776229692502;
        Tue, 14 Apr 2026 22:08:12 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67469dc3sm763706b3a.58.2026.04.14.22.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:08:12 -0700 (PDT)
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
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/7] iio: ssp_sensors: drop duplicated wdt timer and work cleanup
Date: Wed, 15 Apr 2026 10:37:46 +0530
Message-Id: <20260415050749.3858046-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415050749.3858046-1-sanjayembedded@gmail.com>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The SSP remove path cleans up the watchdog timer and associated work
both via ssp_disable_wdt_timer() and through explicit timer and work
teardown.

Remove the duplicated timer_delete_sync() and cancel_work_sync()
calls and rely on ssp_disable_wdt_timer() as the single cleanup helper
to simplify the remove path.

No functional change intended.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index da09c9f3ceb6..cb4c26a6b76c 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -585,14 +585,11 @@ static void ssp_remove(struct spi_device *spi)
 			"SSP_MSG2SSP_AP_STATUS_SHUTDOWN failed\n");
 
 	ssp_enable_mcu(data, false);
-	ssp_disable_wdt_timer(data);
-
 	ssp_clean_pending_list(data);
 
 	free_irq(data->spi->irq, data);
 
-	timer_delete_sync(&data->wdt_timer);
-	cancel_work_sync(&data->work_wdt);
+	ssp_disable_wdt_timer(data);
 
 	mutex_destroy(&data->comm_lock);
 	mutex_destroy(&data->pending_lock);
-- 
2.34.1

