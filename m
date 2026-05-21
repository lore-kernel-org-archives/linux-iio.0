Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277F937F007;
	Thu, 21 May 2026 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357343; cv=none; b=FT02PIo2yRivF7jso/3U1b55GbOTcTmOhJCgKDEnj1q/wRBM3jyF3HSx4jN4EqBBURaIH6PpZDWc1HXzseEgQ31Whmobb9/UrifwKQJlbIabTrjAYguJNfATiTO2tefyzK2gpjHbJlHQo4IGo6Kvqf4R1iAU2SF8/MZ3GWGkPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357343; c=relaxed/simple;
	bh=+qVy/VEiV6aWMIQfz0KhAEFfds0UKkgkJir8yJUDAmc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Evje6k4q9gwqlJKK91iuBgAbny2mHzv0+RqJ57SGdYxz9tFd+/3XdQNSwO3uP5CxPwtLlUx9NNefTttPHWUrBgKS4VyOdfPZUe82evVPJwyYI9jiXXgCoEHFnfjH9vxSNbr7OXF4g0rqDtrHZ3lm9BYo1Y4zjVtfpniMjcKTSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzl11fXW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzl11fXW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C059FC2BCB4;
	Thu, 21 May 2026 09:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779357342;
	bh=+qVy/VEiV6aWMIQfz0KhAEFfds0UKkgkJir8yJUDAmc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gzl11fXWyWiGBFZyYYL6Y+CuakVIKIS1tyEKmxFroGVvbr2t8VqVBUr+g+dUow+Eq
	 RZt/dqE+RlzQYY8a69TjqYCUapjRwxJOa3kNHi1KN765laFltoPUC5+kR3Q7WKxiXo
	 ORIlHF2l4HW5FC62Yapj3oAfZpkEXUrXocokoLC0h0dT8380NKZIG+K3yt+tvDMLMB
	 PmllKvPmlznUObgCFWpfohV/ttMVdWXmmHqoj9jP1GwvPDa6M7YIN24GGEpQEqNncj
	 4SA1x7j81CZO6ePWE+S9ObYeFi9CrdGxs8AG4zD3g5c89zGQs8nZRbAg268sqwrKH0
	 yFXV6QY9SRA+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2213CD4F5E;
	Thu, 21 May 2026 09:55:42 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Subject: [PATCH v3 0/7] iio: light: opt3001: driver cleanup
Date: Thu, 21 May 2026 11:55:37 +0200
Message-Id: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJnWDmoC/3WNwQqDMBAFf0X23JRsojV66n+UHkKMuqBGEhtax
 H9v9CSUHufBzFshWE82QJ2t4G2kQG5KIC8ZmF5PnWXUJAbBxY0XiMzNi+QcmRmsnl4zM5gjNhZ
 zWQlI1uxtS++j+Hgm7ikszn+Og4j7+r8VkXHWlqqsGiPzojD3btQ0XI0bYW9FcfbFry+Srzgq0
 0qtNNdnf9u2L/2iPifuAAAA
X-Change-ID: 20260511-opt3001-cleanup-c1411de14392
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
 Michael Hornung <mhornung.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, Sashiko <sashiko-bot@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779357341; l=2320;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=+qVy/VEiV6aWMIQfz0KhAEFfds0UKkgkJir8yJUDAmc=;
 b=dYMNm1aBsbzIl2yV7fBNsQ5XFgkQhmMUyDbril7YGcSwwdCoWbVMpr90SSR3eKQy0ITRpqiZL
 DkUrZz+DxK6Cqtv4Q//XiUTi40l0MRtRgmnc8ez7tjHTGBv6onR7khA
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
Joshua Crofts (7):
      iio: light: opt3001: move device registration to end of probe()
      iio: light: opt3001: use local struct device and i2c_client variables
      iio: light: opt3001: ensure correct parenthesis alignment
      iio: light: opt3001: localize for loop iterator
      iio: light: opt3001: prefer dev_err_probe()
      iio: light: opt3001: move driver to guard(mutex)() use
      iio: light: opt3001: add comment to mutex

 drivers/iio/light/opt3001.c | 378 +++++++++++++++++++++-----------------------
 1 file changed, 179 insertions(+), 199 deletions(-)
---
base-commit: 8678fb54958893818ddeccd05fea560a4e1fc759
change-id: 20260511-opt3001-cleanup-c1411de14392

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>


