Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EDA385536;
	Mon, 20 Apr 2026 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672281; cv=none; b=i54ZaxbjWPTFgaKWduzbiUANoNq4IYpdfd3bqGhvGQ7Gb1cPDCvbKXiWkJxjn3goo58qMdnkYPE+9aqPAGWoe1L8//iJvzXr6SHPuB0jlDL6JspSKpiRau7DIAgF0ACluFi8rZtUeOR97kXc7+2g7qy41q/gW46i3k+w0VPa9FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672281; c=relaxed/simple;
	bh=pTa8pq24A5FijSPJIQX3I3UFOHq3WQ2bKXjFwa3xFWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=hjHVYK9nnIQJwqUefI0NsDp6j9TDuy8ybuPpnOSBwkaYrt0Wr/osMIz8f9yPTOQfSaQotqUVYzxODe62V+LvPXAKAJYeNodQHVgEyi7ciAGUkOpEj8jRn7Bv7Giw8NB3tL/UMdZAKgjwJTWOYMAm9KcubSfW55WwW8XMhjvDrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wAJgtUBD; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wAJgtUBD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1776672280; x=1808208280;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=pTa8pq24A5FijSPJIQX3I3UFOHq3WQ2bKXjFwa3xFWM=;
  b=wAJgtUBDNtfvg+S10La4xXepBMV12/k0cHItMFTh9GFsDTSPAvM1CcL8
   Rxae7s74a/OpQ1/y8beeDNU3bknVe11EdikE0ptfjXs10yJSdqjH0Hc9h
   f0kmzBkBEGfrF5fapsFKRGJ7F+kAHep2xhW44+wvCnO43HI10xMBDMxhU
   IHOpW0SyPDTTOPGfausEN1OEKnM076H6dNfWovgXcMrcfskZ/CojIIxjQ
   y0kk6nr/b//qNvjc3hXISo6Gw0TYH0W+Xz/F0k1uUCYR+Vtfy3EDnO+Ax
   MrmNSVtnjuBZGhbFZE1BWWkYbB7z3L9hrbtgW1OaVDo9ROyYCUckTumBW
   w==;
X-CSE-ConnectionGUID: h/A3Lf4mRPGPlmSnDFY3Jw==
X-CSE-MsgGUID: ZKTt1tviSFyj7nnIOuKE1A==
X-IronPort-AV: E=Sophos;i="6.23,189,1770620400"; 
   d="scan'208";a="64343728"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 01:04:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 20 Apr 2026 01:04:25 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 20 Apr 2026 01:04:23 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Mon, 20 Apr 2026 11:04:12 +0300
Subject: [PATCH v2] iio: dac: mcp47feb02: Fix passing uninitialized
 vref1_uV for no Vref1 case
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260420-mcp47feb02-fix4-v2-1-8b758eaa8bcf@microchip.com>
X-B4-Tracking: v=1; b=H4sIAPvd5WkC/3WNQQ6CMBBFr0JmbQ0zVAiuuIdhAe1UZgElrWk0p
 He3snf5XvLfPyByEI5wrw4InCSK3wrQpQKzTNuTldjCQDW1tUatVrPrzvFck3Ly1qpFbblvGu2
 IoKz2wMWfxcdYeJH48uFzHiT82f+thApVbzucJ+ss3XhYxQRvFtmvxq8w5py/6fbnF7IAAAA=
X-Change-ID: 20260414-mcp47feb02-fix4-614de9334f22
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<error27@gmail.com>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776672263; l=2520;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=pTa8pq24A5FijSPJIQX3I3UFOHq3WQ2bKXjFwa3xFWM=;
 b=ArUgK7nq65/jMRsLn/SSFvsPQg7/FLIk+dUTcntHXxTyPNKgSOl/rA8JAIj+BL7uU77HOZGmp
 4rVW8lj0AFTDsRtkyVvL+VRQY0TRKkHfTjOGhDxlc01OCFcWGt30X4h
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Ensure that if a device has Vref1 but reading the regulator returns an
error, mcp47feb02_init_ctrl_regs() is not called with an uninitialized
vref1_uV value.

Also add a device_property_present() check for the Vref1 supply before
reading the regulator.

Fixes: dd154646d292 ("iio: dac: mcp47feb02: Fix Vref validation [1-999] case")
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/all/adiPnla0M5EzvgD-@stanley.mountain/
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Changes in v2:
- return the reading regulator error to not use vref1_uV uninitialized in
   mcp47feb02_init_ctrl_regs() call 
- add device_property_present() check for the Vref1
- Link to v1: https://lore.kernel.org/r/20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com
---
 drivers/iio/dac/mcp47feb02.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index faccb804a5ed548088aaf83266b16ed45a92916c..a876ed71ecdf101784e0f98668a1681a1cd19ed0 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -1095,9 +1095,10 @@ static int mcp47feb02_probe(struct i2c_client *client)
 {
 	const struct mcp47feb02_features *chip_features;
 	struct device *dev = &client->dev;
+	int vdd_uV, vref_uV, vref1_uV;
 	struct mcp47feb02_data *data;
 	struct iio_dev *indio_dev;
-	int vref1_uV, vref_uV, vdd_uV, ret;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -1146,16 +1147,16 @@ static int mcp47feb02_probe(struct i2c_client *client)
 		dev_dbg(dev, "Vref is unavailable.\n");
 	}
 
-	if (chip_features->have_ext_vref1) {
+	if (chip_features->have_ext_vref1 && device_property_present(dev, "vref1")) {
 		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
-		if (ret > 0) {
-			vref1_uV = ret;
-			data->use_vref1 = true;
-		} else {
-			vref1_uV = 0;
-			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
-			dev_dbg(dev, "Vref1 is unavailable.\n");
-		}
+		if (ret < 0)
+			return ret;
+
+		vref1_uV = ret;
+		data->use_vref1 = true;
+	} else {
+		vref1_uV = 0;
+		dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
 	}
 
 	ret = mcp47feb02_init_ctrl_regs(data);

---
base-commit: 51e7665ab81f02adc80a1219c260ee678e9c6eb8
change-id: 20260414-mcp47feb02-fix4-614de9334f22

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

