Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A2433E88
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019243; cv=none; b=OYU4zg89cd8sus/9IlOR7oeSQz/uFkkjV1bwlW4roTq6R0TVagSN8/PG+EkiHNqvIT0b91WP8EcgBtU3kozmkeaF+kJD1QGDXLardrj5xUNfKG22OnQ3bWtAdR9mW/lfWWZ5Gt7viCRXNkjhnxHYv3whRJyJfPpmSU1jEPgaaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019243; c=relaxed/simple;
	bh=b9WVh5Gqjl+KmpFaABDI9OAx3mPQ6/J0ttV7X3dUrU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYPbqv/jH0PO459S9hoaAFbRg1kuIez13UdCBQagR6jpRIOl0iCLpYRAYNg5cRjH4EJcUFei96pB+jvuaVzG50uKcjPi/qA3//jJCxeMyk43mP3jIE2kEdRE9M6NX8MW+QTU2goMF9nJNZphogIqQqGkj/+bl04cf0DfubK0i+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B07tS/1h; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B07tS/1h"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15fd3a299eso111322566b.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784019240; x=1784624040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mHNTM9mrSWHg/Adj00DnnB0usdvvj/sz9rd6+8UIJfA=;
        b=B07tS/1hEEJRbI5808Bk2oBoRH0OF0EITL3CnUTORXJ0ri4wpEBIN42RkP6c/8ffpP
         vDLxbbbDGHVpzO56dsdE1M4nwWedo512f/bFc7IfV0pQ9+BCJx2rW4IEMZ5IKVn1wlC3
         1s0FN3OGFEvFkhTohPM5FoBdY/1V+Scedv4//180j6GNmIqtJ2O1kzxWcLGpou73/dos
         Y/cs1M4kWERo3uc222jgWqWZDE4VpdPESPGKN+uEcvynwh4i1rrL8rKFZ/ONkiMvi3JA
         K/CykOiGS0iXe/boJVu4tW5NxcFWcbOpvQZ1xYjTEldP2afPsB+XzKsuo7dPwxJoewK3
         wWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784019240; x=1784624040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mHNTM9mrSWHg/Adj00DnnB0usdvvj/sz9rd6+8UIJfA=;
        b=a4sm7PKk+5ovUJKq1eaYoFIJW014aH3QTb3rbaRHGIOxZHiD2zGpQPKV6lpX0B/0t8
         ESagyorMOQIA2SWCfd94W11AS+IHq1JcG+Szt0J7PB/aKsCRTDVSUkuU/iRBSbKZXk19
         OtSsyFo9bj3M1cgReMREuTQ1fPJPlhqB+5ECtXKGS7nkiMVwk/9yLAkg2dReMQoUcOOg
         Xk/nJvZSS5wk9RpL5YxWbGsoHyA/e1Y1NcDuiWW6mlnT31YkLxfJ37pbcuotlm8HkVxH
         W024g80sN4GvSJhBRFogDTnn5C1IG4fY3l94rSbR81T2mr9JPCt2ozzQSC6EZu/IiPRX
         Rlfg==
X-Gm-Message-State: AOJu0YwxECqsbvzFOvV+JDp+CwUPiTi/xW2WlxDUnMWSmhjSNlL4rC2E
	TZz14HYIjmMBY7bcwsFxkmECDg41ay3K8KnhpehZ5qybJpzcz/4MoAio
X-Gm-Gg: AfdE7clH+GX5cALHKLdAgBYDOM5PrBS+K4wno4bvfKaHPFCr03POV5rXC4pGXRc4OS9
	nGGqYJCy1RzDEkaCh+FLwWh0KQvw40ccnWn6slqgeFTH000gwiHu+oryPnwxSkiNnXEFbfVKhjg
	FYRhBkW5Ody68IYVv79dWiLN3t6mZA/NQG/2PcadKu2p8hfF4sksDPV5Q2uL6wjFo9my7I8ADPl
	rkOhKMpz7ldrg6BmWus9G9aTteft4lxQNcfnup/9+rsrcWivQCJxPM5PyIPNWlM0AX4j0UjPBKM
	evYe8cIbWhSqJ6LqdDjLo46GI5CNx07jIUIlUs3ZEI1mC16svjHi/aFrOsT3xnGggJCEvgVOevS
	TlJT+a+s6Yarq60BU9VZDiE9F6DblDy00oLmeFdNilgLtR5ZlWmvImNxSwWqaTvC4++AHhRBBuD
	R9IlhD6xOMczgqiehfHU5Igs1kuQU8regLrIM=
X-Received: by 2002:a17:907:2685:b0:c16:5855:659b with SMTP id a640c23a62f3a-c16585567f5mr231653766b.57.1784019239910;
        Tue, 14 Jul 2026 01:53:59 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad82279csm1143689366b.13.2026.07.14.01.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:53:59 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <maxwell@maxwelld.cc>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: [PATCH v5 1/4] iio: types: add IIO_VOLUMEFLOW channel type
Date: Tue, 14 Jul 2026 10:53:55 +0200
Message-ID: <20260714085358.20842-2-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714085358.20842-1-wafgo01@gmail.com>
References: <20260714085358.20842-1-wafgo01@gmail.com>
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
index d8d6d85235b0..8dbac1004fea 100644
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
@@ -2496,3 +2498,12 @@ Description:
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
index 93c2540d4cd2..d6b547207591 100644
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
2.43.0

