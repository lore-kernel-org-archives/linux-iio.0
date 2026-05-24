Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955B3324B2C
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779655879; cv=none; b=T5vF+fE3S3jiXvJfmS++w/qqmhse4FjvDYWVU3oWzTTCbO+rBCJkmByTWNr15rg/hG16PUZtwUwgYo8/sxyZkY6crtZ2yj/ortPpeJBYqDibLp+msY5JkG251dGgfhhrSjEwuuUDnRKE07j2J4WiyslSRMiEzCrSY8zWT8fKWSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779655879; c=relaxed/simple;
	bh=V2o/vJV29MW00MzllS88rek3h8IxCCPVdHA37Y/IsL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4Ufcz2Ug8wKzRx1C3xQVEtfCa53G2+sbWeqDuUBxkVtHRaqyXxZmJ44EZlrN9Tu81Ppnynj/K0iwKwtPnO+XGuMCpVyiaR/86XsviFtTuMI7WU2iE40rCzyAXN1Uh3IvRJ0ec0DhqGCPRpWws76/P6TJOSCwW1qb0rcvRRl+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwt3PX4C; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwt3PX4C"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso4991823f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 13:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779655876; x=1780260676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgZxqqtEk/bcjKKyOMFKpuNhp2tz27mBRUcefyZzmdc=;
        b=kwt3PX4CwQiefsHk5NL57J2GetGpFZPhNDsHy1xt181H6YuvNC2iFQpPLIhWF8AZVW
         v+VAUTxyJQdWORwJEW9I2hN95npm5345WLRVHi8BpXhMpkSBpMv7TLZWfOP0kgbbaY0t
         ykKb7C3TtTy0PTu8TCBDWgsTzRvecuHdt78ZXP4ylahFe2G8M5NaO5eIj29U8NWn7j77
         hLujKJZ1qDmTcNR42asp+dA8lydwDxoY5JSg+QeYa7fu8hzxI46P7TveWwBF1gs7yiiZ
         FGm4/fISLHA35u34i5uoAKYTcNOAzuhwMgEavkQSD0j3CRojfOkXHz7ahHP8mcJwRlFg
         5qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779655876; x=1780260676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FgZxqqtEk/bcjKKyOMFKpuNhp2tz27mBRUcefyZzmdc=;
        b=ONN/rtvh/hFCgCKdDjAbQTNZflYcLyAM0E/k5bwHq7aYWykuEm+sDXcbVNE793QPtp
         XZm4dCm8RuvF6aNkcIJ+/xNdao0ZwT/K4nxIr81YyRcHWxh4D61Lm6YL6+IGHxQWOobk
         EDnbhXAckeJRaa9RH6WkOrlyQ3B5thx5tYcBX8gUJ4cLXOEdoKnFYjG8DFnIlza9Ov9D
         VpGIDs3xXGMtu8Fr1SpunIHJgNseNJzRZKLjrWB3S+sl0DSxb6YXVSSrUUieD9mLAKrc
         fRy66XbXAr/kBjrb9Wf5HSWS+c1z0z85jI19UMTQgJ1leR5dFaSSgkbQNgTJtvtu4RJx
         ub3A==
X-Forwarded-Encrypted: i=1; AFNElJ86DkPLd9kWX0gIlADOdSOqkwwPLW1MDXEBsIrgQuYeM/t5EBxDLRKLoC1sRZofvRzRKftI9l0/5Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIjY6qN9+9QAGFUoYaQhMQF8QQS54apqEtNPb/H/ih6NduuTRL
	zhvtMlmyatIJKV3SLWkcfTxqTmYn/8Os2tKOgDAy4sOgp3xgQmjBvX3z
X-Gm-Gg: Acq92OGByIV1rDchbe0SdFJPF2i08QXLtP0tmJPql1UoDqR24DFsUeg0ZYMWbl+PJnh
	LbE5Ao7dvQU3KE9JO84eRA8i9RjotrZG5o8/2Zq4biJe9hN7lCOZcJRItnBaK+70LJqsdNyVfHM
	lnqUokS22Xt58vguZvxgY3k7Cd3agKj1NEqyqxxxjs0RfS+R61S+8Koj/PFVzCtc563WVHDHMmo
	g818h+kkBvTbduX6O3h4vuhYmHw+aa3becixPA8hQJKF81K7Ooaz27u5nZyzMLYvrbWTq6SDNjk
	yN3zZ8H0mcJgp5cA4TUJo6B9BpXHtgRzG3/XXHiOLwTfQ+otT4jOajR8Xenc+yL4c7GapbmH0lx
	2rb8v3cwkgQcIj3g+/ZVVIkG0OqWnJLtIcr6PwV+Nznph31lk7/9Y/kLW6du/hK39TLYYucjqEf
	Z3/zj0
X-Received: by 2002:a05:6000:2384:b0:43c:fc5c:a9fe with SMTP id ffacd0b85a97d-45eb39e1efcmr19662501f8f.20.1779655875822;
        Sun, 24 May 2026 13:51:15 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d6ebf0sm22738588f8f.34.2026.05.24.13.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 13:51:15 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	jdelvare@suse.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/4] iio: types: add IIO_VOLUMEFLOW channel type
Date: Sun, 24 May 2026 22:49:36 +0200
Message-ID: <20260524205112.26638-2-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260524205112.26638-1-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wadim Mueller <wadim.mueller@cmblu.de>

Add a new IIO channel type for liquid volumetric flow sensors.  The
unit exposed via the standard _scale attribute is litres per second
(l/s), so drivers reporting smaller native units (e.g. ml/min) only
need to set a fractional scale.

Update iio-core's name table, the iio_event_monitor whitelist and
the sysfs-bus-iio ABI document to match.

Signed-off-by: Wadim Mueller <wadim.mueller@cmblu.de>
---
 Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  2 ++
 4 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5f87dcee7..68eb703c1 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2458,3 +2458,20 @@ Description:
 		seconds, expressed as:
 
 		- a range specified as "[min step max]"
+
+What:/sys/bus/iio/devices/iio:deviceX/in_volumeflow_raw
+What:/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_raw
+KernelVersion:6.19
+Contact:linux-iio@vger.kernel.org
+Description:
+Raw (unscaled) volumetric flow rate reading from the channel.
+To convert to standard units (litres / second) apply the
+channel's _scale (and _offset, when present).
+
+What:/sys/bus/iio/devices/iio:deviceX/in_volumeflow_scale
+What:/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_scale
+KernelVersion:6.19
+Contact:linux-iio@vger.kernel.org
+Description:
+Scale factor applied to raw volumetric flow readings to obtain
+the value in litres per second (l/s).
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 22eefd048..aa34fcd8e 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -98,6 +98,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CHROMATICITY] = "chromaticity",
 	[IIO_ATTENTION] = "attention",
 	[IIO_ALTCURRENT] = "altcurrent",
+	[IIO_VOLUMEFLOW] = "volumeflow",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 6d269b844..49480f321 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -53,6 +53,7 @@ enum iio_chan_type {
 	IIO_CHROMATICITY,
 	IIO_ATTENTION,
 	IIO_ALTCURRENT,
+	IIO_VOLUMEFLOW,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 03ca33869..078004750 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -65,6 +65,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_CHROMATICITY] = "chromaticity",
 	[IIO_ATTENTION] = "attention",
 	[IIO_ALTCURRENT] = "altcurrent",
+	[IIO_VOLUMEFLOW] = "volumeflow",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -193,6 +194,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_CHROMATICITY:
 	case IIO_ATTENTION:
 	case IIO_ALTCURRENT:
+	case IIO_VOLUMEFLOW:
 		break;
 	default:
 		return false;
-- 
2.52.0

