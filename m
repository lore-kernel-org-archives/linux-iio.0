Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A253B440F;
	Fri, 16 Oct 2026 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178671; cv=none; b=GTwD+yn0AhXK3G6JO5Sp9XEx1pTdhm88AZRJKRLKKeaaRsQNv++FRuE/XlBrSYZBW4d9HPF/5eqjBzJUGsk+SGc13thhTF/NoYDIk6JrSiOc6wdREPPlEP22PbrVvqZLh5xtvOJmXEKtwJHIsYAPKCQafdf4JiZRJY8hOnejXbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178671; c=relaxed/simple;
	bh=BGiuguw2nDrUMZhZt/fC2z/TQeWYzLVwuYjJIurNctM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LjCU8/NN9B0EBdBPN1+ET/FZb6udYJNf0X+Sp1z7VZexOT8utL9awIU9cif5s5KdkaEoEHwn2F0Nute8Fvdb6pLWQpsu0+XtyYN8BPWuYauEEFPT4HTo/NBXyd3vqKV14yh4ARecASsLeWCfQbCJaDrLOnt07BLWp++7dm27fC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWfVY5cu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWfVY5cu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3640EC2BCF4;
	Fri, 16 Oct 2026 19:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792178671;
	bh=BGiuguw2nDrUMZhZt/fC2z/TQeWYzLVwuYjJIurNctM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QWfVY5cu+eT5d2HBN16qX3TwmRCW6K+hyC8HKQpY9DY7EQ6NeQd9eMBzk6hIsuh98
	 c4bXksEHXiEWAxcX9XgRx8NFcKKDVzBhe4am7Oo5/IAJVJTnYgzWbzoC3iv0/ALXLy
	 yIr5H6MPpWq/hlz01BnMG43CJLNkFPZ5z1f33kPeyaI+wlmPK33NLWx5NAdAkJe6pN
	 62ZsNnrCSipE+xupT5jI1GiT2Gji2J+FRLPtyrPn/auTEiqr5u7JihoBBdRXUkVAej
	 3EeASfY2DDX4SH8mQr4hmRE7QTt2s2KH3OKia99qVXzKj1CECoR1JEWHHchD1em+3+
	 TZX+9Pke4r2qg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F405CCF2C2;
	Fri, 16 Oct 2026 19:24:31 +0000 (UTC)
From: Bruce Tsao via B4 Relay <devnull+bruce.tsao.analog.com@kernel.org>
Subject: [PATCH 0/2] iio: dac: add support for AD5413
Date: Sat, 17 Oct 2026 03:23:52 +0800
Message-Id: <20261017-ad5413-upstream-v1-0-61f40c8fef25@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ5AMBBA0avIrDVpqRJXEYvSGWahpEUkjbtrL
 N/i/wQRA2OEvkgQ8ObIu89QZQHzav2Cgl02VLIySqpWWNdoVYvriGdAuwnqjNFEpMlNkKsjIPH
 zH4fxfT+j/ii+YQAAAA==
X-Change-ID: 20261017-ad5413-upstream-f8664fff4fdb
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bruce Tsao <bruce.tsao@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792178669; l=1183;
 i=bruce.tsao@analog.com; s=20261017; h=from:subject:message-id;
 bh=BGiuguw2nDrUMZhZt/fC2z/TQeWYzLVwuYjJIurNctM=;
 b=67wYDI8ghJZc/4BM1JHb87+Z0LrADI+BD0Z4dwLGt5zWYA8BRkm3upxR1HCfkIytOhgFzZ6KB
 l+gvS4+KK8RC9cYsyFbp8QvtKPHGI3AGgPXjWVqcIyAHK8iUaZko7zH
X-Developer-Key: i=bruce.tsao@analog.com; a=ed25519;
 pk=dT7qI1i91oYvnYmY2ljmdZ0ZQoCZIzrQ8hnsyjuBedg=
X-Endpoint-Received: by B4 Relay for bruce.tsao@analog.com/20261017 with
 auth_id=1215
X-Original-From: Bruce Tsao <bruce.tsao@analog.com>
Reply-To: bruce.tsao@analog.com

This series adds support for the Analog Devices AD5413: a single-channel,
14-bit, serial-input DAC with software-selectable voltage (+/-10.5 V) and
current (0-24 mA) outputs. The SPI interface runs in mode 1 and carries a
CRC-8 on every frame, which the device has enabled out of reset.

Patch 1 documents the device-tree binding; patch 2 adds the IIO driver.

Tested on an EVAL-AD5413SDZ with a Raspberry Pi 5 and an NXP i.MX93 FRDM
board (probe, voltage- and current-output, scale/offset, powerdown/resume).

Signed-off-by: Bruce Tsao <bruce.tsao@analog.com>
---
Bruce Tsao (2):
      dt-bindings: iio: dac: Document Analog Devices AD5413 single-channel DAC
      iio: dac: add AD5413 driver

 .../devicetree/bindings/iio/dac/adi,ad5413.yaml    | 101 ++++
 drivers/iio/dac/Kconfig                            |  11 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5413.c                           | 666 +++++++++++++++++++++
 4 files changed, 779 insertions(+)
---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261017-ad5413-upstream-f8664fff4fdb

Best regards,
-- 
Bruce Tsao <bruce.tsao@analog.com>


