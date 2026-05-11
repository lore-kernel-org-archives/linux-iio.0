Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B601E345741;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498779; cv=none; b=uej8cJ/970T94UTvFB5WjWUTfS+mP+5ySLakkVTW10ZqrWujycPXUXHXYZR148IyZ0njsSoR0/Ze86c7oZ0qAX0tS8EhEwUOXzJ1kmJ49iAeRDRR0N8XXB9F6gpXJLa6NmoZn3FQaKS29FQXGxJ7atpeD5lp7DCYzNmm2e4C6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498779; c=relaxed/simple;
	bh=pATk6uJhpz24bzKtqgctD3eFXWA+8lzLS0KDy1+wEwk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UhLnZqvYCzw+l/dzbX0pVF8nNGuzrsD0UHFoMcK30+SSqP+s9xG5LzMMCF6ch6Mx0TaSll9Y+TX/2F1F2mERujUsD5gkt3xkfoj5CZxB7FyPw42YZWr/pqsDWM7uexYcWmeV5JSPCX6C0j1sGyAHF7vS8Wq2JbMtKUXtFkr6/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB5ULa6+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB5ULa6+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 566CBC2BCB0;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778498779;
	bh=pATk6uJhpz24bzKtqgctD3eFXWA+8lzLS0KDy1+wEwk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QB5ULa6+YQFC4rWi4zwceXTc9gv9uvscBRE8naz3yZLM2srGO7IcKYTPxbkBG5XcD
	 1V3IThzZC7dn6MYQbaZ63jF53AZb0XETTPjKWraGKe52kiwp/fHUNFqunN46rq1xsk
	 Vvq+naOg6qiCIeMH9enhM7r6Z47llf4iMc8QRsyZuicKrGHc03ye6UTsHiGNRNTsAk
	 aeKPgIrZKTRJv+Bf3uuHqEwvkJWL6idQbodvPqZvqdFKcrSUl0xDSP15bpVb67V1da
	 0IY0eEZ7gUpGgVeZNEHU+B9ri0rQS3CRgxrUyUYhCSlGAQXMUaEKnC59VjencXspqH
	 9o/F4ayTWfN7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ABFCD37AC;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Subject: [PATCH v7 0/8] iio: magnetometer: ak8975: driver cleanup
Date: Mon, 11 May 2026 13:26:09 +0200
Message-Id: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANG8AWoC/42NQQ6DIBBFr2JYdxrECqar3qNxgTDqpEUIUNPGe
 PdST9Dle/l5f2MJI2Fi12pjEVdK5JcC6lQxM+tlQiBbmAkuJG+5AqenBbN3mDHCSG9MEHzKEMg
 8XgGMtHqwVsqxvbASCRGPUWnc+8Izpezj5/hb65/9O73WwKFRnVBGy24cmtvkND3PxjvW7/v+B
 bMHRB/MAAAA
X-Change-ID: 20260507-magnetometer-fixes-post-pickup-c6dabdd66f54
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778498777; l=1610;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=pATk6uJhpz24bzKtqgctD3eFXWA+8lzLS0KDy1+wEwk=;
 b=92D5u7R3Sknaw658T8q6n3XQl8Bl8Rb+isc+2WAqK82vvHoJe4a52CTYiL60ikdtpeuTtR0cc
 4XGIcvNY+b9Atbuu5A/S2XjIH6XetMSFPRzty9GnxbyWt3lZ7HIlTJc
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

This series is a continuation of the previous ak8975 driver cleanup
effort, as most of the patches were picked.

Changes include:
- using BIT() and GENMASK() macros
- moving to devm_* resource management
- adding a scan index enum
- moving from using wait loops to iopoll functions
- various code style changes

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v7:
- Changed revision to v7 as series is a continuation of previous series
- Added Nuno's Reviewed-by tag
- PATCH 3: change order of pm_runtime initialization
- Link to v6: https://lore.kernel.org/r/20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com

---
Andy Shevchenko (5):
      iio: magnetometer: ak8975: switch to using managed resources
      iio: magnetometer: ak8975: consistently use 'data' parameter
      iio: magnetometer: ak8975: unify messages with help of dev_err_probe()
      iio: magnetometer: ak8975: use temporary variable for struct device
      iio: magnetometer: ak8975: make use of the macros from bits.h

Joshua Crofts (3):
      iio: magnetometer: ak8975: modernize polling loops with iopoll() macros
      iio: magnetometer: ak8975: check if gpiod read was successful
      iio: magnetometer: ak8975: add scan mask index enum

 drivers/iio/magnetometer/ak8975.c | 269 +++++++++++++++++++-------------------
 1 file changed, 134 insertions(+), 135 deletions(-)
---
base-commit: 74d173f29572951629d1e0b7456b424006e51b87
change-id: 20260507-magnetometer-fixes-post-pickup-c6dabdd66f54

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>


