Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B9535A3B8
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106217; cv=none; b=IWxbQi6zwvXbQ0ei4q8xMGMaugWdHJsRIBoNtzor5k94i4aWmAdxJrp0uKmN+CT9VaWVf17rGgtJZHcUqYcJ3RhMZtsXx8Q5Vhzs9vMp+TDUZc/xzIM2ofPRc5BI/twfeZr6z/eyy1ZDlW+sKGKq8ojjk2D9kIArjeAAs1SRnD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106217; c=relaxed/simple;
	bh=Y82TrF2hjltbuUq5wvpY8/mWvTcHDHFnlrb+MK7r54M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uqx6R+ySqpRYcHsQXhldL9KXe7A69NnID0E/owc4TS+Ncdj75PXbgE7xRI26u3Q2O7xI2jiFGZK4L4/Z/Uo5NvBrEm1Wd1EGze+3xtyXRfQ5F2WNEuW6FJR7iip1pKunau7kqNMiymLAtEqBUQMRjfLb+q7olOYZMMC0zOIooic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oja2Gdqu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oja2Gdqu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c6bb8a5980so26024135ad.2
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 22:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782106216; x=1782711016; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQW1C6qb+lSsw+bGlEgRloEDW/3yda0n+8R2fJMon1I=;
        b=oja2GdquBj6BFeY/l0Yg8lsz2SVapkQ0WduJ+TLanQCluPASGl1A8z1oRGOTK+g15S
         wZChvcMjpcaH25OVWUvx96sYUI+dizU6De2dBEcw4kJxaojxLbUrsJST82GSei8nKYyd
         BRLtLq7P1sSPi41nt2BEZDdXsKwlbIHI0aW4kiUdT2Vp0HwfMp7iFtXc+/1Sx3JwEnof
         TJxxIxItC3DxOPn8eBBwczqD4gnyVdE3wACw7DzskVOKbL+k+XG+3PNdaSMX17mJ1HEv
         WG6GmUoBaAWWoveo7I1VMR2FAj6sDmznSe8jtJDm6SnHkMCjeDOfhG+7SJOUBlSWFg0b
         qoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782106216; x=1782711016;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQW1C6qb+lSsw+bGlEgRloEDW/3yda0n+8R2fJMon1I=;
        b=J5m9q+he+vxHgEtnF2KfUifH6L/RR/+nIxZSJ7MuAdoctQKjewUVHsDjklyig04BCE
         1cVOCpZfvVNMVTLQJBKS0QQCax2MQB9GXPj5s3cvJYFCtccUn6eqQqzRjX/bfTP+fz8o
         ixESAxiGgYvDFXBgfjV4RadS76ZhaH+aT6qpkarx4gXAyPzSxcRHTVnGJjfFMW3l1hRU
         7A3b2vL+/YN821iP1NBUHeOKe2MwjTyvJNKnCH7we/i4JouSG6SU/6LsgWsIYEt9m3fd
         ZA2vElE6r4z26JG/yre/hpeVn5fRq1GxoQdJjz8UXv8HTu3xyzSikbWpMK/SLwGd3uaj
         n8yQ==
X-Forwarded-Encrypted: i=1; AHgh+RqvcLpbZSSGWFlGzu7NzCVcecNnxb4IOuo5RP3U0iFnfDLaD0WmzT1Tjnv5iMtGDycaO5xHUYfhufI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPpT0MxrusorqcYxbVbwotaQ8m1fpKhe/B/uWCfHqPlkdQWZnp
	zrqdGSWbkz6WGm0laCAOrQ/iRpRD02Mcs8fu4ETdz7Vg5htl3FjP1gE8mARdDA==
X-Gm-Gg: AfdE7clef70U+uwZzgzg9isMXZICMa1LwspX7bTS1YZHJNMKOX4FOFV/ObLmqf87syV
	x+K4bnMDim/htgQ/FLl9Vf+weuCwAMyjwkOXLZxb7qxnFbXFYEuk57hKoicfaEHt4BVXpBUjmkh
	wyy017H8CwUAxsMINcwy3daRRM2GNIFoDHUkkc7hHGIm/zV5F/JYa5u+zKutj0whR56ONIyx+59
	u+OgGnBYiJo5iUn4tnnoOeuPtRVeeR7lI1MR5Bl4KFPB2NSQmvlW/FjNx31e+fVfpvbZ4jPUaq+
	pTVvaGZY3a8YJvMEocidu9a5XlCqZyMfde/LanZ4C7wtLuibK7PcsJdl1cCQfBgPChnCdwskMtW
	6OYRQKMo7lAwPvvYJo1R1pkjb/34+KlvIpC0NJkWvukgl6UO6GlcS0d7PRJg88mvzqTpg1zTLD2
	jjxlHGLexZefWwY9FMPSVXRcNXdhh+6gGhyMljTg==
X-Received: by 2002:a17:902:d4c8:b0:2c1:150d:6db5 with SMTP id d9443c01a7336-2c718f1f271mr131047735ad.6.1782106215644;
        Sun, 21 Jun 2026 22:30:15 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743fd6420sm63932315ad.70.2026.06.21.22.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:30:15 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Subject: [PATCH v2 0/8] HID: iio: Avoid race between callback setup and
 device exposure
Date: Mon, 22 Jun 2026 10:59:56 +0530
Message-Id: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFTIOGoC/32NTQ6CMBBGr0Jm7ZjSWKiuvIdhUcoUhig1LRAN4
 e4WjFuXL9/PWyBSYIpwyRYINHNkPySQhwxsZ4aWkJvEIIUsRCEUKuyngbDjBpk9BmMJHb8ootP
 1WedOy1oLSPtnoD1I81v15TjVPdlxO9waHcfRh/cun/Ot9/MUfzxzjgJlafRJW1Uq7a7tw/D9a
 P0DqnVdP/70XTLUAAAA
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

This series avoid a race condition in HID IIO drivers related to the
ordering between callback registration and device exposure.

Currently, several HID IIO drivers register the IIO device (making it
visible to userspace and other kernel consumers) before all required
callbacks and resources are fully initialized, or rely on devm-based
cleanup in a way that does not guarantee correct teardown ordering.
This creates a window where the device can be accessed while it is
not fully initialized or is being torn down, potentially leading to
sample drop or stale/no data.

To handle this, the series ensures that:
  - All required callbacks and resources are set up before the device
    is registered with the IIO core
  - Resource cleanup is performed explicitly where ordering matters

PS: This is prepratory series to convert all HID IIO driver to devm.

Testing:
  - Compiled with W=1 for each patch in series

---
Changes in v2:
- Drop fixes tag and rectify commit message with reference to that
- Link to v1: https://patch.msgid.link/20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com

To: Jiri Kosina <jikos@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Sanjay Chitroda (8):
      iio: orientation: hid-sensor-rotation: Avoid race between callback setup and device exposure
      iio: orientation: hid-sensor-incl-3d: Avoid race between callback setup and device exposure
      iio: gyro: hid-sensor-gyro-3d: Avoid race between callback setup and device exposure
      iio: pressure: hid-sensor-press: Avoid race between callback setup and device exposure
      iio: light: hid-sensor-prox: Avoid race between callback setup and device exposure
      iio: light: hid-sensor-als: Avoid race between callback setup and device exposure
      iio: magnetometer: hid-sensor-magn-3d: Avoid race between callback setup and device exposure
      iio: accel: hid-sensor-accel-3d: Avoid race between callback setup and device exposure

 drivers/iio/accel/hid-sensor-accel-3d.c       | 20 ++++++++++----------
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 20 ++++++++++----------
 drivers/iio/light/hid-sensor-als.c            | 20 ++++++++++----------
 drivers/iio/light/hid-sensor-prox.c           | 20 ++++++++++----------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 20 ++++++++++----------
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 20 ++++++++++----------
 drivers/iio/orientation/hid-sensor-rotation.c | 20 ++++++++++----------
 drivers/iio/pressure/hid-sensor-press.c       | 20 ++++++++++----------
 8 files changed, 80 insertions(+), 80 deletions(-)
---
base-commit: cc746297b23e89bd5df9f91f3a0ca209e8991763
change-id: 20260605-5-june-hid-iio-race-fixes-f8b981f82b80

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>

