Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB39E399368
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443149; cv=none; b=Rl+iSD1HGA6tyArTopR1QYth1DaV+juULWAfeEjIu+X5W537yvJFVWnrNdj+/NA8Z2zSGNH5BpHy+zycwDmks1Md+FRggzaN6nFIKRP+COhX2ONgdWVFT5DZW4Eg/pwlRtN7iamXRj9+jp7P33k+qQXDHpnO4MS7Y7Zz4e++NxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443149; c=relaxed/simple;
	bh=W+AYoAL0sPb9wsGlMhJ//9Rfdjrh8bjSNVBAdC/KA1E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cq6EBHsRUqy6Hh1tfWQZnEuRWEz/eiA31dP3UpK3ueTE+Ad9GKO5K2EkgMygr63w6f+plssZBvbx+s0PLdKg0A4zsjWH6WNeCg3i8UMt6R6FQlxquC4pHBJowYjfYsBiwEzrAB3uPY0XavXTI8U3qDrNfLcbVSccErAEf2J1TQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+srsUL1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+srsUL1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4905529b933so24716705e9.0
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781443146; x=1782047946; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xsFmAY0G11NUmbB99LEpbxText/8LFdDER2BdIag1dM=;
        b=d+srsUL1RsJsbP5XjK0Torw+D9zCk7veLcvlOv+tyvXZi0yzgSXgaBcRo5d8lRCHOr
         aOI809djPpRID4ZvP/WHGWdIkOGsiOAvjCoDmyQiT93bjH8CYoMulCSY65SYk502Dopz
         o7P2NLBsA2mvP7aEshKFcnyJC1zL1JtBmjDtQYUHNSyZtOMRiw20IoMUQuPoXTzZ/3vu
         TfcSNhphmScQcd8HvninCUKTmXZDeGyYRN8vVYguIiuRCVkXd3ZCRxQWRrGbEnewJq5G
         hRI+8Qg+dPGHA9S6odAt6qTQBWas/d8yIshBx9HDnCeD0gcLDHgnIw1YRk0tMwuhP4PR
         NwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781443146; x=1782047946;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsFmAY0G11NUmbB99LEpbxText/8LFdDER2BdIag1dM=;
        b=bHtFP5jPmxy0v/5bQaH8ex52udjRWnRc45cK9/Q18wzI7PG+accKjNGoMxzLZwNo6z
         jysEZ4E2yJJUjMCCTu3k5/gc4BEDnBZbtIwRm9Jv9xQckcGJcVN4a+jgU11cC64VMiEC
         7kq82JInYtevQ81dYXf/dzyshOV1mZDAj/wMFuDjVq9HoMFxyVtUWXFOA8te8o9yIUEs
         9veCwZ32h492ORiE/7ko0GCeI7NhqimoGD9Q1fP+YEAZ6Fa3Uldv4G6cUeB64uphBMtc
         Z1KvdP2X4Lpw8MPvrUId9fbA5Q/k6mkEZyGQigoOfMgBPx+Wphcp9+Y9CsIDfIuhT+z6
         lf5Q==
X-Gm-Message-State: AOJu0Yy9xo1u00e4rBvI9idTkF/Gr69BYn0AhRrwsj+xOxxLipvOp29y
	AwYANeHMyO+D/7h3u55Ub7fZBtqJZTdzSecjVnUQM/cD3WoWoE6y0VXC
X-Gm-Gg: Acq92OFIfgNIDB4XykhzWO3XJIFjGbxd4qU6LHfHWySCAJPMkfVS/JiUkI7n8cxVZsP
	I13MCJarOArZX7xxmNFZJ0Lfmb9aVjMtybXOXkufoY2+ihtLQzGdLhZgGAtI6c6LPN70b40b3wx
	qyGTiak4y0Kgjsk9Wuc95gXEyGn+ENCWfKYijg+X2URaSkJ+eBZoCYGLBoQ2dH297xSQ9sHvTf2
	SuWoWqKNTI3AnM40BwJOUWr/lqeC80Orz/JlWh7KYQ5gwsrAtiUvFkcXqBFZetIQKWLlEWsRed1
	Rk7uYlYYlyUBmtJym10cVGELaclk2QhYVv0lXPLm+08z2Pjto6yjZSWYMiQAyvShqMVsRNtWaHi
	ARJDTzvNEfjp1iZHBRe5FYC5QleqWZMO9NIVWKgbFx4QxCNTVI5jyD0PZjlj4wKvmVdpnOqDCPQ
	bvS610tfdAJubXo5RTBtOygECUSVE0wDRgV9PuOx+UfPeQGdzcJiGJ1hn88RWu2jBGDoD80tikZ
	+7t9T3LcJvjD87uN0bV9iFFMLnUzQygDv1TX34dYcmttlS+mUBGkTygatN9Swrr2U/uzO1v5u7t
	Bs6gU7D95xf/fperBt2yuDvfNT4cHZuoL2BB5WFjZTyrymesn+w=
X-Received: by 2002:a05:600c:5296:b0:492:1e7f:d426 with SMTP id 5b1f17b1804b1-4921e7fd54bmr91591125e9.2.1781443145793;
        Sun, 14 Jun 2026 06:19:05 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922037055csm168406355e9.13.2026.06.14.06.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:19:05 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v6 0/8] iio: light: opt3001: driver cleanup
Date: Sun, 14 Jun 2026 15:19:02 +0200
Message-Id: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0Jmbc1QnJq64h6GBZQBJgFKWiQaw
 t2t7F2+l/z3d4gchCM8sh0CbxLFzwnMJQM31HPPStrEoFEbNFgov6wFYq7cyPX8WlR+sw0jdcb
 aBtJqCdzJ+yw+q8SDxNWHz3mw0c/+b22kUBXc3RurTUtEZT/VMl6dn6A6juMLLrkstq4AAAA=
X-Change-ID: 20260603-opt3001-cleanup-149be05f699b
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Maxwell Doose <m32285159@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781443145; l=3239;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=W+AYoAL0sPb9wsGlMhJ//9Rfdjrh8bjSNVBAdC/KA1E=;
 b=KZy3LAb/OXccTSKUPBGuvkNPJ7WGdmuzWmGKt9SxrHBVdp1cxbsnaFNENrKT2/dQCVNuHaZ5w
 S95pTt+0t4gD/v07WPvfItlzHtKvyCtxMLp6seKYsYHoqDxiIT4VM85
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This series deals with cleaning up the TI OPT3001 sensor driver,
moving it to more modern kernel practices and improving the code style.

While reviewing, Jonathan Cameron (and eventually Sashiko) found a race
condition where userspace could start interacting with the device
before the hardware IRQ was set up.

Changes include:
- moving the driver to use devm_* functions
- IWYU cleanups
- removal of unnecessary macros and comments
- using dev_err_probe() in probe and probe path functions
- checkpatch.pl warning cleanups
- fixing a race condition found in opt3001_probe() function

---
Changes in v6:
- Pull review tags
- PATCH 2: reduce code churn
- Reorder patches to reduce churn
- Rebase on updated testing branch
- Link to v5: https://lore.kernel.org/r/20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com

Changes in v5:
- PATCH 7: remove dead code oneliner
- Pull new review trailers
- Link to v4: https://lore.kernel.org/r/20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com/

Changes in v4:
- Fix bad merge
- Edit commit messages
- PATCH 1: add free_irq on iio_device_register error
- PATCH 8: change comments
- Link to v3: https://lore.kernel.org/r/20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com

Changes in v3:
- PATCH 1: fix build error
- PATCH 2: remove struct device member from struct opt3001
- PATCH 6: edit return statements
- Pull additional trailers from previous version's reviews
- Edit commit messages
- Link to v2: https://lore.kernel.org/r/20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com

Changes in v2:
- PATCH 1: added patch that fixes race condition
- PATCH 3: remove wrong usage of GENMASK()
- PATCH 4: add patch that moves driver to use local structs
- PATCH 5: add patch that ensures correct parenthesis alignment
- PATCH 6: change int to unsigned int
- PATCH 7: moved opt3001_read_id() function to use dev_err_probe()
- PATCH 9: removed unnecessary dev_err_probe() calls, reordering
- PATCH 10: added patch that adds a comment to mutex declaration
- Link to v1: https://lore.kernel.org/r/20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com

---
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

---
Joshua Crofts (8):
      iio: light: opt3001: move device registration to end of probe()
      iio: light: opt3001: use local struct device and i2c_client variables
      iio: light: opt3001: prefer dev_err_probe()
      iio: light: opt3001: ensure correct parenthesis alignment
      iio: light: opt3001: localize for loop iterator
      iio: light: opt3001: move driver to guard(mutex)() use
      iio: light: opt3001: switch driver to managed resources
      iio: light: opt3001: add comment to mutex

 drivers/iio/light/opt3001.c | 381 +++++++++++++++++++++-----------------------
 1 file changed, 181 insertions(+), 200 deletions(-)
---
base-commit: 5eff1cd0d0156240c0839921b537599ae77a2ce2
change-id: 20260603-opt3001-cleanup-149be05f699b

Best regards,
-- 
Kind regards

CJD

