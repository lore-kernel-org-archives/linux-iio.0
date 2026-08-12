Received: from sg-2-5.ptr.blmpb.com (sg-2-5.ptr.blmpb.com [71.18.227.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E726F3AA518
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521553; cv=none; b=Wy+KieDh74JcrPWZrBuv2eV/JNV6h00gYtyn9lraMA1hzn3Y1Zo9rS7FWEPoji0WEKuEZRDfgBi5LsAN/ENK50OGxPlrayTup3J+NRpFr25gwV+wh/OY+hSkiYYTzCjWcDLBNSOsFqyA8A2BwQfLsxOTDSvRya6yQVJkDm6Ksec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521553; c=relaxed/simple;
	bh=j46aXIL504JUxloLR4rl/7TMYu3jXTK9kbAwu2NEVEc=;
	h=Cc:From:Subject:Message-Id:Mime-Version:To:Date:Content-Type; b=Tu8yKGsUu5CAjHySPoXzdZ8VB6/OmmJwuERtYS8rogSh2jCYGU2JmntkwRRVxOqbiN3v4nlRBonZNbOIefki5ddkWVpdFRd3qyYhFE6d9CRA2TCjsQDsEhT9c4oYp7gvJTllbYsOunRRsZKQbZpi94dvY8cQ1uHED5yYoNJObqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=c0UWLRgx; arc=none smtp.client-ip=71.18.227.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="c0UWLRgx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1786521536; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=tTadZPLtuH8iOO6FZr4Kk5UogQtHmYPhWjpD4s0i4cE=;
 b=c0UWLRgxMAYa7oylG2TWLRZouarMVzfoPm5SJ4L2ZFXy1n1Bh3oTeLISQteR/uC8xl4w4L
 YPoSAaV2dVtxbDtq+lPYpp8mYDTLDwskTzqkxQBbM8vGZkQcjrOIEp4XHvMFLjV5B40tK8
 9FHCT87jh6MbVUYOsQVDRHFip1XTwWs95MClRb99LNXo7yDlbb/Yvp7Mfhj1VtIJF7uu1k
 BuEJeMiOro0S0KmrQ/fuHqiwABvTmGmxG9o7OmiR5FpOhdPJDZUH1YXa2T4L2Hqor5s+qd
 yP6pmDLWhNzjCaAk3Nr4+OAGrOQ8mbsSLayOfVZdQg9oGachpmr5HEziyMixUQ==
Cc: <linux@analog.com>, <linux-iio@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
X-B4-Tracking: v=1; b=H4sIALgnfGoC/2XM0QqDIBTG8VcJr3eGWql1tfcYXZgel9AqdEQje vdZG4yxy+9w/r+VRAweI6mzlQScffTjkAY/ZcR0ergheJs24ZQLqhgHbZcenHcjFFgITaUUslI k/U8BnV8O69qk3fn4GMPzoGe2Xz8KrQ4lV/QNmV7fJ5gZMJCKWiXQ8RLbi+kwhLMxO/5bCvlXC mzzEjW2xuK3bLZtewHqjP935AAAAA==
X-Change-Id: 20260812-adxl-fifo-4e46a0776798
Received: from [192.168.9.107] ([111.42.148.52]) by smtp.feishu.cn with ESMTPS; Wed, 12 Aug 2026 15:58:53 +0800
Content-Transfer-Encoding: 7bit
From: "Shengzhuo Wei" <me@cherr.cc>
X-Lms-Return-Path: <lba+26a7c27be+f6496a+vger.kernel.org+me@cherr.cc>
Subject: [PATCH v2 0/2] iio: accel: reject out-of-range FIFO entry counts
Message-Id: <20260812-adxl-fifo-v2-0-86bea20faf1c@cherr.cc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: b4 0.14.2
X-Original-From: Shengzhuo Wei <me@cherr.cc>
To: "Ramona Gradinariu" <ramona.gradinariu@analog.com>, 
	"Antoniu Miclaus" <antoniu.miclaus@analog.com>, 
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
	"Michael Hennerich" <Michael.Hennerich@analog.com>, 
	"Jonathan Cameron" <jic23@kernel.org>, 
	"David Lechner" <dlechner@baylibre.com>, 
	"Andy Shevchenko" <andy@kernel.org>, 
	"Marcelo Schmitt" <marcelo.schmitt@analog.com>
Date: Wed, 12 Aug 2026 15:58:48 +0800
Content-Type: text/plain; charset=UTF-8

Both adxl380 and adxl367 use a device-reported FIFO entry count directly
as the length of a burst read into a fixed-size fifo_buf[], without
checking it against the buffer capacity. A malfunctioning or malicious
device reporting more entries than the FIFO can hold causes a heap
out-of-bounds write past fifo_buf[].

Neither driver is reachable from untrusted userspace -- both sit behind
SPI/I2C -- so this is hardening against buggy hardware rather than a fix
for an exploitable bug. Following review feedback [1], the out-of-range
count is rejected with an error and the read is aborted rather than
clamped, and the message is ratelimited because the check runs from the
IRQ handler and a stuck device can trigger it repeatedly.

The overflow was confirmed for both drivers using KASAN repro modules:
  adxl380: slab-out-of-bounds Write of size 1022 (fifo_entries=511)
  adxl367: slab-out-of-bounds Write of size 2046 (fifo_entries=1023)

Changes since v1 [2][3]:
  - Drop Fixes:/Cc:stable -- this is hardening, not a fix.
  - Reject the count with dev_err_ratelimited + abort instead of
    clamping, per review.
  - Combine the adxl380 and adxl367 patches into a single series.

[1] https://lore.kernel.org/all/20260812060029.7dc3d25b@jic23-huawei/
[2] https://lore.kernel.org/all/20260809-adxl380-fifo-clamp-v1-1-780d86ef25eb@cherr.cc/
[3] https://lore.kernel.org/all/20260809-adxl367-fifo-clamp-v1-1-6eb35eaebcde@cherr.cc/

Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
Shengzhuo Wei (2):
      iio: accel: adxl380: reject out-of-range FIFO entry count
      iio: accel: adxl367: reject out-of-range FIFO entry count

 drivers/iio/accel/adxl367.c | 8 ++++++++
 drivers/iio/accel/adxl380.c | 7 +++++++
 2 files changed, 15 insertions(+)
---
base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
change-id: 20260812-adxl-fifo-4e46a0776798

Best regards,
-- 
Shengzhuo Wei <me@cherr.cc>
