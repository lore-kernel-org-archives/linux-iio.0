Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378423890EA
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611630; cv=none; b=J1irTmUOiQ9+ETYUJSKxdEmObrooPm8tKOla9VgeeYuixKNYCeeFCDdvoRJbOMUqbbXif9X9JWNWxsJ7lDM80Ugss1fzOgoLMqvMy/3vGunK/r4IV48xthCOz6FvQDgWbQHlpBl4t403394ol7Szzvsap42BrBmMSPaA/WHm3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611630; c=relaxed/simple;
	bh=Ol6p0rZth3f/iRDeonQqxoZNZAQhn0rATMP/onRw3YU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jAK385m5sBJ6e1YR6oJsc2pvWpuQ9vRCDXHGV76sn1RKO3zB5KB+SQI5ClFrP+yzd2G0m0ms+ohB3IxIJLkTXBMBYRh2dx2/eE7QMpnUEaqCKnCWjGi/ybDwr3ndD629vCkUG98eqqkctr4GhSkmzZ2a/oIATmxY+9raGdXcT9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=avJonRFD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="avJonRFD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4837584120eso47826065e9.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 00:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772611627; x=1773216427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBQtYx9tuun6QBYG3+5uaN0RHfw3MtXpDHY198tkVjk=;
        b=avJonRFDiBh9NnOMlP/vV6raypKT+fo2draJZvOzTowzwX2rW7/7Wd7TgmOh1+M+6E
         UAdiE0oQB6bRizYFExSvW0FEmjxYDKW0fLo3LrRownprFhLSHPuqiZ37LFQ2Os7qNifb
         RClw4GrTi3ttKBkEcMLZORNSkGinkMfRjB8VfP02wG8FK5vg5y07hRKaHBjr8sT5BTkJ
         px5yUWMOJ4phUXh3g8QgnkQK8UCsnvjhcjMyl1ifRqmMCiOuNBHbUKDxCsP/5MFc3m6l
         QQRXUoXkwb98rcHZ8sU8ZJHDTRHBe18wYhJNRgZpq3r850RmnCcOIVln+W3J++5GXhoD
         8+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611627; x=1773216427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oBQtYx9tuun6QBYG3+5uaN0RHfw3MtXpDHY198tkVjk=;
        b=T4M4SwQcDPIUsoN0ASnQGvMYZiVFLkrmLzeiLAjx10j8wcscVfMoBJ0gq6Vw+Z/tcb
         J0E8C7x3qQda9/QbaFr9z4/9BV54i5PhVdsKtxsME/Z5mDdqycQ+zmfkfN+6bvnuRO4I
         wM5dAvSb6j6cbDqRXNAbIRuE9HAgqwuXAwaleGGiiETMVMIXcujIrOXkQ0nWTJMflVV+
         nx58Tb0RmYCVtGRH83ZN9xUWIuenS7Z3AZUXBX7OavHUgI0Mly4J4waIUJAVwEMXSBP/
         cV3QSsrKegwrc4tNMRmMcbhqHf/s+Hk4micC6fkj3C+3gvDg85ASHe4rauEgbLTeNXVK
         8mKw==
X-Forwarded-Encrypted: i=1; AJvYcCU8Z2lVkXI6XCbad7TUpsP5nW3T1CB2R7+e213cGUt4JdwB/GYeSwtOx8a+RctjKS7l1ZMC2ElFPck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxYFk4422+qxf+D0JFZiDZfVLIeIbwcPjfxaIHmxBTo74uNqbQ
	o56TscBc22KamzKuXIXeRpjDL4dBRNOCkVVByV8xm5MAkmy4xGVXPQ97EnM4cfnd9rBBFolqsXI
	quU23NRE=
X-Gm-Gg: ATEYQzw/2qeyy8DSjhuVfhIgD/rygfAb0YqcjR0VxJ9e7vVnS7xXC6fMq7OVX1CUlVL
	9lr4na902VO2gDEHXwOG2RrnBZaFuTYZ98MvytsLwvr08nbFNQBej7pBA9u3H74uj+lBlyVqpnF
	mx7IqqKEcuDQGtD9+X6BbHFYoQRiilHJ8TqgLFUO9H1VM78vrIBGhzh2T4q4+vwIr1soqzvMT6q
	08a61bNU91S6cCP/bPBBIERxCNIgh8+XTvDpq87+VhfjrroroUeOeCzBZulZup9yB2v98+NxVZ0
	ErZ5jzJh/uUahsWY796CkvuD/m+UI67lB2jCoCjLyPcA5PL72L+YgvgG6wf0KsxTgIFc4O0RFGt
	E+lpexFS1AlZIbQCDbdf5b3wqQBwXSnQVUHxL96XrY7lX3zzrVgqjKI/dLKn82whcAFZCCrxVOh
	6AfQg=
X-Received: by 2002:a05:600c:1f85:b0:485:17a7:ba0d with SMTP id 5b1f17b1804b1-485198a2858mr14098255e9.32.1772611627398;
        Wed, 04 Mar 2026 00:07:07 -0800 (PST)
Received: from localhost ([151.19.177.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad28363sm2482015e9.30.2026.03.04.00.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:07:07 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
Date: Wed,  4 Mar 2026 09:07:05 +0100
Message-Id: <20260304080706.2844472-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260304080519.2844101-1-flavra@baylibre.com>
References: <20260304080519.2844101-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3185; i=flavra@baylibre.com; h=from:subject; bh=Ol6p0rZth3f/iRDeonQqxoZNZAQhn0rATMP/onRw3YU=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpp+gpXzqY3TDqet6R5VUZ+IRv8tvwkuErdTDGd Lxh9s0qji+JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaafoKQAKCRDt8TtzzpQ2 X6MKC/4lx/3OC+xd/HZeviR7B8SDtAwArzj88cvVqY9LgevL2CVoPu88RInxP0VcFWFuEMcOEJE cMXeRJRtfcm7SydQRp48EioAc66ARJH2hokyWngI4T0O0dkqXGL4RHsnkzqhv7Snv0ZiNPNrtRq Pewp7bnKHalvwiH8A21D8A+q0LCxxRDwa8ZogCuU7eYOLV9daQLfJ0eKijfnvFW5x45qmrSBlTx qk/Sl5HpEcu+1NLyDyZo1PgxElCQOSo9EshxHXmUzY8SdF20Tkd2YAClbwjZJtb9NxMeymv3XRO awq6+UptWFwXRwY5FHIdTdyyIJC45eFI5G6/Yuq7ew5E0B57pAlB31N6N9xzplFUmUOg8A/NiOz Dh1qjN0DmLpXN00HdsEXFNJ3f0bhmUfv+eVOFmv5/8gp3uxngg3P590n6P2EDPdWAjtxX1vCJGI 6A1R2mQeHZ/M+/WdrugPSF4zgxgl/jmILHuoj1Jxj+plxz6sCA1SECtuXy0EQ8x9Fu758=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This modifier applies to the IIO_ROT channel type, and indicates a data
representation that specifies the {x, y, z} components of the normalized
quaternion vector.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  1 +
 4 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index bd6c3305dd2b..54e38ebb044d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1755,6 +1755,19 @@ Description:
 		measurement from channel Y. Units after application of scale and
 		offset are milliamps.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_partial_quaternion_raw
+KernelVersion:	7.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw value of {x, y, z} components of the quaternion vector. These
+		components represent the axis about which a rotation occurs, and are
+		subject to the following costraints:
+		- the quaternion vector is normalized, i.e. x^2 + y^2 + z^2 + w^2 = 1
+		- the rotation angle is within the [-180, 180] range, i.e. the w
+		  component (which represents the amount of rotation) is non-negative
+		These constraints allow the w value to be calculated from the other
+		components: w = sqrt(1 - (x^2 + y^2 + z^2)).
+
 What:		/sys/.../iio:deviceX/in_energy_en
 What:		/sys/.../iio:deviceX/in_distance_en
 What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_en
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 22eefd048ba9..792fbeb0dfa8 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -125,6 +125,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_UVB] = "uvb",
 	[IIO_MOD_LIGHT_DUV] = "duv",
 	[IIO_MOD_QUATERNION] = "quaternion",
+	[IIO_MOD_PARTIAL_QUATERNION] = "partial_quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",
 	[IIO_MOD_TEMP_OBJECT] = "object",
 	[IIO_MOD_NORTH_MAGN] = "from_north_magnetic",
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 6d269b844271..c80ef7c1ed12 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -77,6 +77,7 @@ enum iio_modifier {
 	IIO_MOD_LIGHT_GREEN,
 	IIO_MOD_LIGHT_BLUE,
 	IIO_MOD_QUATERNION,
+	IIO_MOD_PARTIAL_QUATERNION,
 	IIO_MOD_TEMP_AMBIENT,
 	IIO_MOD_TEMP_OBJECT,
 	IIO_MOD_NORTH_MAGN,
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 03ca33869ce8..db0fb75806ab 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -113,6 +113,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_UVB] = "uvb",
 	[IIO_MOD_LIGHT_DUV] = "duv",
 	[IIO_MOD_QUATERNION] = "quaternion",
+	[IIO_MOD_PARTIAL_QUATERNION] = "partial_quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",
 	[IIO_MOD_TEMP_OBJECT] = "object",
 	[IIO_MOD_NORTH_MAGN] = "from_north_magnetic",
-- 
2.39.5

