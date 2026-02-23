Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0530EF86;
	Mon, 23 Feb 2026 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863782; cv=none; b=Q1XFveImJV4VJ0j4aLaHS7lqOqfSXbHzaLXq8uOzow62SH1nEbQFVePmizLW+DWwSM8a/6E98Ln5j4VsfAeMsO7N6rjFHMWxgJC9G0M9sRojISQzmz4rJDkTL6uS6KnaAi905zIllHKcToRblJs8+ouHA93U0BZKQ0TtbphQV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863782; c=relaxed/simple;
	bh=SV7W4fnjFcezDK3AHJj9/tpEokgD76c3PddPVFJsBtc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDcbKDJPFFvvNakhyGgZazIOjWJVz4UZyrn5k+z2XRujabmWJGtg2xTVHsXwmfZcu0JFkgP0EKCkbV6xBopw1iZjCpuMK4/PFiqMdCEYdsPvPRfv/aJt+1ZhsGcR1ZVwnI2G9WcbCWLeBeTMOkVJZghuHZKimgpPfO17Q2gYjPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Dwd4lKBQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Dwd4lKBQ"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NDxXR32668516;
	Mon, 23 Feb 2026 11:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=P24n3
	5u3npM9iCfs3A1VCmCQr0Fy7jcLyEihCd3IxVE=; b=Dwd4lKBQZcQOV2rMNUkBu
	4ag40mN31gUjTS7/4Y7+2NKMauCsni5WUtqmghH7b64OpztSsQwhdAB/c5/p8Mhd
	RiVgnrN7MOq0MCxWT7dasBsOVg8AA94cuzy6W5L33HFsRxcgEldwhvgUsl+yxvQ0
	jErPCKcRyTPXjRmDhU+P8fdDkKPzn2cGFbKfClfHUUkb3619O1ZQbtaGcs6vzk6V
	9yhxJAJmVg3x+L28cEepzBl92XW9pvIBlmMS/aoxvqDWYv/Frw1BiR1jrD7++Z1k
	XqgnnhsMURoKGMNXumO6YORNv1NK9XSFsEPnokW/8EPXSsxEgd4w6mko7+4q/15m
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7pbbngb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:22:41 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NGMeQa031804
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 11:22:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 11:22:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 11:22:40 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NGMJUc015342;
	Mon, 23 Feb 2026 11:22:31 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian
 Reichel <sebastian.reichel@collabora.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v4 1/5] spi: allow ancillary devices to share parent's chip selects
Date: Mon, 23 Feb 2026 18:21:00 +0200
Message-ID: <20260223162110.156746-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223162110.156746-1-antoniu.miclaus@analog.com>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 9ZNKzmb3SmSWDW5ruQZh0Ngdw9im299n
X-Authority-Analysis: v=2.4 cv=RPK+3oi+ c=1 sm=1 tr=0 ts=699c7ed1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=IpJZQVW2AAAA:8 a=Brvx10Sw2QwnUvu3_sIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: 9ZNKzmb3SmSWDW5ruQZh0Ngdw9im299n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE0MCBTYWx0ZWRfXxHxtdFnD0ODV
 SKPYc8wwCD4WiLbrB8t91ICK0vllt1OiSywjBOU34xpUrIoGsC/H3diMj4I/y1VAilykuoOYkva
 Z/GAmyaa1Ji+Yz2tmfsH6IZE8YxuMo5HoIAZGEbR+YGlG+lXqNGksz6Q4wsxo/b6roS0FChrJaQ
 lHPKTU3TX/5DsHjGmORvQiedP2rlRDKwQUhhJdY0emTukAhIGvHlBk4rIZHeLm8rEbwITm9gaT5
 dl5IBFLwR5KQhbYHB8XpXfXR8kMFrT8ywr00K4j7C15MWEvCeKuSm0T5usuDiVgLX/69jfG4jGX
 89kXz3hVX6p0RzoDCzkcJ0BKSizdaxdWkMjG2p5MupgjMOsGwmEju6t1RAiuTsAtBJOEJpjo41N
 CaMioIZzPA8wCOSzKiatCCAzXL/LGPl6Z7AcFpyk6CjSSVZBhXw8Zf0K9r4X7X7+WGhvCQ6sOHP
 f8H1aN+6gxgx342NeaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230140

When registering an ancillary SPI device, the current code flags a chip
select conflict with the parent device. This happens because the
ancillary device intentionally uses one of the parent's chip selects,
but __spi_add_device() checks against all existing devices including
the parent.

Allow this by passing the parent device pointer to __spi_add_device()
and skipping the conflict check when the existing device is the parent.

Fixes: 0c79378c0199 ("spi: add ancillary device support")
Acked-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v4:
  - Add Fixes tag
  - Add Acked-by from Nuno Sá

 drivers/spi/spi.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e25df9990f82..693bdcc5a12a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -641,12 +641,26 @@ static inline int spi_dev_check_cs(struct device *dev,
 	return 0;
 }
 
+struct spi_dev_check_info {
+	struct spi_device *new_spi;
+	struct spi_device *parent;	/* set for ancillary devices */
+};
+
 static int spi_dev_check(struct device *dev, void *data)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	struct spi_device *new_spi = data;
+	struct spi_dev_check_info *info = data;
+	struct spi_device *new_spi = info->new_spi;
 	int status, idx;
 
+	/*
+	 * When registering an ancillary device, skip checking against the
+	 * parent device since the ancillary is intentionally using one of
+	 * the parent's chip selects.
+	 */
+	if (spi == info->parent)
+		return 0;
+
 	if (spi->controller == new_spi->controller) {
 		for (idx = 0; idx < spi->num_chipselect; idx++) {
 			status = spi_dev_check_cs(dev, spi, idx, new_spi, 0);
@@ -663,10 +677,11 @@ static void spi_cleanup(struct spi_device *spi)
 		spi->controller->cleanup(spi);
 }
 
-static int __spi_add_device(struct spi_device *spi)
+static int __spi_add_device(struct spi_device *spi, struct spi_device *parent)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
+	struct spi_dev_check_info check_info;
 	int status, idx;
 	u8 cs;
 
@@ -710,7 +725,9 @@ static int __spi_add_device(struct spi_device *spi)
 	 * chipselect **BEFORE** we call setup(), else we'll trash
 	 * its configuration.
 	 */
-	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
+	check_info.new_spi = spi;
+	check_info.parent = parent;
+	status = bus_for_each_dev(&spi_bus_type, NULL, &check_info, spi_dev_check);
 	if (status)
 		return status;
 
@@ -772,7 +789,7 @@ int spi_add_device(struct spi_device *spi)
 	spi_dev_set_name(spi);
 
 	mutex_lock(&ctlr->add_lock);
-	status = __spi_add_device(spi);
+	status = __spi_add_device(spi, NULL);
 	mutex_unlock(&ctlr->add_lock);
 	return status;
 }
@@ -2580,8 +2597,8 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
 
 	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
 
-	/* Register the new device */
-	rc = __spi_add_device(ancillary);
+	/* Register the new device, passing the parent to skip CS conflict check */
+	rc = __spi_add_device(ancillary, spi);
 	if (rc) {
 		dev_err(&spi->dev, "failed to register ancillary device\n");
 		goto err_out;
-- 
2.43.0

