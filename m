Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3937AA98;
	Mon, 27 Apr 2026 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320871; cv=none; b=ec/VIkKKXWNq8vbm1eZunQ1JIk7v9c/KExyYinWwqxwyBci9YpDyyupzXBtHj8uO719kjnPbQ5zgxszobVA8GcP9r9GicvMpuKBo2T0g5OvP895moj5vA1DxKpowVhYKUuJMqyeibfrn3Rp24rEVQqefOZJcnlA8lZLcjLgCzsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320871; c=relaxed/simple;
	bh=vm9VO9p5mzpqWI5oVoVUa2H4DddECknhlZG4n1fkysc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWZq/ZY9eigO/CearOttb8Tc9efSIdvkQFEm8jw+AttaGPfOw/G3KEfIkvmYIuJ2AnI6nAOAw5Dxy76SBHNT3neLS2Q6DEp272WasMVgTOwIANGSscGs2N04xuUkJBf5A35IoB5W9n3AJa/RS3rCsmJuczamEMXlVCwXQf3yrhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MN/tTBpM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MN/tTBpM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777320870; x=1808856870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vm9VO9p5mzpqWI5oVoVUa2H4DddECknhlZG4n1fkysc=;
  b=MN/tTBpMxuekgEjQjJ5yplaYgsD5r6pm2lBf08n2ciBkek66dovUR/y/
   YfYErJLLo+v5CE7a2g5R7taMHUhLVyfV3TWKlE+NcQ1SJ5/Tbph0/5utf
   MxAsoPZvkbQf1YXy9f6xRAitr1aYK7vPUJu24U1RUL3+qh9/JQBDNBGdK
   JsdB/QimCrXJRe9U15n6SkgSpC/JuU9iUf3VuLFjeZBcTwjJdzVqPQcWH
   vNl4jyEJi1nnvib3mVDtVVgBGhlVP2yn/RYkG7LkXnAcfzSMEDGK2mZ9+
   151h/MqwgaEcPvggRLdOiWolo8yWG3oxfpDOFOC1SJAbi6NmZ0OzLUP8s
   A==;
X-CSE-ConnectionGUID: yIh/CpaDRZ6N5zZ5vmIDBg==
X-CSE-MsgGUID: R3jIqwNNQ6ODGeWcbSWy1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77384114"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77384114"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:14:23 -0700
X-CSE-ConnectionGUID: CguXh7KsS8upwVOHx/Bj4Q==
X-CSE-MsgGUID: dIpMIIoNRhe5W7zB/hEPvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232857730"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 27 Apr 2026 13:14:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 69E73A4; Mon, 27 Apr 2026 22:14:17 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v0 08/14] iio: magnetometer: ak8975: Reduce usage of magic lengths of the buffer
Date: Mon, 27 Apr 2026 22:09:53 +0200
Message-ID: <20260427201412.3067235-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce usage of magic lengths of the supplied buffer by replacing them
with the corresponding sizeof():s.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index dbaa64c66e4d..7ec1d4848fca 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -490,8 +490,10 @@ static int ak8975_who_i_am(struct i2c_client *client,
 	 * AK8975   |  DEVICE_ID |  NA
 	 * AK8963   |  DEVICE_ID |  NA
 	 */
-	ret = i2c_smbus_read_i2c_block_data_or_emulated(
-			client, AK09912_REG_WIA1, 2, wia_val);
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
+							AK09912_REG_WIA1,
+							sizeof(wia_val),
+							wia_val);
 	if (ret < 0) {
 		dev_err(&client->dev, "Error reading WIA\n");
 		return ret;
@@ -610,9 +612,10 @@ static int ak8975_setup(struct i2c_client *client)
 	}
 
 	/* Get asa data and store in the device data. */
-	ret = i2c_smbus_read_i2c_block_data_or_emulated(
-			client, data->def->ctrl_regs[ASA_BASE],
-			3, data->asa);
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
+							data->def->ctrl_regs[ASA_BASE],
+							sizeof(data->asa),
+							data->asa);
 	if (ret < 0) {
 		dev_err(&client->dev, "Not able to read asa data\n");
 		return ret;
@@ -853,7 +856,7 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 	 */
 	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
 							def->data_regs[0],
-							3 * sizeof(fval[0]),
+							sizeof(fval),
 							(u8 *)fval);
 	if (ret < 0)
 		goto unlock;
-- 
2.50.1

