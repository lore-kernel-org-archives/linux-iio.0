Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD6137F00B;
	Sun, 19 Jul 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784454723; cv=none; b=BLMq5ftq8Djm5ZoQCt3f3XPmXezE5XWqArdiWvj4/4c0zQsI6/U5OR8XpGJg+mE/UPbkVksthEn6wjIjrL4Ew7fR2QpPOQjGKhkc9UcWnFVzAXQOrLcJViA2k2Cc6wudmavsdBJtAC/uvN2/7TlqZCzLAbhs/bC+M1eirnZKTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784454723; c=relaxed/simple;
	bh=s6BQ0/nz+/RqPwvgtlb6ILSJzkf4z/B6nvGzCDiBFJ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=exFROHY/A1Xk2K+i9kNBP9rv8A9C/K15wtcbGFOi8E2X/5hRtKPUCxzmqa38Lq6TRtiwL6tIrANPZZcYiMztiNfHHE7jznCkPOgTcRbSQxX7/rBGJpMzOr1YJlywdU6CQwoHW18Z+sQ1jc6/6lb1bqkALIKu36q9sO18AdYW8W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMF1MFUC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMF1MFUC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5E4FC19425;
	Sun, 19 Jul 2026 09:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784454723;
	bh=s6BQ0/nz+/RqPwvgtlb6ILSJzkf4z/B6nvGzCDiBFJ4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NMF1MFUCiq2FT0Q1YHE9NNJPtObxXvcEo4DcFxxHk97AQ/5vOSTZzSF5iy7oCTcbA
	 MhyKPwQJs8G8BFQGmYyPnEmaiU35DfrbzH3QcRQlzMMFsCqWe22llNr/hADWgQipOe
	 oc0CD5jNpdSDGrF66EJS4wkbmBIYKqhs5A6G34oZmn/i7NDdweAcU4N0EVlJwTUOiw
	 B42+WMSgYRCvfVRjY+bL82EjgtBGT4hO3Hk5V+YhMWaRG6DtxQMhWET/OUD1nQXddw
	 afiRKdQ66NqAD7e7s9FQe54nn9h9RszypbqICJNoAKbYFdR+dWnHwrppe8t+qYYdwK
	 CxSath9IyjlUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C253FC44520;
	Sun, 19 Jul 2026 09:52:02 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH 0/4] iio: dac: ad5686: extend device support
Date: Sun, 19 Jul 2026 10:51:56 +0100
Message-Id: <20260719-ad5686-extend-dev-support-v1-0-841ec75cf5d8@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADyeXGoC/x3MQQqDMBBG4avIrB3ICI1NryIuxPmts4khURHEu
 zd0+S3eu6kgGwp9mpsyTiu2xQppG5rXKX7BptXUuc67XgJP+vJvz7h2RGXFyeVIacs7w6mqSFg
 kzFT7lLHY9X8P4/P8AI72HwNrAAAA
X-Change-ID: 20260719-ad5686-extend-dev-support-e0ddd119f19c
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784454721; l=1666;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=s6BQ0/nz+/RqPwvgtlb6ILSJzkf4z/B6nvGzCDiBFJ4=;
 b=S5UNlQQ/G/3S5Vv4Uu/22GIBawbGPyRA12LoTgENJ23VLi3F6tza9gWAGvPkPBm5j2G9hLEVU
 pT9apzWKEMAAHauJ5WQ6rclWu87ClVranJfnw7ZOs+TJbgeIWJlx+A8
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This is the third series of three on updating the AD5686 driver.

Initially, a big patch series was sent:
https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com

Then, the first patch series added fixes and cleanups:
https://lore.kernel.org/all/20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com/

The second series introduced new features:
https://lore.kernel.org/all/20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com/

This series adds support for:
- SPI: AD5313R, AD5317R, AD5674, AD5679, AD5687, AD5687R, AD5689, AD5689R;
- I2C: AD5316R, AD5675, AD5697R

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Rodrigo Alencar (4):
      dt-bindings: iio: dac: ad5696: extend device support
      dt-bindings: iio: dac: ad5686: extend device support
      iio: dac: ad5686: extend device support with new parts
      iio: dac: ad5686: update device list and file header comments

 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    | 14 ++++-
 .../devicetree/bindings/iio/dac/adi,ad5696.yaml    |  6 +++
 drivers/iio/dac/Kconfig                            | 31 +++++++++---
 drivers/iio/dac/ad5686-spi.c                       | 23 +++++++--
 drivers/iio/dac/ad5686.c                           | 59 +++++++++++++++++++++-
 drivers/iio/dac/ad5686.h                           |  7 +++
 drivers/iio/dac/ad5696-i2c.c                       | 14 +++--
 7 files changed, 135 insertions(+), 19 deletions(-)
---
base-commit: 1258e8ca13866b1a60895abf0ab8a4dd77bf4bfd
change-id: 20260719-ad5686-extend-dev-support-e0ddd119f19c

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


