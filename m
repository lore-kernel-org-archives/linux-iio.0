Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BB93CD8BD
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360599; cv=none; b=iWUmNEQi50G4CbrCezr8xg+s1zzh/5htgNIkL8ImWF90aR1dq/1cbquDcyl84i5BQNmpzwr5kD/3aCsz/lm4xK5RttwomFDB9eZ4idIWC15sNLIXvIl9HRA2U2CkEf1ECL6EZe9a1CG14EH2afFoNnV3aFCWugnU4D6YWIK+3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360599; c=relaxed/simple;
	bh=MFkF4FxHhibTkpZ7hne1HySj9bjmGLfceyZ44mIAeVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c1z3L0jR7mLbu+tYac+Z1e3/2xG5yoiKzMOZ9ox2gMqW0q3YudB6rFqsKwjQve7X2jjGHkPGYESUOZNJ55uEGFvwQFc47TYcx0826s1s9Jy5/84oy3b3pb9S2pfCym9oEGymQzIwBZUIGMXAQXDCzf5mhzsAhJIpVQEssqlXsJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bO8NFbny; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO8NFbny"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so4154390b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 00:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360596; x=1777965396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vu8H0bZAUzIM+TB7GToLvbyidCdn+6nJwGvF9IVANM=;
        b=bO8NFbnyRxWDDVGsyPG0EUGEhpPqZvhxWvRDDThzJFNKz3RVBK6OnynF2nPAFmQifN
         DXeTzEZHg0AW5ekRrscKx4/HxkxdUHcxjTJQ/R9nZWsvVulY891Juh6ZI6HJEegZuaUA
         puDoMRCSTut81FjnZ3R/gk6AA4VCWHQuJuvzCLGTToCeDAwuNTqngouIC09fbPjUSi7n
         sMu0vg8UtMImCOPH3fVqO1jts6MyxIIfUWAfAajP4WXa80x5NjTIHh4VjUWZV9Uh59Zx
         xohuQmzDaeP4jYeh/m9LfxtO+RNP6umbRCEJQ14reFLufe8zRoPbV/f5C/197R1FKaFm
         TN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360596; x=1777965396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0vu8H0bZAUzIM+TB7GToLvbyidCdn+6nJwGvF9IVANM=;
        b=ZhUuNlYA+TmaAEBjPco6H6gTlTjP4nL0pfurcv3rt9Zqh5D2EOg9aZIhKcImoT6mqD
         WTrBA0QqqhCNDO/MYBEEqmK4Szrph6YyA+e2TS3t2X+KqaDzqYmigurM55uISA/EgqML
         UoTL0pGAma0wZQXhr9w5c5NzgiuxoLmbzUeWuaK04SNTHi1Wg2Z0sse3FjctgE/DkG4S
         lXjb7ql4p6K2qXBDw4nJFzdJ+mp4scDqVu6lwaItC7Ic9c/zOLQ1CjtdUUyrWrbS5z0h
         hgbiThRy7GXK1rgQ3R/fnUi2HRYuipxnUue+j3Cmyybh5fEjzMWhyXph303+VFrWquGB
         bV/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/c8El+tIUrwQ0ciiRlfW9hr2bcG9YJf0VxAn+xxveh38ze6AZ4L4Z8wzbTmRrEqpkGoFeC38nfxro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/q3anh0tJ17C1n32FgDFuODI2E1x3fo/ilErtV1IPjiVbJf+G
	4qfn4GQPc633GKF6cfcgA7myLIiVWQYZRDIjovYKxv3CUEIlelt69zoh
X-Gm-Gg: AeBDievNoQ/nCpI5wSrovdsk5N+qPHFb4szPNPqUZRel7j8V8QX7qqh4VDN7SjRQ9XW
	jLjDlcAGr60wTsptBjg+MPJimK8Jypp7yz6M0YlkHSCmfjjSoGMJF1iTxEnyTUJmt/zMLY77aKE
	EHHuC6nuj63iox6Qy+mNSYt9Jrbfr1z+jwv7AuhKtXo9KvjSShUR6wgcDCMuxcOEM7RI//ovAU3
	bMdmwZalunbahFH72694osBB1RlWkIRaA/U1q7Q5RXk54tFwNrLgrWKW73XBAxX7wAdu4aZGnJm
	tweuaZEEJgUjr38j+QfcF3z81ZOgs8xP47yRs2FoOlQ5jl3vX6247yfGH06lCvOSurIl+rMBEMv
	XADamoYw85fY6iXmg2lXrBQkGSmW+iKgJSO8e03qjWFCvF1mYgcUEQz8fmibRo3++M3DYcW6SkS
	Ty7ZmfgwOdftkQ79OPZzC0Wk7NopTubpFA5lfd1L81yo8wM34E8mqJ3YDJOW4=
X-Received: by 2002:a05:6a00:3495:b0:81f:4a36:1c7c with SMTP id d2e1a72fcca58-834ddb9f2d0mr2167388b3a.23.1777360596021;
        Tue, 28 Apr 2026 00:16:36 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:35 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sakari.ailus@linux.intel.com,
	sanjayembeddedse@gmail.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] iio: pressure: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:07 +0530
Message-Id: <20260428071613.1134053-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428071613.1134053-1-sanjayembedded@gmail.com>
References: <20260428071613.1134053-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Update the driver to match the updated hid_sensor_remove_trigger()
prototype, which no longer requires struct iio_dev.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/pressure/hid-sensor-press.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 5f1d6abda3e4..2bf5d055e175 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -319,7 +319,7 @@ static int hid_press_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
+	hid_sensor_remove_trigger(&press_state->common_attributes);
 	return ret;
 }
 
@@ -332,7 +332,7 @@ static void hid_press_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
+	hid_sensor_remove_trigger(&press_state->common_attributes);
 }
 
 static const struct platform_device_id hid_press_ids[] = {
-- 
2.34.1

