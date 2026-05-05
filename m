Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F6395D8C;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981562; cv=none; b=U3+fjYTNJxdtGsaWeL/qP1GwkB1GxvRe9silyxsA6OYWY1MR3Vke5NuLVHpDADXoCDWTNRJjJ+Rf56R4ny1ZdR3rkoP3lRbYD2Cmupcr1d3HVnqhJr+54V6z22jBvB4QsmTx851UbfcFx0y3MCFggPteRa4xwyQnNAapQE3jGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981562; c=relaxed/simple;
	bh=YjyLao0KdG1xzz8sO4GyQbdN702IziQpnrZg0iH6dsM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G26daqAPHOERqJv3Rwghui3rrWs8gYToD2j7TSQDHZSU1aWpj8UkBqk9o8Cf5UeYVx7wOEebcDQxonH7e9Ew0/PGdWqYNbQOph2ZQvpbtZgotIekVo5ArFRz4SrsuifoXFp/RhnFXZDkvksQ3/XgndPO5iQ7eJSbuW5+9LIwF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bE/dlFi4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bE/dlFi4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98C54C2BCB4;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981561;
	bh=YjyLao0KdG1xzz8sO4GyQbdN702IziQpnrZg0iH6dsM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=bE/dlFi4BNPaLg+hJnLRF8VMKxil/ylStNV+9cC8PrexOImvBlQJqIMNH8xbEw15d
	 fSILUg51530yMSa+oeD1rbWum9WR6jT4YQ9jBnqxyG6nAZYRE6EYviVR7m35ZQEieS
	 vpJyhrRdaRZXav4l1Fy43K3d7A2UpAIFdCZdxkYSBeR3bOzsc8bAMRYsUFqlnh6sV0
	 PA+eFmSRAQ8ygF7xhbhmWu0bMT8uaQlX7NOpa0KekyCkK7qp4KKaKPZpJPIMJSp+yI
	 HWB4gY0Rjf0m2FcRuNXO+OUEPf+HoVY3dYcsadb+TqyIQPcJ99IL1H4UXSZvrrwNfL
	 aFisicJLLDL4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E1DCD342F;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Subject: [PATCH v5 00/18] iio: magnetometer: ak8975: modernize and cleanup
 driver
Date: Tue, 05 May 2026 13:45:56 +0200
Message-Id: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHXY+WkC/x3LOwqAMBBF0a3I1AbiJ6JuRSyiPnUKo0yCCMG9G
 ywPlxvJQxie+iyS4GbPp0sweUbzbt0GxUsylbpstNFGHXZzCOeBAFErP/BqqWzXFK22Uz1TGi/
 BH9I3jO/7Af0vEYdkAAAA
X-Change-ID: 20260505-magnetometer-fixes-d3a96180ab4c
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981558; l=3002;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=YjyLao0KdG1xzz8sO4GyQbdN702IziQpnrZg0iH6dsM=;
 b=wz3YpiyS9Vbwnq36K+IVvIrmZr1mLE0wDv7xK/sUys/BubBJFdX3iLmeHracJnkqsn1lAQBwr
 k4kMOc042NhDd3ycbtLCcLpt3aq3UVVN1UNNe90yA7eqXXKOB0NjTGZ
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

This series modernizes and cleans up the ak8975 driver, migrating to
more modern kernel APIs and cleaning up legacy code. Patches 7 through
17 were provided by Andy Shevchenko.

The series was compile-tested and ran in QEMU with i2c-stub and
no issues were found.

Changes include:
 - replacing usleep_range() with fsleep() for optimization
 - migrating to iopoll macros for better device polling
 - removing unused headers and adding new ones
 - checkpatch.pl fixes
 - switching driver to use devm_* functions

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Changes in v2:
- PATCH 1: reverted alphabetical header ordering per logical change
  separation
- PATCH 2: added newline between fsleep() and return
- PATCH 3: fixed open parenthesis formatting
- PATCH 4: fixed whitespace issues, added <linux/time.h> for
  USEC_PER_MSEC macro

Changes in v3:
- PATCH 1 & 2: split alphabetical ordering and header removal into two
  separate patches
- PATCH 4: commit message fix
- PATCH 5 & 6: split error handling and polling loop replacement into
  two separate patches

Changes in v4:
- PATCH 7-17: am Andy's changes into this series
- PATCH 2, 5, 6: fixup Andy's changes to existing patches

Changes in v5:
- PATCH 6 & 7: reorder patch series, edit commit messages
- PATCH 8: add check for negative val from readx_*() call
- Various cleanups

---

---
Andy Shevchenko (10):
      iio: magnetometer: ak8975: avoid using temporary variable
      iio: magnetometer: ak8975: drop duplicate NULL check
      iio: magnetometer: ak8975: remove duplicate error message
      iio: magnetometer: ak8975: reduce usage of magic lengths of the buffer
      iio: magnetometer: ak8975: unify return code variable name
      iio: magnetometer: ak8975: switch to using managed resources
      iio: magnetometer: ak8975: consistently use 'data' parameter
      iio: magnetometer: ak8975: unify messages with help of dev_err_probe()
      iio: magnetometer: ak8975: use temporary variable for struct device
      iio: magnetometer: ak8975: make use of the macros from bits.h

Joshua Crofts (8):
      iio: magnetometer: ak8975: sort headers alphabetically
      iio: magnetometer: ak8975: update headers per IWYU principle
      iio: magnetometer: ak8975: replace usleep_range() with fsleep()
      iio: magnetometer: ak8975: change 'u8*' to 'u8 *' in cast
      iio: magnetometer: ak8975: fix wrong errno on return
      iio: magnetometer: ak8975: pass conversion timeouts as arguments
      iio: magnetometer: ak8975: modernize polling loops with iopoll() macros
      iio: magnetometer: ak8975: check if gpiod read was successful

 drivers/iio/magnetometer/ak8975.c | 369 +++++++++++++++++++-------------------
 1 file changed, 180 insertions(+), 189 deletions(-)
---
base-commit: 440c14da1af1cc6cc9bb18841603711d845ed900
change-id: 20260505-magnetometer-fixes-d3a96180ab4c

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>


