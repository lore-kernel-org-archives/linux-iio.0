Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB93E224AF0
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570828; cv=none; b=So5mJ5zi5hwzHAWIh59yizxxWTJF6xxQvWYPLxBA+gqI1Dr54NlZGpPWSteP7pW/VH/Ig4HORqS1Diksh8xPuG4Niou2NWKt9rHFn/qDnQgh1F2lJdiI7+8L3N36y4ImVT85ORAZTO6Jebp7zQmCDyw9SQ2i6PtginV70P6ElWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570828; c=relaxed/simple;
	bh=m55Oq0OM42E/H5AtUF+f5F1AKPGvAsarLBXNrruuBrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwRN4XlpgqVFFgVsFjBSuGMqgZv21glq7nfkgYN5r8XaAqzgsUqzJatz4je0huoUiKS+xnNcc17RHLi5IjaSWRw/HSNBwsDck4qOQMGzLWabh6QPk4KnQBiGAx0bu+/BTRe2umJNKHqIrh9Ras8hXM6KQ8yQt7LfusERLEP1mgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VzoCQ43k; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VzoCQ43k"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b720bb90d0so5830027eec.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2026 19:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769570826; x=1770175626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XNqURX/4DzNha23BzKt7hSs6dV3TsScOiZxeTj4ynNg=;
        b=VzoCQ43kC3h94m4TU2DfNBbb+cLh7FK4FojT2x8sYCB3NgmsHzowCcdngdcnltkBaS
         zQNJTA5tiaJEdOyhawGh6fiUfhn4kclT5AZ+lTcLjxDTxN//jP7ptZooBLJbeNEbahO/
         D1fQmFP9y4GmsoljRnBTocQ7o+Ib9Yzab/uPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769570826; x=1770175626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNqURX/4DzNha23BzKt7hSs6dV3TsScOiZxeTj4ynNg=;
        b=p/hsmgHy+GxTIPes5bFwmqSv/bApgVhECu08LgDIT/G5IuiogiPTF5zMPxfnyLbo9x
         RtfftAWbA03NvvVrrfP1EQD84pggtqi5uVi+DK1+8hqaGXBrWLnfubk0cVQ5wWtcuOVP
         Vcy7h7TJBrdkgEfKDWFemybjjvzY4cajfSyV7jfwm9GGA2lLsKXohB3yoe6Q2bjcza9d
         vUl02/OxhPBukzIIE5fZ8o7X7DFxn0e+9btHUIUxrRcQr5OVNy46g0lSQqx/YUnIGYgQ
         1tcBse+jk9nwUD8Q9Upzbuf4Fb0Xr1j9k1D2Q+4H6zleURXF5cM6SbATbqz1ikcYizZO
         f/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnx6YADMg9MhhO00XyQ8NipdgFNPpn8/BIQsO3g0TSe+Xicwbbs/6pritje5Ch0gx0ZheGyAQvd/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp1tu4JHEAzMhWOr3hLuAyS5OhiPiYYGq17Zagg+/IcAWF6vHe
	V1HAtgj12//MXQ91lQ2Z7F1fwKYwOXvkDhVDGGlAj774SZJ70stBecJahDBvFjPEG+OvgVd8bhM
	4Ams=
X-Gm-Gg: AZuq6aI+yDLy60TvZ5/bsXWDEQ6k9qBlNJoYQqg9ayZpKqDhLFyACkHo+TDb3l1hupg
	+S35jb2nW/Dqmga0kNrcwbb3JqVWiMUX9zlb4nPWHImJCPHfWB4zSB+WSx/yWPEETVpwaKnojYe
	pO84c4d0DAuR2vuuU6jPGniN7rLs0z96u3tMhHjJANR1KhaFk3e+BHTW7D560lgHaz4dhISOJzS
	wDmnUPKH2HTDtGWL4mMDUTG35qEZ0N0jWdIFWogr1XRBmJLIcap9cuNUACkQyRhpJYItb/OeZkF
	HBXoujAF7dRypYP2dg/CbonTUs4fT8EvE+RIhkhOYQY1yRY/Yb+ohK6qV03MRzZ6F+PxkVBngJg
	AQFn35qbBZm4O3NN3B0PeJyr4IAb2KVrLX8uxwVeNIBroElwwPZoRpY8fuH7iy3hfdHRtgkIPAq
	6i53pB+0jbFfXeiX80c3JlgCwB0ZRI1JvwzOHmdk8SXtcXvGqESsDQkFA=
X-Received: by 2002:a05:7300:72c5:b0:2b7:1abc:a6eb with SMTP id 5a478bee46e88-2b78d8cc6dcmr2587933eec.7.1769570825897;
        Tue, 27 Jan 2026 19:27:05 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:bbd7:b5c3:7c7a:45ed])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b7a1abeb6asm985555eec.19.2026.01.27.19.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 19:27:05 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
To: jic23@kernel.org
Cc: nvaccaro@google.com,
	tzungbi@kernel.org,
	linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3] iio: cros_ec: Allow enabling/disabling calibration mode
Date: Tue, 27 Jan 2026 19:27:02 -0800
Message-ID: <20260128032702.1714041-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
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
Changes in v3:
- Update ABI documentation.

Changes in v2:
- Reword commit message to indicate the calibration mode is a state for
  some sensors (light)

 Documentation/ABI/testing/sysfs-bus-iio-cros-ec      |  9 ++++++---
 .../common/cros_ec_sensors/cros_ec_sensors_core.c    |  6 +++---
 include/linux/platform_data/cros_ec_commands.h       | 12 +++++++++---
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
index 9e39262437979..3de1dfc983893 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
+++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
@@ -3,9 +3,12 @@ Date:		July 2015
 KernelVersion:	4.7
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Writing '1' will perform a FOC (Fast Online Calibration). The
-                corresponding calibration offsets can be read from `*_calibbias`
-                entries.
+		Writing '1' either perform a FOC (Fast Online Calibration) or
+		enter calibration mode.
+		Writing '0` exits calibration mode. It is a NOP for FOC enabled
+		sensors.
+		The corresponding calibration offsets can be read from `*_calibbias`
+		entries.
 
 What:		/sys/bus/iio/devices/iio:deviceX/id
 Date:		September 2017
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
2.53.0.rc1.225.gd81095ad13-goog

