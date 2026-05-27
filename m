Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615B41C31D
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779907385; cv=none; b=DGH5TzrEOi6h3R9pMdnwWGf9BWc1oMvuxyv0KbU/hkhnxAdSzqtCQrJ6PObZBmuAEut5IPTEGLJ57Bj3HlcI3tAGcJfL8QvaoIS3TbdAeAJZB5JnaIttXcDXs4N/9StsGKP5RtvQPQamj1ns3NVLSJZxzboFHPFTT2nV96+jwUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779907385; c=relaxed/simple;
	bh=D9BxbyTlaO5evXhF/LaETEV0mQZGeHluXR9mIUC2e0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoBkjrmExedzmHMiJQo/ysOpu60I6G/Ok56K1F+GIZsarly41W6z1yp8usyAHgcRBaFKrHiMrNkqTQ9T4fC2vWb0kN/0pE8u+gS+gNR88r3YA96vy+hFOhbekXqEz3eeIgoOv3mulXGfWFosOLf7Uk0msb8nJIw2hIktTblfucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHhIqiIz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHhIqiIz"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so45403295e9.0
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779907382; x=1780512182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APxKf4/T3LceCmlA6Kks7f2ZfrO1GmfmpalJc2yympY=;
        b=ZHhIqiIzuwwA97JXllqBpdWYvUY/xlHLrTlntWnIXbeI0/G8usJAnDFb9QypigipH6
         pzVJdRziMFWw9yU55nsKbbPdp5JdYRcCNxiKd+hTrZVFu1htrGKSM+iLs7dvwOr7lUK1
         +oWkk8G9RK6MXmkMoG1vqzuNXscabaLhgSaj+vW6JTtDPrbYX9Wb+XYriOSUgP2G640c
         Y0VV0AI2gQYig+9il1Xqa1h6zddAe9TtOhYYgo4VRh1d8bzbkhleMp62Wdd9Nd+ilepF
         hHBrBTUAkHDnhvBTlFIZp/Jq3bma/mw4PFKt+OFqSBDqQfjA9YLIs2Rp706uHYbB8l9B
         ypyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779907382; x=1780512182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=APxKf4/T3LceCmlA6Kks7f2ZfrO1GmfmpalJc2yympY=;
        b=bFv7khanKddEKNC7xS/NrrbfsFiaog4Yn+jvageY2235dPSpsdLp+p7AyvtYACcbFK
         JAEtZGubngkkF6BSpDcaDhYOb4lD1XBZAgN2OKnL9PYIgvk7WkUCr7TAnkM7yK6XIVKZ
         yfSSYQMCGspJliyTRFvE1mTD7xhSoiF/oQBXgDthJux0BrZW5ySnb4LDKMYz/Z8LAcdW
         bykLgmm1LuSeMeU7B7Ls/wshHvz3Gs0jC6iDv58nFbqiv2p/yB8ZSmc7h0+6MmJ8AgAN
         KkN39QXMgCaIPboquPpnaGtEBnQ0uafmsZNvRoUgjEpHjFyI6qlAH4M3tXRjA4J+0ImH
         5h4A==
X-Forwarded-Encrypted: i=1; AFNElJ8zWr4HLsYsn+3eCuXSsViP33d2MlGyM1utf+/PJylyw+P9QjRYVSsjzV/TmRwkfh9A+vxLU3AIlm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJPNvCHowI8rKKSm2JSzJ0DhArryW+L8FLgcGAJxgfDe6CCvaP
	QcyDaEZi6iw1rChCOcbeAPufm6EWpqNx+9uQ2f8UdgEBlc+FoVOtaYpN
X-Gm-Gg: Acq92OG93Sv0zhSRPwXVrJCR+PDIfxDTH9o6G6YMlXfNFKI+XvzTYdPeyjyuukRYhUI
	amWyx6No2L7tnu1VOjg7H9S5TMX74vzBAQoGh8pNlSEGXr2XHWP5MOztNVUIV39AoxZXcr8PDcG
	S0dgVFUMRiWaSABuW6pMr/PoVUnYfN3XpGAl97R7Qhou3viCxVwBv602pKwikjFwtaTA0guVny3
	NpKP6wXiLvU/SJ/adSbAo6zhx9t6R5FTIMf3I0JN8iVukVWV1jQalzyymtvTgWeG8WIelGaVDHt
	kKmAfQ3RzHOIZxxqqDxo+g3BcxvOVR6ZgG2Fa/a7P/MAqETDrytmVeTIajCgXTyPaT3FXcVjpMa
	t4vY1TOfAnnqmGebjBAu4Ile3+wZvExuBCJjWiFgWR+qaVnZgY27Ghg+yM7B0cJ61ZsZDYqhEqX
	D4W/YB5BZe+0dnd7E=
X-Received: by 2002:a05:600c:1c21:b0:490:44eb:c1e0 with SMTP id 5b1f17b1804b1-49044ebc29emr405905935e9.21.1779907381827;
        Wed, 27 May 2026 11:43:01 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490809ca202sm35312935e9.6.2026.05.27.11.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 11:43:01 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-hwmon@vger.kernel.org,
	Maxwell Doose <m32285159@gmail.com>
Subject: [PATCH v2 1/3] iio: types: add IIO_VOLUMEFLOW channel type
Date: Wed, 27 May 2026 20:42:52 +0200
Message-ID: <20260527184257.141635-2-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527184257.141635-1-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
 <20260527184257.141635-1-wafgo01@gmail.com>
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
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Andreas Klinger <ak@it-klinger.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-hwmon@vger.kernel.org
Cc: Maxwell Doose <m32285159@gmail.com>
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

