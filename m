Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E22E7363;
	Wed, 17 Jun 2026 02:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661905; cv=none; b=Rc7HNbV6TL6L+V/qk23T1CtvzCBy5CnLNyLw4FKRTFB+hF3vfkOt/0mcO7Pof1LUED0ZpvD/fSxFMblNEgB+P1UiWezdywL3WFfBn3HMs2aApQfmkuptKKpHqOzTldc3Q67iZuFllH9VFctn9T7jSdY9m/0ZJwTFUnVCms7I9Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661905; c=relaxed/simple;
	bh=QxSMfBGp2rgFGnkix5Cv05pJimlb250xpzuaD7aPBNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxXGz7qhT1cOTtlUI/j5+w47HuNIgIIOCtUkYsZgPOCvnoMaCWRHfsF0jfZ1tjGScYxOdAaf/KeFmGjEGZ+hnWoY79XB4X7jlwofSuGVD5LqZQPfLVsGnaAGusCLLKGmIUNmDmh5UyAvp7NKhNUoqS+LA81m1oCVuHZ4USPE5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=erBBQdq1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="erBBQdq1"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLWjKV878652;
	Tue, 16 Jun 2026 22:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GiPeQ
	O+FPXHsho8SrYHrVt3dhMAUnZ3Rs7kiBMNwkf4=; b=erBBQdq11vUoEwT4IqF4i
	BCCqqkoBfo1hwMiqUuhK4sZwMYTtDXyIsRNnvC9ZT3CnbHhpRagK0SwRBlIj4N9r
	e0y/EIrjT6EvU9UPuQbJXl9EvqVczzQ02y90J0XZ6U7FAhtEu+14PPsXfuSHEvPj
	lFolyj4AzO6+AZB9ELGss1fg4X4Zy+v2sLp77YRh5BaPiZFZhZ3Tq/Is//yRxeew
	doYgIEL4HkctXZBzVoyOBok37PjSBSt0PmepeIma2ezajOAUAvGDm5epVyUdfdTa
	hl/Tcfrvxa9TOl4cxhKtbQ/liUgItIsUL1bsdi/8Nimx/pkRXPkDO9fVII2p8QME
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4euegdrsbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 22:05:00 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65H24xDW014166
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Jun 2026 22:04:59 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 16 Jun 2026 22:04:59 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 16 Jun 2026 22:04:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 16 Jun 2026 22:04:58 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65H24kK5006756;
	Tue, 16 Jun 2026 22:04:48 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <pop.ioan-daniel@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 5/5] iio: adc: ltc2378: Enable triggered buffer data capture
Date: Tue, 16 Jun 2026 23:04:40 -0300
Message-ID: <22248e8ba646fbe8edfc87e2b9be527632d5b48c.1781661028.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1781661028.git.marcelo.schmitt@analog.com>
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDAxNyBTYWx0ZWRfXwWPmmVK0xAOe
 j1KFYVdZTWtwfEpD14VWj8sDN8ZfxnfFH7YNOThly0q1Eavy01sA1omta4m2qa+vKhgCs0UaSgA
 7jxur3++AuvIb1df25qRBLZlNINxHd0kC7jUWp9yPo6QjpUl30VYjUNwVTP5EFzQ6uE+sunBiX2
 iARyl9OBkaR4vVpi5FdtTeyoi/NByGwr8rV5RbGY7uGC1wodHj5mKSakvXrcPaJt3NQsveSVOj3
 9/vTGnnfcVrLX2itC4AkJyMuAs3l0fFrKjkGF2YELnZNev+MF+l/RrM+zEgeOH8nmfSpD4bE9jJ
 o8T4HdWHMqhyqWvntIM/8YnJdFbqa1QQwx1GCZ95YnAed6BpdTA5dtSCbM0X6OBm3WO/Ku7DM9q
 XopGZkV2Iin1YJQzfZFuQ825mySgE9x4vdfQ11Bcg9gMc1SLzrllYqMsGuQzH16eIfBry8RGWFx
 HOve8unU6O7LUpT9yNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDAxNyBTYWx0ZWRfX1jzSWjs3r8iV
 dmDYfTUDqfP7mhuPvS72jFmvgEKAyxHfQrrbUmsPOLWqsg0JmnAFawK1h64nLlkeFPCz4ka2pRW
 cg71bFF+jmNcV9F532e98nwXLkT0t1+12L5rPevsv7ZXCBaH2HWV
X-Authority-Analysis: v=2.4 cv=BbvoFLt2 c=1 sm=1 tr=0 ts=6a3200cc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=yG7T9kLISj94RV_eT-gA:9
X-Proofpoint-GUID: VvkxPUoGS7WRpPhZAMMenyX5LKIi9sCT
X-Proofpoint-ORIG-GUID: VvkxPUoGS7WRpPhZAMMenyX5LKIi9sCT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170017

Enable users to run triggered data captures with LTC2378 and similar ADCs.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3:
- Extracted from main driver file into a separate buffer-specific containment.

 drivers/iio/adc/ltc2378-lib-core.c         | 17 +++++++-
 drivers/iio/adc/ltc2378-triggered-buffer.c | 49 ++++++++++++++++++++++
 drivers/iio/adc/ltc2378.h                  | 15 +++++++
 3 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/adc/ltc2378-triggered-buffer.c

diff --git a/drivers/iio/adc/ltc2378-lib-core.c b/drivers/iio/adc/ltc2378-lib-core.c
index 1160f4324d01..ec83e9f2ae81 100644
--- a/drivers/iio/adc/ltc2378-lib-core.c
+++ b/drivers/iio/adc/ltc2378-lib-core.c
@@ -18,7 +18,7 @@ int ltc2378_lib_buffer_setup(struct iio_dev *indio_dev, struct ltc2378_state *st
 
 	ret = __ltc2378_set_offload_ops(st);
 	if (ret == -EOPNOTSUPP)
-		return 0; /* Let device setup complete without buffer support */
+		goto trigger_buf_setup;
 
 	if (!ret)
 		ret = st->ops->buffer_setup(indio_dev, st);
@@ -27,6 +27,21 @@ int ltc2378_lib_buffer_setup(struct iio_dev *indio_dev, struct ltc2378_state *st
 		return dev_err_probe(dev, ret, "error on SPI offload setup\n");
 
 	return 0;
+
+trigger_buf_setup:
+	ret = __ltc2378_set_triggered_buf_ops(st);
+	if (ret == -EOPNOTSUPP)
+		return 0; /* Let device setup complete without buffer support */
+
+	if (!ret)
+		ret = st->ops->buffer_setup(indio_dev, st);
+
+	if (ret)
+		return dev_err_probe(dev, ret, "error on buffer setup\n");
+
+	st->chans[st->num_iio_chans++] = IIO_CHAN_SOFT_TIMESTAMP(1);
+
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(ltc2378_lib_buffer_setup, "IIO_LTC2378");
 
diff --git a/drivers/iio/adc/ltc2378-triggered-buffer.c b/drivers/iio/adc/ltc2378-triggered-buffer.c
new file mode 100644
index 000000000000..d1d788fb5cb4
--- /dev/null
+++ b/drivers/iio/adc/ltc2378-triggered-buffer.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Analog Devices, Inc.
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+#include <ltc2378.h>
+
+static irqreturn_t ltc2378_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ltc2378_convert_and_acquire(st);
+	if (ret < 0)
+		goto err_out;
+
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+				    pf->timestamp);
+
+err_out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static int ltc2378_triggered_buffer_setup(struct iio_dev *indio_dev, struct ltc2378_state *st)
+{
+	return devm_iio_triggered_buffer_setup(&st->spi->dev, indio_dev,
+					       &iio_pollfunc_store_time,
+					       &ltc2378_trigger_handler,
+					       NULL);
+}
+
+static const struct ltc2378_ops ltc2378_triggered_buf_ops = {
+	.buffer_setup = ltc2378_triggered_buffer_setup,
+};
+
+int ltc2378_set_triggered_buf_ops(struct ltc2378_state *st)
+{
+	st->ops = &ltc2378_triggered_buf_ops;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ltc2378_set_triggered_buf_ops, "IIO_LTC2378");
diff --git a/drivers/iio/adc/ltc2378.h b/drivers/iio/adc/ltc2378.h
index f6e10f9a83e0..4241b1e79ac0 100644
--- a/drivers/iio/adc/ltc2378.h
+++ b/drivers/iio/adc/ltc2378.h
@@ -89,6 +89,8 @@ int ltc2378_lib_buffer_setup(struct iio_dev *indio_dev, struct ltc2378_state *st
 
 #define __ltc2378_set_offload_ops(st) ltc2378_set_offload_ops((st))
 
+#define __ltc2378_set_triggered_buf_ops(st) ltc2378_set_triggered_buf_ops((st))
+
 #ifdef CONFIG_LTC2378_LIB_OFFLOAD_BUFFER
 
 int ltc2378_set_offload_ops(struct ltc2378_state *st);
@@ -102,4 +104,17 @@ static inline int ltc2378_set_offload_ops(struct ltc2378_state *st)
 
 #endif /* CONFIG_LTC2378_LIB_OFFLOAD_BUFFER */
 
+#ifdef CONFIG_LTC2378_LIB_TRIGGERED_BUFFER
+
+int ltc2378_set_triggered_buf_ops(struct ltc2378_state *st);
+
+#else
+
+static inline int ltc2378_set_triggered_buf_ops(struct ltc2378_state *st)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* CONFIG_LTC2378_LIB_TRIGGERED_BUFFER */
+
 #endif /* __DRIVERS_IIO_ADC_LTC2378_H__ */
-- 
2.53.0

