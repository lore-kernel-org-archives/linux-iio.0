Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547925;
	b=yotFz4nEeEyvwE5vyhh+ZcFHylrVDo2BfhnAYYzPzdZSzeYyW0TrXgtr0Tbn8RDRASZQ
	 ycNJZbZcH51VTRfclVbgmMkkBIjdv7drIKnolJWgxr+Ndb3aVTy+fKPoWShzBRH4O5myd
	 fmsiUlY/goljw5kMv/ogHdsnl6IfwL6m887qpgI3Xyr+7Y11bpwn+i2tj6T7N81SqizVT
	 5pUJflI6u6b2QCDM1rE53mPlx85X6PDdM4ASjZyNnOjIHJ3Z0LHWaTVL4CWCjvOE6sVE0
	 ihRvueDwB96lS6jLKCg45rbxczXmB7sr267cWRKGCwpSmNpdkYGWxz6h1gaUEBiv39w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547925;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8dyNiXTPV0ZALPo5XR0+sPCC6RtKvK+KITrFQQTb35I=;
	b=0gvMAltkwfBsIHNBe1qKe1IdOjw7E/6yvZg7oc6uCEgjxt9hhEo1/Os2AQ613/OiJeo7
	 5Qhn+tlL2v+9jvBndfscv2S9bMaRf0XC/Q7wZH7smIjGuxqIqJcrO6D3kFNuupss0u7ZL
	 QqxX3VjdWWXQWD0RI/x7HPotk7JgAX0A/nTJOWVKvmLTFdmGwhBqcPLjla9JrBaWWBr+w
	 sUNS1JVZntLXnW7q+oB8c0LmXcUJOtteneFpu1kJ+CYZWQOs+9Jr3UpF6NbYk1MhQj3Qx
	 xXLR4oJLNyrASh8FgjXRYpna3YHsAOjP9A1a/3cmQ7dBU6MrzVlT5wifEJMiMRxu8Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=iilk55O7;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=wfL6oF+J;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD96606A322;
	Wed, 21 Oct 2026 01:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFD96606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=iilk55O7;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=wfL6oF+J
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L13mIp2442302;
	Tue, 20 Oct 2026 21:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=8dyNiXTPV0ZALPo5XR0+sPCC6RtKvK+KITrFQQTb35I=; b=iilk55O
	7AEDj0IoutMqLr8Vrn3NSr0MhEDqiitMVZlCJayE2Af7bgzWtK6PdwEnctKmjkYn
	EUZCMVqkzkGgLar63NsJPq8cvQsdGWQ87w57ZH/vZiZkFfH52zFTQz2AOfQAvViK
	LWwU3TCi9Z0HrDYhuH1R5SLGlwdMtds7sadTW03Va9TT/ufHGix//znf61vzRaFz
	VmP26HnQ7682kcwlOOzA1xJHhkgPlr8Fb/R+ShVYtxYL71YMTNuYhMOQVNrZUOWI
	XeOALCBGxmWozaDQRRACvGyfD23N849DTopbOzlCSOgs+Q6K5hgMX5Xr8sNUuCtc
	/KuJiRx+6w194gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8dyNi
	XTPV0ZALPo5XR0+sPCC6RtKvK+KITrFQQTb35I=; b=wfL6oF+J1bS8gJUJRqh1u
	RLOJCeekEnTFTprkqf2NEDK3DpRDzHxyrqKpXgTwkpGJ0+20dkjZcGhrZzmVl2xX
	mh+1m8UIaDdQ2NFhlomULH0LKetUJwITfwM7eyIYiKwllgOX+roizQh3e+QWMSAC
	9nfT7+qirutVz0YevARItTaavRdvClr7Z7di26bTBgBCXlb3mVndjztozhTpWXTQ
	SogR/lHsgyxXhkAOadaenhws07Kexw2/ggfhsKnz+2mbs+ehZAXxLAHZ7SGS7R75
	RRB4mf+N/kmjh5XqYeWmg2ptHfXae7viH3vKUAy/XzEPGSW8kafjX1bbZjW9ykkA
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hef2khjnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:58:40 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69L1wdq1007049
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Oct 2026 21:58:39 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 20 Oct
 2026 21:58:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 20 Oct 2026 21:58:39 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69L1wQZW029092;
	Tue, 20 Oct 2026 21:58:29 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 7/9] spi: add KUnit tests for the multi-CS framework
Date: Tue, 20 Oct 2026 22:58:21 -0300
Message-ID: <cb439b0d9a5b0daa5109929debfddee21b56778a.1792435248.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
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
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfXx/va/4oh2Uyh
 STjTKOMmmBD5QV5A9PREUgWb8Cjf0lbtXWmUjEk4L+cTh/d8g2sMa302PjMivY667nI0iQ3aYtJ
 0eqmvzXf8PiTrNf/Y1mqXNvIZRfkPi0STr0WNV7PVFLRWyDpRx70RIs5dqVpvVjoXPRILD2j03l
 tRsKcBJLffsN5ATjx/rLoTIQRFb4ngWSJ4vCKFLjbRxeLwI1ygGUTPHHukVs9ZxEd+VvIIqueGn
 gvCndGWZ6e9shVkaKYZeCc07O+koYTl4Kmot6tlsa9Uln110Etoi5kBpa5MMvxowPOILt8rEBpG
 FinxcJ7FcQGHaDmH+sMHgVVTh5S16BfJmRtL+0r0Qu0JnFC7H4ANaEdmDZ1oosNJ2J4PLwglYVr
 Yc8uDcf2c/oaxNpzb8uXHlGJ0s6aotJLwTFhqlJ+7vehxCNhPd2d2+4jYX7TsAJStZ6Ow7pSehx
 Dr+DEeecJaHMXahsVYw==
X-Proofpoint-GUID: ZitqpWxnSjB3YgxHK9tiyFth4vephnWR
X-Authority-Analysis: v=2.4 cv=KIHPn1Fo c=1 sm=1 tr=0 ts=6ad81c50 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=bhRbwl_YxwYJZz0IS0UA:9
X-Proofpoint-ORIG-GUID: ZitqpWxnSjB3YgxHK9tiyFth4vephnWR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfX0xAXqSrC8NL3
 AUAWW+reOZGU4jg/IK4ZU/C21ltGALTC37Aww6APLuMM2+hHAeuXhlioM4SRRH5Bw1BJdJviDoA
 xsExowmEpp3IkrMAPfdjjqItU4zyS8QPgCQP0os1tUKgIq0Uhuvf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210007

Add a KUnit suite for the multi-CS feature in the SPI core, covering:
the CS suffix of the device name, considering the contiguous values
restriction, the last-asserted CS tracking for single and multi-CS devices,
and CS array validation rules (overflow, out of range, duplicates,
non-contiguous and descending sequences) and filling of unused slots with
SPI_INVALID_CS, implemented by a test-local spi_validate_cs_config()
helper.

Move SPI_INVALID_CS to internals.h so the tests can use it. Mark
spi_dev_set_name() and spi_is_last_cs() as VISIBLE_IF_KUNIT and expose
them through internals.h.

Place the test in drivers/spi/tests/, next to the existing DMA KUnit
suite, and add CONFIG_SPI_MULTI_CS_KUNIT_TEST to the subsystem
.kunitconfig so it is exercised by default. Since tests/ now hosts more
than one suite, descend into it unconditionally and let tests/Makefile
gate each one on its own Kconfig symbol.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v4:
* New patch, as requested to cover the changes in the SPI CS management.
---
 drivers/spi/.kunitconfig               |   1 +
 drivers/spi/Kconfig                    |  11 +
 drivers/spi/Makefile                   |   2 +-
 drivers/spi/internals.h                |  16 ++
 drivers/spi/spi.c                      |  17 +-
 drivers/spi/tests/Makefile             |   3 +-
 drivers/spi/tests/spi-multi-cs-kunit.c | 374 +++++++++++++++++++++++++
 7 files changed, 409 insertions(+), 15 deletions(-)
 create mode 100644 drivers/spi/tests/spi-multi-cs-kunit.c

diff --git a/drivers/spi/.kunitconfig b/drivers/spi/.kunitconfig
index 07fa092c8fd0..eb4c6e693203 100644
--- a/drivers/spi/.kunitconfig
+++ b/drivers/spi/.kunitconfig
@@ -2,3 +2,4 @@ CONFIG_KUNIT=y
 CONFIG_SPI=y
 CONFIG_SPI_MASTER=y
 CONFIG_SPI_DMA_KUNIT_TEST=y
+CONFIG_SPI_MULTI_CS_KUNIT_TEST=y
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a0f37e2df716..7077f2e78c0f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1383,6 +1383,17 @@ config SPI_DMA_KUNIT_TEST
 
 	  If unsure say N.
 
+config SPI_MULTI_CS_KUNIT_TEST
+	tristate "KUnit tests for SPI multi-CS framework" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Build KUnit tests for the SPI multi-CS framework. The tests cover
+	  device naming (spi_dev_set_name), last-CS tracking (spi_is_last_cs),
+	  and CS array validation rules.
+
+	  If unsure say N.
+
 config SPI_LOOPBACK_TEST
 	tristate "spi loopback test framework support"
 	depends on m
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index a18814fbde93..c549cf471bd2 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_SPI_MUX)			+= spi-mux.o
 obj-$(CONFIG_SPI_OFFLOAD)		+= spi-offload.o
 obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
 obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
-obj-$(CONFIG_SPI_DMA_KUNIT_TEST)	+= tests/
+obj-y += tests/
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_AIROHA_SNFI)		+= spi-airoha-snfi.o
diff --git a/drivers/spi/internals.h b/drivers/spi/internals.h
index c56c190b02e9..ef227d17b33f 100644
--- a/drivers/spi/internals.h
+++ b/drivers/spi/internals.h
@@ -19,6 +19,22 @@
 
 void spi_flush_queue(struct spi_controller *ctrl);
 
+/*
+ * Zero(0) is a valid physical CS value and can be located at any
+ * logical CS in the spi->chip_select[]. If all the physical CS
+ * are initialized to 0 then It would be difficult to differentiate
+ * between a valid physical CS 0 & an unused logical CS whose physical
+ * CS can be 0. As a solution to this issue initialize all the CS to -1.
+ * Now all the unused logical CS will have -1 physical CS value & can be
+ * ignored while performing physical CS validity checks.
+ */
+#define SPI_INVALID_CS		((s8)-1)
+
+#if IS_ENABLED(CONFIG_KUNIT)
+bool spi_is_last_cs(struct spi_device *spi);
+void spi_dev_set_name(struct spi_device *spi);
+#endif
+
 #ifdef CONFIG_HAS_DMA
 #if IS_ENABLED(CONFIG_KUNIT)
 int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg);
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 30103bffad33..287e81048063 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -778,7 +778,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 }
 EXPORT_SYMBOL_GPL(spi_alloc_device);
 
-static void spi_dev_set_name(struct spi_device *spi)
+VISIBLE_IF_KUNIT void spi_dev_set_name(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
@@ -810,17 +810,7 @@ static void spi_dev_set_name(struct spi_device *spi)
 	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
 		     spi_get_chipselect(spi, 0));
 }
-
-/*
- * Zero(0) is a valid physical CS value and can be located at any
- * logical CS in the spi->chip_select[]. If all the physical CS
- * are initialized to 0 then It would be difficult to differentiate
- * between a valid physical CS 0 & an unused logical CS whose physical
- * CS can be 0. As a solution to this issue initialize all the CS to -1.
- * Now all the unused logical CS will have -1 physical CS value & can be
- * ignored while performing physical CS validity checks.
- */
-#define SPI_INVALID_CS		((s8)-1)
+EXPORT_SYMBOL_IF_KUNIT(spi_dev_set_name);
 
 static inline int spi_dev_check_cs(struct device *dev,
 				   struct spi_device *spi, u8 idx,
@@ -1247,7 +1237,7 @@ static void spi_res_release(struct spi_controller *ctlr, struct spi_message *mes
 	for (idx = 0; idx < spi->num_chipselect; idx++)		\
 		if (!(spi->cs_index_mask & BIT(idx))) {} else
 
-static inline bool spi_is_last_cs(struct spi_device *spi)
+VISIBLE_IF_KUNIT bool spi_is_last_cs(struct spi_device *spi)
 {
 	u8 idx;
 	bool last = false;
@@ -1258,6 +1248,7 @@ static inline bool spi_is_last_cs(struct spi_device *spi)
 	}
 	return last;
 }
+EXPORT_SYMBOL_IF_KUNIT(spi_is_last_cs);
 
 static void spi_toggle_csgpiod(struct spi_device *spi, u8 idx, bool enable, bool activate)
 {
diff --git a/drivers/spi/tests/Makefile b/drivers/spi/tests/Makefile
index 26689e0cb28a..0711fdd7ce33 100644
--- a/drivers/spi/tests/Makefile
+++ b/drivers/spi/tests/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_SPI_DMA_KUNIT_TEST) += spi-dma-kunit.o
+obj-$(CONFIG_SPI_DMA_KUNIT_TEST)	+= spi-dma-kunit.o
+obj-$(CONFIG_SPI_MULTI_CS_KUNIT_TEST)	+= spi-multi-cs-kunit.o
diff --git a/drivers/spi/tests/spi-multi-cs-kunit.c b/drivers/spi/tests/spi-multi-cs-kunit.c
new file mode 100644
index 000000000000..314de7dc8606
--- /dev/null
+++ b/drivers/spi/tests/spi-multi-cs-kunit.c
@@ -0,0 +1,374 @@
+// SPDX-License-Identifier: GPL-2.0
+// KUnit tests for the SPI multi-CS framework covering CS suffix formatting in
+// device names, last-asserted CS tracking, and CS array configuration
+// validation.
+
+#include <kunit/test.h>
+#include <kunit/device.h>
+#include <linux/spi/spi.h>
+
+#include "../internals.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+KUNIT_DEFINE_ACTION_WRAPPER(spi_dev_put_wrapper, spi_dev_put,
+			    struct spi_device *);
+
+/*
+ * Allocate an SPI device on a controller with @ctlr_num_cs chip selects,
+ * using the core allocators so both are real, refcounted devices. The
+ * controller is parented to a KUnit device and released through devres
+ * when that device is unregistered at the end of the test. the SPI device
+ * reference is dropped by a deferred action registered after it.
+ */
+static struct spi_device *alloc_spi(struct kunit *test, const u8 *cs,
+				    u8 num_cs, u16 ctlr_num_cs)
+{
+	struct spi_controller *ctlr;
+	struct spi_device *spi;
+	struct device *dev;
+	u8 i;
+
+	dev = kunit_device_register(test, "spi-multi-cs-test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	ctlr = devm_spi_alloc_host(dev, 0);
+	KUNIT_ASSERT_NOT_NULL(test, ctlr);
+	ctlr->num_chipselect = ctlr_num_cs;
+
+	spi = spi_alloc_device(ctlr);
+	KUNIT_ASSERT_NOT_NULL(test, spi);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, spi_dev_put_wrapper, spi),
+			0);
+
+	spi->num_chipselect = num_cs;
+	for (i = 0; i < num_cs; i++) {
+		spi_set_chipselect(spi, i, cs[i]);
+		spi->cs_index_mask |= BIT(i);
+	}
+
+	return spi;
+}
+
+/*
+ * Name @spi through spi_dev_set_name() under a controller named "spi0". Both
+ * names are freed by the kobject release when the devices are put.
+ */
+static const char *spi_name(struct kunit *test, struct spi_device *spi)
+{
+	KUNIT_ASSERT_EQ(test, dev_set_name(&spi->controller->dev, "spi0"), 0);
+
+	spi_dev_set_name(spi);
+	KUNIT_ASSERT_NOT_NULL(test, dev_name(&spi->dev));
+
+	return dev_name(&spi->dev);
+}
+
+/* single CS 0 -> "spi0.0". */
+static void dev_name_single_zero(struct kunit *test)
+{
+	const u8 cs[] = { 0 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	KUNIT_EXPECT_STREQ(test, spi_name(test, spi), "spi0.0");
+}
+
+/* single CS 7 -> "spi0.7". */
+static void dev_name_single_nonzero(struct kunit *test)
+{
+	const u8 cs[] = { 7 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	KUNIT_EXPECT_STREQ(test, spi_name(test, spi), "spi0.7");
+}
+
+/* two CS 0,1 -> "spi0.0-1". */
+static void dev_name_two_cs(struct kunit *test)
+{
+	const u8 cs[] = { 0, 1 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	KUNIT_EXPECT_STREQ(test, spi_name(test, spi), "spi0.0-1");
+}
+
+/* four CS 1,2,3,4 -> "spi0.1-4". */
+static void dev_name_four_cs(struct kunit *test)
+{
+	const u8 cs[] = { 1, 2, 3, 4 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	KUNIT_EXPECT_STREQ(test, spi_name(test, spi), "spi0.1-4");
+}
+
+/*
+ * cs_index_mask only has bit 0 set even though num_chipselect=2:
+ * only the enabled CS is reflected in the name -> "spi0.0".
+ */
+static void dev_name_index_mask_single(struct kunit *test)
+{
+	const u8 cs[] = { 0, 1 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	spi->cs_index_mask = BIT(0);
+
+	KUNIT_EXPECT_STREQ(test, spi_name(test, spi), "spi0.0");
+}
+
+static struct kunit_case spi_dev_name_cases[] = {
+	KUNIT_CASE(dev_name_single_zero),
+	KUNIT_CASE(dev_name_single_nonzero),
+	KUNIT_CASE(dev_name_two_cs),
+	KUNIT_CASE(dev_name_four_cs),
+	KUNIT_CASE(dev_name_index_mask_single),
+	{}
+};
+
+static struct kunit_suite spi_dev_name_suite = {
+	.name = "spi_dev_name",
+	.test_cases = spi_dev_name_cases,
+};
+
+/* single CS: last_cs[0] matches. */
+static void last_cs_single_match(struct kunit *test)
+{
+	const u8 cs[] = { 3 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	spi->controller->last_cs[0] = 3;
+
+	KUNIT_EXPECT_TRUE(test, spi_is_last_cs(spi));
+}
+
+/* single CS: last_cs[0] is SPI_INVALID_CS. */
+static void last_cs_single_invalid(struct kunit *test)
+{
+	const u8 cs[] = { 3 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	spi->controller->last_cs[0] = SPI_INVALID_CS;
+
+	KUNIT_EXPECT_FALSE(test, spi_is_last_cs(spi));
+}
+
+/* single CS: last_cs[0] holds a different physical CS. */
+static void last_cs_single_mismatch(struct kunit *test)
+{
+	const u8 cs[] = { 3 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	spi->controller->last_cs[0] = 4;
+
+	KUNIT_EXPECT_FALSE(test, spi_is_last_cs(spi));
+}
+
+/* multi-CS: both slots match. */
+static void last_cs_multi_both_match(struct kunit *test)
+{
+	const u8 cs[] = { 0, 1 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	spi->controller->last_cs[0] = 0;
+	spi->controller->last_cs[1] = 1;
+
+	KUNIT_EXPECT_TRUE(test, spi_is_last_cs(spi));
+}
+
+/* multi-CS: only second slot matches. */
+static void last_cs_multi_partial_match(struct kunit *test)
+{
+	const u8 cs[] = { 0, 1 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	spi->controller->last_cs[0] = SPI_INVALID_CS;
+	spi->controller->last_cs[1] = 1;
+
+	KUNIT_EXPECT_TRUE(test, spi_is_last_cs(spi));
+}
+
+/* multi-CS: all slots invalid. */
+static void last_cs_multi_all_invalid(struct kunit *test)
+{
+	const u8 cs[] = { 0, 1 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	spi->controller->last_cs[0] = SPI_INVALID_CS;
+	spi->controller->last_cs[1] = SPI_INVALID_CS;
+
+	KUNIT_EXPECT_FALSE(test, spi_is_last_cs(spi));
+}
+
+/*
+ * cs_index_mask only has bit 0 set even though num_chipselect=2:
+ * slot 1 is skipped by spi_for_each_valid_cs, only slot 0 is checked.
+ * last_cs[0] matches.
+ */
+static void last_cs_index_mask_filters_slots(struct kunit *test)
+{
+	const u8 cs[] = { 0, 1 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	/* override mask: only slot 0 active. */
+	spi->cs_index_mask = BIT(0);
+	spi->controller->last_cs[0] = 0;
+	spi->controller->last_cs[1] = SPI_INVALID_CS;
+
+	KUNIT_EXPECT_TRUE(test, spi_is_last_cs(spi));
+}
+
+static struct kunit_case spi_is_last_cases[] = {
+	KUNIT_CASE(last_cs_single_match),
+	KUNIT_CASE(last_cs_single_invalid),
+	KUNIT_CASE(last_cs_single_mismatch),
+	KUNIT_CASE(last_cs_multi_both_match),
+	KUNIT_CASE(last_cs_multi_partial_match),
+	KUNIT_CASE(last_cs_multi_all_invalid),
+	KUNIT_CASE(last_cs_index_mask_filters_slots),
+	{}
+};
+
+static struct kunit_suite spi_is_last_suite = {
+	.name = "spi_is_last_cs",
+	.test_cases = spi_is_last_cases,
+};
+
+/*
+ * Validate and normalise the CS configuration of @spi against the controller's
+ * @num_chipselect limit. Arithmetic Analysis only, no device-model calls or bus
+ * scan.
+ *
+ * On success the unused chip_select[] slots are filled with SPI_INVALID_CS.
+ */
+static int spi_validate_cs_config(struct spi_device *spi,
+				  u16 ctlr_num_chipselect)
+{
+	int idx;
+
+	if (spi->num_chipselect > SPI_DEVICE_CS_CNT_MAX)
+		return -EOVERFLOW;
+
+	for (idx = 0; idx < spi->num_chipselect; idx++) {
+		if (spi_get_chipselect(spi, idx) >= ctlr_num_chipselect)
+			return -EINVAL;
+	}
+
+	/* No duplicate physical CS values within the same device. */
+	for (idx = 0; idx < spi->num_chipselect; idx++) {
+		for (int j = idx + 1; j < spi->num_chipselect; j++) {
+			if (spi_get_chipselect(spi, idx) == spi_get_chipselect(spi, j))
+				return -EBUSY;
+		}
+	}
+
+	/* Fill unused slots before the contiguity check modifies chip_select[]. */
+	for (idx = spi->num_chipselect; idx < SPI_DEVICE_CS_CNT_MAX; idx++)
+		spi_set_chipselect(spi, idx, SPI_INVALID_CS);
+
+	/* CS values must form a ascending contiguous sequence. */
+	for (idx = 1; idx < spi->num_chipselect; idx++) {
+		if (spi_get_chipselect(spi, idx) != spi_get_chipselect(spi, idx - 1) + 1)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* valid single CS within controller range. */
+static void cs_cfg_single_valid(struct kunit *test)
+{
+	const u8 cs[] = { 3 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	KUNIT_EXPECT_EQ(test, spi_validate_cs_config(spi, 8), 0);
+	/* unused slots filled with SPI_INVALID_CS. */
+	KUNIT_EXPECT_EQ(test, (s8)spi_get_chipselect(spi, 1), SPI_INVALID_CS);
+	KUNIT_EXPECT_EQ(test, (s8)spi_get_chipselect(spi, 2), SPI_INVALID_CS);
+	KUNIT_EXPECT_EQ(test, (s8)spi_get_chipselect(spi, 3), SPI_INVALID_CS);
+}
+
+/* valid multi-CS contiguous range. */
+static void cs_cfg_multi_valid(struct kunit *test)
+{
+	const u8 cs[] = { 1, 2 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	KUNIT_EXPECT_EQ(test, spi_validate_cs_config(spi, 8), 0);
+	KUNIT_EXPECT_EQ(test, (s8)spi_get_chipselect(spi, 2), SPI_INVALID_CS);
+	KUNIT_EXPECT_EQ(test, (s8)spi_get_chipselect(spi, 3), SPI_INVALID_CS);
+}
+
+/* num_chipselect > SPI_DEVICE_CS_CNT_MAX. */
+static void cs_cfg_overflow(struct kunit *test)
+{
+	struct spi_device *spi = alloc_spi(test, NULL, 0, 8);
+
+	spi->num_chipselect = SPI_DEVICE_CS_CNT_MAX + 1;
+
+	KUNIT_EXPECT_EQ(test, spi_validate_cs_config(spi, 8), -EOVERFLOW);
+}
+
+/* physical CS >= controller num_chipselect. */
+static void cs_cfg_out_of_range(struct kunit *test)
+{
+	const u8 cs[] = { 8 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	KUNIT_EXPECT_EQ(test, spi_validate_cs_config(spi, 8), -EINVAL);
+}
+
+/* duplicate physical CS values. */
+static void cs_cfg_duplicate(struct kunit *test)
+{
+	const u8 cs[] = { 2, 2 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	KUNIT_EXPECT_EQ(test, spi_validate_cs_config(spi, 8), -EBUSY);
+}
+
+/* non-contiguous CS (gap). */
+static void cs_cfg_gap(struct kunit *test)
+{
+	const u8 cs[] = { 0, 2 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	KUNIT_EXPECT_EQ(test, spi_validate_cs_config(spi, 8), -EINVAL);
+}
+
+/* descending CS values. */
+static void cs_cfg_descending(struct kunit *test)
+{
+	const u8 cs[] = { 3, 2 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	KUNIT_EXPECT_EQ(test, spi_validate_cs_config(spi, 8), -EINVAL);
+}
+
+/* max 4 CS, all valid and contiguous. */
+static void cs_cfg_max_cs(struct kunit *test)
+{
+	const u8 cs[] = { 0, 1, 2, 3 };
+	struct spi_device *spi = alloc_spi(test, cs, ARRAY_SIZE(cs), 8);
+
+	KUNIT_EXPECT_EQ(test, spi_validate_cs_config(spi, 8), 0);
+}
+
+static struct kunit_case spi_cs_config_cases[] = {
+	KUNIT_CASE(cs_cfg_single_valid),
+	KUNIT_CASE(cs_cfg_multi_valid),
+	KUNIT_CASE(cs_cfg_overflow),
+	KUNIT_CASE(cs_cfg_out_of_range),
+	KUNIT_CASE(cs_cfg_duplicate),
+	KUNIT_CASE(cs_cfg_gap),
+	KUNIT_CASE(cs_cfg_descending),
+	KUNIT_CASE(cs_cfg_max_cs),
+	{}
+};
+
+static struct kunit_suite spi_cs_config_suite = {
+	.name = "spi_cs_config",
+	.test_cases = spi_cs_config_cases,
+};
+
+kunit_test_suites(&spi_dev_name_suite, &spi_is_last_suite, &spi_cs_config_suite);
+
+MODULE_DESCRIPTION("KUnit tests for SPI multi-CS framework");
+MODULE_LICENSE("GPL");
-- 
2.34.1

