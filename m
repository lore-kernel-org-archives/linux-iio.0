Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A133D091F
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051565; cv=none; b=Jt2CE4I5FT9WgENTSG+M6KQnRhTpAjZ99O94gB0sC5xub3NcB5sNo09pOCrwb1HMnLl6GS9DjBymnps/Si1JgLeZ3IyQYPd1lQKyuWMl5C0/dEZ3YWf6EJZRw7uBPCc6nyrR1kaeugbhqaYKFPB1L1Vmy3mv81mG+DTw+ky1yAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051565; c=relaxed/simple;
	bh=Ds1IePhPH8cdXoDJgltMRTsR7yErO+r38H8TLfydJzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gL2c4Zz+sBLk3wszMyiJXGVZPdmNWmGn1ZWlvWAYuw9sCTqPRPBqrPv+t8CSt1f3H1blpaRUXYnS4JU1RUpnalqQca+fiHQmYgNHZIxkPYiYA+REq3Vck0gZk7E4vfA5RoX+jRyxayvTxWwVygXnv5aFdxwrglj/DchJl6fw+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYblXAsC; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYblXAsC"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a8b18efe47so1119405e87.0
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 03:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780051561; x=1780656361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrkG2GgwE7d9GVC7/yBvpw/L+5Pl56q+Sn4VeitLYBQ=;
        b=aYblXAsCqDdv+KXBmqJqehuByOZaXVLkINp9BGpq5p9+cVg6HJU+ysT9lFt7WFfsZg
         LP6e51rR4qcS6ut0KUqB4BB8Onca8L8aUABSq7diuDB7nZIGBedAbqNZJKyKjw2RinsL
         HGngoEQFp8CulNqE1hZuPZuN881jNz+syWpfxQfubPt9rNZ8EeA62lQrMlEMupu2u+9j
         6+CuBoppG7iOJu2/YDta9P2pRxhSv+YbT+fIWNT4J8HTQ8jPEIUsg9PYkj8Z1RoXFucj
         8aU8rFuK7wlDpO/1At44YuoKL5lWZPY4TFEs35dLKQsc2go5ArjZ9FhWtCiS+5EhxpZf
         lCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051561; x=1780656361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QrkG2GgwE7d9GVC7/yBvpw/L+5Pl56q+Sn4VeitLYBQ=;
        b=BaVGkZXxRyKEmMlidlzh/9scESSRVJZ3xR9UAlORTQ1kw/wKgkQOblHQu3TLMdH2F1
         k+1cR3fLTn0EmPagvGOE/gbTgihXpcJhEDfHs9W69/DAdYpIoStIz8uqa4SWwIBQzD3F
         mCcwsQVeAY/VWwrMF5emI2Tb1ZcdgCIi/c/MbZlIN/I2hfq4vgkqkPco3VTverUqQ5DI
         HOJyPxyuz2mjVZ1eAkyAr+9tbMgK5yvKF0DmAqsRwR+kqex7yTcbps67adWBFxJvr3Ly
         8s4LOPQUzSQ7jRmgAkM52WP14BDgomgk/ssg8IgMyI37UzCKQhxpRHtd0jvqrAG0urom
         HpNw==
X-Forwarded-Encrypted: i=1; AFNElJ+C+SpUGioujN2jDAwTUNqeXl8R/UzCAdGMcylvkemqWvxfRRjgC5i42CCUfzF1kt4GJTlZJcmZz/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEdTmU5J9Z53HF4Tizn0YKNIJkTmbRceelbqoe0o6JHMwXdQQ0
	GAf4+MhhaB8aYXn46cYMHewB83JXuIf/13IW++Ej4zXKPRiq/l7zmJj/
X-Gm-Gg: Acq92OGehIHFJoU8/IHHMW93SHkWtcROu59kpzCiLyk/oZhPLvXH47UManBbGehsGm9
	TyJl0X+NGiTVKCVGY+C8DrrzWvmFgAHsVeAb6wVrXYz8y4ESjBElXIyEY6oPFQSQaCQ/dPSbU46
	X8Nxx4fHSROqJdipPUGgy/SkGdD7xfE0ej0YSijOWXBqGJgdeXs7nWjk0yY6Srbg9lQXvB8WLTN
	O95pIKfoquV4Mteolsy5UXXrDOKBRyWh6B4YxJPW4NQYLuq55zyKH9KKKqYbnbdGmY5kAJiReIE
	lwrLEYiC41THWmp8j5+sF+66Um9prqpP3j12DmzHxwf4VE4/pQVLHwA4BZK0ma2Owl6C4ny8g/o
	RlFx/D/lYNbM1Q6696pY0rEeu7uE0xtSdG6MZcXtf9O3LtETtlk0/7r7+S6JMVkmJ7fe/JdXD3p
	ClEiyZGTEc0U2UIKj7NraVnfnZF4E3byeH0bBj/DfPEh/UE8A9hg5GB/a06Z+F+rzVqQ==
X-Received: by 2002:a05:6512:3a85:b0:5a4:18cb:8850 with SMTP id 2adb3069b0e04-5aa5952acc3mr285910e87.6.1780051560916;
        Fri, 29 May 2026 03:46:00 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b788811sm192604e87.63.2026.05.29.03.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:45:59 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iio: light: apds9960: use devm_pm_runtime_enable() to fix probe error path
Date: Fri, 29 May 2026 15:45:43 +0500
Message-Id: <abf95e4e9a43c08ce429578ea067155ff5178d73.1780051096.git.sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <cover.1780051096.git.sozdayvek@gmail.com>
References: <cover.1780051096.git.sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apds9960_probe() calls pm_runtime_enable() and then several operations
that may fail through goto error_power_down, ending with
iio_device_register().  None of those error paths call
pm_runtime_disable(), so the runtime PM enable_count leaks on probe
failure and on subsequent rebind.

Switch to devm_pm_runtime_enable() so the enable (and the matching
dont_use_autosuspend) are torn down automatically.  The probe error path
on devm_pm_runtime_enable() itself is a plain return because no hardware
has been powered on at that point.  The pm_runtime_disable() and
pm_runtime_set_suspended() calls in apds9960_remove() are dropped; the
devm action runs after .remove() and handles the teardown.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/light/apds9960.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 785c5dbe2d08..edbf149b931e 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -1074,7 +1074,9 @@ static int apds9960_probe(struct i2c_client *client)
 	if (ret)
 		goto error_power_down;
 
-	pm_runtime_enable(&client->dev);
+	ret = devm_pm_runtime_enable(&client->dev);
+	if (ret)
+		return ret;
 	pm_runtime_set_autosuspend_delay(&client->dev, 5000);
 	pm_runtime_use_autosuspend(&client->dev);
 
@@ -1123,8 +1125,6 @@ static void apds9960_remove(struct i2c_client *client)
 	struct apds9960_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
 	apds9960_set_powermode(data, 0);
 }
 
-- 
2.43.0

