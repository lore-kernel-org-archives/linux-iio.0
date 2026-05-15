Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA43F8EA9
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866857; cv=none; b=JNiBJn/tGszArHBH9g0WE8aRPDXB7kv8+VISeT+gy6GupnEi3L+uS4wCnS47jcEDZ69VBPsilrFdW4PMlf2NEIFcOx1g6oGiI85WSFJw5gueNyoUOGofIQYU1Q77u3/BukLmgoYVeGiOQ6huit+bmNqpd59/k+1dDPjENcyAp7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866857; c=relaxed/simple;
	bh=97ly4BjJHtk0X0D0XIMtHD1ZVF5yf0y6F7zT1Ri/QBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmAAAVnIBNqQ4LnWjvJjFgrl+j5kxof9ZupgI39+pZD+xiKtvIW2m/+FwHiTuu4YSEbjiE9UtmfhS84EtjmQ4FRieV06w5PveArmiLS8HM9yF1O47innair1y6VzJsuRqAyCK4SXOmbV5pWctG/PyQFAvECgY5mp6+b/0VkyK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlRzfANP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlRzfANP"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8354461da74so61852b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866855; x=1779471655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgncZFBSo1Y+nwYmK2FCTW++Gfuechd40CMtdCuk34Y=;
        b=OlRzfANPwHqRzVisOAOubUy8Hv9R867klGQbFmaiovocA/u2AXvNhf4yAbRPtSSyiN
         9dev/AukNcGeTAD6JiaA2GCLX+KQXeYcktXU1TzIl8K4NbVLfUqI4HmtWICDZFqD/vKi
         RI4+SFy/1O/BAXx4MhJzU5MwJZcCtouD7+AQxIp5oyi2MYi8ZA3UmzJbEwumYFjMPP1J
         7QShPxNBHeTCbvz0pAloajD7cz2YWZHO4ZJiQAU3xOdT5LMItoBj6bn1Knif0OJYeFAa
         twBgEa0v9mkdrLljYGTkhqrsmQgEad23lT+LrDa9wIa+SDxgOohyPCGpAImhTehO4TTb
         hnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866855; x=1779471655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XgncZFBSo1Y+nwYmK2FCTW++Gfuechd40CMtdCuk34Y=;
        b=dHk4l+MurpYWjPPF915IZpFEEBEtO02cAGqwL6lE6OV8875f1B0EOqr1lCOC/4KW8O
         1VJ2CpeCvXMX5Uj+kx49V5/iqKOaS5cSUWiXRG8/fSt2ecOuQ2zwXjNK426UacxNwOqa
         i5XnFZgIlgeWi+CRqE6nspwDm8Go63xUofFUrvSN/zMJW68s45DPux9xNF5fDXeWFUwY
         KsmtlRmPCis4NGc2dtJ3RKz1p7DPqjN/WHrMfGhq81Xbf3Z7l+KstrZrPHmgY9N08Bww
         DR48GSgWZOAFi6vMu6RR5dKqaVL5Qb92ENU08R73rFDx/FQazii6Ls5W0gaiJUHBUkoo
         517g==
X-Forwarded-Encrypted: i=1; AFNElJ/VONQUi3E2Z7ZcnZ9bBQxoVX+3IPo4g53+2SE9tW6ZWxEGAPdOEPsXufjATMuKhNc6xQ9Hsciagiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6g4YtAvZLzSRMAmsX4jsKK6ALq4be9RpSIto5lzdcr2oGfKe3
	gXmbrRI7wln5oJWctTG0AKdBRMkJObDfswblCQ8HmzOmUM3gcuHcx03nqXrzLQ==
X-Gm-Gg: Acq92OGhtF1P3TAucrEZmTiUYEMMErY7yDoi8r+XGLSxUCfw9gezH0SLZo9bU/6cZxO
	CEKTMoegnsy/30GfOTj9bdj92HXjr6jE0+EgnprllP0uozTd4pjf9yuFJo6f56BubKfo/iw3MCj
	7z3QdQ7vilADxWcpafJ1W0bBv7zhTWjNtdWDbldOXAWLR8SVta32UgW7K+2bLUofiHC6LJbuQKm
	/b1whwZD1e0Oki+Bd1oGunzuaGcZg9KLb+DdO9EOJfrMQvHVPlwBgimuCZSwbyP3d8jsSmChTIK
	HsM6/Y0Q3rEaQbHJoy2IGbGWVTEl3gcRqwm/h0cEnFTazguBYb0EioO8vqW3eblhRJOa/dzc0tZ
	3fdnxeXzcZKUX3M9moZo0eNwc82o1wkwJKt1AE4XbOudgkMB9OqntT2WkLCksgr+yR3pstDUL01
	zwwWz7we+NHCW80TbQvUti+MfCB6hZYCAApewDy4xRLZLSgoqs
X-Received: by 2002:a05:6a00:32cd:b0:83f:250d:5ab with SMTP id d2e1a72fcca58-83f33bc8888mr5959617b3a.7.1778866855475;
        Fri, 15 May 2026 10:40:55 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2875f0fbsm5579034b3a.57.2026.05.15.10.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:40:55 -0700 (PDT)
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
Subject: [PATCH v8 07/12] iio: ssp_sensors: Drop duplicated wdt timer and work cleanup
Date: Fri, 15 May 2026 23:10:12 +0530
Message-Id: <20260515174017.3962168-8-sanjayembedded@gmail.com>
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

Calling ssp_disable_wdt_timer() after IRQ teardown is safe, as the
watchdog disable helper does not depend on interrupt delivery and
ensures all watchdog activity is fully synchronized before returning.

As a result, the additional timer and work cancellation is redundant
and does not provide additional ordering or race protection. Remove the
duplicated cleanup and rely on the centralized watchdog disable helper.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v8:
- Add more information about wdt shifted to specific location and
  address comment from Andy
- v7 change: https://lore.kernel.org/all/20260426091710.3722035-7-sanjayembedded@gmail.com/
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
index f3ad2b38cc12..88bb8ab0cd9b 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -590,15 +590,12 @@ static void ssp_remove(struct spi_device *spi)
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

