Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355BB3B3BE1
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791930; cv=none; b=ICAm7J6RkDahR2Qy6jL7W14TRbvwKsSz+LB56FgVJ1tjP4qweo4hEKVKxJKEnaDFMRXu03JdZMG68ixU88+8LZUXVZo+LAjEqpleTjf4bJJrCmmcGoSfSCLhjsmqyvFDzEqa2lmBNwfm5i3P/bsSuu7va06OGrTHO38WA36nFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791930; c=relaxed/simple;
	bh=pTsf3yVpRPJaEVrdk6KnVrX1yznkHWpzOa5z8W0NXrw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=eCoxuKN8vyC60td20QBb6JsXHDUowNA8SV/MqSw6q9Ftp4NZcz76VdfFpFhf5rDjS6FgTH6BLtxfRRkh6nSI3AMawgRqXJuegYusBJ/fLHgb90diXkOYDSllIwcPx+8KN5vMbtgg6WLo5J2za/RiZKlKi0rSkLFY1UP3s+Bk0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPjVGY8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPjVGY8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723781F00899;
	Wed, 30 Sep 2026 18:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791929;
	bh=K1XxXaMjIWqqVt/KV4h8Iabdm9Ibw9vdeKB/YU3mzqo=;
	h=Date:From:To:Subject;
	b=YPjVGY8kIwNL3Rm0aRkCClurqtLOp/W25Ilm+Gr1sA2hhjLfgEIVeGuPxLnrztabV
	 Nwl3bH/JMZEKSbSu1JemKoIrDgX44UDTkLAEOIJ0cHP/WUJT97OoN550boxdicUOlW
	 cRySVd6Xd50PhWqx9Gm0n3EauPXDNxdyuaWCyQG+NlrLITlD13TtH0oiHf8br5KSvg
	 yFIB1dHpzn31smMW/rMWklo/0yyhLVGGwdf6EAQD4T762qmxtMETX1k+xpAfJ9hLA+
	 Ps2kV4uKNHLAA1RN7yH1yfvmb/lafmUOpD8ER0zuJGnjGjTFIXI3W8/5AXvFK/SyMF
	 r7Xry2Jh+ffUQ==
Date: Wed, 30 Sep 2026 19:12:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: Fixes for late in the 7.3 cycle - (7.4 merge window
 soon enough)
Message-ID: <20260930191205.4f6a2664@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 137d6ccf0ec8c48ecf0facc47cc46926df5fd0f3:

  rust_binderfs: add transaction_report feature entry (2026-09-16 19:33:40 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-late-7.3

for you to fetch changes up to 9ee8306121495d2a25aa5d1bfd519f2748786b83:

  iio: adc: ad_sigma_delta: fix use-after-free on unbind (2026-09-30 18:59:56 +0100)

----------------------------------------------------------------
IIO: Fixes for 7.3, or 7.4 merge window.

Nothing here strikes me as particularly urgent.

The core buffer one has been there a long time and is a race only seen
during driver removal.

core
- Ensure buffer teardown on remove occurs under same locks as in other
  paths, preventing races around access to active_scan_mask.
adi,ad-sigma-delta
- Fix a use-after-free in driver unbind path by just always allocating
  a buffer that is large enough rather than trying to resize at runtime.
adi,ad4030
- Fix validation of oversampling_ratio to check if value is in range before
  using it.
adi,ad7173
- Fix swapped masks for filter fields being written.
adi,ad9000
- Fix a potential NULL dereference.
kionix,kxcfjk-1013
- Reject disable of disabled event with underflows on runtime PM.
inv,icm42607
- Don't eat runtime suspend errors.
- Make sure to put runtime PM back on errors in system resume.
isil,isl29501
- Fix a wrong return type for register_write function so it can return
  error codes.
st,stm32-adc
- Fix checking for whether a channel actually exists.
- Avoid a possible division by zero.
ti,pac1934
- Fix missing memory allocation check.

----------------------------------------------------------------
Fabrice Gasnier (2):
      iio: adc: stm32-adc: fix check on internal channel availability
      iio: adc: stm32-adc: fix possible division by zero in processed channel

Fan Wu (1):
      iio: adc: ad_sigma_delta: fix use-after-free on unbind

Jiale Yao (1):
      iio: accel: kxcjk-1013: reject duplicate event disable

Jinseob Kim (1):
      iio: buffer: serialize buffer teardown with mode claims

Linmao Li (3):
      iio: imu: inv_icm42607: propagate runtime suspend errors
      iio: imu: inv_icm42607: restore runtime PM on system resume errors
      iio: adc: ade9000: fix NULL pointer dereference in clkout registration

Marcelo Schmitt (1):
      iio: adc: ad7173: Fix digital filter configuration

Pengpeng Hou (1):
      iio: cdc: ad7150: fix OF matching and publish module aliases

Salah Triki (2):
      iio: proximity: isl29501: Fix return type of isl29501_register_write
      iio: adc: ad4030: fix invalid oversampling_ratio validation

Slavin Liu (1):
      iio: adc: pac1934: check ACPI label duplication

 drivers/iio/accel/kxcjk-1013.c                   |  2 +-
 drivers/iio/adc/ad4030.c                         | 11 ++++--
 drivers/iio/adc/ad7173.c                         |  4 +--
 drivers/iio/adc/ad_sigma_delta.c                 | 31 ++++++++++-------
 drivers/iio/adc/ade9000.c                        |  5 +--
 drivers/iio/adc/pac1934.c                        |  4 +++
 drivers/iio/adc/stm32-adc.c                      | 43 ++++++++++++++----------
 drivers/iio/cdc/ad7150.c                         |  8 +++--
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 38 ++++++++++++++++-----
 drivers/iio/industrialio-buffer.c                |  4 +++
 drivers/iio/proximity/isl29501.c                 |  2 +-
 11 files changed, 102 insertions(+), 50 deletions(-)
