Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792DF30FF08
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195068; cv=none; b=bNdYfRs+RbVIhAvDd6N5ETsrfNBYxd6QdzNJjS+MnN/KUkQvg586bRjmUZ4suG19HQL2wK52XCrUxliEFL7RQ6kYDXwNTrh+LZUljLOFmtAokFaRG6l6CidM1INUnmsbcgbDzQajyhGhzh6abE26Y9ZCMTB/4q/p44KDo4lyhAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195068; c=relaxed/simple;
	bh=0cP/SpEuIRnMTsbwa6oOuewBFl9Xc1IhNPqjtx4GWJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JPafDKzR62IMcHeDgnGWMdMxG+V8XfNBYDq4N70eVB1kJICYuxHTeCZ1pkPsCyZHyQ/oOpExmHA5BjU1FWaY6TGibDf7JWDfyIBUTagU4fGOBHxqUZZ3wSS2/b/RwhFUKUmuFFjj3+tFaioSMi3LaM9wIBQekq86yZbrEusvvDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QegaQhjr; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QegaQhjr"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-827270d50d4so8291132b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 02:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777195065; x=1777799865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RvA9yofPmrJVN1v7H/Y57b209Sd9mb+5g5ouS/KXC4=;
        b=QegaQhjr3WUP0lBleJbOGZM2D6nvdUQjDjxk43JUrmswUBpIW0cnTvDzhiZ/G5CGch
         tCiB/mA3s83OzO4iK1EVXohiyeL28hs6ot4SxGn65FVFo6e+Q+w6g9bJdc8v4H5C+mSk
         hSISR0yupjz7u7ISUFx8d1r6Q2KlltqIPRbY9Bco1NXm5+4Xfcp2k5BSd/CbUS8fTFPY
         IfAIwKXxrwt/kppyK0OBRfLTqrOD2rVHAw8Dvv9gjFlklhYht/wBbWnPR8cVwswvB1i6
         4B8C2STzPTK2EEm4X0kLBLJ6YIOngFCbBAkO6UqDz+eqI9dkK0cypNVJgvzlBEergeH9
         caZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195065; x=1777799865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+RvA9yofPmrJVN1v7H/Y57b209Sd9mb+5g5ouS/KXC4=;
        b=RvSpm4Rbc5hPI5zupXDMBEkqCJVuslW0m2yFEgK1bvqAvIYbfpFC7eLMA+SOna57v9
         +mEPsfneIAehiL8xLsfqbmHnx8AssDTveVX7nTQn47ym3UBlLlUbqMp1QMNMtXw1llyS
         //tHko6XN7OG7MAvkEhhLOyqNILn8FOvjKK8r0yWgoBNz9hh6dCHMXBWjjctJy/m8fKh
         mkTevJcBhHDJoF4K6b9i6bOV8WhkXv5tO0uClai5cMm5IK6B9J4RSoeW0rLbLc7I4VOn
         Ab+YoI5uOxZohrQGEM0MVV/Dp4U4IwRLAp87vm4J7fuCdiu4ymj9wzANkOlv4ghF4CLG
         +0wg==
X-Forwarded-Encrypted: i=1; AFNElJ/PabO0P5KZq1TUiTOCekZIuFCiiCWx4+sg9qXRR2t7lV9+Mb6CLLWQernNu0nUlDMBPv08bdZem6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9jF14UiXeJ+Kp/2kn3n5z8h09WWsIrfN1wj/247PAFW7U/67Y
	JSNJwyXeGMyDoMtT/CGvYx89fsJi65qGxSx63/wW2mjjLuFD35barm27
X-Gm-Gg: AeBDievjE6bJbI3VK3wHRdPRSu+rcS9/rIPlKFtveDhKZ+bISjFR1sKa9PyIHjxPV7L
	yYl0VdiVSlE0INAetm2ea8mZcJQazcjbxwuisZpP30nzauisQXe2+AUG3p/1ohR27IuuiZwr5xb
	9COm72UPD4eL0wjMyfPkFHeyZCyCYae5opeaMoGZatwf4Gwg1VKaRER2RvzwAK+75jE4onoMA4l
	opQ7AIitBzAlt9ojLCFmDdRp9nJpBlaFuiIMkv4GmpSC5cJ5zK8ZArPYp31zJFQqXjGazWvLVwp
	GtCm8q0zccQ9Q29gpUop2v0nfqpboqqdMCatmhOyeH/5vPa5TM1VVSJpYFyBQYbmtKIGlHOtCMd
	ZGoeKPTgU4LzzeKwHjzOJYp0xaymeNO7SIKXDWwr2b3U6nDx0hHVq8UplVJZkKEEcZh/L4cLxA2
	0p3qNCYgaRSYWO08bC4tJhcZ+ErKMSR9ix+uDwrljZepp1dHw8gz3HQpS6iDg=
X-Received: by 2002:a05:6a00:8011:b0:81e:12f1:d8a with SMTP id d2e1a72fcca58-82f8c90497bmr41155497b3a.34.1777195065545;
        Sun, 26 Apr 2026 02:17:45 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e982fd3sm36145226b3a.10.2026.04.26.02.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:17:45 -0700 (PDT)
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
Subject: [PATCH v7 6/9] iio: ssp_sensors: Drop duplicated wdt timer and work cleanup
Date: Sun, 26 Apr 2026 14:47:07 +0530
Message-Id: <20260426091710.3722035-7-sanjayembedded@gmail.com>
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

The SSP remove path cleans up the watchdog timer and associated work
both via ssp_disable_wdt_timer() and through explicit timer and work
teardown.

ssp_disable_wdt_timer() already performs a synchronous teardown of the
watchdog timer and watchdog work, guaranteeing that no timer callbacks
or watchdog work can be running or requeued once it returns.

In addition, the remove path disables interrupts and frees IRQ handler
using ssp_disable_mcu() and free_irq(). The refresh work is also
cancelled, preventing wdt_timer being re-armed before teardown. This
ensures that no new refresh or watchdog activity can be triggered from
the IRQ thread and refresh workqueue.

As a result, the additional timer and work cancellation is redundant
and does not provide additional ordering or race protection. Remove the
duplicated cleanup and rely on the centralized watchdog disable helper.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v7:
- Following comment from Andy, Study the timer, work and IRQ
  relationship and how it would work internally for ssp_sensors and
  changes looks correct; updated the commit message to explain the
  race condition and information on resource release during teardown.
- v6 change: https://lore.kernel.org/all/20260415050749.3858046-5-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index fa47282b39c0..29b17118ba2a 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -596,15 +596,12 @@ static void ssp_remove(struct spi_device *spi)
 			"SSP_MSG2SSP_AP_STATUS_SHUTDOWN failed\n");
 
 	ssp_disable_mcu(data);
-	ssp_disable_wdt_timer(data);
-
 	ssp_clean_pending_list(data);
 
 	free_irq(data->spi->irq, data);
 	cancel_delayed_work_sync(&data->work_refresh);
 
-	timer_delete_sync(&data->wdt_timer);
-	cancel_work_sync(&data->work_wdt);
+	ssp_disable_wdt_timer(data);
 
 	mutex_destroy(&data->comm_lock);
 	mutex_destroy(&data->pending_lock);
-- 
2.34.1

