Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C243369D70
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051513; cv=none; b=teIvyErbh95+kum9UfAMRmlmJodqr8XgKzV9qxmFsDGgmZRegVtuJocCxmYcimD8qrJC+v7CmLLPeEqeLOewW7DN4tfDU4ghMI7lrpOBc/GuXMGVZQ804KVhwPqvqMsMMTDPz5F1sJ9QBMLrcnM0BnFW5PkF4tTj+lAM2MezOlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051513; c=relaxed/simple;
	bh=QuD01jJQSvE8R5xMlmBpQ+/u1Qt6bvUX20bJXOgIMzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BIPU2EKcaooKj4rR1lgLrsyR9W2RNJhex/sFVxcrIm2kpVAINSOVDbEZr0zVe7+PY2FSGi+ApYCnOS77uykJBbBASQoOEnOQcYhcXbvepj9Y0vvTXd1KJdhb5u5L7ItIiQM75cQe+cCgivhxGJ+DIYSrmGjUKsIhupB0C/z+UVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcWrQNX3; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcWrQNX3"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-393b0fa758fso18011971fa.3
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 03:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780051510; x=1780656310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTiUmxm2e7d2JB+Cngp4w/ag6Fk1gY21uN8oBR9XC1k=;
        b=kcWrQNX3e3KO8yPWpgfvifF/oAj0BlruAgx1n0OUfs6Cxr1/vBpYDpqjarLI2E4ogu
         BItPCX8Q9cMAloU41ruXEVXEvXXag+mIScjaNEhkx9bq7+42THwRtOpGzOwoK+lEyu+5
         qYinvPthzwz4+tcXX9wTqTXDux4nxo9PbdQs0fSgYjLTCz3Wi//qQ3+fFX4QN8NnzrOK
         ZiSp7b/3pwTXEJ3hoKhvqIBWv28uLA8OLMb31LT7lHe5wtl/EjjSYr74247IAKzzt1rx
         VOOxQDJg09Z1Vyf0cfM65QUszMZ5v78u57GBIneHKxVpk7QDoDbkZ5jfyqvCbIQ9O7dM
         a/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051510; x=1780656310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xTiUmxm2e7d2JB+Cngp4w/ag6Fk1gY21uN8oBR9XC1k=;
        b=AJwrVHT5shu9kXipDqLre8mMXP5fxWNrfp7SnEhYwNMo68ocoWIOkufSJWK/H9Ja6m
         blmKVqOUz6fFAnGXcMbBRs6a3zs2cT841Pf4PHdTzEqmHw7Zi9dL8jdsP/65By4BSli7
         6i85lLDNpeDoWQnwZIECHmRUZtMfOcekj5+T3gOwCtWQYOjqFDK7i/vG9Z7Uy14QBx/t
         WU6d5EnQQnXCoAYSMt4KiuQJhkhvJzQfRwANMvzgi8lp+nqavpgpjv+c2zNvrMDDpviV
         G5lPw203SrFv1rV8LXVC9eL9eJp7UnGDScA4tdzF/ZiKiSBKvAuT+Q9o7YvcFeKC+LEO
         hRRg==
X-Forwarded-Encrypted: i=1; AFNElJ+SDl9QSAr9K+H650oEkNSPQDESQiPmKuwQXx94GkpeVk7VW3z7HhSIZuNs0gwVZq+R8s+zGmfTJYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNwSk0geNhDCgQ/YKVYAmsEWl3/Rsf+cCLIGxdf4QYvIsm0Zwy
	Yq9F0Jbrs+MW67dmCreZLyVYhEAcd32aC0doWjvVj6kDa2AV39C/Aaz7
X-Gm-Gg: Acq92OGjapITiW8Sd+eO6oz6Xj78k6pLUzl/F5URQWCcrm9Zj17/NZX5SH5mvcnJ5XI
	MwhBlKpgkWUKpVeXPgrId2Z/xk05TVUOj35zconbWWRbgPrzApz6kGpTu2TW9r5sXuIvQqmHkZV
	Eo8lme6vXxU4LwW6Kcix2VI5oZJGNHaXlN7XD4tIUsTfzhPxvNUCbjYAR/q5CcpFLukolxE3kwW
	mRwZRsM/g68X2HA192nr4Vrp3Zeq62pgzkb2EOefU569nIUxSH6y/+16Kz8bZmpobdxl5qCJNO2
	IpbLj0YUUdAoyfb/BmE6PtXOJ6JwgplhbaTL9n8WGU5C+zZpHc8S7piaAJ/GyiBLi6nRz3yQw7U
	tMLF+15wTw644C1anCYnwI31DiY9ggQwOBySyK64JSm94beONRs9nzoQMwwtLmCNOFONLQnYULZ
	kKqrYuvzvVSB/cHga6cu3I1bf4dAnz7WkBZuQ/ekAGBrnrXMmoGdQX6qo=
X-Received: by 2002:a05:6512:a89:b0:5a1:4712:376a with SMTP id 2adb3069b0e04-5aa594bac11mr306522e87.8.1780051510356;
        Fri, 29 May 2026 03:45:10 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b071d25sm205269e87.18.2026.05.29.03.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:45:07 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iio: light: isl29028: use devm_pm_runtime_enable() to fix probe error path
Date: Fri, 29 May 2026 15:44:53 +0500
Message-Id: <184ef63b17643278dde6b9c15a9d6d1defd9d7c1.1780050609.git.sozdayvek@gmail.com>
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

isl29028_probe() calls pm_runtime_enable() before iio_device_register(). If iio_device_register() fails, the probe returns directly without calling pm_runtime_disable(), leaving the runtime PM enable_count unbalanced. On the next probe attempt the kernel logs "Unbalanced pm_runtime_enable".

Switch to devm_pm_runtime_enable() so the runtime PM state is unwound automatically on probe failure and on driver detach. Propagate its return value with a direct return on error.

With runtime PM now managed by devres, isl29028_remove() no longer needs to call pm_runtime_disable() and pm_runtime_set_suspended() explicitly; drop those two calls. The remaining isl29028_clear_configure_reg() write does not depend on the runtime PM state.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/light/isl29028.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 374bccad9119..4fb0262b214a 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -615,7 +615,9 @@ static int isl29028_probe(struct i2c_client *client)
 	indio_dev->name = id->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	pm_runtime_enable(&client->dev);
+	ret = devm_pm_runtime_enable(&client->dev);
+	if (ret)
+		return ret;
 	pm_runtime_set_autosuspend_delay(&client->dev,
 					 ISL29028_POWER_OFF_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
@@ -638,9 +640,6 @@ static void isl29028_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-
 	isl29028_clear_configure_reg(chip);
 }
 
-- 
2.43.0

