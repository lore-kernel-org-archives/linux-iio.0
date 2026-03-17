Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE033EAC91
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759864; cv=none; b=ImZ42mpNTikfvXE279jQ6bPFRwUT5FFVT/DE6N/3ZC/rc6N3MvMVVUu4SApBLbIXA71tHwi6MUFUrDFGGNMsbJyXb25gfI1+kgpyUb6BWtpnP1/65UaW2NWpf4UPSLczjDkHgIcl0qRz88IV+/9wOlo++nkJJP2pVyh8/8g/iJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759864; c=relaxed/simple;
	bh=HohRRDF8l3Dbx0JorWXh1uk1N4zs/oYSUkkwvR1Z+LE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrhWSBWszuaC4qDPkVBfUjQR/7+02K3WInUL4niIWBP6Coq2dAP3D34eOhwKWw90TqrflUOgQvFoFORz+oRaD9+QfNzhYse9WFdqP56zpjZXz+Pe0rXmJTol5gNAzNFl6xS7YoFyz1TPYXonxQv7EIiIptLbq02EraBKe6xZr2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PU/4661g; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PU/4661g"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486b9675d36so5935485e9.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773759861; x=1774364661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qy8dwe6FlWYM+ip3X8t+5BGr1q3na3YWkrOYcDJH1sc=;
        b=PU/4661gzUispEAYzY8T2a/J6e0+xLxLH8B6mH+PmWJDTaRoZW1x505xWE3bKflEKm
         yxzyhMQWhC1ORY99BGeH6hipyG8srRVuJT31pvxBjT0XIEdkc+rgxKfeh9q8FcbOhHWG
         8Xo/c+zLJ8XtQttVlYTrWTXWUZwQ7iH+kva8XjagjuIPixHG61/eDqBDWoR4fcjL8gbZ
         FHFGYE+KpnW1exBXR3aMogT/z0tz+b0JpODheP2CqUStT3gktnDPFRnzuy52P6lB406s
         JMuqzr38XPZ8kC8+yBF/EYfdAq7Ct47l/olPUzhRzF1yawHB6vfdfsHsgGV/hwuGc05+
         KWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773759861; x=1774364661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qy8dwe6FlWYM+ip3X8t+5BGr1q3na3YWkrOYcDJH1sc=;
        b=sSE9R7oEdG8fkr0ZLvig6cJC5F6vxQI18ztzi8kd/c1CO9cDZkDbD274/xrmhj476A
         VKulim88LQZuFmLLX+qTzY60Bz2gQq0DDFfzMqQ3SCiShu55sN2IH9B2dk82WSef084C
         y4Lx1cH08g9QpDweKzNZZV/Tezlujvy5jRWPGRu2zoUlVVvf0Bvif68+sz2UIduOi0ma
         3otC85XRa8MxOVudLqYKImCdJTqH+Z4AsvntW4JGMVsiOJ5EYTxR83W987fTtcIKNt2F
         qlLDr9J1cFJ56+egCZZluXImvdc/XqldSY4/3unRsRERAFnmcFfxfX0P+weuTMPassFZ
         nHVw==
X-Forwarded-Encrypted: i=1; AJvYcCW6mAJiLgpDEmEWBngp6FK2Xa0D2S7LBIZU5CGoW7yhAu7KTXkiGu+rfD5Be+M4cyon10Y07KKlgVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Ye+GMNf3sZ+iAdnVxGpQ+IUtHFq6ljuYEjzh+Qcwo9GXYs1R
	alYWgiGpI+sCaFJUBZRXz88NyzTTU8iABkmHen+zVVw0VSuZrbbB5rTH+7pzm2LlBZAVKlq9aoP
	/MEBofeM=
X-Gm-Gg: ATEYQzw/jQQWD6i7qW5iPiUx7yvkf4+fitWZqdO3fJH39uzWpmnxFLJB8Hu8fMQ1jub
	9A3N4l6RvYhxOELofX5wsn/i9lsP7UAMUpmLasl9Jms+BxaPxcaBuFqj3O/Kjcj2ZgNZBspWeKU
	iHYyg4F36km+UcPsfDO5SzF9ucSlA6MVtSPIuyCx85gU5zVp75NqEXwxrzifgSoPUTBGF0dWZYt
	QUX3QDLEJiwSLtjGcZgV6m1LZtXkHNR3CuaEQKnpUa8oOs7lY4rApFGKcMQyMfrnSLtJ8AY2Wqm
	Eptqx2mNDtdDXasn9w/DyeaaxrjsRx2Ioe8TJ4GmTVuR7DYOUbYtWlLNJSgLr/u4V/6Z7Q2FS2a
	QiLl1XfMtsSHLz6vB6uBT77Rhm2MW+x/kTwZLdMBnwcOanwHPkp/x62vt3/3YRqI7S3tyCoOVwL
	fdXopty2gpb51I/A==
X-Received: by 2002:a05:600c:4e4a:b0:485:4135:5c92 with SMTP id 5b1f17b1804b1-4855649360amr292454075e9.0.1773759860943;
        Tue, 17 Mar 2026 08:04:20 -0700 (PDT)
Received: from localhost ([151.37.101.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48634a7ac2csm38692075e9.1.2026.03.17.08.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:04:20 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 5/6] iio: ABI: Add quaternion axis modifier
Date: Tue, 17 Mar 2026 16:04:20 +0100
Message-Id: <20260317150420.3878400-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260317150316.3878107-1-flavra@baylibre.com>
References: <20260317150316.3878107-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3003; i=flavra@baylibre.com; h=from:subject; bh=HohRRDF8l3Dbx0JorWXh1uk1N4zs/oYSUkkwvR1Z+LE=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpuW1zfUcZOZ9QxxP4UfnwEnT+HuNvD8t9POSyc pyp3qizUvCJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCabltcwAKCRDt8TtzzpQ2 X0UuC/0RKlBcYDWfJv9o2PyvSd6XBzrMTqjUy7tvO87gAV8unVKprNL7pSKig+SkxeRAdtf+ACc 4OC+BtTBunaPnc4XWLezw2ZDHuwbjo2hCvvex7JZ0ueWCCYzR8aP3Qm6HX5lwuz+AhZar+DIGBS CYDObE4zDEvfYSLXKM3S4YxUtz/35G4A5mm9OKMmMEfDruW191iaHN6BHRrj+WEw0JGycFmJRPz N0uFqW2LrcUFnhfho7ol2OVAQ1snOOUm1wUitCuwQQAigskotAEhl8BaBdFZ37bmUXEdK/1rUWt WSmB52Q5LIAzI9fae3go6MsqEMFiPqCyNZoVD6AbynYOx6UJCv02cPA3LWC14IeKPPHFoAAEIhV wts+DDOd94HlmV8VbQ70vNWjT2LsYORmaUCtMZDxi58FsuX4h2g/+07hBTT4tBHwYsK14tJ570w 206DdgmQWTtfrSMj2BxqrGCAkBnOl9Ib+h92U1J87YcfTf5P9F863wrjRjRGbKSP0FoN0=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This modifier applies to the IIO_ROT channel type, and indicates a data
representation that specifies the {x, y, z} components of the normalized
quaternion vector.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 15 +++++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  1 +
 4 files changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index bd6c3305dd2b..46fef26e5376 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1755,6 +1755,21 @@ Description:
 		measurement from channel Y. Units after application of scale and
 		offset are milliamps.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_quaternionaxis_raw
+KernelVersion:	7.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw value of {x, y, z} components of the quaternion vector. These
+		components represent the axis about which a rotation occurs, and are
+		subject to the following constraints:
+
+		- the quaternion vector is normalized, i.e. w^2 + x^2 + y^2 + z^2 = 1
+		- the rotation angle is within the [-pi, pi] range, i.e. the w
+		  component (which represents the amount of rotation) is non-negative
+
+		These constraints allow the w value to be calculated from the other
+		components: w = sqrt(1 - (x^2 + y^2 + z^2)).
+
 What:		/sys/.../iio:deviceX/in_energy_en
 What:		/sys/.../iio:deviceX/in_distance_en
 What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_en
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 22eefd048ba9..bd6f4f9f4533 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -157,6 +157,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_ACTIVE] = "active",
 	[IIO_MOD_REACTIVE] = "reactive",
 	[IIO_MOD_APPARENT] = "apparent",
+	[IIO_MOD_QUATERNION_AXIS] = "quaternionaxis",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 6d269b844271..d7c2bb223651 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -113,6 +113,7 @@ enum iio_modifier {
 	IIO_MOD_ACTIVE,
 	IIO_MOD_REACTIVE,
 	IIO_MOD_APPARENT,
+	IIO_MOD_QUATERNION_AXIS,
 };
 
 enum iio_event_type {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 03ca33869ce8..df6c43d7738d 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -145,6 +145,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_ACTIVE] = "active",
 	[IIO_MOD_REACTIVE] = "reactive",
 	[IIO_MOD_APPARENT] = "apparent",
+	[IIO_MOD_QUATERNION_AXIS] = "quaternionaxis",
 };
 
 static bool event_is_known(struct iio_event_data *event)
-- 
2.39.5

