Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288541DE18;
	Thu,  6 Aug 2026 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006026; cv=none; b=tRKQ9taP6Nxm6jkFvmToiwBg+rnurlaZFP8X5HPpAfhkfaKgZcHH08zCiMUWNmmRV/vlJZkp27b2Evv4wz9ZuYKNipCCBAkt1TOcl/VgtTcbsZ/NHS+NswFTwSYNi4886AOoUovVbybK3CM76xCfwwQIBFCLhjg7DiYJ7Og8Pjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006026; c=relaxed/simple;
	bh=MgNz0ew/hB8/oQgEHR3uHQozOSw31+4UIzG+VwzCIq8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRAoemZSUU506H3IHWSZubNxEMRmjPGGxbiIjG0VLXVa4fxjTpObHTO1JR3sFmdFxqWpE9AHYaZ3ZB20CX9z94OkCFwHhQvp/cgs7t02IIJGCS6Ptg9vdilKitavtCqHVuoOxd3gAD5OYxfYb01saoJ1rc4hvfnuFCemcjcsq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Fpz1tCiN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Fpz1tCiN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786006024; x=1817542024;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=MgNz0ew/hB8/oQgEHR3uHQozOSw31+4UIzG+VwzCIq8=;
  b=Fpz1tCiNhGQmgP56aIdUMZSi49QCOOhYrIGe8pB2mmFzJwuF5gRlKsEY
   /PAaPabYIg8bCs3wJY8nIabK8o+0udM1aYsBRLWWrQWl53o80LwRpr7ct
   jrGJ51CsIuG5RpEgT6Clt3GmoCBZA8+G3IoScLfMHQKJ37MdnYf+M3Oa0
   Krl6Z9SYIZHRZm4mtKRSYdLq81JjD8OeZlGkGFZxTOToNDtS7/vFs4afl
   UE26HPVnvRH928a/NuwvFTzUOC/by2iT7wnOJ38cBfzqcMHLEGWGKC3nv
   WUlUGRPi3z+MQGWtLO6KMxhhFjpGEE8MMHQf7DMMyvej2RGKfJu9ukGca
   w==;
X-CSE-ConnectionGUID: feqVjCi7SHWDKao9a8++uQ==
X-CSE-MsgGUID: YKrLMB+nSSiAs893eQV/cQ==
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="228880353"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 01:47:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 6 Aug 2026 01:47:03 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 6 Aug 2026 01:46:54 -0700
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
Subject: [PATCH v6 02/17] nvmem: add DEFINE_FREE for nvmem_cell_put cleanup
Date: Thu, 6 Aug 2026 13:10:09 +0530
Message-ID: <20260806074024.531259-3-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806074024.531259-1-varshini.rajendran@microchip.com>
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
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
 include/linux/nvmem-consumer.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 34c0e58dfa26..5315bd862f5f 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_NVMEM_CONSUMER_H
 #define _LINUX_NVMEM_CONSUMER_H
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/notifier.h>
@@ -243,6 +244,8 @@ static inline struct nvmem_device *nvmem_device_find(void *data,
 
 #endif /* CONFIG_NVMEM */
 
+DEFINE_FREE(nvmem_cell_put, struct nvmem_cell *, if (!IS_ERR_OR_NULL(_T)) nvmem_cell_put(_T))
+
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
 struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 				     const char *id);
-- 
2.34.1

