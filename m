Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA783D3CE8;
	Mon, 25 May 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697226; cv=none; b=hP5DpPT82JX5bz6QlIxJqtWBivVOOmwaOqAO1R+Js+MpQoMAZpOp2Y6JMKT0hiNSWRbN3M3BURWz+5QQWjG4DL+MA1EnN0W3QrVoirTCPE8bzm8cbnJSht6ky3FdyI1P/dXnoi40spdt5UfifPMNEUwRdFPehe5JqJ0WpN6Vy6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697226; c=relaxed/simple;
	bh=bp/J2VWqqgDoTfQwUcGpGrAJeMLeiom+JLmjnUGFpTM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MI7XrUgUq4xijWfhKW9reptc03oPtchxUc0ueEj5vV4pGRT5WYRGrprvgztV/uWZPE9YIvK0CNL9kzqAOLqd+Fa4/O3Fgpi1IpdHEU7hff0C9ycaww3CxxuF3P3KDwljIJZXEBhEo1qv7wAokZPEOJzTRYG+FHTQNqVB1nntrM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuOwfQ0G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuOwfQ0G"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C21EDC2BCB3;
	Mon, 25 May 2026 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779697225;
	bh=bp/J2VWqqgDoTfQwUcGpGrAJeMLeiom+JLmjnUGFpTM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=KuOwfQ0Gpdq8UtlsEMDRgBT8FgpptuZWjMxSAdOVyMwHOMsH452gWtxwCS613ZbwK
	 eY1ASVvfKB9TwdjRY4uCPoxIaZT6Ig0NcWcCEZHkmdP0NohCoIdxSfZ0JdSX2xqBOC
	 vX/ibc4d/jMjqh4mGWpH4BCX8UB7xsP/n+pjLX07dVxezuVxQkvQ2kBOSfCHXbTujr
	 qZ6XOXBJHDvnSdpDPuZW/1rclrrfNhP9C/v/4oo99DvROMZnlpVt1OZsNNp9Lk6rEQ
	 FOXGPycVcWmxeoGnVuFjSghsfHZwDoKmYDVraWYuj93emV1GNmAuYjZVzQkiRJyXxu
	 S65InCUHmN/nw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91E3CD5BCF;
	Mon, 25 May 2026 08:20:25 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Subject: [PATCH v4 0/8] iio: light: opt3001: driver cleanup
Date: Mon, 25 May 2026 10:20:14 +0200
Message-Id: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD4GFGoC/3XNyw6DIBQE0F8xrEvDBVTsqv/RdEEuqCS+Apa0M
 f570ZXpYzmTnJmFBOudDeSSLcTb6IIbhxTkKSPY6qGx1JmUCWe8YDkAHadZMAYUO6uHx0QRJIC
 xIEXFSVKTt7V77ou3e8qtC/PoX/tBhK39vxWBMlqXqqwMCpnneG167bozjj3ZtiI/ev7tefKKg
 cJaaKWZ/vTi4PmPf7F5zqCojEWF4ujXdX0Du2pf2S4BAAA=
X-Change-ID: 20260511-opt3001-cleanup-c1411de14392
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Maxwell Doose <m32285159@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779697227; l=2618;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=bp/J2VWqqgDoTfQwUcGpGrAJeMLeiom+JLmjnUGFpTM=;
 b=81MTPqNziK/PMKNaygfkBMvJPZ83iqoBVSet2CXrZU+QrWPqSzMOWz0xxr6dDWMW0yqSZFWHy
 TX6y+PPlDX8CswMWWYZEknvmFv6teUOMyRHEqwmA4ZwMui7wfgJQl6S
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

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

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
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
Joshua Crofts (8):
      iio: light: opt3001: move device registration to end of probe()
      iio: light: opt3001: use local struct device and i2c_client variables
      iio: light: opt3001: ensure correct parenthesis alignment
      iio: light: opt3001: localize for loop iterator
      iio: light: opt3001: prefer dev_err_probe()
      iio: light: opt3001: move driver to guard(mutex)() use
      iio: light: opt3001: switch driver to managed resources
      iio: light: opt3001: add comment to mutex

 drivers/iio/light/opt3001.c | 382 +++++++++++++++++++++-----------------------
 1 file changed, 183 insertions(+), 199 deletions(-)
---
base-commit: 0e7dbde323808f28c5220295bfc1c5bc6f08c3f4
change-id: 20260511-opt3001-cleanup-c1411de14392

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>


