Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5EF13D886;
	Sun, 20 Sep 2026 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789875276; cv=none; b=L6i8XV0je4+BDBle9WRQP8gC4Rs9ybsnsdmq0Wc6TUnM1960SlMO3ZYzqa8wQgQ1gke8sBi1Kwy5hona/2RLhtHSA4ABlkuNEO7KsDhf59ct+wYorTPMVYeiC2B1MtBLS9WTCt4JKo7Y6BIiXQN9UIhNMTMXUGGmBXIE7S8Rexo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789875276; c=relaxed/simple;
	bh=3Jn1SlgFJNigozgAaPL+v3ErLDdCg0vARhjuQ6GfbUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBNBHPYe/+wSCL5GFhf5/ihT3Bfi6dcdLjQGZjjFK0amb8ZaF3LZf/Acjtkje2qnVHY3oblMpf1Of+cUW3AsFDGBfY8Wmb6IOKGQB+MEG/I/xNoDVk1CCsuDU9BcCZgN7lz3Bn2+l/Fm+h4e/pWtVh6lAMKtCiUkvbYlHeNHklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Is48XaVp; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Is48XaVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=JQ
	CuQMfS+XLP6psli6HHgNqnqjpOHGAJrR2ky5r9S20=; b=Is48XaVpi6I0tEwYRs
	XfVA8QXvObbHQ4mbJ/3HgL8plsEYvhvcDYwzuhYPB4HwTFgTCAPcEH9xXv62NLD7
	38bn4wi92d5aeOm7umvMHHr+xbe/N+tDiCuAGDVr807eILN3nJqvQAQWQT1/6lWx
	Qq2E8teU0NJhxjTWlsDfClMN8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3xxgnVK9qGKc5AQ--.62090S2;
	Sun, 20 Sep 2026 11:34:00 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: petre.rodan@subdimension.ro
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tiberiu.a.breana@intel.com,
	andriy.shevchenko@intel.com,
	hppiscas@163.com
Subject: [PATCH v2] iio: accel: bma220: publish the SPI driver ACPI alias
Date: Sun, 20 Sep 2026 11:33:58 +0800
Message-ID: <20260920033358.12345-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3xxgnVK9qGKc5AQ--.62090S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF45Ar4DKr18ZFWrWFy7Awb_yoW8Xw1fpa
	1DWa4jkr93WF4Utayjvw1Uua4rGwsxJ347Cw4Uua4Uuanxur1UKF42yFykAr9xKFy3AFZr
	JFnxZr9xuF48A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziEfOrUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7QilbmqvVCh5SQAA3n

The SPI driver advertises an ACPI match for BMA0220 but does not export
that table. A modular build therefore lacks the ACPI alias used to load
the driver when the device is enumerated through ACPI.

Export the ACPI table. Move the existing SPI export next to its SPI ID
table so each export is adjacent to the table it describes.

The issue was found by our static-analysis tool.

Fixes: bf2a5600a3eb ("iio: accel: Add support for Bosch BMA220")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1:
https://lore.kernel.org/all/20260905133901.66016-1-hppiscas@163.com/
Place the SPI export immediately after the SPI table as Jonathan and
Andy requested; use the full author name.

 drivers/iio/accel/bma220_spi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index d6c1087cc3c0..d7a95289df48 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -28,12 +28,13 @@ static const struct spi_device_id bma220_spi_id[] = {
 	{ .name = "bma220" },
 	{ }
 };
+MODULE_DEVICE_TABLE(spi, bma220_spi_id);
 
 static const struct acpi_device_id bma220_acpi_id[] = {
 	{ "BMA0220", 0 },
 	{ }
 };
-MODULE_DEVICE_TABLE(spi, bma220_spi_id);
+MODULE_DEVICE_TABLE(acpi, bma220_acpi_id);
 
 static const struct of_device_id bma220_of_spi_match[] = {
 	{ .compatible = "bosch,bma220" },

base-commit: 518e5b794c06c0f0eb40df3e202274a66202c137
-- 
2.50.1 (Apple Git-155)

