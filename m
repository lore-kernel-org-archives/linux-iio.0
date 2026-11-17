Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926630;
	b=kghc06zNdjHHe7hnSUl4cKmHyo5lufYl6jtdmUiwbGNfUImVs6Qevfu7ZHdBYgaEcRyD
	 i0QKppEFF79llCVk6p0CWVoqSLyFPjESwTRZhltp/nYaAc2J1qt8L3pPwtE3b3vE7yXH5
	 ZcJ0nXmxSGDGjOuxFvwxWj40/T+kgSkCjo2c7wXVe4MlMo4NnWqKkOVfJQ5LshBEPuqHk
	 zbnVsjAkB/xkHCLFy5HZNmqwUD3/BQZvMKuYbHJxULHFBjn7IJ9s/bLpk1CCxu9zFVIyh
	 LfPIFUmAmLd+UHFFd3cXg3hEFlYG/77FAihq03FEeeTNkMMbFxJywW7zOcRTmnTcZSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926630;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3Or6fa8doLohGi4P+eViupZADBB8Qyy/B0l59oPQqUg=;
	b=zJxUWCMcWBHmerKsE2xVptxWSn5d1quQ3yxntrO4ea4wWiVbijwM7SuRI62FVyGAS8uI
	 gFEwJU0m73c6ewdTFJHOKTn8BhH8h3xtp6ZPcoR/11Qp7lcOdn6l2jD/k1ZD9xVQxw9q3
	 /ybBPqxthGGIXKF/u3D4mvARHsG6z5jOSsByi4uc0fwMJjIHcz3BtyBTvo4SIQ6cWCOh5
	 eYIoaUoLehEFIBpGxL8D64tDgsrGc+Q6i3F0xfFStRgKFNVn3ajr6B52tQOd+ed6O/WKA
	 wqqESz0Lhb1AXcx5Ki/YXWybMZymLDCD8+joIkWLhW2moZN//69D47RmgJZducYMJlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lj+Zs1EX;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A90606A31C
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 14:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13A90606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lj+Zs1EX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794926630; x=1826462630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M+H8ERUL1Nk2WOKNkLytQsl83M5+JPphdYDa1VngzLk=;
  b=lj+Zs1EXKMle0lvYRagKSKZrWnNJbhPHzWMs7xh93mcopTVbJdtrrkSx
   doV3q3qUygDjj591nG9M9+DTPmc9nkoIiQlHav+IZruXlrQRcM4VlX4Oq
   +l0Xu23DmGduqk5OsRxFpuDu5+X912TqP18/n0Pi6nGaaXXqUX95xTkfT
   qwBAgUecC9SEFtS4v64OZ75PIr48DmJzNfS8zx+Jpo8Ltj6BM2axeyRIN
   1LzwcKBSRaJa+sczTbthQTKyUIwfetclRcLOm43jWqmMY0FBjipaTvb3W
   9iT5FSEdyuLxIzb7FxAFwztbQS1qohFM75Xd5X0hT+SXDy7JneqeM1es3
   g==;
X-CSE-ConnectionGUID: v9T28GOqQ4C5n+ZoGIeXxA==
X-CSE-MsgGUID: TQsJK6UEQOasVPGYr15Awg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3702408"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3702408"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:36:00 -0800
X-CSE-ConnectionGUID: OOfKjRQISRy/i9sCGUYiXg==
X-CSE-MsgGUID: LDUlfbjmQ2SnG8WKnFSJIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9852290"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 17 Nov 2026 06:35:59 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7635399; Tue, 17 Nov 2026 15:35:57 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: proximity: sx9324: Convert GENMASK() to use static parameters
Date: Tue, 17 Nov 2026 15:35:56 +0100
Message-ID: <20261117143556.1759717-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to use run-time calculated masks in the code. Besides,
GENMASK() over non-static parameters might lead compiler to generate
much worse code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/proximity/sx9324.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 1c8ba28c030a..d3f56ec57531 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -72,8 +72,7 @@
 #define SX9324_REG_AFE_CTRL6		0x26
 #define SX9324_REG_AFE_CTRL7		0x27
 #define SX9324_REG_AFE_PH0		0x28
-#define SX9324_REG_AFE_PH0_PIN_MASK(_pin) \
-	GENMASK(2 * (_pin) + 1, 2 * (_pin))
+#define SX9324_REG_AFE_PH0_PIN_MASK	GENMASK(1, 0)
 
 #define SX9324_REG_AFE_PH1		0x29
 #define SX9324_REG_AFE_PH2		0x2a
@@ -187,7 +186,7 @@ static ssize_t sx9324_phase_configuration_show(struct iio_dev *indio_dev,
 		return ret;
 
 	for (i = 0; i < SX9324_NUM_PINS; i++) {
-		pin_idx = (val & SX9324_REG_AFE_PH0_PIN_MASK(i)) >> (2 * i);
+		pin_idx = (val >> (2 * i)) & SX9324_REG_AFE_PH0_PIN_MASK;
 		len += sysfs_emit_at(buf, len, "%s,",
 				     sx9324_cs_pin_usage[pin_idx]);
 	}
@@ -877,8 +876,7 @@ static u8 sx9324_parse_phase_prop(struct device *dev,
 		return reg_def->def;
 
 	for (pin = 0; pin < SX9324_NUM_PINS; pin++)
-		raw |= (pin_defs[pin] << (2 * pin)) &
-		       SX9324_REG_AFE_PH0_PIN_MASK(pin);
+		raw |= (pin_defs[pin] & SX9324_REG_AFE_PH0_PIN_MASK) << (2 * pin);
 
 	return raw;
 }
-- 
2.50.1

