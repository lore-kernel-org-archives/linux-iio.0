Received: from mail.imp.bg.ac.rs (mail.imp.bg.ac.rs [147.91.50.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4043DA5A4;
	Wed, 18 Mar 2026 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.91.50.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842749; cv=none; b=XEvvj2sw5NyftaDq0FF8jP4p3wzgImROQQQcC3pvXALdS3fuBjNxxRAssFDDhlopQov3sltr/aHUuO5SF/SJqaAFGaRiQUhHRDDDrnelXu3sAu58HkymZCrPAmEyjgX2ETS82aMKYoefzATjj5rRSbOUHQ/3VVKHUKLuSrKW0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842749; c=relaxed/simple;
	bh=3RNXbHn2Cuzp6YtmHQ0QRNkor2RY5pfowKfuO+SgwMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPjW44VmHbQo74YgghWQmRVPh/YAqE8HQkbxBDez2B4Axxq+Y3U8jG1aiZZICD4wihAzMp6GYpKM6zUxR5TmMMH7EV4X5LnleWSwmnPoTj0e4pxL0W2quQusR0wbh1irtgDxjvxE1Y7Tjt84bRcwLSKZlGx2ZWnWAXno8tyLw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs; spf=pass smtp.mailfrom=pupin.rs; dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b=Y+KN0dyG; arc=none smtp.client-ip=147.91.50.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pupin.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b="Y+KN0dyG"
Received: from localhost (localhost [127.0.0.1])
	by mail.imp.bg.ac.rs (Postfix) with ESMTP id C3C80140C2731;
	Wed, 18 Mar 2026 14:57:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pupin.rs; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=dkim20260301; t=1773842267; bh=3RNXbHn2Cuz
	p6YtmHQ0QRNkor2RY5pfowKfuO+SgwMM=; b=Y+KN0dyGUDANQU+PZeWkVdIF8Gn
	ZwdZ0/OHks/r9MBK0WlIU9eL0U4Aa68MfMAt+JjMqBXAhFeAhC/rb7h7jwxj3gEy
	wL89eoqIsxq4gHJFDtKK8gLwkoomeG+tKwmrN3uhDzpt13YwUwtZ2H0XLsNdBfl/
	R2o4F4ZCEOqeskgo=
X-Virus-Scanned: amavis at imp.bg.ac.rs
Received: from mail.imp.bg.ac.rs ([127.0.0.1])
 by localhost (mail.imp.bg.ac.rs [127.0.0.1]) (amavis, port 10024) with LMTP
 id suj9W2IABeR1; Wed, 18 Mar 2026 14:57:47 +0100 (CET)
X-Comment: SPF check N/A for local connections - client-ip=147.91.52.78; helo=phyvm-virtualbox; envelope-from=david.marinovic@pupin.rs; receiver=jic23@kernel.org 
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.imp.bg.ac.rs 9EAFA140C272A
Received: from phyvm-VirtualBox (unknown [147.91.52.78])
	by mail.imp.bg.ac.rs (Postfix) with ESMTPS id 9EAFA140C272A;
	Wed, 18 Mar 2026 14:57:47 +0100 (CET)
From: =?UTF-8?q?David=20Marinovi=C4=87?= <david.marinovic@pupin.rs>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Marinovic <david.marinovic@pupin.rs>
Subject: [PATCH 1/3] iio: dac: ltc2632: drop enum and use individual chip_info objects
Date: Wed, 18 Mar 2026 14:57:30 +0100
Message-ID: <20260318135736.91564-2-david.marinovic@pupin.rs>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260318135736.91564-1-david.marinovic@pupin.rs>
References: <5d4fb8998d9634c3e5a8ed17b80dae07@pupin.rs>
 <20260318135736.91564-1-david.marinovic@pupin.rs>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Marinovic <david.marinovic@pupin.rs>

Remove the ltc2632_chip_info_tbl[] array and related
ltc2632_supported_device_ids enum used for looking up chip-specific
information. Instead, use separate static const struct
ltc2632_chip_info objects for each supported chip variant.

Signed-off-by: David Marinovic <david.marinovic@pupin.rs>
---
 drivers/iio/dac/ltc2632.c | 327 +++++++++++++++++---------------------
 1 file changed, 142 insertions(+), 185 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index 105f939f7e54..ca0b88285ce5 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -48,27 +48,6 @@ struct ltc2632_state {
 	int vref_mv;
 };
 
-enum ltc2632_supported_device_ids {
-	ID_LTC2632L12,
-	ID_LTC2632L10,
-	ID_LTC2632L8,
-	ID_LTC2632H12,
-	ID_LTC2632H10,
-	ID_LTC2632H8,
-	ID_LTC2634L12,
-	ID_LTC2634L10,
-	ID_LTC2634L8,
-	ID_LTC2634H12,
-	ID_LTC2634H10,
-	ID_LTC2634H8,
-	ID_LTC2636L12,
-	ID_LTC2636L10,
-	ID_LTC2636L8,
-	ID_LTC2636H12,
-	ID_LTC2636H10,
-	ID_LTC2636H8,
-};
-
 static int ltc2632_spi_write(struct spi_device *spi,
 			     u8 cmd, u8 addr, u16 val, u8 shift)
 {
@@ -210,97 +189,112 @@ static DECLARE_LTC2632_CHANNELS(ltc2632x12, 12);
 static DECLARE_LTC2632_CHANNELS(ltc2632x10, 10);
 static DECLARE_LTC2632_CHANNELS(ltc2632x8, 8);
 
-static const struct ltc2632_chip_info ltc2632_chip_info_tbl[] = {
-	[ID_LTC2632L12] = {
-		.channels	= ltc2632x12_channels,
-		.num_channels	= 2,
-		.vref_mv	= 2500,
-	},
-	[ID_LTC2632L10] = {
-		.channels	= ltc2632x10_channels,
-		.num_channels	= 2,
-		.vref_mv	= 2500,
-	},
-	[ID_LTC2632L8] =  {
-		.channels	= ltc2632x8_channels,
-		.num_channels	= 2,
-		.vref_mv	= 2500,
-	},
-	[ID_LTC2632H12] = {
-		.channels	= ltc2632x12_channels,
-		.num_channels	= 2,
-		.vref_mv	= 4096,
-	},
-	[ID_LTC2632H10] = {
-		.channels	= ltc2632x10_channels,
-		.num_channels	= 2,
-		.vref_mv	= 4096,
-	},
-	[ID_LTC2632H8] =  {
-		.channels	= ltc2632x8_channels,
-		.num_channels	= 2,
-		.vref_mv	= 4096,
-	},
-	[ID_LTC2634L12] = {
-		.channels	= ltc2632x12_channels,
-		.num_channels	= 4,
-		.vref_mv	= 2500,
-	},
-	[ID_LTC2634L10] = {
-		.channels	= ltc2632x10_channels,
-		.num_channels	= 4,
-		.vref_mv	= 2500,
-	},
-	[ID_LTC2634L8] =  {
-		.channels	= ltc2632x8_channels,
-		.num_channels	= 4,
-		.vref_mv	= 2500,
-	},
-	[ID_LTC2634H12] = {
-		.channels	= ltc2632x12_channels,
-		.num_channels	= 4,
-		.vref_mv	= 4096,
-	},
-	[ID_LTC2634H10] = {
-		.channels	= ltc2632x10_channels,
-		.num_channels	= 4,
-		.vref_mv	= 4096,
-	},
-	[ID_LTC2634H8] =  {
-		.channels	= ltc2632x8_channels,
-		.num_channels	= 4,
-		.vref_mv	= 4096,
-	},
-	[ID_LTC2636L12] = {
-		.channels	= ltc2632x12_channels,
-		.num_channels	= 8,
-		.vref_mv	= 2500,
-	},
-	[ID_LTC2636L10] = {
-		.channels	= ltc2632x10_channels,
-		.num_channels	= 8,
-		.vref_mv	= 2500,
-	},
-	[ID_LTC2636L8] =  {
-		.channels	= ltc2632x8_channels,
-		.num_channels	= 8,
-		.vref_mv	= 2500,
-	},
-	[ID_LTC2636H12] = {
-		.channels	= ltc2632x12_channels,
-		.num_channels	= 8,
-		.vref_mv	= 4096,
-	},
-	[ID_LTC2636H10] = {
-		.channels	= ltc2632x10_channels,
-		.num_channels	= 8,
-		.vref_mv	= 4096,
-	},
-	[ID_LTC2636H8] =  {
-		.channels	= ltc2632x8_channels,
-		.num_channels	= 8,
-		.vref_mv	= 4096,
-	},
+static const struct ltc2632_chip_info ltc2632l12_chip_info = {
+	.channels	= ltc2632x12_channels,
+	.num_channels	= 2,
+	.vref_mv	= 2500,
+};
+
+static const struct ltc2632_chip_info ltc2632l10_chip_info = {
+	.channels	= ltc2632x10_channels,
+	.num_channels	= 2,
+	.vref_mv	= 2500,
+};
+
+static const struct ltc2632_chip_info ltc2632l8_chip_info = {
+	.channels	= ltc2632x8_channels,
+	.num_channels	= 2,
+	.vref_mv	= 2500,
+};
+
+static const struct ltc2632_chip_info ltc2632h12_chip_info = {
+	.channels	= ltc2632x12_channels,
+	.num_channels	= 2,
+	.vref_mv	= 4096,
+};
+
+static const struct ltc2632_chip_info ltc2632h10_chip_info = {
+	.channels	= ltc2632x10_channels,
+	.num_channels	= 2,
+	.vref_mv	= 4096,
+};
+
+static const struct ltc2632_chip_info ltc2632h8_chip_info = {
+	.channels	= ltc2632x8_channels,
+	.num_channels	= 2,
+	.vref_mv	= 4096,
+};
+
+static const struct ltc2632_chip_info ltc2634l12_chip_info = {
+	.channels	= ltc2632x12_channels,
+	.num_channels	= 4,
+	.vref_mv	= 2500,
+};
+
+static const struct ltc2632_chip_info ltc2634l10_chip_info = {
+	.channels	= ltc2632x10_channels,
+	.num_channels	= 4,
+	.vref_mv	= 2500,
+};
+
+static const struct ltc2632_chip_info ltc2634l8_chip_info = {
+	.channels	= ltc2632x8_channels,
+	.num_channels	= 4,
+	.vref_mv	= 2500,
+};
+
+static const struct ltc2632_chip_info ltc2634h12_chip_info = {
+	.channels	= ltc2632x12_channels,
+	.num_channels	= 4,
+	.vref_mv	= 4096,
+};
+
+static const struct ltc2632_chip_info ltc2634h10_chip_info = {
+	.channels	= ltc2632x10_channels,
+	.num_channels	= 4,
+	.vref_mv	= 4096,
+};
+
+static const struct ltc2632_chip_info ltc2634h8_chip_info = {
+	.channels	= ltc2632x8_channels,
+	.num_channels	= 4,
+	.vref_mv	= 4096,
+};
+
+static const struct ltc2632_chip_info ltc2636l12_chip_info = {
+	.channels	= ltc2632x12_channels,
+	.num_channels	= 8,
+	.vref_mv	= 2500,
+};
+
+static const struct ltc2632_chip_info ltc2636l10_chip_info = {
+	.channels	= ltc2632x10_channels,
+	.num_channels	= 8,
+	.vref_mv	= 2500,
+};
+
+static const struct ltc2632_chip_info ltc2636l8_chip_info = {
+	.channels	= ltc2632x8_channels,
+	.num_channels	= 8,
+	.vref_mv	= 2500,
+};
+
+static const struct ltc2632_chip_info ltc2636h12_chip_info = {
+	.channels	= ltc2632x12_channels,
+	.num_channels	= 8,
+	.vref_mv	= 4096,
+};
+
+static const struct ltc2632_chip_info ltc2636h10_chip_info = {
+	.channels	= ltc2632x10_channels,
+	.num_channels	= 8,
+	.vref_mv	= 4096,
+};
+
+static const struct ltc2632_chip_info ltc2636h8_chip_info = {
+	.channels	= ltc2632x8_channels,
+	.num_channels	= 8,
+	.vref_mv	= 4096,
 };
 
 static int ltc2632_probe(struct spi_device *spi)
@@ -354,84 +348,47 @@ static int ltc2632_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ltc2632_id[] = {
-	{ "ltc2632-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632L12] },
-	{ "ltc2632-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632L10] },
-	{ "ltc2632-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632L8] },
-	{ "ltc2632-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H12] },
-	{ "ltc2632-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H10] },
-	{ "ltc2632-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H8] },
-	{ "ltc2634-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L12] },
-	{ "ltc2634-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L10] },
-	{ "ltc2634-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L8] },
-	{ "ltc2634-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H12] },
-	{ "ltc2634-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H10] },
-	{ "ltc2634-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H8] },
-	{ "ltc2636-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L12] },
-	{ "ltc2636-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L10] },
-	{ "ltc2636-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L8] },
-	{ "ltc2636-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H12] },
-	{ "ltc2636-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H10] },
-	{ "ltc2636-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H8] },
+	{ "ltc2632-l12", (kernel_ulong_t)&ltc2632l12_chip_info },
+	{ "ltc2632-l10", (kernel_ulong_t)&ltc2632l10_chip_info },
+	{ "ltc2632-l8",  (kernel_ulong_t)&ltc2632l8_chip_info  },
+	{ "ltc2632-h12", (kernel_ulong_t)&ltc2632h12_chip_info },
+	{ "ltc2632-h10", (kernel_ulong_t)&ltc2632h10_chip_info },
+	{ "ltc2632-h8",  (kernel_ulong_t)&ltc2632h8_chip_info  },
+	{ "ltc2634-l12", (kernel_ulong_t)&ltc2634l12_chip_info },
+	{ "ltc2634-l10", (kernel_ulong_t)&ltc2634l10_chip_info },
+	{ "ltc2634-l8",  (kernel_ulong_t)&ltc2634l8_chip_info  },
+	{ "ltc2634-h12", (kernel_ulong_t)&ltc2634h12_chip_info },
+	{ "ltc2634-h10", (kernel_ulong_t)&ltc2634h10_chip_info },
+	{ "ltc2634-h8",  (kernel_ulong_t)&ltc2634h8_chip_info  },
+	{ "ltc2636-l12", (kernel_ulong_t)&ltc2636l12_chip_info },
+	{ "ltc2636-l10", (kernel_ulong_t)&ltc2636l10_chip_info },
+	{ "ltc2636-l8",  (kernel_ulong_t)&ltc2636l8_chip_info  },
+	{ "ltc2636-h12", (kernel_ulong_t)&ltc2636h12_chip_info },
+	{ "ltc2636-h10", (kernel_ulong_t)&ltc2636h10_chip_info },
+	{ "ltc2636-h8",  (kernel_ulong_t)&ltc2636h8_chip_info  },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ltc2632_id);
 
 static const struct of_device_id ltc2632_of_match[] = {
-	{
-		.compatible = "lltc,ltc2632-l12",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2632L12]
-	}, {
-		.compatible = "lltc,ltc2632-l10",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2632L10]
-	}, {
-		.compatible = "lltc,ltc2632-l8",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2632L8]
-	}, {
-		.compatible = "lltc,ltc2632-h12",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2632H12]
-	}, {
-		.compatible = "lltc,ltc2632-h10",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2632H10]
-	}, {
-		.compatible = "lltc,ltc2632-h8",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2632H8]
-	}, {
-		.compatible = "lltc,ltc2634-l12",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2634L12]
-	}, {
-		.compatible = "lltc,ltc2634-l10",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2634L10]
-	}, {
-		.compatible = "lltc,ltc2634-l8",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2634L8]
-	}, {
-		.compatible = "lltc,ltc2634-h12",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2634H12]
-	}, {
-		.compatible = "lltc,ltc2634-h10",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2634H10]
-	}, {
-		.compatible = "lltc,ltc2634-h8",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2634H8]
-	}, {
-		.compatible = "lltc,ltc2636-l12",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2636L12]
-	}, {
-		.compatible = "lltc,ltc2636-l10",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2636L10]
-	}, {
-		.compatible = "lltc,ltc2636-l8",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2636L8]
-	}, {
-		.compatible = "lltc,ltc2636-h12",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2636H12]
-	}, {
-		.compatible = "lltc,ltc2636-h10",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2636H10]
-	}, {
-		.compatible = "lltc,ltc2636-h8",
-		.data = &ltc2632_chip_info_tbl[ID_LTC2636H8]
-	},
+	{ .compatible = "lltc,ltc2632-l12", .data = &ltc2632l12_chip_info },
+	{ .compatible = "lltc,ltc2632-l10", .data = &ltc2632l10_chip_info },
+	{ .compatible = "lltc,ltc2632-l8",  .data = &ltc2632l8_chip_info  },
+	{ .compatible = "lltc,ltc2632-h12", .data = &ltc2632h12_chip_info },
+	{ .compatible = "lltc,ltc2632-h10", .data = &ltc2632h10_chip_info },
+	{ .compatible = "lltc,ltc2632-h8",  .data = &ltc2632h8_chip_info  },
+	{ .compatible = "lltc,ltc2634-l12", .data = &ltc2634l12_chip_info },
+	{ .compatible = "lltc,ltc2634-l10", .data = &ltc2634l10_chip_info },
+	{ .compatible = "lltc,ltc2634-l8",  .data = &ltc2634l8_chip_info  },
+	{ .compatible = "lltc,ltc2634-h12", .data = &ltc2634h12_chip_info },
+	{ .compatible = "lltc,ltc2634-h10", .data = &ltc2634h10_chip_info },
+	{ .compatible = "lltc,ltc2634-h8",  .data = &ltc2634h8_chip_info  },
+	{ .compatible = "lltc,ltc2636-l12", .data = &ltc2636l12_chip_info },
+	{ .compatible = "lltc,ltc2636-l10", .data = &ltc2636l10_chip_info },
+	{ .compatible = "lltc,ltc2636-l8",  .data = &ltc2636l8_chip_info  },
+	{ .compatible = "lltc,ltc2636-h12", .data = &ltc2636h12_chip_info },
+	{ .compatible = "lltc,ltc2636-h10", .data = &ltc2636h10_chip_info },
+	{ .compatible = "lltc,ltc2636-h8",  .data = &ltc2636h8_chip_info  },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2632_of_match);
-- 
2.50.1

