Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8093DB629;
	Tue, 14 Apr 2026 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170096; cv=none; b=HHr8POL2/v6kRtn6oEkaGFX9gCKJMKyOEA+4GJykLMKX3TlxWfFiBExTBmbxTTwoJY+1mrK1q7KFTedJ8QXhk0dv/t7BRvMVfGrSYCU6PW1uOG7l5OhE6UCw8SKkEoRn8kGQXcJKespDxbh/ejTgBM5GvTTKVn8v9DCQlGqhQCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170096; c=relaxed/simple;
	bh=hvo7ItC28MeILTqF6coGY5d9telHrmFBV1tmVPibG/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=XB1po7AtXCRVmi03FO57DNoUNsaagcdppdSFpNdMNgPRYK364PETUPd3hcfO7C+0sPU0NxAzAsPD42I3tF1S9t9oZfGw24+r7Tjvx2ZuA8iP2pXFCEjdeU86mPm4isp1m/7WEnw3E7rAZdzSsIBjAaXDGv6cR6DfbInq0kLFpUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sN6p/Ak5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sN6p/Ak5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1776170095; x=1807706095;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=hvo7ItC28MeILTqF6coGY5d9telHrmFBV1tmVPibG/A=;
  b=sN6p/Ak54y0kfWLMLxo+HqX1rzAhl9RsMzsM/meBfZHNDCY0L0qQC6M/
   fe3OEvt5eP9cipIjmE/TCxNQyJHdgGFmSFIa/gd+PVaiTxYyZsXX2eJZP
   I4uWg2r+nJsOSxPfRDqRima3VWkqQkCEuQWW1PW6qhDuMKQkXJUSfeoNu
   qJrrISxzQOgcDwpyZB1QZL4WXgrirQoaBMXNju6CbR0U+SeOJYlK7Qszx
   ViOgM388r2Mq8F5tMFgqcahYBdkLEEPYW+BDnROiKwIV45a1QLe0VQmj4
   jElmTpypCDtmygp0t04DW1KeBLS1dVT4qAapCqwOibUZkFXi5t6E6K2mj
   A==;
X-CSE-ConnectionGUID: DylnJ+N7ToGEsZXGMLtw5g==
X-CSE-MsgGUID: QaIytJgAQqinCjZw4Gus8g==
X-IronPort-AV: E=Sophos;i="6.23,179,1770620400"; 
   d="scan'208";a="55320339"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:34:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 14 Apr 2026 05:34:22 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 14 Apr 2026 05:34:20 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Tue, 14 Apr 2026 15:33:38 +0300
Subject: [PATCH] iio: dac: Fix passing uninitialized vref1_uV for no Vref1
 case
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com>
X-B4-Tracking: v=1; b=H4sIACE03mkC/x2MQQqAIBAAvyJ7TtBtKeor0aFsrT1kohBB+Pek4
 wzMvJA5CWcY1QuJb8lyhQq2UeCOJeysZasMaLAzZEmfLlLveTWovTykO0sbD21LHhFqFRNX/x+
 nuZQPNU/sW2EAAAA=
X-Change-ID: 20260414-mcp47feb02-fix4-614de9334f22
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<error27@gmail.com>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776170061; l=1829;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=hvo7ItC28MeILTqF6coGY5d9telHrmFBV1tmVPibG/A=;
 b=ZW8v1GPofVaXThohySLEck03jrcyU1U+FNwkJero+4Nb+Cna3XKhTxP2/tgzRpVIsn/ZB7QWG
 Xdp64adTCWLAPHd3FYbHCbqeBnpVN1rAwsELi705Q+YfvRow40w1/as
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Initialize vref1_uV variable to 0 before calling
mcp47feb02_init_ch_scales() in mcp47feb02_probe() to avoid passing an
uninitialized value when have_ext_vref1 is false.

Fixes: dd154646d292 ("iio: dac: mcp47feb02: Fix Vref validation [1-999] case")
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/all/adiPnla0M5EzvgD-@stanley.mountain/
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index faccb804a5ed548088aaf83266b16ed45a92916c..efd4847913e46a4fa1b671aa9c5bd3e1430406b7 100644
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
@@ -1146,13 +1147,13 @@ static int mcp47feb02_probe(struct i2c_client *client)
 		dev_dbg(dev, "Vref is unavailable.\n");
 	}
 
+	vref1_uV = 0;
 	if (chip_features->have_ext_vref1) {
 		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
 		if (ret > 0) {
 			vref1_uV = ret;
 			data->use_vref1 = true;
 		} else {
-			vref1_uV = 0;
 			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
 			dev_dbg(dev, "Vref1 is unavailable.\n");
 		}

---
base-commit: 51e7665ab81f02adc80a1219c260ee678e9c6eb8
change-id: 20260414-mcp47feb02-fix4-614de9334f22

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

