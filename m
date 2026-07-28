Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0386C4756BD
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275389; cv=none; b=QrLWpqxDp0OvU9cTgZiVEq0iQ3aJ8rdogkHO9CFJ7bm4G4crz71jQNT23bODsSTuLXt45k/fSuK+UPXcefxexheRNzmcO0P5Hy3BhLDaQ0oPJwVsJYLpB+y+8AlDK2pTkQcVvgxTiYlxhbhSnUWWyZicP3wg8dEqfbyl7qTEq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275389; c=relaxed/simple;
	bh=/13tJVfUsCVY/nv7Ue64cjY4y72j9rKL8Beo1uBTrDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/pF5c/31iLjNnlMzrCFvKsQ/02dobuxew0nQiMSLf/0Z4dpaUIQhIw9oIMt1kqA6u9coMisW/61ggNCj/68nn5kbDeiQwba26Pj7D4S8FqoixsNUammKi9qPWjCy1nkgaJS1+LXf62WS3MfaVGzAQwvkwkBex8g8arNUitjVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d13KAbSq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d13KAbSq"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso238302f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 14:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785275386; x=1785880186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4jmmnI30b3C0sGM92AX/xMbbQqI1f4H7LaLXWEruSU=;
        b=d13KAbSqQPrNFDQek1Jy2BRr1JMye+klrSN4FSBFomgAXcx2eGB1q/4OSCHK0Er06f
         vRaQic2J5mtLE3VBkPqPKPL594vmIdRuxEiwVOkumDF3o862uQnb7DYdbmV5KBjfqgIp
         1NXepncF23TECCAXg4SzOtXLvxKFDdb+Fcvd0nAQKwvq8V8R7pe1RdfJSXj2I/e8o6vn
         mH3kJ47ekV6lurRpaXwBDISvb014fgNurZLoV1qOEoZE5f1oBARx55s9KWkGYGz4Y2Qo
         Q2YqsWT68kkh9Dwrv/ciECVNAJTodeokGfLHVBjGmXDAU8lzGfj0Wu/++qB2NmFNiipc
         m+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785275386; x=1785880186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q4jmmnI30b3C0sGM92AX/xMbbQqI1f4H7LaLXWEruSU=;
        b=rqldtG5YRVGFJI8G7rG413rkui2HhnKmdqSJ7f8nKja1JHuT4epaRmKolBPOmJlH+E
         Zy2tRtcBzkETrWoGjrk0nyCOCW0wuu/Y8pVAA1UWsM+DHkHfC7GVdhHhiTzxS70VGkpl
         LyxjS7c2IHdRUzLiWee6Vq+vAt3ojUNGqx9ZhMeBEqh+1V541Yae99fAkuU/Yx2iFj1t
         gUxqbIVqwwCtBp0exEee9R8zxc4VxwgBtdA2XWRmP0qaMLkiV7A6nog4KxnSzu0V+Jzr
         FQpMttYHcRssYByXl0z+rg1Xu4X7BMz1ND40Ctey6uP8OA3IOgGtA3AvnXOpDQbE64xW
         WtMw==
X-Gm-Message-State: AOJu0YxQkCGiL7uEhx0wXhSV9cbxQRFWMc76L0+E7Hiz2h7sZTxS6mWU
	qpoDn7KncLXqHy+T4jKT745a3uobitHFvrmg/tRtAmTNgs+8ny1FubB/
X-Gm-Gg: AR+sD12HYIVU+vkxXduuHbL20dd4J8Eugiej7eBS4V4VYFQkztSr0AaEAeTOahRVPxO
	gKK+PyHACwwvSToRv5L5YSVG1woyUXcRek7lqxJCL7163zquv22i4q+mB7Dc9IlF+oMEy8EtBGz
	A13ezETFeXuIDxGbf6QezgxF5Zj/cJw3CflEKzoXckuxCw2M1GuRjBB9HS+hYmfSj3/L5N8FrWo
	aLWcnU6ajKJut6IdgTlVRuYeRO8ypKQ4qDtQrtQTKmu7Xv+U2mSpm50HZwcjb+qLI3tnSf7Y9Li
	IpcbYkpqt434879eV8jzrBDiOVFOS4V/rut9lqywTNA7lBrB6Ai+5DfP4bGVQPfeir7YSgj3cDB
	jsG4JS6PyldsDsYJs/DWK4fIgSIpvADhDu1pC4kqySn+CovOYSTzISfm+ufU=
X-Received: by 2002:a5d:5d13:0:b0:47f:776f:3838 with SMTP id ffacd0b85a97d-47fb1e8785fmr4585315f8f.6.1785275385997;
        Tue, 28 Jul 2026 14:49:45 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0ef25sm2353042f8f.24.2026.07.28.14.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:49:45 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: jonathan.cameron@oss.qualcomm.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	maxwell@maxwelld.cc
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt1@gmail.com,
	455.rodrigo.alencar@gmail.com
Subject: [PATCH v6 1/4] iio: types: add IIO_VOLUMEFLOW channel type
Date: Tue, 28 Jul 2026 23:49:40 +0200
Message-ID: <20260728214943.29820-2-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260728214943.29820-1-wafgo01@gmail.com>
References: <20260728214943.29820-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new IIO channel type for liquid volumetric flow sensors.  The
unit exposed via the standard _scale attribute is cubic metres per
second (m^3/s), following the SI convention used by the other IIO
channel types.

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
index 5cc2e82c4997..ad99a810f4d5 100644
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
@@ -2497,3 +2499,12 @@ Description:
 		seconds, expressed as:
 
 		- a range specified as "[min step max]"
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_raw
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) volumetric flow rate reading from the channel.
+		To convert to standard units (cubic metres per second, m^3/s)
+		apply the channel's _scale (and _offset, when present).
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bdf3d4c06331..37cf2817b3d0 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -99,6 +99,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_ATTENTION] = "attention",
 	[IIO_ALTCURRENT] = "altcurrent",
 	[IIO_COVERAGE] = "coverage",
+	[IIO_VOLUMEFLOW] = "volumeflow",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index c9295c707041..d0fb714ca0fd 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -54,6 +54,7 @@ enum iio_chan_type {
 	IIO_ATTENTION,
 	IIO_ALTCURRENT,
 	IIO_COVERAGE,
+	IIO_VOLUMEFLOW,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index bc3ef4c77c2b..b5c5479b9d78 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -66,6 +66,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_ATTENTION] = "attention",
 	[IIO_ALTCURRENT] = "altcurrent",
 	[IIO_COVERAGE] = "coverage",
+	[IIO_VOLUMEFLOW] = "volumeflow",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -196,6 +197,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_ATTENTION:
 	case IIO_ALTCURRENT:
 	case IIO_COVERAGE:
+	case IIO_VOLUMEFLOW:
 		break;
 	default:
 		return false;
-- 
2.52.0

