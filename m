Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81334FF70
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772306068; cv=none; b=tOkxcSPOE6yINJvah42Cq9GhOxXK0MzHevvcVIqAvav4sAxv7hm53UC6kqc5kySPZ8B4jntmsLs1ty+yZEG85mFRuIHcBk4rjq7lLdC51yHc2+lYVGMOgTU+ETha1hJ/GmP65ayfKRfzzP1AQliRezimvHO+npr2QeGnuW8LLL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772306068; c=relaxed/simple;
	bh=O7BO7sofFShJ3rZNNsX0QOJOK89m0pgDWdmerQ+0GlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPL6dbMZUe2aoj1qF0QoiUPsBzfw1V5xdp1Qaen/5n2FThbBt9Bia/8l6vZlNigmqk6ubMQD9om7Gkc0TEcEGHhE9zzjq6t+QLmsbhEiv2gjmb39EozR9aA0MRZIWaGGqk8C7aDWr4oNk8gP3GjXpLhAuOGv9zLtPUvCRMEaVhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNJIN2eP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNJIN2eP"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8273e0fb87aso1705311b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 11:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772306067; x=1772910867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aTEnHmdgjafFhA5Ze37HfWiPS6hJ9PTsE7JUpCM9LQc=;
        b=lNJIN2ePqg1c7A8FwzdtTldYxkOMmETzBRnx9KnYksQVJSlBArKpF6hKLlvqYQAM3S
         e9QwyOeYNjt701AbbysnIKdO6Fx+RTQhVuI0w/bNgW0aHof2tmBKR411a5MAHk7VLk88
         fSYz+qnZEwBVqg0CYoUTVn5jiKwohGHG8Pi9Q2d9KmaE2EdCGNLN1ktQpGCN6VZWHMxi
         /8CJe68wulUQELGvk+7I2B6OScSCIf896fX9w4zN8o3KV7pFCXCFv4WbiGFtkaUlYVbr
         9HbZq4GhQlbB/zT8FFeHBav24h/rOxZZyiQ2TWOZAOlX3n9sGAFasVYEUubcPdWYKK05
         OGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772306067; x=1772910867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTEnHmdgjafFhA5Ze37HfWiPS6hJ9PTsE7JUpCM9LQc=;
        b=eDqgjpTmYGLXIqqWQ9hapcxYWBTYj2fxMrRJxa8D6y/qC3cNVVUCHidQ+WugGqBnA2
         /ahR9TzfWryuhAv672vQQ1P4aqxGPlnW9cS3AuusAHiob9GavveIw6r6lo7oyEL6aV9Y
         HWACScYRQUD2+b+xSuJG/NBPwXHOPOIzFFM9wSgiE6m5sqZmtyVu+POOFXsa58oQTwmB
         bZk/Oh7Qwr0xZgY6SD6LCtnY3bVAbmjTuVpKvE2pT0AFH3LSnojlZRdPYRudUY+FUdZS
         nveqCwOTBkGFSfY6GR2VJC0Z3QanM5874iJ/bBBQT/WQ6TO9J4B4By6qKqJJRZsHm5Ok
         SwCw==
X-Forwarded-Encrypted: i=1; AJvYcCVjwGJVN3ji174VXt/hS0cuAd03DZRncqeWqXDVT6ZK29SUuhV6qc2cQep6KmjC6S84wQKsDulAkkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hkNrfmmakxQZg1+Dz3EH5bN5OTzlc31FJYhE2Q7hmhHL4muT
	2TkQSTaw3LOLnRonLX5VBhD2Esya393NJ1M8KQi5CGctfYhaZcoYhZJy
X-Gm-Gg: ATEYQzz8G4t1bwZcea9ioAUEFlCB9OHgkINICXbIrrSRPmwZ0Tiuqgg/PX19ozrC2eG
	IJGTVLAeV+5m218z0ujtzAI/QckOMN52JhqedQvx3POhGYHWR4NqG/CkFAgdbLtAtwtwZx8atSB
	t0Vld1Y+uAm8pGC3//J9eNQbWwqfireB+lCX9D0T3rjMDhVBycDF/o0GJXJm8AtrLBJ8BYPBh0L
	KM21wfBUAX991pJzNaIcCcGUC5DFNedo+Ibb/r7Jf2s99OWQ+YgwQGQUKdcp0v8rLdDEkd9k0/x
	dp2VCKIlzXzh/3wdEjPKE5g4E74O74X+ZkgIOV0m3ExnN/bu94XsUKgypJRFlL0LZI12IiLRq0E
	uvZjJcjRXOy8C7ig/TufgPOmYqCPB6khxyW2c0CPLH/yI6jotSfXbvZNhVNi397X1vSrf15tPu/
	liEeOjiH/vFv3IgOgAfn3oD7rK6UzfqyEOCSE=
X-Received: by 2002:a05:6a00:2e04:b0:81c:717b:9d39 with SMTP id d2e1a72fcca58-8274da568e3mr7084345b3a.56.1772306067008;
        Sat, 28 Feb 2026 11:14:27 -0800 (PST)
Received: from arch ([2409:40c2:5057:a20e:20e0:a4e3:da85:ffd2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4c910sm8327918b3a.8.2026.02.28.11.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:14:26 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: jikos@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com,
	linux-input@vger.kernel.org
Subject: [PATCH 0/2] iio: hid-sensor-gyro-3d: fix typo and probe race condition
Date: Sun,  1 Mar 2026 00:43:58 +0530
Message-ID: <20260228191400.19244-1-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces two changes to the hid-sensor-gyro-3d
driver:

- Patch 1: Move iio_device_register() to the end of the probe()
  function and updates the error handling and remove() sequences to
  strictly follow the LIFO teardown order.

- Patch 2: Fixes a trivial spelling mistake in a array name ('gryo' to
  'gyro').

Bhargav Joshi (2):
  iio: hid-sensor-gyro-3d: move iio_device_register() to end of probe()
  iio: hid-sensor-gyro-3d: fix typo in array name

 drivers/iio/gyro/hid-sensor-gyro-3d.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

-- 
2.53.0

