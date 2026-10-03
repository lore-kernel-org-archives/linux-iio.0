Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5191A8F7B
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791006974; cv=none; b=KtcHr7r8B0VcCsF/BmN7XPCFymHWWLTMn/7IAamT+jbTyEXLco6+HwUE8kuNtG6l7vz05CLyX2m+7OCX/YfO8tCDnegpC7dyXGJ8kLIpcZzC56ZruAHJyATTXufOhSVyXWg/Ty0+NOXV8rz1i44u/HIfEANOXbHqRId8ZtE4FWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791006974; c=relaxed/simple;
	bh=M+XHvsZCSs8UMt+4cjH5LkDPVR9MydSvltCK2UxrAM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSuYuUHOq1VPF6jJhG5BBRuAdiTuScdnFnHIMLRof1uBJQQJlQScPnXzTuGCTXrWy4GeLi6kUPF5Rq2FQK8oPoLPgD8FUnArfik4Suzqx+dEsYxtjTivg1KUrzlNOeNHOyNsYk3nOrlQw5JyLTV8Jc2eF/7tLDszBX+Njz/zfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlDV96f7; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlDV96f7"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34d2d25127aso21085eec.1
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 22:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791006972; x=1791611772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YETMn4PKQI92wLgHuySNZM6RqX6K1rM2vnhS2RJDbOI=;
        b=OlDV96f7j1MsgIVr6VyU30rwtc26pDpTTANB2emgJnUarw7OQT/9rik7X21iNWfO2Z
         Yel+ShDigrzLAqWVSVMz5nlxJubk8Y0IcyyNA7p0GaI1TCVW2hNNayQuKydeQ2CrEZSo
         mzvUQJKIgluvs7o5nzxmDW9Un8ww5BvpQ9ay3fTuoiOZEKV0AC/7wD3MNwbwBtGai1Nr
         NAci9xV9r2yxv1nugWKKfZPeLKBC7Yegvn5oYnTHKPrkepZQgz5ZvUOOI1JB3UnQB7Lc
         z9GeLM0OjFijDjkrPVo3SzZhit92+8ufpwAeEoDYgxzyFzjnbfdK28AaA/pEf7bb7m4h
         44ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791006972; x=1791611772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YETMn4PKQI92wLgHuySNZM6RqX6K1rM2vnhS2RJDbOI=;
        b=0fvkSuJFOPuqNDJLIKW4BIuKRfJN3mzkS7A0KJ7S4jukoq4zPQBKGTLkuWLdrtSu/E
         4Klq47QEokTXUIxiPQfobTNACDEwfhw/+UX2P4gTCyJbafN0GSlCU4uqFEADtzddYpaI
         7PtNLKF48aadzxcLM3lxj1/azuA55+PEkhP4yNDSRFPW9ICiuh3/qW2IMvtOK9r7Dc3w
         /O3f8TNifahoi20OCLhD45oBwWAH5zY3UFBXLuJzEzN7PMxFggwOAwBM6PDvwVIXTlOR
         48r4koIMVYSZwodJQ496FTZP8FhTgGJimCSFUJAW162OdE8ZwdF2lw2PTaOJgEujwNEY
         NOfg==
X-Forwarded-Encrypted: i=1; AKwUvByvSczvc142iQ6mAaxGTwgWVQKiN5rM7aNC7iyjMV6gQ+wE/d9X9eHouFY5f1pvxhNb31QwYNq+va4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlGjY6N6HUt4A0wGZfGiQTqXeMs6KvB/RZVbkMWEZ1qLdGr/Yp
	GM3iR+8THq7PGJtpNCn0TWpF8YbNnhVwCT3htRfuOqkoRTqW2R93+PAp
X-Gm-Gg: AYBFou3/EjNJdOpLowbiQoYhzsHWtZwnp93qUZ9uYHZLmofT3Mh6Fiqq3HNx5x4q3G4
	blwKaOhrPq+jY1IOWVh2hRtgS4TBWdw1ll4c3MB65qsYGErJiVmagtH7gIF9vkS6aEHgFt2vGrj
	O8PJXEYrpPghb8NR583xbis4YD/pn5EysmYhVoc7zy3Jjw3JEM976XNtZTxkNVnQEjs3YQNjPSk
	uxUKUfxlr1CZEhnwiyC9h7mj5pgp7buojZ4ceTHGuaGuU9UiDFsUAYw2AGpYf8zaUMw5Px5DQwH
	igfGE3VXD6zR4ugGUyfpR9bostKbbNpEpc/ejMUEuc3grTDg7Cze6BJ1JFf6dlS4/WPHAEn8oD3
	2qaqAENGWUyo/j30FdIsvYEX7sy37C2q/tXuLrJKvYJe6tc9p9RqXspPrJPZnsM/brAzShKajV6
	XY3ZtaykVqcadAP2RH751Y/m16kllVxAj15uiU1ZtLg86jQRBrtGxt/7x+nwiPEDv9mnlCaXaVb
	xGk9kfdXk0kx9ynhHQBegD+wK/AFjgyq97K4E5SYkoT6rFmh+tITHtKsjtn02B0no5Pl7ZGofpT
	1pwv8YYzze3z7zFtxg==
X-Received: by 2002:a05:693c:65c6:b0:341:bd7e:da35 with SMTP id 5a478bee46e88-34f1508f93amr4641259eec.11.1791006971710;
        Fri, 02 Oct 2026 22:56:11 -0700 (PDT)
Received: from kapoor ([117.235.138.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fcd065sm9960995eec.19.2026.10.02.22.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 22:56:11 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: common: scmi_sensors: fix truncating 64-bit divisions
Date: Sat,  3 Oct 2026 11:25:55 +0530
Message-ID: <20261003055602.145118-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_div() divides a 64-bit dividend by a 32-bit divisor: the divisor is
stored in a uint32_t on all architectures. The driver passes 64-bit
divisors to it in several places, so they are silently truncated:

- scmi_iio_set_odr_val() divides by uHz, which exceeds 32 bits for
  sampling frequencies above ~4294 Hz.
- convert_ns_to_freq() divides by interval_ns, which exceeds 32 bits
  for update intervals of ~4.29 s and above. If its low 32 bits happen
  to be zero, this is a division by zero.
- scmi_iio_get_odr_val(), scmi_iio_convert_interval_to_ns(),
  scmi_iio_sensor_update_cb() and scmi_iio_get_raw_available() divide
  by int_pow(10, n), which returns u64 and exceeds 32 bits for n >= 10.
  The SCMI exponent fields allow values down to -16.

Truncation results in wrong sampling frequency, timestamp and
raw_available values being reported to userspace.

Use div64_u64() and div64_u64_rem(), which take a 64-bit divisor.

Fixes: f774117c96f9 ("iio/scmi: Adding support for IIO SCMI Based Sensors")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606040245.XfmRpBhA-lkp@intel.com/
Assisted-by: Claude:claude-opus-5-5 coccinelle
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Compile-tested on x86_64 and i386 (W=1); I don't have SCMI sensor
hardware. I checked the arithmetic with a userspace model of these
conversions: e.g. a 5 s sensor update interval is currently reported as
1.418373 Hz instead of 0.2 Hz, and requesting 5000 Hz computes an update
interval of 141837 (does not fit the 16-bit field) instead of 20000.

 drivers/iio/common/scmi_sensors/scmi_iio.c | 28 +++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 442b40ef27cf..16ec1fa36e7b 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -14,6 +14,7 @@
 #include <linux/iio/sysfs.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/scmi_protocol.h>
@@ -70,8 +71,8 @@ static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
 		 */
 		tstamp_scale = sensor->sensor_info->tstamp_scale + 9;
 		if (tstamp_scale < 0) {
-			do_div(time, int_pow(10, abs(tstamp_scale)));
-			time_ns = time;
+			time_ns = div64_u64(time,
+					    int_pow(10, abs(tstamp_scale)));
 		} else {
 			time_ns = time * int_pow(10, tstamp_scale);
 		}
@@ -162,7 +163,7 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
 	mult = scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
 
 	sec = int_pow(10, mult) * MICROHZ_PER_HZ;
-	do_div(sec, uHz);
+	sec = div64_u64(sec, uHz);
 	if (sec == 0) {
 		dev_err(&iio_dev->dev,
 			"Trying to set invalid sensor update value for sensor %s",
@@ -237,13 +238,10 @@ static int scmi_iio_read_avail(struct iio_dev *iio_dev,
 
 static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
 {
-	u64 rem, freq;
+	u64 rem;
 
-	freq = NSEC_PER_SEC;
-	rem = do_div(freq, interval_ns);
-	*hz = freq;
-	*uhz = rem * 1000000UL;
-	do_div(*uhz, interval_ns);
+	*hz = div64_u64_rem(NSEC_PER_SEC, interval_ns, &rem);
+	*uhz = div64_u64(rem * 1000000UL, interval_ns);
 }
 
 static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
@@ -269,7 +267,8 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
 	mult = SCMI_SENS_CFG_GET_UPDATE_EXP(sensor_config);
 	if (mult < 0) {
 		sensor_interval_mult = int_pow(10, abs(mult));
-		do_div(sensor_update_interval, sensor_interval_mult);
+		sensor_update_interval = div64_u64(sensor_update_interval,
+						   sensor_interval_mult);
 	} else {
 		sensor_interval_mult = int_pow(10, mult);
 		sensor_update_interval =
@@ -395,9 +394,9 @@ static ssize_t scmi_iio_get_raw_available(struct iio_dev *iio_dev,
 		 */
 		exponent = exponent - scale;
 		if (exponent < 0) {
-			rem = do_div(resolution,
-				     int_pow(10, abs(exponent))
-				     );
+			resolution = div64_u64_rem(resolution,
+						   int_pow(10, abs(exponent)),
+						   &rem);
 			len = sysfs_emit(buf,
 					"[%lld %llu.%llu %lld]\n", min_range,
 					resolution, rem, max_range);
@@ -491,7 +490,8 @@ static u64 scmi_iio_convert_interval_to_ns(u32 val)
 	mult = SCMI_SENS_INTVL_GET_EXP(val);
 	if (mult < 0) {
 		sensor_interval_mult = int_pow(10, abs(mult));
-		do_div(sensor_update_interval, sensor_interval_mult);
+		sensor_update_interval = div64_u64(sensor_update_interval,
+						   sensor_interval_mult);
 	} else {
 		sensor_interval_mult = int_pow(10, mult);
 		sensor_update_interval =
-- 
2.53.0

