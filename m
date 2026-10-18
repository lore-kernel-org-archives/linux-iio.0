Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73942B742;
	Sun, 18 Oct 2026 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359741; cv=none; b=bqW/082dBrpxmTwVPXZL1ust8pIdWGrVrQdgKP9F7oPAxQQAYmSv1sYQApwg5Dx19I//GGvRyracAZY9BiWGiMWbWHdD+ARe4d7KlR8L9aT9DyqyqZFEZJbLdlsRj3u8AxAtC4RoqFKrIDy9bHcmCzglckkdRRFusKdDNPiJUYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359741; c=relaxed/simple;
	bh=6nfRQdeF7YPs+cvmTHFcNKp9NpREBzOxIrnig+osLr8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cw/BySFFu81hBX10MIAxAVrwlxsDXaLaL0TmdYosl/Q1+dVDZ21FdrlPeKS1qGAw5Ls39REjT64mOxwxS0stxlE/Ntctj6wWOy64ngPGVu21d9X88Qv3JMcsT9jfyCyUDHY0vczngDIN0+tNxy53NX15Lx6liaY0UoeXFe3zRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9ajmu8T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9ajmu8T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 340E2C2BCC7;
	Sun, 18 Oct 2026 21:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792359741;
	bh=6nfRQdeF7YPs+cvmTHFcNKp9NpREBzOxIrnig+osLr8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=C9ajmu8T3Y7D5sPUqvBFfHLVzrJ1INH0wsQcYdeGOyj4N0D3ThlnQWjOmAB6BrUhV
	 R0dAPw25cyE35xR/KbiLtp7tREJ78gPe4hff1dstg76WKKEhbMFPTFPtw816w2E/Ut
	 C1TTTNi6P0IUJWbtS7KmS9NNyx63/wRCjZ0/fuDw2Xp0F6jBIDKv/ZOnpGJ/9ca775
	 NW7WWY09hNZFPEpfYBN3dDxhJdt3TfIpX378YhPaaeSrECTdgk8yMBJYk7eJOPvYNp
	 J4Kh/PuDp/o+SQSp6HpaPTCf/2fdiwDIBfXLCbNKY9x+33kLHe7zVWxMrmSXTpHMG2
	 4zqxKz18OJbXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE6FCCF2C4;
	Sun, 18 Oct 2026 21:42:21 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Subject: [PATCH 0/2] staging: iio: addac: adt7316: error code and probe
 cleanups
Date: Sun, 18 Oct 2026 22:41:49 +0100
Message-Id: <20261018-adt7316-error-codes-v1-0-1970b7e242ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxA0auQrm3SoiDxKsYFnalaF4xp0ZgQ7
 u4oy7f4f4FQNw04NQu4vi2sTBW8ayDdx+mmaLkaWmp7Jh5wzPNxzz2qe3FMJWvgYeiIREg4CdT
 y6Xq1z/96vmyOlzw0zb8VrOsX1lpCBHcAAAA=
X-Change-ID: 20261018-adt7316-error-codes-48500bb0b1cb
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792359739; l=1590;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=6nfRQdeF7YPs+cvmTHFcNKp9NpREBzOxIrnig+osLr8=;
 b=8XdQsDFcKXECYP0TbCWHKIFERLwFeJRpzhbVsy0z3N1g1MzaCUztOyTKs0N6rLIofHBk635aP
 Hu319KJj3XrCUyhMjZqeh49SPKpHVZrA9+xOOlBNHEea2fylCGV0SQ9
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com

Two small cleanups for the adt7316 driver.

Patch 1 makes the driver return the error codes reported by the bus
helpers instead of replacing them with -EIO, so callers see the
actual cause of a failure.

Patch 2 removes the dev_info() printed on successful probe, as
drivers that are working properly should be quiet (see
Documentation/process/coding-style.rst).

Tested on arm64 QEMU, with i2c-stub providing the device:

  insmod i2c-stub.ko chip_addr=0x48
  i2cset -y 0 0x48 0x4d 0x01
  echo adt7316 0x48 > /sys/bus/i2c/devices/i2c-0/new_device

- probe succeeds and no longer prints a message
- device_id reads back the stub register value
- writing 0/1 to "enabled" updates CONFIG1 (0x18)

Error path, instantiating the device where no stub chip exists:

  echo adt7316 0x49 > /sys/bus/i2c/devices/i2c-0/new_device

  before: probe with driver adt7316 failed with error -5
  after:  probe with driver adt7316 rejects match -19

Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
Raffaele Tranfaglia (2):
      staging: iio: addac: adt7316: propagate bus error codes
      staging: iio: addac: adt7316: drop informational message in probe

 drivers/staging/iio/addac/adt7316.c | 91 ++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 48 deletions(-)
---
base-commit: 6a27f3a7d1063aec5aa3d9370161e850fc3a85dd
change-id: 20261018-adt7316-error-codes-48500bb0b1cb

Best regards,
--  
Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>


