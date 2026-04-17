Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475238CFF1
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430192; cv=none; b=TOdiXxpG6hhx6e5ZlmT1qakRNBxZMvSUWyAigeCHfZDzoXyO9tqpUJbBGgg2yNaQLtiHBzpLD7T5bIRNtUy7F9l+kida9CLew7ysRA4zLPoRoJv9QJjLDVyeQAsZrJvB6fjwfb/bSabvPuIgzUAbyLiX5c+vAQVJJYurnWYU1wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430192; c=relaxed/simple;
	bh=FyutRze4dwTunn8UefEMTf6/n/UG9pIcPguCaoYkTCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UxNZlwUdk4Rbd8I01YcNQ5VeZz90MsJUQUzZrdt11x03Jvu/xXj3c5/zkwqvttb0lWPGxOP1TGIFGaMxAQ0oSFXjDy/0vlVXH+YayxUeiljZBOXpmsA6+vNNd6WAd/XVX0YR2bEmRnG35J8wB1fHJs5vjPl36Tt5RclE95Gz91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcN7rUME; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcN7rUME"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b2503753efso5860005ad.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 05:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776430191; x=1777034991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRJ9joLNbqO0VrRbkOHdpVg+4neh1oV3/4mvLg8GreU=;
        b=kcN7rUMEKwkpWRaRRtnioGTWXZejUvID5f7uBSZpQn698j8mRSJ57pPNDgltAg74SA
         QsHDlJfMGVf8kCtfYpU0t+k4xH80/i8RLqPlEIQrK1gS9netD2wMNd3I5d6mEQnWJgQG
         tmQC2GfrAPJqhbe8XvdDIwsYpbUO2QJGvakhTYjVIySHRTJH4Frnncp0NVC3kP6qaSgS
         fexq9WemlMcSDtKbx2KkJ9DWZ7uQD8v5ej4+O0ZRouA9vz/emLyPLzhIS0rsTLgRpfU6
         3Lv4W/D+0KI84BPgWClFOYIjn0CRQmw4HYM0ffses9XfLWp/NrZC5QKgQecz7yYPcuDm
         9eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776430191; x=1777034991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TRJ9joLNbqO0VrRbkOHdpVg+4neh1oV3/4mvLg8GreU=;
        b=bt30XKmtqIheFC/SP9l+UWh6xhsfoQyR6/dnpZ++tXp0QQGt0Hdliu5/+K2myLntqE
         f6wDmuro8ZcGuyGq020RCvihXmtueZHUxVMY4LcH7JLxh2cI+44AVk/Fj2mbJNMOtAa5
         MeBvGzIHwTAMjbMTyxwXUHEiErZtduejD93CjEbTGWC1C+RrtmiEOn3F79+yv8sUxsvC
         PKodkcViwlhavQnr9D8oVZC01PCtW1Qxinzah80a7ZjHOnj4g4BceHV9bUWsmLlLZze9
         kz9eNtMC/R4Slememb9CrQqhjbYhBh9EJfQBVVNNTlwEg0LfbyBan8fa2eAZAWi/YNkN
         mhYA==
X-Forwarded-Encrypted: i=1; AFNElJ/vSsiX+fbPDeoz27jyNgygz7EMFrY/7JIrtsacl1dUu3lhnXGK1AfiTgA4ANnZLG7GiK31We6EJ40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb1joNWXD0XhC81lunNNepjpwCFRhPll7E+pde4qFK2BYEDpHi
	KhAZ/fBPvr4WfcqPTergGgW7cMjkQSfYlyXC/Q8tbtVz8FDztqUX1WyB
X-Gm-Gg: AeBDiestBUYYtFHBoAdjH+ySMe+MVGVkprtUHcyMjL4jBXKII1PGREpIKmOFF3wm/fh
	uIMccK4G49n1DZGBNupZiDtP7Gc8tN49CBapN0XIUutH05OtktFa/c8bN+j55ETYhro1KSD4gG3
	Ads5iX3ly+FXKsrBH+ar5gVBfmN3nheBVUH8Yq8erZmrw7tseWVTZXIiW4kxeoJzXy5Zqp+YA4I
	zNZIAHmuT3ytzBJ7qnqrWtB5GSM2Tr5aY3v6cvTdBOiBbHMGGRM0dOHc8VnDHVJCEi01p4dqtZy
	RBtislkPb8//twXv74qNXVXzS6v2XKRwjBecoLUHmjlylDcV3OyvuauFGN2dgQxekYQOFfWiiEv
	AOETRu9vy0SGxL8h8lH0REc0k9vid3sK2/x+wvYMOVnhdkpconQbpTUnEqNaS8Xm2NeR/d8tsil
	ZBInBd5PYRPDGe0pYs7lv48QhAOy/NVjccAy393dcwIi7UXdlGVpnkE+o8sWo=
X-Received: by 2002:a17:902:8308:b0:2ae:c529:a13f with SMTP id d9443c01a7336-2b5f9eb2249mr19149155ad.14.1776430190900;
        Fri, 17 Apr 2026 05:49:50 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cb92sm19428855ad.50.2026.04.17.05.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:49:50 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	puranjay@kernel.org,
	cosmin.tanislav@analog.com,
	marcelo.schmitt@analog.com,
	antoniu.miclaus@analog.com,
	ramona.gradinariu@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] iio: accel: adxl355_core: Use devm-managed mutex initialization
Date: Fri, 17 Apr 2026 18:19:20 +0530
Message-Id: <20260417124924.353189-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417124924.353189-1-sanjayembedded@gmail.com>
References: <20260417124924.353189-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use devm_mutex_init() to tie the mutex lifetime to the device and
improve debugging when CONFIG_DEBUG_MUTEXES is enabled.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/adxl355_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 8f90c58f4100..a310f8e37e3d 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -802,7 +802,9 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 	data->dev = dev;
 	data->op_mode = ADXL355_STANDBY;
 	data->chip_info = chip_info;
-	mutex_init(&data->lock);
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->name = chip_info->name;
 	indio_dev->info = &adxl355_info;
-- 
2.34.1

