Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A03CC32B
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051520; cv=none; b=qI4KKg4OonEW0gPm/MosjclWMTa3F561tP9H7phMV1CAwjTmVKcFolFkKgUm7uCyU9b3HEwKEEofpLvoZDNTsduNdJYzBUEYwqYvJ56a/AumbJBMD4yigUbcsCHdNAfdfyrPVtf9i1Ca4DSxhJIsZVZqxnHF6ssDBA3bS1DI6Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051520; c=relaxed/simple;
	bh=Qg+YOvOsxFa1FjF9pxlEVUZeNV4nkT+8W/V7DXn4Wx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWNJXkh7toGaXK9k0K5zHOyPPyECAA11fn6UJADa+mSFGRYZmqaqCc8AkuDrVjAsGnFZ6AOXPXcCg4hisUrt4H1SrD3tPUO4aPVj+p5I90539ItfECkT1UlLgK9QgQtf/sGLdmqwk/DfkIRdbijLJ/H6IfEtw4oIRXThkYDkT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEgahbHN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEgahbHN"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa5a77c07aso54084e87.2
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 03:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780051517; x=1780656317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0MP+Ex7cIEzzP8tyMPl3ZCHPMlkjCOuy2uaX8dY4Hw=;
        b=PEgahbHNh7J1XKVUfIxVysV2gjwinqAcfr2YMwyaA4fESmsohXDxfqdmuFkO+Z9mMK
         jcaToBN0GISvJ4VZGz2dG3MTrPX/dCQvVVq2V95ixYtWQzV69+d849bUN+L4fAEidvci
         Fbj3EJT2iITYu6gkk5JDm2gn98NCGYsg/wIUX3bp+3rB1swMNqGpWO49MkTEvtMN0lK+
         DgxNehjTkoTrwsrRGkCtuSbVnreKMwnno55x1JY3DAYU5wT8dR7jtD4Aar+watuvZup7
         jfBCutlz3SJ3xlf9GZBc5St0biFxQoI0V90o3IXNevozKQRe3Ejlx3/MmLmPtd4NHl0k
         lhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051517; x=1780656317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v0MP+Ex7cIEzzP8tyMPl3ZCHPMlkjCOuy2uaX8dY4Hw=;
        b=Z7gVlb4l4hp27eNF73VD/RLxNQR0x3buYxemO8VVHYMhVnyKMn7OMikDuwIyGfF9BB
         UFkjz/wRIkzVf/FIzv7r483BLhdczcI+THSqAGykqgAByq6QKr2K5gA8edLaF1ZAO3WD
         e7V4i60VLwlAXc2xGf+pnbjsEIggyAwi8ZWe0yPpOA7BlPcEK4mtHteJn18gi23SSzKm
         f7XnVOROgbTkRWAgQBLN19lXo9ZD+W+rfriKFjMJFKaI1wrOBpDXQ5JPCozbCzTKz46y
         s+razhiFynDJtMVFfOVJ1f8gZ8pZXv+tegML4b7WOsPAIYTydmorxDIRBscT8fL2y/Sg
         uyng==
X-Forwarded-Encrypted: i=1; AFNElJ+fqaa/X0s2DOMPH278IgbJWuFGIU9aaf/Abkvca5gUoAl7oxp4KCqadGiWHojp3hVHAgJFgzJUTZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cYBhAl+hX6s7cpZGbVsG5grCaHZzuuJqzzU4VoH6Yoi2GazR
	PJxF07nRoyGlMaC5HjWgos0Vwbas3L/t9hxcu3kYfHNlf8RCdDWgcZP6Jf6asD99
X-Gm-Gg: Acq92OFeq3PbVbzgXhygBDz/jTY0NrxxyZ00GsK44FKx0g5gYXiI1pG/4DpbOdEF2FI
	G8cu/DzjVEM8gzEojYfBfLZl/D1Xhbmre5GQWDnOxsJ4N2ejd1qGNjct56d9LFo5gW+7Nd9+N/0
	+2mm3NA5nz0YQTM8qXZCVJVCaCKqetawvi2ckglIf8qFy6+PrN/PntWdJLWhi9N5J9ZfUPSCgZv
	LyhRC83hhdT70VMH4pWVumj6CUfXHV2sI45HH9ht8QPfYPqeM+xKf1kkanP714+IwQcMASuIiJu
	cQd+tziD4mWgnAZ8bHPBDyY8c5FlvdvUyaK3yPV43bRDS6tQq8ZA6ikbV0zbVmgR344y6mtPTgk
	SUT7dIgaM2LrGEcJlPgVCS22XHcJ2quOFb5tUh1Xtbb4XMpsY/+c5PAQrgqjbVdAcj7Ipddkah4
	1zk9cyxbHffMr2FsOSbPD/0ifRVsHp8BYNpiKDBcRVSp6e/p+2spxbITo=
X-Received: by 2002:a05:6512:1304:b0:5a4:f0:c4c4 with SMTP id 2adb3069b0e04-5aa594c1db9mr260623e87.7.1780051517040;
        Fri, 29 May 2026 03:45:17 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b071d25sm205269e87.18.2026.05.29.03.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:45:14 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iio: temperature: mlx90614: use devm_pm_runtime_enable() to fix probe error path
Date: Fri, 29 May 2026 15:44:55 +0500
Message-Id: <983359a9d0ebdad84f47a8ea95301a9626bf5abd.1780050609.git.sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <cover.1780050609.git.sozdayvek@gmail.com>
References: <cover.1780050609.git.sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When data->wakeup_gpio is present, mlx90614_probe() enables runtime PM with pm_runtime_enable() and then calls the non-devm iio_device_register(). If iio_device_register() fails, probe returns without calling pm_runtime_disable(), leaving the runtime PM enable_count unbalanced. On a subsequent bind attempt the core complains with "Unbalanced pm_runtime_enable".

Switch to devm_pm_runtime_enable() so the framework disables runtime PM automatically when the device is unbound or when probe fails after this point. The corresponding pm_runtime_disable() and pm_runtime_set_suspended() calls in mlx90614_remove() become redundant and are removed; the existing pm_runtime_status_suspended() check and mlx90614_sleep() call are preserved so the part is still put to sleep on unbind when it was not already runtime-suspended.

The edits stay inside the existing if (data->wakeup_gpio) branches, so devices without a wakeup GPIO are unaffected.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/temperature/mlx90614.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 1ad21b73e1b4..9e09597a1c31 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -625,7 +625,9 @@ static int mlx90614_probe(struct i2c_client *client)
 						 MLX90614_AUTOSLEEP_DELAY);
 		pm_runtime_use_autosuspend(&client->dev);
 		pm_runtime_set_active(&client->dev);
-		pm_runtime_enable(&client->dev);
+		ret = devm_pm_runtime_enable(&client->dev);
+		if (ret)
+			return ret;
 	}
 
 	return iio_device_register(indio_dev);
@@ -639,10 +641,8 @@ static void mlx90614_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 
 	if (data->wakeup_gpio) {
-		pm_runtime_disable(&client->dev);
 		if (!pm_runtime_status_suspended(&client->dev))
 			mlx90614_sleep(data);
-		pm_runtime_set_suspended(&client->dev);
 	}
 }
 
-- 
2.43.0

