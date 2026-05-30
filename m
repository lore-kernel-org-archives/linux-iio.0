Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865830148B
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780174506; cv=none; b=hFRwxUwzHre00ffofmCARqscaOlViI/I8aeImNd2beNDZ300QRHOBbNvV40mgEYlzL/9E9NktGt++fYwlTexTiWDkzA412b9c0+H3BrkVrkNo2c4hxt17DsjzYORnI+bLZotHttWkDxJYVYY/DcJ0KayLSpdiN3Kxql7hIeIh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780174506; c=relaxed/simple;
	bh=Nx8EK67/RioyI6Z4M1OApHSBUTezoml6mYEJkUAfw1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdtYjSQmsio8fddC8nmfwVDsQGBB+GOfEH0KLD6ZGy48v1dKB8fcKpOSsfFi1ZfSupvaYFhKuCa+3nbYnhSahZ381fKbvPGQJZDCS+PeFol8o/v+jmdHSIELXb28JnMpkALDc7HAnIC6oRlSrhDMPBw7Zs4pHzwi4lvm3nSrSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhwLfd9a; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhwLfd9a"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef4223be7so957054f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780174503; x=1780779303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qQ+HP5KO/pNape1oL4kHR1H0GGu6Zsl3upOKWiRgzM=;
        b=HhwLfd9aV3uHZfViJud7DScv9nE+K5+hkCG9zvUYZcU01jKJ01EBOERV5vZgj4xZSO
         BQ3+SJ5QFcr8LHlolvW8c/FLwCNaQNTZns6LjDy7CmzPVa9Du5KXuSMU1GNIjCxJ+jyr
         Z4uLZPooULWV35QLJgrquMuJUWlEKsF2mBboLZhB6cEyjg3pFKl6pmMdq0aX1HlaGma9
         eeYXFgIUrqLKIAKvtxa39Vv0eGNlKEnxKbsGysxNbuegnx2ZiiKHK8lNlwG8W9gPd1Zb
         Qy4hBd04DapvuvZ3m6t/psDhAKx17tHpoE/8CkRbBAHBmX5kqLjSaK8lq2wHJnnuV3dv
         MzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780174503; x=1780779303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8qQ+HP5KO/pNape1oL4kHR1H0GGu6Zsl3upOKWiRgzM=;
        b=lEh5oFToOYY9zOYAdRg+v+ROOkMJzo3jwOjEFKTCmXJFJJPeq1jCYwK8j8reBRyUCT
         mYT9/XM4en8yl9qebmgcJGa8Jl7MNUhaXFwPy1w9rlK/s73+AdrXVdciTDeuJOcXC4t3
         0T/AQJzOzJw8Gl3kZpdcoDBMY/UC0gCqq06b2CN9EN/fhJhjtWLBbvlzY7+DoAYf1H7/
         ysSJPfrPwLTB/Ormh5kV8wlEj3Tq/IDZovJTXzbJuu7+ZiOJ52nWsOuofWYTvyJp5IiD
         3xo6nOQe3sBteGc3yi+oj93BjZcxh8EPcxXclvsurA5pbcEYuLUZ2l9S+5vMQyv4sfOY
         YJsA==
X-Forwarded-Encrypted: i=1; AFNElJ9GQdDEzP1772FnpwHtZRRA94pJNNytO5xm1lD3eAMzP26lv9+LMU19+GxW6pJWegUnfGo54BlQHPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUaKVK+zGwRbuD8XSqeHJfgo6fydhDNmY3HeGeLSj5BqLidQFe
	Y9fOPJSdE/Ey3iSQrQGo1+8nx4e4PDHBtnyMlOGGpvYZMD/+1Cm2JE3e
X-Gm-Gg: Acq92OEX7fikp9Z717H6jbV8j4K7nm42HgjtJ9eizKS/yenwbk9c0MeQLh7GkrYJH7N
	7YsCdFMfG+JfCYUCaFny3Xw7IwAjXhdNaAEwVd55X7HvQEm4pOQa5MkBQ3uRoWV9hnfFRH5hCK5
	RK+MkIGqDdjY9sVvfuFyRDM5KXHLKpVsYJJ7TjTIprUPhHw8LSHiNDC9fi0x9YSO9pSuVcQGs0x
	mWI3U3qCJoYLZYtIyj9Wq+p1VTWTD+5HbC3fgXoOGj8YO3rQvWbHcoLfoooFLxr6dKtvgkyzQv7
	l9Uxi4y9dx3ADBtE0z4kPfC24k+9ipiTElu5G80BEtzm/RtqXReadIK6dvrQAx/JW7qn1aMXExa
	gFI1x8/CkYX+91WLp9/p2A3fjHgMTOiT7aho2WpUG3T3QA1dfjof/oRd60k2Pjv/4GaNhvFiApe
	W3FyaYQwHaRuemsak=
X-Received: by 2002:a05:600d:844f:20b0:490:4973:91a0 with SMTP id 5b1f17b1804b1-490a292191fmr65148555e9.10.1780174502753;
        Sat, 30 May 2026 13:55:02 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909cab0e94sm132288225e9.12.2026.05.30.13.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 13:55:02 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Subject: [PATCH v3 1/3] iio: types: add IIO_VOLUMEFLOW channel type
Date: Sat, 30 May 2026 22:54:30 +0200
Message-ID: <20260530205435.37326-2-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260530205435.37326-1-wafgo01@gmail.com>
References: <20260530205435.37326-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new IIO channel type for liquid volumetric flow sensors.  The
unit exposed via the standard _scale attribute is litres per second
(l/s), so drivers reporting smaller native units (e.g. ml/min) only
need to set a fractional scale.

Update iio-core's name table, the iio_event_monitor whitelist and
the sysfs-bus-iio ABI document to match.  The new _scale attribute is
folded into the existing shared _scale block; only the per-type _raw
needs a fresh entry.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  2 ++
 4 files changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5f87dcee7..2188557cb 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -507,6 +507,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_scale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -2458,3 +2460,12 @@ Description:
 		seconds, expressed as:
 
 		- a range specified as "[min step max]"
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_raw
+KernelVersion:	6.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) volumetric flow rate reading from the channel.
+		To convert to standard units (litres per second) apply the
+		channel's _scale (and _offset, when present).
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

