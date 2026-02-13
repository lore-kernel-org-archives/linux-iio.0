Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960273624B5;
	Fri, 13 Feb 2026 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994289; cv=none; b=aaM9c9w8dnLrrm40Jl69PuVGmWdfMhzYHXtDEDyddtWBthob2uSD2occVA3D1TzL58NlvNjoETmjDiA4DV3RVcWkm/Hgwa9oa5c8sai7vXwHuCphVQCd3k4F5CPO15NLd9jJAKdaZAlFc3cUdpGtJUUU553WSrlAnEvIydb2SrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994289; c=relaxed/simple;
	bh=UGbI9BoloVjenYVbUNwNpVHMhG2aG+M2yP9nsGah+xk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piuC4shgsrEdHLpoIqKbjncRbeYxFuZFLaypMDKiE4z3ey81Qj9NTYzEbaOimNpz/umRh9MiKBY8eTNPgpL/4TI9JGKsDwk3lPqD3tGHVNUfeXRx7hFtyQXRdAvjDGqQTGcjDCdRy9rA7z46WpY6pEnlIm+l/nAGy3wbMhTKvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EMgGfMdw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EMgGfMdw"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DE6eBD861524;
	Fri, 13 Feb 2026 09:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XlsoJ
	Zfx9kg1MnghywKRaY8hdY41t13YOn9Q3SPA8Oo=; b=EMgGfMdw9ZmeybNfHh5qY
	KE+mtGsh1rdA8fjA7gXFZxfFnZl7hzqkNg8Ec5om8JtKy6TAX9anUkQ1llThQN25
	Y2y9hdOd6Z9cY6I14KH0w4ediBJ71zbJE4Msg0aH4wzJQAlev5DLJ9yuLaerHG7l
	5hZgI1lwHZMWXohu36hwf6dnXVgpYr0IYFrRDWUZz8sSstOjagTkV/MygmYB8ibB
	X68wc0hLmFkGk1d20RyX4zE94GD0ZBEdoUTYFqFXLWIOp6x/WaJbpnvHKVrR3Ksx
	vuCZLEG5Wm7HuMJzcW5ajVQbfx38mpTxZ6FOM9U4b71O5JxNDsH3vrcd/S88MnG+
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c8hn342j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 09:51:09 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61DEp8MT041658
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Feb 2026 09:51:08 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 13 Feb
 2026 09:51:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Feb 2026 09:51:07 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61DEop6H018676;
	Fri, 13 Feb 2026 09:51:03 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Mark Brown <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v3 1/5] spi: allow ancillary devices to share parent's chip selects
Date: Fri, 13 Feb 2026 16:47:33 +0200
Message-ID: <20260213144742.16394-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213144742.16394-1-antoniu.miclaus@analog.com>
References: <20260213144742.16394-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: oXek3MgzP4zly1j36IM8KfiT8J07d1qB
X-Authority-Analysis: v=2.4 cv=AdC83nXG c=1 sm=1 tr=0 ts=698f3a5d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=Brvx10Sw2QwnUvu3_sIA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNSBTYWx0ZWRfX1u+rDuvSOa4a
 Rx/+Iqv+yoOyBUq2mF0HTWtgZXp9/zoDTojsTA8iK2S7/EMTP+ZoJ3PZasbPfSoKIPEOP5oXHpS
 ZwIS6f0DpXkEqLBTQlzIUE2nLoDmlmNZ52C3mYVtK/yyhofJrpnf87ODWNe4MSuZTCteRX+Qxj0
 ciwg+tIlLIVXKhs8VcVWV3xj1Sdk6I1a7FGieFojcmKYFJS2oMNGo0LzsRkHKnAVaxlPf4a+xvh
 mF7fS/uBMBCguDD6GaPco9RI6mOuMM5psPvT8lx/Bxp9YmpXSwjGacop132tOojrsbuBEffeACm
 lafJKuxDXqUxj044f+sNfg7lN6SACsLNaNKinKxzdFod47BjSD31smBJobQse/sROD/9Bp+5fz0
 ZJ2kpps5QgOatiR+RBL6O0+qxG9/gvQdF2CvCAjU1A4ZuH/fGXoDmN8t44Tur58VIKgPXAm3Xjs
 /Xynz/Ovho4jBK95JiA==
X-Proofpoint-GUID: oXek3MgzP4zly1j36IM8KfiT8J07d1qB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130115

When registering an ancillary SPI device, the current code flags a chip
select conflict with the parent device. This happens because the
ancillary device intentionally uses one of the parent's chip selects,
but __spi_add_device() checks against all existing devices including
the parent.

Allow this by passing the parent device pointer to __spi_add_device()
and skipping the conflict check when the existing device is the parent.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
Changes in v3:
  - Drop redundant NULL check for info->parent in spi_dev_check()

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

