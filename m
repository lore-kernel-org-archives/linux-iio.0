Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06CF34402B;
	Tue,  4 Aug 2026 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843262; cv=none; b=XB7C0Th8bWefKzs5zsWL9v1KOefqTx8S6OJc1Xtq04sD2FmkqTvjQ4MDdmvFkxOtNKN/7Z9/xM7NRoQuoXKVALB1bnhkdXBBVYNV2ILYgUCfMd2O7cVkNxAldeDfRZK3PktQj4OMaT+xXyctAdkzHLMdPWMyi75iutSibP6um+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843262; c=relaxed/simple;
	bh=IZcSCPqZO3l5d2iyZ0Qc0KOp1vdICk1AW9fpfanl+M8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3YJWKW1oxBFo05y/4GRsF3OP+nCpgHA1NmliLruZB62dFAm69Tm+32hi8mRfy+RcZn3j2vYfspHmVw4dwgo14AWUj/XN3GUGmHjmiKZo2Rj9B+LfI8jX7QpcZlrtUFJIXxlmG+ndY/7l/eZWbhErnevWNuJNWrb8ZvYBIfmi3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=a7BgYKqy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="a7BgYKqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785843261; x=1817379261;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=IZcSCPqZO3l5d2iyZ0Qc0KOp1vdICk1AW9fpfanl+M8=;
  b=a7BgYKqyuW/Yvg8gMFvvVv6fRa5zZxjxIMTvkAbWS/P/dOfeJ5FWQ50N
   1bW0digKzu/AY21g+CcEm9+bgq2eVbtPu4kSTci4yeA/WxWbghbdZ7TR1
   7lzjLToIRd1xKfEvzrSO+OeoSH0ZJzmKBXYgdxsfKhy0Kg2M24lf9/L51
   R6MFRiH155fh/miY0PBbXGhL2L5T0u1Vu5slohNR2hfaKPAH4NhDFCpDi
   IkyY6tCwv/LBUkFFtKOpWz0AejwG6nIJySLkJ8edAjxIKkvre/CwVajse
   FNZ4qZL8EaLQACvh8rB/c5LiPLWm3v5FpoE/+DFuWMLdJ3pQRYZPCpizJ
   A==;
X-CSE-ConnectionGUID: 4yFAMHBdQxOTpCoL0PKOLA==
X-CSE-MsgGUID: 9bo6NXMARqaViXPRtBB6Qg==
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="61629495"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2026 04:34:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 4 Aug 2026 04:34:13 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Aug 2026 04:34:03 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
	<joshua.crofts1@gmail.com>, <jorge.marques@analog.com>,
	<Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
	<antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
	<mazziesaccount@gmail.com>, <varshini.rajendran@microchip.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 02/17] nvmem: add DEFINE_FREE for nvmem_cell_put cleanup
Date: Tue, 4 Aug 2026 17:03:23 +0530
Message-ID: <20260804113338.261782-3-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804113338.261782-1-varshini.rajendran@microchip.com>
References: <20260804113338.261782-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add cleanup.h helper for nvmem_cell_put() to enable automatic resource
cleanup using __free(nvmem_cell_put) annotation.

Use IS_ERR_OR_NULL() since nvmem_cell_get() can return error pointers,
and passing an ERR_PTR to nvmem_cell_put() would cause issues.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 include/linux/nvmem-consumer.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 34c0e58dfa26..35a2ea8b8957 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_NVMEM_CONSUMER_H
 #define _LINUX_NVMEM_CONSUMER_H
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/notifier.h>
@@ -54,6 +55,9 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id);
 struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *id);
 void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
+
+DEFINE_FREE(nvmem_cell_put, struct nvmem_cell *, if (!IS_ERR_OR_NULL(_T)) nvmem_cell_put(_T))
+
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
 int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
 int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);
-- 
2.34.1

