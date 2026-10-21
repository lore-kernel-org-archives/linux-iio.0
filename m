Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547908;
	b=CQqiOoatpl3L87/Y6zQ9L0E2R/t9/iIYAhgST3UJCNXAZ99LyVWoKiQEEFKOQthPlQuB
	 dmg+16zJVxPQ4idHmCu8bkJWzpZVUjq2ZaJUZeDZTcTjyhyZz/262exZAM72lUwJLziYC
	 ikvn4SHCOWCyWgAaTl6afvk0UVfy0mKaei3AKlAbfVRlVDWembYPAWA6WXUODJ3pgThTh
	 pgsaW/t9r9yRyGh3Makao8XcBUyXZwwSSyz6ZG1tsEW/EobujsL7D3u5zSvJ8/q/0BFn0
	 VDHuwyfDack7cAIL/fqlB83H1NsaMQffE+2RprO8ND6Po1DbsJuXIsaD5TY2fnWnmQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547908;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HNtfu5h+eofUMxrH5WYqrwSwvrISMA/IN0ugNJ/2FYM=;
	b=oU6HO9iT9kG5mrq0ypzLJW+f9BFe9Q27ojcAt10uxyicfeH0idaMkJOhYVq2nfYL/fv3
	 Zpyn+/NxjjZiE+3kuPoK3+5CAW/vgGrjWGOHUKn/V/LoxvoXxfKwVD1DbpXuP4HvQnns2
	 MU3IuWgDylTZF4dKACfaI4coC91+AOD2yd/qEQFaKzkdM0SY6iPKt8wAoJ2DiVTgElfjb
	 Vm50+4vv1t5aCe/Lr/GEmCqf7GZ2PeRaRocOiIJ1Vri5WPH8cpSOImF253rHxhn6hHC4i
	 oQ11FKCIvkA85sHuQ/xj+jbXxiV/q3H3esJHvo0cifLs72bSeRw12X2DhfevakC1bXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GZhQobIq;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="vl4/8kEi";
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEDB606A320;
	Wed, 21 Oct 2026 01:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFEDB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GZhQobIq;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=vl4/8kEi
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L17dN32058035;
	Tue, 20 Oct 2026 21:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=HNtfu5h+eofUMxrH5WYqrwSwvrISMA/IN0ugNJ/2FYM=; b=GZhQobI
	qAoVJhBasWKvGXVfoOB9T2vh3RZGdC/7VGBgTGR5a5TXtkG4D8iAwY71F+iJG+kB
	wZ3DaYGkMZ62eXGzhg9vGI8R9i33bJ6l51lX24c3eS+9T6hqzoTWBKgkVPSVHFEx
	mGBBcwzyuJxPzdexxtm3IUcXh7xToVqu9Tdi+NwYvMctWKSz16OiUlWSGui8i/Xc
	ufYfwufLXHma1e+YeXaxDXUk+SljeNut/WvWBfoRVuGjZcMzasKPo452cqUrY17O
	aZTPK8dRbt0gxlpp17soELbeJV5vWHfhCkUo6nsYJb1aqUdMT9z7oeiyo/1xYIqf
	v2ZnSWv5UVv4SAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HNtfu
	5h+eofUMxrH5WYqrwSwvrISMA/IN0ugNJ/2FYM=; b=vl4/8kEiMXd6WAlrgp4JG
	Pk5RkLmtC85uV+AbmrWHKsmUh9vROGef4bERqtglffe/BgW5x6U7h5g+Q9V7lQtP
	k++MF4TH4j8uJmDhFi8DiUaVq+eCw4aJF9yJ+Evhidgy3XZbjt3XdUNgQKmcU3Fw
	2OEgzJoibit9U/snWuWMc7oMd7or6YbCOOTQ5LsUc1HjebWoyY4QrSgKpWn1MxBt
	zdYa4YMQRyWRhr1q1IklZxbdU1uGPu53gyXeFcrEiraMVdlTMCTD2XrtRUfoRVGC
	fud2TZ8vyphrDPzwn3Hy7yToHwaNqc1PckWa1FSqNTj4BBlJN1Rid8UH9JpcLkvP
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hedgy21f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:58:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69L1wIg9062376
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Oct 2026 21:58:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 20 Oct
 2026 21:58:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 20 Oct 2026 21:58:18 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69L1w6wf029085;
	Tue, 20 Oct 2026 21:58:09 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 6/9] spi: introduce SPI ancillary device with lanes
Date: Tue, 20 Oct 2026 22:58:01 -0300
Message-ID: <21fb26ff0337f493643167f8c9dfae92d1b3b9a7.1792435248.git.Jonathan.Santos@analog.com>
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
X-Authority-Analysis: v=2.4 cv=EvBHPicA c=1 sm=1 tr=0 ts=6ad81c3c cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=MtwxMzEE2bzGYhNubMUA:9
X-Proofpoint-GUID: YtwJTAFRh_27OxR-rhXkQviBHOGzAtcg
X-Proofpoint-ORIG-GUID: YtwJTAFRh_27OxR-rhXkQviBHOGzAtcg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfXwxZSqSt8gEn/
 yFhhqmJN/8yJnEo6LzhIk7mUzi1MzyQHqLOYLRTjL1k1Fgu45FMG0byvdXn5gl6uA0xV/ANL0yi
 c1TzMWFhJmbUIFd9y9ammenRdOyh/zhSeAdm7E92AvNeBdCwQC/coKDZViC0XIjKDF17HRQctEB
 b5/NJ98CA/EMCVyqVM5kzOvSDJHGfmIY1SAN9lfuqBRz8suMzP48QWBTTY98TOGCIfyoENX7EQ6
 QpXzjwAcFnSPvZ3RZoMjLO+f+SLSzQfzzKWNcZ1S7NDvrHIJTWVhIG+vUlhpVCDMeRlGn3uJjR2
 JJhkUBAy3t7e/hGvGGsRTX4/AyVzLFRKBDCp0BUt5ZM9D2xYdojZiXaiUo/ZuQbIdw4nh+xp65R
 Zck7qwjPRzkqkmMFDB3cfl+swMcUMUInnKN9DmkB2HlG15huDMvFazYek/kdXvHydPoF++SE7aB
 DdWSGnvNcv4CoS3OVbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfX9zO6Vu3oUww3
 39gS53vXyS+Np7WvJTuv+juTJqs+C18MRw48DLlWsrnU7HowsInc+M1QIeECkTx5qY+2I8FNZpm
 oWvihF5xk8xFag7CffJobIz0ov9TYz+AcqFlplFT2bNgOHW4QsWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210007

The existing spi_new_ancillary_device() creates an ancillary SPI device
but does not consider the parent's lane map. In multi-device setups where
each sub-device's chip-select is bound to a dedicated data lane, there is
no way to bind an ancillary device to an arbitrary lane index.

Introduce spi_new_ancillary_device_with_lane() and
devm_spi_new_ancillary_device_with_lane(), which accept rx_lane_idx and
tx_lane_idx parameters to select a specific lane from the parent's
rx_lane_map and tx_lane_map respectively. The resulting ancillary device
is registered with a single RX and TX lane, keeping it independent from
the other sub-devices sharing the same controller.

While at it, fix the spi_new_ancillary_device() documentation, which
claimed it returns 0 on success instead of a pointer.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v4:
* Don't use extern for the new declarations of the ancillary functions from
  spi.h.

Changes in v3:
* Refactored code using helper function to reduce duplicated code.

Changes in v2:
* New patch.
---
 drivers/spi/spi.c       | 116 +++++++++++++++++++++++++++++++++++-----
 include/linux/spi/spi.h |   8 +++
 2 files changed, 110 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 53d6ab4ce8a3..30103bffad33 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2918,20 +2918,12 @@ static void of_register_spi_devices(struct spi_controller *ctlr)
 static void of_register_spi_devices(struct spi_controller *ctlr) { }
 #endif
 
-/**
- * spi_new_ancillary_device() - Register ancillary SPI device
- * @spi:         Pointer to the main SPI device registering the ancillary device
- * @chip_select: Chip Select of the ancillary device
- *
- * Register an ancillary SPI device; for example some chips have a chip-select
- * for normal device usage and another one for setup/firmware upload.
- *
- * This may only be called from main SPI device's probe routine.
- *
- * Return: 0 on success; negative errno on failure
- */
-struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
-					     u8 chip_select)
+#define SPI_UNDEFINED_LANE	-1
+
+static struct spi_device *__spi_new_ancillary_device(struct spi_device *spi,
+						     u8 chip_select,
+						     int rx_lane_idx,
+						     int tx_lane_idx)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct spi_device *ancillary;
@@ -2958,6 +2950,21 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 	 */
 	ancillary->cs_index_mask = BIT(0);
 
+	if (rx_lane_idx >= spi->num_rx_lanes || tx_lane_idx >= spi->num_tx_lanes) {
+		rc = -EINVAL;
+		goto err_out;
+	}
+
+	if (rx_lane_idx != SPI_UNDEFINED_LANE) {
+		ancillary->rx_lane_map[0] = spi->rx_lane_map[rx_lane_idx];
+		ancillary->num_rx_lanes = 1;
+	}
+
+	if (tx_lane_idx != SPI_UNDEFINED_LANE) {
+		ancillary->tx_lane_map[0] = spi->tx_lane_map[tx_lane_idx];
+		ancillary->num_tx_lanes = 1;
+	}
+
 	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
 
 	/* Register the new device, passing the parent to skip CS conflict check */
@@ -2973,8 +2980,53 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 	spi_dev_put(ancillary);
 	return ERR_PTR(rc);
 }
+
+/**
+ * spi_new_ancillary_device() - Register ancillary SPI device
+ * @spi:         Pointer to the main SPI device registering the ancillary device
+ * @chip_select: Chip Select of the ancillary device
+ *
+ * Register an ancillary SPI device; for example some chips have a chip-select
+ * for normal device usage and another one for setup/firmware upload.
+ *
+ * This may only be called from main SPI device's probe routine.
+ *
+ * Return: Pointer to new ancillary device on success; ERR_PTR on failure
+ */
+struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
+					    u8 chip_select)
+{
+	return __spi_new_ancillary_device(spi, chip_select,
+					  SPI_UNDEFINED_LANE,
+					  SPI_UNDEFINED_LANE);
+}
 EXPORT_SYMBOL_GPL(spi_new_ancillary_device);
 
+/**
+ * spi_new_ancillary_device_with_lane() - Register ancillary SPI device bound to specific lane
+ * @spi:          Pointer to the main SPI device registering the ancillary device
+ * @chip_select:  Chip Select of the ancillary device
+ * @rx_lane_idx:  Lane index within the parent's rx_lane_map
+ * @tx_lane_idx:  Lane index within the parent's tx_lane_map
+ *
+ * Like spi_new_ancillary_device(), but additionally binds the ancillary device
+ * to a single lane from the parent's lane map. Use this in multi-device setups
+ * where each sub-device is physically wired to a dedicated CS and a dedicated
+ * data lane.
+ *
+ * This may only be called from main SPI device's probe routine.
+ *
+ * Return: Pointer to new ancillary device on success; ERR_PTR on failure
+ */
+struct spi_device *spi_new_ancillary_device_with_lane(struct spi_device *spi,
+						      u8 chip_select,
+						      unsigned int rx_lane_idx,
+						      unsigned int tx_lane_idx)
+{
+	return __spi_new_ancillary_device(spi, chip_select, rx_lane_idx, tx_lane_idx);
+}
+EXPORT_SYMBOL_GPL(spi_new_ancillary_device_with_lane);
+
 static void devm_spi_unregister_device(void *spi)
 {
 	spi_unregister_device(spi);
@@ -3015,6 +3067,42 @@ struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi,
 }
 EXPORT_SYMBOL_GPL(devm_spi_new_ancillary_device);
 
+/**
+ * devm_spi_new_ancillary_device_with_lane() - Register managed ancillary SPI device bound to a lane
+ * @spi:         Pointer to the main SPI device registering the ancillary device
+ * @chip_select: Chip Select of the ancillary device
+ * @rx_lane_idx: Per-device lane index within the parent's rx_lane_map
+ * @tx_lane_idx: Per-device lane index within the parent's tx_lane_map
+ *
+ * Managed version of spi_new_ancillary_device_with_lane(). The ancillary device
+ * will be unregistered automatically when the parent SPI device is unregistered.
+ *
+ * This may only be called from main SPI device's probe routine.
+ *
+ * Return: Pointer to new ancillary device on success; ERR_PTR on failure
+ */
+struct spi_device *devm_spi_new_ancillary_device_with_lane(struct spi_device *spi,
+							   u8 chip_select,
+							   unsigned int rx_lane_idx,
+							   unsigned int tx_lane_idx)
+{
+	struct spi_device *ancillary;
+	int ret;
+
+	ancillary = spi_new_ancillary_device_with_lane(spi, chip_select,
+						       rx_lane_idx, tx_lane_idx);
+	if (IS_ERR(ancillary))
+		return ancillary;
+
+	ret = devm_add_action_or_reset(&spi->dev, devm_spi_unregister_device,
+				       ancillary);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return ancillary;
+}
+EXPORT_SYMBOL_GPL(devm_spi_new_ancillary_device_with_lane);
+
 #ifdef CONFIG_ACPI
 struct acpi_spi_lookup {
 	struct spi_controller 	*ctlr;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 88d17fce02dc..9bc7fb9ec69a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -391,6 +391,14 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 
 extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 chip_select);
 extern struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi, u8 chip_select);
+struct spi_device *spi_new_ancillary_device_with_lane(struct spi_device *spi,
+						      u8 chip_select,
+						      unsigned int rx_lane_idx,
+						      unsigned int tx_lane_idx);
+struct spi_device *devm_spi_new_ancillary_device_with_lane(struct spi_device *spi,
+							   u8 chip_select,
+							   unsigned int rx_lane_idx,
+							   unsigned int tx_lane_idx);
 
 /* Use a define to avoid include chaining to get THIS_MODULE */
 #define spi_register_driver(driver) \
-- 
2.34.1

