Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410AB3A873B
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748286; cv=none; b=eK3zt8ERltmvX3UwLCIw9Sxzy+VyfsXMBy8AqLE+ImIN2F+7Mb+8gGCu4P4tCzCL6eOa9i5jyGqH1BXwzNoQjc41zBd2uMC4TiCsUzfjo+ZXefDT7uRqQiTALmkgZ1ibkLOXSbxolc4Io2VmKF2tpX1CkHnO0pGZ8Wl4gsrucPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748286; c=relaxed/simple;
	bh=GqX3qsviXk58AXgPbpCQAUVbN5QAqQDcXvmHrllU8fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDnufQnMl+NaCiNRQlYDWaciEpLfRU/dKDBRIuAwiKjJ+1ewGDftYYSbrE13/2LIK2bZzcCCKLC+Az//aP36gONLTHh+7baSY2aaDDkgPESI05LC0jS78X2qNFLdqGgiWpVxvdy42MoPmYiCcaNGwS8y+ZpIktl5lfnMqftvd3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAxKszM8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAxKszM8"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36da151a152so2063966a91.1
        for <linux-iio@vger.kernel.org>; Sat, 06 Jun 2026 05:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780748282; x=1781353082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYUlHjrzq9x0wWhn3UhtXwVB0aizDrgtDKmKAEDK6i0=;
        b=GAxKszM8Yp2ee8d79sBUTeCYRTAyvg6qb7gk/Q3ucGq81K6JQ39UfMu+W8zjxv5ME0
         dT29xb4qxLWVfHylUQ594VC/1r7uLAW23ob278vXAINA/1NxhYk4u6b1o76PQvJb+ikE
         NcJY/TrkX+3NMjeJw3ZTHJcFehWkJhb2boMhKaZbJo/AWzQk0im3dQWui8EXWCkDv7Ys
         vvXGORV6wKMIR07w61eij7Hsg2D0Wv9/x1qnIGPbf+43Vg7MX7Y8dMgx+lEmHzv7NbBv
         rgx5T/q4bJXD5NQghtuKMPk/ojUGyciKNySH32xU96lZ46eP69x9Ff71LbPK6P2THwiO
         SyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780748282; x=1781353082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eYUlHjrzq9x0wWhn3UhtXwVB0aizDrgtDKmKAEDK6i0=;
        b=srTfwVgDfhZcblP0G0wM/RNz88VUkHDNArsIwVfzXX77QLTESjw/OkJqV6M6NGX+Tb
         tvHzvpb7kpWTTEg3UwWv9fBJKS7CTLjS3N08lgy+GykI/5h+xEvyIRnlCXlfMLWheghh
         DVK7oo/4QYIBPHh7G+vQieewr5nvtL1RNAXKifnwaaeeFPGPPbJ5y+7bPi9zSM0sja/w
         DBzcFHOwk/dMLqVkAi+ra2nSTSzw++widO2q5+lshROc8nxH/vEsquFxteA3cARVmoAg
         nYqLh13pFNIcgHdL9VB1u0tdU6Hkmu5rcI5e5PeRqO3zxyNHTj856c572O3JGCrdnz+n
         WVEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gidDowSoB0xRwp7lhVTH0gIa8/euRfhKGlox9th1NwuCcbDjvXmOOoEGrX1gEktGgBXy71uk65ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOpbZLTg2aYgG7w2p7OpZssEQTL9rI1oRUvyGWEqrcQ970jpjX
	s1VgnFJ7zN2+ZTUbiVLfWi21x9Ps9xdwBoh29CGB+ILFujAAsZDOMjMN
X-Gm-Gg: Acq92OFNQwUBCBDzsCw3WJwZ3o0zTAjOkGcGb6kecaiK6NxzdGjJstHUuIhAnvnS0n2
	BEJZj/IRWzbef1y7LpSj1786+tWwad6BKLqsBMaxatkDjPMwmiyp6L+re9mwa7ccSPQCwmFsGlb
	ejqeuI9cCI47Qrdts3QOLW/lRbldi3BWHtaxiaGLqDQ16D9MFgWPdKJMv4DcyMCLVKEH2JVpyZv
	ZQo6w7afJDEV8v5QHAzj6x/QAx4M1P/TcVkTLnoXa8iJx0GO61mJvecMYmMEd/nz5ml0ivubxOl
	gD+LDdYfEWH/Fe179/1mURMnAAgst8PSGtoLwvrSdEJajKOb2qRNqJ6Wva5xeQA1vPQTtorh/wj
	dlErmmNcDUu0041iPZ9GQmTp1+oAXE1AYJAVkTl+480VVBlAXZCyh07Ah7AFSEg6ve2HWReTAiF
	1n7PRYlkocFKzrWBwhpouq6qKDtezE6NmL5wOxHXZ5Btw1UwRCAxnF7T9QBko=
X-Received: by 2002:a17:90b:43:b0:368:a27f:9083 with SMTP id 98e67ed59e1d1-370eee02480mr8504065a91.7.1780748282597;
        Sat, 06 Jun 2026 05:18:02 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291ed20sm15253532b3a.61.2026.06.06.05.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:18:02 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:47:43 +0530
Subject: [PATCH 2/7] iio: accel: hid-sensor-accel-3d: use u32 instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-6-june-hid-iio-correct-usage-id-v1-2-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' variable to improve code
clarity and consistency with kernel style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2bf05ab5235e..42c4259bf209 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -223,7 +223,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_dev, void *data,
 
 /* Callback handler to send event after all samples are received and captured */
 static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -247,7 +247,7 @@ static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -283,7 +283,7 @@ static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int accel_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				u32 usage_id,
 				struct accel_3d_state *st)
 {
 	int ret;

-- 
2.34.1

