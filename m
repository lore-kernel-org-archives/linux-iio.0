Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DCA37B022;
	Fri, 17 Jul 2026 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784291994; cv=none; b=TRytpTbVFBqzL7vhRxM/Z1UybYD1LYdDpXGyzVB7he8kFi9LYSuQESJyPW9uC8VoICNSnf2C2q5aBR4X/OvoZBLJ1IiQfgXD/fEYcus94LOlX58WUzhnk50DEi2UI+FTlxYKUdtR3WF9eHQm09bFSeqmVHaKDmFs6zW0aNGpDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784291994; c=relaxed/simple;
	bh=eJ/ZhnSqtVnhlW2YrlsssveGtVix22fBl3oGwtL5XoU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OsXlyqUgSzAeRdpZKhL9Kp0vd2unRGRAmFJeVYDkRZ4hSRgaCSp3vNZOiUTJdcGLFEj60mQZfMOFbjs9VPmF31jh0idvSmZekehXLb58B6jUl64LjYi2WU3CIou9oFId3xxtp0fGP6xlmf9YL0C3sKSZlx7TmuGEV1tyg1ERpEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoZogLP7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoZogLP7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B5C6C2BCB8;
	Fri, 17 Jul 2026 12:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784291994;
	bh=eJ/ZhnSqtVnhlW2YrlsssveGtVix22fBl3oGwtL5XoU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=HoZogLP76KoDstf1pacW7F06PQRXzepxxS2o1IhakoWdLf4ApzWCmxfX5xZcGplJu
	 KQ0s9l5tVBmrxe0bqCcqdXZyZ+w0FTgU8i4s301U8mV6qYQNZWVyt2YKPLFfv5A6tr
	 wf2eV49uXRufsbrX6IrbRRprT/TWcYKt09qrIn1Z0ZdSvRgAlx7CmBvf3KDI2uSZ50
	 mdOd2O/zdqotbFu7I6k2SmuJIUofXBghOh1dyECVEb5MQeFHVl3gaB0TL1ltSdZi43
	 gFLqyQpYSsC9naIuLdd30CLyLfxrAQCExOqZUIFtb8mA1AXjIqFgMFThavD09VTKgY
	 Ukyub97c9MVgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66361C44516;
	Fri, 17 Jul 2026 12:39:54 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH 0/2] iio: common: improve InvenSense sample timestamping
Date: Fri, 17 Jul 2026 14:39:39 +0200
Message-Id: <20260717-iio-common-inv-sensors-timestamp-rework-v1-0-d1afee2805cd@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIsiWmoC/yXNTQrCQAxA4auUrA3MFH/Aq4iLOGY0ykxKMq1C6
 d2tuvw2783gbMIOx24G40lctK6Imw7SneqNUa6roQ/9PhziDkUUk5aiFaVO6FxdzbFJYW9UBjR
 +qT2RUo4UiELIW1hrg3GW9+90Ov/t4+XBqX3zsCwfFvNuyIsAAAA=
X-Change-ID: 20260715-iio-common-inv-sensors-timestamp-rework-acf1a0aa00f4
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784291993; l=1194;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=eJ/ZhnSqtVnhlW2YrlsssveGtVix22fBl3oGwtL5XoU=;
 b=VB8/qYpScMTlTMLfFT1t48xXhay/BKoM2YSuoDG2Fwh6e4RZ339UXz1CctLpfA10eOYRxOxTk
 JY9AGd1XFh4CDsthxokfTeDw+V8H4EjkD4ABSH5HIrjnIGKbQGqvf1h
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

This series improves the InvenSense timestamping mechanism for 2 cases:
when using watermark and for high frequency sampling.

Data arriving by batch because of FIFO watermark will now be all aligned
correctly with the interrupt timestamp and the chip period measurement
will use a minimal period of 20ms to ensure that system latency is
not preventing measurement when using high frequency sampling.

This was tested using inv_icm42600 driver when using maximum FIFO
watermark and when using 1kHz sampling frequency.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Jean-Baptiste Maneyrol (2):
      iio: invensense: better timestamp alignment when using watermark
      iio: invensense: improve period measurement by using a longer delay

 .../iio/common/inv_sensors/inv_sensors_timestamp.c | 86 +++++++++++-----------
 include/linux/iio/common/inv_sensors_timestamp.h   |  6 ++
 2 files changed, 51 insertions(+), 41 deletions(-)
---
base-commit: aa58ecc73466d0cb8c418de98e2225490bf600e3
change-id: 20260715-iio-common-inv-sensors-timestamp-rework-acf1a0aa00f4

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


