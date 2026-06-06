Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325C138D686
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745858; cv=none; b=RO5o91xHNlAWdhdWvgiXQFBo1FXaqR2KC5E0oV6LbsI0mHSbmx4czuhofnsxg/2ygyXMWtcmqfQ2hMvJ8bGndJkCb0kVARJYFqZ5DxAyZUBYu98xeklLVOib8AuIJR2CPif/I9JDkaDrF0uB3aZEhhsKiQaXC9AUGLHLNXzrbZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745858; c=relaxed/simple;
	bh=Gqlu30OIKKpb2UA45Rqv4BuvnrPB7GcngT7X8FSR3IE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RKuXaRCHrmdUTAq9fjcxr2+lvbM0f5jhkJlmcJXKl/HY9vVGsBbmmqGDEFOH7K7lw6xdkRPXlxNqV+ABpTLtNlEs4dBq7DiIx5F0ciWuWnkLr7eeg1pho0tXyxctd/QL5SfZd20SuFYkj4w2yWRfDaj2NHHZnnv1wmI87GVEUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnYFzVNi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnYFzVNi"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0b9328c4aso19838775ad.0
        for <linux-iio@vger.kernel.org>; Sat, 06 Jun 2026 04:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780745856; x=1781350656; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W5Cbn8D1EcGuxfgSwWsv1vDeR4Y4hD7VuV/IV4coqyw=;
        b=FnYFzVNijdoxCAsCfASmC2IJPFMJeDH8a5uLPEaDFs78caEQArvZT2QE+4VDw68y63
         WAvK8V7C6CF0ytb7AHDLO8O+XnaFAuwPlF7HzfcXl1FZ9Sqyfss6KvmBDEOqsNzzF+qS
         5e6eA+XHHlmQpUW4DBoGfcVAhQeyMcFCsfpezxqSlGq7ghr/6V5BSMRp8tHk9fkl+x0S
         TnDweMMxamf/YKOJwxhJ/ZYNEW4oGWmx2+IQQ2lY4vol8lP5V3C7Wb+7BPhuVrkaJrkN
         pJE6pWYs+yPR0aaalzyKcUIEyc7SrEDMU9OGFpNo0oN1MmAtryU1DkPatd3jrOKpfVuO
         4RMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745856; x=1781350656;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5Cbn8D1EcGuxfgSwWsv1vDeR4Y4hD7VuV/IV4coqyw=;
        b=o4Dsd3qFS/ywTd+DEaPGLFkg90sTV0y7dsjga+LKPOkZAk/vJ3a9s3By5gdaBi8GfB
         /HDHswIJrBPHzAYv78HMC/fnP9izXjgREfM+zjqIQ2ZMtn+Cep7DkHo3mam2AnO8kKbK
         ZxJiSfMpJmFsuOdElFcj6PmF6EGP5GPl1/gpLzgmFjft/vVnl1oEk3pWdLJn33vip42E
         CnksN4pCV6KBJoLBNZgFEQZ/VpbMlK5f9bdnS0+1wGYENwRJwYSUbeFaXBVPpq6PXrXH
         wacSv0qKfMfreoPbZ3uk/8tXlkTarzYTZ/Ds1U0VQ9wtdaVgiz6f0L+E3LHReN1K3BjP
         sKoA==
X-Forwarded-Encrypted: i=1; AFNElJ+wFlyX6KmR0XjJscSF8IeAM0qioQOxDsiye8jGtcqEDNXLmDCwzsMzfAi5SpdQ75oEfDYD+OxNHdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtpVs+phwTS5FB3szCWyz9q441Tb4Z3aydmL7RpmZDvBNbec04
	41c2Noa2NUa1qxL3NN2pqkTGSumsgxArfVR+slMfY6kHSgDLtNqrHiAC
X-Gm-Gg: Acq92OHBimR7fvBhz3UT6pdrH5XHSXWwYidw5PeU1MqdEaZd9/zpcg0iCv6KmoDnDdx
	8QdCpPWk2lYH4yRmqJ7GfyDXPn3l2XcErDtENMDOjnmlWf3NJPyLU5wV5ssD3pdA2ZPTjFmX2Gg
	eYncQYPfuSZMa3uErXOveFbjia2DNP9u62NrNMG2fCMmhMNH2ZBfO9OLI6mKrElYJUSzC/0FgiH
	8eQnJEOcSWelBbe5ODT88XVEhWejBKN4jcz1XRIV0r/xr5GhqIV45A2o5E4VHYZRi7RjYfWqFBD
	mMK8PdHcVDbZ9n2TVAx+JgzNmAqGvvcHOi9a2c8eOfwJPdapr6OAvWQhvzGU71UgwKaIjB0G10S
	c+Z22fEzQ1OKuuwe7yC8QoDXF3F1Jg7ScwLSwC54emdTH0VdCHF3wPBHVYnv760sQxfnQemgWgd
	7UYsVDZY7G4G9Y3mhh4+bTghgSza10cREYOD/8uJ8g8hjncOcFQAO6mIRuAs8=
X-Received: by 2002:a17:90b:2e45:b0:36a:95c:7613 with SMTP id 98e67ed59e1d1-370ef3e8fe0mr8427210a91.10.1780745856342;
        Sat, 06 Jun 2026 04:37:36 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371358615aesm3220830a91.2.2026.06.06.04.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:37:35 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Subject: [PATCH 0/9] HID: iio: Fix race condition between callback
 registration and device exposure
Date: Sat, 06 Jun 2026 17:07:09 +0530
Message-Id: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGUGJGoC/yXMwQqDMBCE4VeRPbsQA0raVyk9mDip6yGWrIogv
 ruxPX4M/xykyAKlZ3VQxiYqcypo6orC2KcPWIZissZ2pjMttzytCTzKwCIz5z6Ao+xQjs4/XBO
 d9c5Q6b8Zv6Hkr/ffuvoJYbkP6Twv6ZCu7n0AAAA=
X-Change-ID: 20260605-5-june-hid-iio-race-fixes-f8b981f82b80
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Archana Patni <archana.patni@linux.intel.com>, 
 Song Hongyan <hongyan.song@intel.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 srinivas pandruvada <srinivas.pandruvada@intel.com>, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

Hi all,

This series fixes a race condition in HID IIO drivers related to the
ordering between callback registration and device exposure.

Currently, several HID IIO drivers register the IIO device (making it
visible to userspace and other kernel consumers) before all required
callbacks and resources are fully initialized, or rely on devm-based
cleanup in a way that does not guarantee correct teardown ordering.
This creates a window where the device can be accessed while it is
not fully initialized or is being torn down, potentially leading NULL
dereference or use-after-free.

To address this, the series ensures that:
  - All required callbacks and resources are set up before the device
    is registered with the IIO core
  - Resource cleanup is performed explicitly where ordering matters

PS: This is prepratory series to convert all HID IIO driver to devm.

Testing:
  - Compiled with W=1 for each patch in series
  - Build-tested on QEMU x86_64

---
Sanjay Chitroda (9):
      iio: orientation: hid-sensor-rotation: Fix race between callback registration and device exposure
      iio: orientation: hid-sensor-incl-3d: Fix race between callback registration and device exposure
      iio: gyro: hid-sensor-gyro-3d: Fix race between callback registration and device exposure
      iio: pressure: hid-sensor-press: Fix race between callback registration and device exposure
      iio: temperature: hid-sensor-temperature: switch to non-devm iio_device_register()
      iio: light: hid-sensor-prox: Fix race between callback registration and device exposure
      iio: light: hid-sensor-als: Fix race between callback registration and device exposure
      iio: magnetometer: hid-sensor-magn-3d: Fix race between callback registration and device exposure
      iio: accel: hid-sensor-accel-3d: Fix race between callback registration and device exposure

 drivers/iio/accel/hid-sensor-accel-3d.c          | 20 ++++++++++----------
 drivers/iio/gyro/hid-sensor-gyro-3d.c            | 20 ++++++++++----------
 drivers/iio/light/hid-sensor-als.c               | 20 ++++++++++----------
 drivers/iio/light/hid-sensor-prox.c              | 20 ++++++++++----------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c    | 20 ++++++++++----------
 drivers/iio/orientation/hid-sensor-incl-3d.c     | 20 ++++++++++----------
 drivers/iio/orientation/hid-sensor-rotation.c    | 20 ++++++++++----------
 drivers/iio/pressure/hid-sensor-press.c          | 20 ++++++++++----------
 drivers/iio/temperature/hid-sensor-temperature.c |  3 ++-
 9 files changed, 82 insertions(+), 81 deletions(-)
---
base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
change-id: 20260605-5-june-hid-iio-race-fixes-f8b981f82b80

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>

