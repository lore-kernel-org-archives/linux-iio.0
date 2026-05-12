Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BEB3839B1;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583473; cv=none; b=hv1VLr/LNYKi2QAJ9D6xktqxPkei6DENO0LuaPMED5a9GarWBzVhdgAEvNiS/lCsYQnxQifXXqfKdhpe8cqpF004RBXE4k6DJL4XlPS7W4MApPGeMWTQE9+6IZ1YsP3kSE8wv6Rt4M2VYqC+GIXVt1/EaGhMYBi8U//G+jYYA68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583473; c=relaxed/simple;
	bh=hNJ9H/mENM4XoWbrFVOCTJPYM5P7ngB+toPPIohWZdA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oCH2pXt5vFhmlueVMXNEg74F2ZnM7is1Sh+TyhyhsWbwGD9SyM5iMNlCT1YNV21M5wEDVXuMutGjtgVqIwWeLaQtMSjHwsbRbUuxSG7cE6fdSAF1O5FUfq5ACM4Yw440DmM1KseLz0sFpS44A9gJfvIX7MVvqA6i6QQxwdNd7YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQn8KMY+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQn8KMY+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C234DC2BCB0;
	Tue, 12 May 2026 10:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778583472;
	bh=hNJ9H/mENM4XoWbrFVOCTJPYM5P7ngB+toPPIohWZdA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=OQn8KMY+V9+qUBMuyA+nBOEbHmNx1s2CAu7ErSPqdoKUKlLFM7u0AvlDNTtF7s9Kr
	 UpUGhypbBd7ZymtK1O/1I5bJqYXFK+XgxTSN6dOeLhcFPwnMSHeRcQZg/xBdTehM6I
	 5tRutJeEMjcC/ahDFLiaR6fUIiQtBpYRt5TUcFKlYr6Ztz0TJiEgapHQvTjv7ZIJj4
	 8NoMYmtr+E4+8sG20IWsNHdRTNsRbm8aOfqcGZTPQ7+VFd5R3acb3a8m9XDglRvDw+
	 RbgGv2NXFdOkbfb8BPeWgwCR8KVD4r1S88y5GkMg+ohtp7Vu1PGw/EvDNhPn5tVsCV
	 5PJBwccYgoHSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B055ECD4855;
	Tue, 12 May 2026 10:57:52 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Subject: [PATCH v2 00/10] iio: light: opt3001: driver cleanup
Date: Tue, 12 May 2026 12:57:20 +0200
Message-Id: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJAHA2oC/3WNyw6CMBBFf4XM2ppOHyKs/A/DgrQDTAKUtEg0h
 H+3snd5TnLP3SFRZEpQFztE2jhxmDOoSwFuaOeeBPvMoKS6SYsowrJqKVG4kdr5tQiHBtETGl0
 pyKslUsfvs/hsMg+c1hA/58GGP/u/taGQoivvZeWdNta6Rz+1PF5dmKA5juMLxqBZfq4AAAA=
X-Change-ID: 20260511-opt3001-cleanup-c1411de14392
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
 Michael Hornung <mhornung.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, Sashiko <sashiko-bot@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778583471; l=2180;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=hNJ9H/mENM4XoWbrFVOCTJPYM5P7ngB+toPPIohWZdA=;
 b=1Sn2n3lw36dWV6fZep+d3NkCV4YxKxpyBmKkkRIGU1HcqVbEZOlPdEFVTUmkx/bBi71hnrwbD
 e686K6IE6ukAip2LeueyT5p9LrCOz9qqEOmRVVAEMFOFcA/a9SsPmG1
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
Joshua Crofts (10):
      iio: light: opt3001: move device registration to end of probe()
      iio: light: opt3001: make headers conform to iwyu
      iio: light: opt3001: use macros from bits.h header
      iio: light: opt3001: use local struct device and i2c_client variables
      iio: light: opt3001: ensure correct parenthesis alignment
      iio: light: opt3001: localize for loop iterator
      iio: light: opt3001: prefer dev_err_probe()
      iio: light: opt3001: move driver to guard(mutex)() use
      iio: light: opt3001: switch driver to managed resources
      iio: light: opt3001: add comment to mutex

 drivers/iio/light/opt3001.c | 397 +++++++++++++++++++++-----------------------
 1 file changed, 190 insertions(+), 207 deletions(-)
---
base-commit: 74d173f29572951629d1e0b7456b424006e51b87
change-id: 20260511-opt3001-cleanup-c1411de14392

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>


