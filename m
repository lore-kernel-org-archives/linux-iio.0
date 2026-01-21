Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4721257F
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014036; cv=none; b=qXz98bjzmwK8OFe1/tFb21Ck4FJiju8O1UhJqHYqkfey9KKEmXA6pOQipGJte+5oXttGb8M5QkQ8rpqhm0RHQIaRZhRvJDeV6kF0Bwk7RJkfxBkXE4ughYcG+BqcPnHPTeg79s8X/J9wanHL61cZB32DzbyhXFHRKNpwToVReYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014036; c=relaxed/simple;
	bh=aDScvW4yWliW8Xd7sbKeWb6p0Ki9fLuXBfu+NmACK3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIxELm9HEEdNEf6KzOF+MA4lVl9ZGU6kjCII3g4xMX/DAAUC3cgiqpAmYgzuNusmkw40J1M0UpFY4bq5Twm9GMXnR4Kj0+HONbnfZqpaIw++b50/LDK0IFSVXvnqldVMMryykkUd48xY6AYNZUGzPy4NqirlUKfY0bJKyQFGohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LqbV46k9; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LqbV46k9"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b6fd5bec41so4157555eec.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 08:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769014034; x=1769618834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cmRpBr7X3+gwG+di/CXGKUch62fetuIxhb27mGTGu0c=;
        b=LqbV46k9F7ng2OoA6jPgb43ZARFeAe6cpzdUBgF13+YgtoozQgRvp3xMZflfhbwcDl
         rv9tQP5mA2I6gSoqE/9gaaSW3h5l8VvB5SB5BefivAZHsPbLTwTRgo0dopCGh5OEULsB
         zk1WrYfvIkIqR42HmqHkxK9+48OKzg8yZT4+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014034; x=1769618834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmRpBr7X3+gwG+di/CXGKUch62fetuIxhb27mGTGu0c=;
        b=PkVEWDGShxo/WJy1lwBn6Z3Xe0a9AJAIchM/as/VA47d8I5YHcqx8Pmq/NwLkeNbHL
         onjvRUVAhzKXf9OaoM4Y8Dmh9eygUcRwXxQfIhIGg+mUiAwVX5TfoaNg5M7X9pAzE7JW
         TrDXu/qNxonf7EjL5dirpk1wt92+Uj4rgoYUzp8pK32EtXj+hlhhsCrgVWOoRS4jehsp
         zjvFhVxtWaa8ySbm4pbxBl6MJyK+/4C/z0CkdQuJtwCjhHFcXle9jOp6mDSC1mlmHCxg
         izFR+YQ6D93rk0e60KH/ok8sqpHk/OP+xsNpa8Qsr/kRkoKqkmwvFN4E46QJOKN7jcb0
         4fjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH7VVTyDu9IuIFChXuEIWGhPhKDuD2p4sg4AKYOz6U3I6TW+9+R6W0/tZAvUBElAClOcSjd/wpCGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEaYgP8ZgpIx5FRsVRReRiqrt/jmGw61ENlLkU0tVHrf4/jynp
	r0ugF/XguVoDhWuk7YxMYS0pAIIXDPIdiJjaFPMCOP6NEU80pdkge0hXjDCG8KxK5A==
X-Gm-Gg: AZuq6aIr0LN9WydRrzJvBqdLE0AqBGHHbFwf9grZ+wNB48JBRgQVswxDNdlVC7FnqXg
	NZuF/E3R8XIHDu06CcF0l1iJqMInrfFRS61jkWiP/DATTHLUFcS2Df9lLKY8q7mkZDN0aLsv5bI
	piTQBZOIxTRhxbPMuv1yFu+/LmMexvP+mrnmAGsF9YZWVaDya64ifO3YmLbROtVV97hQ7YKvje3
	+j1Q/3FobR5DY33iZJYZXPmGCApLDYsAVJAYQVJfV6koM8TTG0O+clNW0AlPJ40i2F9XTOULl01
	8UXqQYJS5HQeUqzgC5zPyA2xsEug7eLSboJ73qcfWscUmgD8oLBYFM+x8gfc2hVKyHBSBGNLJ1Z
	O6Do8U+u1xOxkljrkgj9Uf7zNFHQhrnScY/2zlT8jzi1MKr65DfLuHIiHQD7jbkORq6VtCLBohe
	SKgthV4aheZKxMjM+kkn7fdovyPOXau86dHSu2rZA8ZHKe
X-Received: by 2002:a05:7301:3d17:b0:2ae:6109:9d77 with SMTP id 5a478bee46e88-2b6b414b746mr12671826eec.40.1769014033923;
        Wed, 21 Jan 2026 08:47:13 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:64e2:6cad:8eba:3190])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b710acfe04sm3965880eec.30.2026.01.21.08.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 08:47:13 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
To: jic23@kernel.org
Cc: nvaccaro@google.com,
	tzungbi@kernel.org,
	linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] iio: cros_ec: Allow enabling/disabling calibration mode
Date: Wed, 21 Jan 2026 08:46:57 -0800
Message-ID: <20260121164657.1433637-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'calibrate' was a one-shot event sent to the sensor to calibrate itself.
It is used on Bosch sensors (BMI160, BMA254).
Light sensors work differently: They are first put in calibration mode,
tests are run to collect information and calculate the calibration
values to apply. Once done, the sensors are put back in normal mode.

Accept boolean true and false (not just true) to enter/exit calibration
state.

Check "echo 0 > calibrate" is supported.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Nick Vaccaro <nvaccaro@google.com>
---
Changes in v2:
- Reword commit message to indicate the calibration mode is a state for
  some sensors (light)

 .../common/cros_ec_sensors/cros_ec_sensors_core.c    |  6 +++---
 include/linux/platform_data/cros_ec_commands.h       | 12 +++++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 9ac80e4b7d756..f1cdee2a61cbd 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -444,14 +444,14 @@ static ssize_t cros_ec_sensors_calibrate(struct iio_dev *indio_dev,
 	ret = kstrtobool(buf, &calibrate);
 	if (ret < 0)
 		return ret;
-	if (!calibrate)
-		return -EINVAL;
 
 	mutex_lock(&st->cmd_lock);
 	st->param.cmd = MOTIONSENSE_CMD_PERFORM_CALIB;
+	st->param.perform_calib.enable = calibrate;
 	ret = cros_ec_motion_send_host_cmd(st, 0);
 	if (ret != 0) {
-		dev_warn(&indio_dev->dev, "Unable to calibrate sensor\n");
+		dev_warn(&indio_dev->dev, "Unable to calibrate sensor: %d\n",
+			 ret);
 	} else {
 		/* Save values */
 		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 69294f79cc88a..d363d60bb8a36 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -2598,13 +2598,19 @@ struct ec_params_motion_sense {
 
 		/*
 		 * Used for MOTIONSENSE_CMD_INFO, MOTIONSENSE_CMD_DATA
-		 * and MOTIONSENSE_CMD_PERFORM_CALIB.
 		 */
 		struct __ec_todo_unpacked {
 			uint8_t sensor_num;
-		} info, info_3, data, fifo_flush, perform_calib,
-				list_activities;
+		} info, info_3, data, fifo_flush, list_activities;
 
+		/*
+		 * Used for MOTIONSENSE_CMD_PERFORM_CALIB:
+		 * Allow entering/exiting the calibration mode.
+		 */
+		struct __ec_todo_unpacked {
+			uint8_t sensor_num;
+			uint8_t enable;
+		} perform_calib;
 		/*
 		 * Used for MOTIONSENSE_CMD_EC_RATE, MOTIONSENSE_CMD_SENSOR_ODR
 		 * and MOTIONSENSE_CMD_SENSOR_RANGE.
-- 
2.52.0.457.g6b5491de43-goog

