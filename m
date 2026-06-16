Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C8428850
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605595; cv=none; b=r7uerE0pGSsWpqesphBSyIHvmdJXrC3EnP+NAviFB9pXOhoZ9vLLbUpr2xSQ7EMkSzasi0UAXXZVPm/SDD0TZoCwUQ5fvjw3ax+7PAxYcb4Kb9jvQRc2gzruJY47mN5sQp27HcIOH2JkTWgABQC1csXGhNlxGmrAkre5l6e3zU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605595; c=relaxed/simple;
	bh=Qfz8+6Uu78GANnk+XXmC1yVoBt4uyAv8DDRBtb1jN/A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qSVbJrkzrYx4PEh0hexU5SC91hbQle2Y7IxJBLnK+iHrbOXNTgxmbvBUHiV2cmF+cy0bpZwRMUkppShHDczhAxnDG3AvEc6CWIofkaFG/oFOSfbGzABFmRjaT2hanA9Nbvb1J6t26I7qd8rxd3pcjApRl3jyKCunoF+JbJEbYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZHuY4+G; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZHuY4+G"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so4270930a91.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 03:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781605593; x=1782210393; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LjOTgU/R9Q6waNYMRI2IpAW/+oeT0LDKFANpc77mFxQ=;
        b=hZHuY4+GXN+UYsCTkFA03mj4t8870XlAgniD8zGl3tH0B1zBcf1zSq/T7QXxZFrqax
         YX5dKyvpe5p8mOLXda6HkBI0AkR1dEubcsm/6BQEBgIpES6kQzU+nAhlhCNJDdkr8VLg
         pPxWHzdo/EJdxALI9sWcARSH8/Qed8NTCFdmbQu9sLj+aVWgVuJEtg/hy8ySieJFK+0Z
         aLs6msHydhbcEEbcgi3DS4CP255x7SvIJJe9eexFSr9UAOTDv0eqcNTbSrm/TUjTsrbX
         KfF46Yc4fFdiDsY3/I3rO5Eh5eQORU+xe47FgSkePpSa1Uil0km/qXjQEVoSVwOgRBT4
         6ELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781605593; x=1782210393;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjOTgU/R9Q6waNYMRI2IpAW/+oeT0LDKFANpc77mFxQ=;
        b=F6GLVNC7wBrwa3phJxkTLVcHhMMMcGcwJG1kEsFUW778sbbajKejxGfng6ALQGev3e
         GB+aaDE6PQYl0RWfdm03raQdPes65pDVLpxES4Afs4EtmzCCSkjMowu7XzXTlaYV9bAv
         t9kX6vkvSRqGNp0AHcETUAFxxs8uXXr9F8lMeQSB+RHPD1Hz2Hqz6L1BL9e31u2OJISC
         s9oVA4VLxLUbhTber3jrscsyepQm0QiY8Db/eGNU8jEqKJ9CQpZMXPXHKw/RBc2YGGOf
         sXdZzVM4rATholQK+eHs1k9XtJEi5bsURAvgTv6h420O841vcdRk3bJELqhrB1SB8x9R
         EOtA==
X-Gm-Message-State: AOJu0Ywre47oorcI4h61oTAO7OS1OhY1ajXJGlZvgzInuW9RWdTxRrPk
	nRulBtqJZyxOz//S7Nc721hTQRgQeEykiHTXs9QMiCl3b8qhlZ/m0Y8D
X-Gm-Gg: Acq92OGRsobPuMiQrXm2hQ1xsNCP/j74y41CEkUmJCYyoC+Uh+WNtRNpcOHAWbgfQ1B
	hPO9lg7OdZ4uTXwXW0HnVy0mll5HIITmeMaOj/mhWjcsB255aORD433/w2/7ZzYSkbJkaKDI8lN
	fuSRF1lZFg8jNwlTvhnN87BuRamd9HkwzPnHORRuDTvuwfUcfYlj7kS3i+F90xPO22u+JPlCXOy
	YdOVORHAi5dnlYTw9mMoS8BOdJKimnN3ZH1S+ZgURvBSTkCqU+WlCops0yPvW7VQ84syk26FG0Q
	4NxTKL4kBvIBCBtkMKFJ5etGnn2K+V3fQPg/VkYPZhmSqgUFDa7rFMs2yE5Ai5ELjWpAJUKD/GO
	+bdcjA8dllTDBJ3gGZVTDW18NeDWbabPtELU44dEJxJZK1Zr/Zf0gg35Go9uljyPes3e1gItX8C
	NQWum7YjpUGjSI0noyVJjcJ9pIzxdRhCW5JsCIdn9GSqU8U5ho
X-Received: by 2002:a17:90b:53cc:b0:36b:7f69:c152 with SMTP id 98e67ed59e1d1-37c2bd494e7mr15411320a91.18.1781605592598;
        Tue, 16 Jun 2026 03:26:32 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e88d546dsm8079269a91.2.2026.06.16.03.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:26:32 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Subject: [PATCH 00/11] HID: iio: warning clean up and prefer kernel coding
 style
Date: Tue, 16 Jun 2026 15:56:05 +0530
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL0kMWoC/yXMwQqDMBCE4VeRPXdBUxuxr1J6SHTVEbuWREtBf
 HfTCnP5DvNvFCVAIt2zjYJ8EDFrQnHJqBmc9sJok8nkxua2uHHauCoPaBmY2U3o9SW6cGm9d5W
 pai9XSvd3kA7ff/rxPB1XP0qz/Hq07wcdM36RfAAAAA==
X-Change-ID: 20260615-15-jun-hid-iio-alignment-46bba7279be3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Zhang Lixu <lixu.zhang@intel.com>
X-Mailer: b4 0.15.2

Hi all,

This series updates HID IIO drivers to resolve checkpatch and
kernel coding style issue.

This improves readability and follow standard kernel coding style
No functional changes are introduced.

Testing:
  - Compiled with W=1 for each patch in the series

---
Sanjay Chitroda (11):
      iio: hid-sensors: add missing blank line after declarations
      iio: humidity: hid-sensor-humidity: align parenthesis for readability
      iio: gyro: hid-sensor-gyro-3d: align parenthesis for readability
      iio: magnetometer: hid-sensor-magn-3d: align parenthesis for readability
      iio: humidity: hid-sensor-humidity: use common device for devres
      iio: position: hid-sensor-custom-intel-hinge: use common device for devres
      iio: temperature: hid-sensor-temperature: use common device for devres
      iio: hid-sensor-magn-3d: use ! instead of explicit NULL check
      iio: hid-sensor-rotation: use ! instead of explicit NULL check
      iio: hid-sensor-incl-3d: use ! instead of explicit NULL check
      iio: hid-sensor-accel-3d: use ! instead of explicit NULL check

 drivers/iio/accel/hid-sensor-accel-3d.c            |  2 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  3 +
 drivers/iio/gyro/hid-sensor-gyro-3d.c              | 58 ++++++++--------
 drivers/iio/humidity/hid-sensor-humidity.c         | 48 ++++++-------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 80 +++++++++++-----------
 drivers/iio/orientation/hid-sensor-incl-3d.c       |  2 +-
 drivers/iio/orientation/hid-sensor-rotation.c      |  2 +-
 .../iio/position/hid-sensor-custom-intel-hinge.c   |  2 +-
 drivers/iio/temperature/hid-sensor-temperature.c   |  4 +-
 9 files changed, 102 insertions(+), 99 deletions(-)
---
base-commit: a50909aa46dec46de3c73235fc15a7d6f763d996
change-id: 20260615-15-jun-hid-iio-alignment-46bba7279be3

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>

