Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E012EDD6B;
	Thu,  4 Jun 2026 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580840; cv=none; b=lONQCM9G3+THZ1sD0K87PEyr+w0KX+dEok8X1WaRp8xkXa9jaq7SeejiGlmKRFUGyeMqCWfgNybGQNRm36VYxRONaARQ2eoEKytYwVkZdB5oGz4kMcoOVz2HuMNQoVVWy/rirnl9haj40ijUyULIydLQPo/GaJaGia1MBbNi54M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580840; c=relaxed/simple;
	bh=fm1zKx2sgyH0z3XD3VaPNenRRf6ELcJG9zeBHwt0Akc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=lgvgH+d8WxIf0oDLqdIvolCWogRIWJI40cP4h6aKQ+YaynpQ3K/Z+etmFA5JgenUhWA08Ra231Sa/IwaNQwk/fPCpYIJFy8yZhXU/OWjPcza9cjZdnx5o4ylAl7XmiQbao68QjfxGBDiVQkxiEMafiNaiQuwNgSVNpymSsj5EPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SqrHJcC8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SqrHJcC8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1780580838; x=1812116838;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=fm1zKx2sgyH0z3XD3VaPNenRRf6ELcJG9zeBHwt0Akc=;
  b=SqrHJcC8RE1wiXvlGG2L52fWZGSyyDSA8Ns7PQ7Tsiu7s6oj6Jz/MAAo
   p9m4YNs0qwvZOyWlC3DsA/wHUnEPXb1a5bOFSgNOV6hGLoQjb7dXa8u2+
   Ixw07lEo6/kRBxdKFl15t4VtwYLkE4Zci0PUjGHgRizIKHXEqZtV9o76d
   TKr4kxrBcic3UsWqgwcSEm/gUtfYg8+QcKUylHTbdN743ogBNtLx+f/Vx
   rkkTpBQGoVMSG7ksVDnISmmVgVWjU7QH1WS0iO9zQYEAraKC8szQ1vm5a
   xiczOpNfnZ9I+bitWp9MrqeGK20XJgl4GXDC+Bn7mSCSGNVLiprStgQtz
   Q==;
X-CSE-ConnectionGUID: sK1BPBeMSXCXLiRMD5VfQA==
X-CSE-MsgGUID: ergGQ2ilRy6gur7SwrGAfg==
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="57778559"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jun 2026 06:47:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 4 Jun 2026 06:47:11 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 4 Jun 2026 06:47:09 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Thu, 4 Jun 2026 16:46:47 +0300
Subject: [PATCH v4] iio: dac: mcp47feb02: Fix passing uninitialized
 vref1_uV for no Vref1 case
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260604-mcp47feb02-fix4-v4-1-cd6ce03749a4@microchip.com>
X-B4-Tracking: v=1; b=H4sIAMaBIWoC/3XNTQ7CIBCG4as0rMXAAKV15T2MCwqDZdGfgGk0T
 e8u7UZjdfl+yTwzk4QxYCKnYiYRp5DC0OeQh4LY1vQ3pMHlJsCgZJJL2tlRao8NA+rDQ9KSS4e
 1ENIDkHw1Rsz7Jl6uuduQ7kN8bg8mvq7/rYlTTmuneWOcd6Dw3AUbB9uG8WiHjqzeBB8GsL0B2
 agarSo0pmqs/2WIt1EysTdENtCxutbKGsfVt7EsywuHORxOOgEAAA==
X-Change-ID: 20260414-mcp47feb02-fix4-614de9334f22
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<error27@gmail.com>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780580829; l=3363;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=fm1zKx2sgyH0z3XD3VaPNenRRf6ELcJG9zeBHwt0Akc=;
 b=Jtxpux9sNevT9nGMHz1TUWJrXJnIG0LjhvSgPj2akBhlx9UJR/aoiyy2BKxZW8Kn0a1vywfFC
 a/8hbsy+tioDUqF/D3yHpeNdTDvW/bLJGtxILrdx5+DEfzKdgBSwA97
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Ensure that if a device has Vref1 but reading the regulator returns an
error, mcp47feb02_init_ctrl_regs() is not called with an uninitialized
vref1_uV value. Also add a device_property_present() check for the Vref1
supply before reading the regulator.

Fixes: dd154646d292 ("iio: dac: mcp47feb02: Fix Vref validation [1-999] case")
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/all/adiPnla0M5EzvgD-@stanley.mountain/

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Changes in v4:
- Remove handle ref mismatch fixes from this patch series to be submitted
   separately.
- Return err if an external voltage reference is selected, but is 0uV
- Link to v3: https://lore.kernel.org/r/20260603-mcp47feb02-fix4-v3-1-ed09975cad15@microchip.com

Changes in v3:
- Handle mismatch between vref modes at power up and enable regulator
   only after the user corrects it.
- Link to v2: https://lore.kernel.org/r/20260420-mcp47feb02-fix4-v2-1-8b758eaa8bcf@microchip.com

Changes in v2:
- return the reading regulator error to not use vref1_uV uninitialized in
   mcp47feb02_init_ctrl_regs() call 
- add device_property_present() check for the Vref1
- Link to v1: https://lore.kernel.org/r/20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com
---
 drivers/iio/dac/mcp47feb02.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index faccb804a5ed548088aaf83266b16ed45a92916c..5f84b46ec6f3d2f59ea815444a94444dfec00e91 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -1136,26 +1136,33 @@ static int mcp47feb02_probe(struct i2c_client *client)
 
 	vdd_uV = ret;
 
-	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
-	if (ret > 0) {
-		vref_uV = ret;
+	if (device_property_present(dev, "vref-supply")) {
+		vref_uV = devm_regulator_get_enable_read_voltage(dev, "vref");
+		if (vref_uV < 0)
+			return vref_uV;
+
+		if (vref_uV == 0)
+			return dev_err_probe(dev, -EINVAL, "Vref is 0 uV.\n");
+
 		data->use_vref = true;
 	} else {
 		vref_uV = 0;
-		dev_dbg(dev, "using internal band gap as voltage reference.\n");
-		dev_dbg(dev, "Vref is unavailable.\n");
+		dev_dbg(dev, "Using internal band gap as voltage reference.\n");
 	}
 
-	if (chip_features->have_ext_vref1) {
-		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
-		if (ret > 0) {
-			vref1_uV = ret;
-			data->use_vref1 = true;
-		} else {
-			vref1_uV = 0;
-			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
-			dev_dbg(dev, "Vref1 is unavailable.\n");
-		}
+	if (chip_features->have_ext_vref1 &&
+	    device_property_present(dev, "vref1-supply")) {
+		vref1_uV = devm_regulator_get_enable_read_voltage(dev, "vref1");
+		if (vref1_uV < 0)
+			return vref1_uV;
+
+		if (vref1_uV == 0)
+			return dev_err_probe(dev, -EINVAL, "Vref1 is 0 uV.\n");
+
+		data->use_vref1 = true;
+	} else {
+		vref1_uV = 0;
+		dev_dbg(dev, "Using internal band gap as voltage reference 1.\n");
 	}
 
 	ret = mcp47feb02_init_ctrl_regs(data);

---
base-commit: 51e7665ab81f02adc80a1219c260ee678e9c6eb8
change-id: 20260414-mcp47feb02-fix4-614de9334f22

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

