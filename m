Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46D423A6C;
	Fri, 27 Feb 2026 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200955; cv=none; b=F5EBnxbgA685JsW2vu7DUTsuEXT72uFSoNadKgSqVVFSzvfiuFTYtaQT+dcjIdjks6Q14hkejThiV8fMyC+CRwez0kBvlZD9h2P1dmnoN2nUMT9C6SfRxZeKnbsi5M4FkZyq9ywySGFBuKi8tvLTCxdI+F5p8XcQ8fCnbZ5W+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200955; c=relaxed/simple;
	bh=1qicuhJCKRNOpCUiuetwWDqGKNcuozXE8Ecv8g2bRiA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9i35Hej6YnqxSYHR7/OG/cDoEObp0rqPM4thJuaLnQJgf6LQYREKyglccv22XSGed4ohGqyarBl7InmYKDGXq3wWkRJd9oeaIw72eIvD3lQqmi3DbZZOAh4L/Mqk6SrrdDbURcgjK2CyaY14r+AU6UBB3sdx9Ejr3XidtlG0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tAh76HUb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tAh76HUb"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RBUokP1380239;
	Fri, 27 Feb 2026 09:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Y5cL0
	Y+dwFT7jueP1cOEGOWoc74NS81KRcAy675a1sU=; b=tAh76HUbE3OrZmZaPGbWI
	JpGQ6D1geLv7GC3OHQMhGFxozoPtBwbDCRHRcLn7uvK3bHgwMLaL+IUXQQoUHr8O
	HsoiUnzMFOylyt0yYr6h4wtsQ7k8phm/c+y0wys5ZI4y1uX2Rhyf2KltMgDsGssx
	lhFnDdw/a0T11EK7sv/QhmZZ87FkrkE7Ns0zMrDhRl4v/+AxsILfP5aC6yP+JZEH
	7B6lj5748kQRw1MZsh4uiRPX5t4zUXvdTaK9wOCxjQ3DZU4cQLXEFClDGoAf/2AI
	sJs43a98FUHzwCF2PhED1yh4uLnFgi594izeI6+fs6ykxNkC5ytnJsYu2yGCB90r
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cja98r2ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:02:11 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RE2AE9064789
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 09:02:10 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 27 Feb
 2026 09:02:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 09:02:10 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RE1t3n001982;
	Fri, 27 Feb 2026 09:02:04 -0500
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
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 01/12] iio: frequency: adrf6780: add dev variable
Date: Fri, 27 Feb 2026 16:01:30 +0200
Message-ID: <20260227140152.77529-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227140152.77529-1-antoniu.miclaus@analog.com>
References: <20260227140152.77529-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNCBTYWx0ZWRfX5VuyNnY5lddZ
 GuTl7EhisCa9RoRh3DjrSZJvREbDlqoJBqehJMSO5BA06nFogHrkn8MKLr2NR1ef/tT4sQTO3j2
 idQw7H3oeWkxWnDM4Q40WG7G/5OJWkFvJ+7CmNbtvMDx1t7d+MZ/pyfW84JQOLrCOFzGdqwgUjc
 KYX7Jt7l5mCdY+5Z1vgsGkKBQOsd1uUCVZDfXw91zUfsumuN9zLQTSQW0hv00OidvoxQ8SlUOBK
 Lz5TnNu2QgSxu3DmJDECjTfSEWivMbXO4jBZaO9XBzLjGo1pEUM/aZ1+VLvue72brLrVa1aNQnR
 eqtIFZteTnJ0sjFLW0Uz7Iokx86Bv45u/zpXIX0jY2+0pXEeGsHaXQeU11zG86KiFo1s6L8/IIu
 1Egr+eEn17nHEZQ6KmmZYz9kn5TBcPlz3OG3likV7OXSUi7P4/pWs2AHbCdBB0i71uPeKw+6HnI
 5S2rS4sqcueKjmfaeoA==
X-Authority-Analysis: v=2.4 cv=a+A9NESF c=1 sm=1 tr=0 ts=69a1a3e3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=2djtLzYQq7BR6x-tG2YA:9
X-Proofpoint-ORIG-GUID: 168GuxZq_ZUIMi9rL80aSOhsakaYAYIE
X-Proofpoint-GUID: 168GuxZq_ZUIMi9rL80aSOhsakaYAYIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270124

Introduce a local struct device pointer in functions that reference
&spi->dev for device-managed resource calls and device property reads,
improving code readability.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adrf6780.c | 35 ++++++++++++++++----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index a7a21f929970..1899995f7b20 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -426,18 +426,18 @@ static int adrf6780_init(struct adrf6780_state *st)
 
 static void adrf6780_properties_parse(struct adrf6780_state *st)
 {
-	struct spi_device *spi = st->spi;
-
-	st->vga_buff_en = device_property_read_bool(&spi->dev, "adi,vga-buff-en");
-	st->lo_buff_en = device_property_read_bool(&spi->dev, "adi,lo-buff-en");
-	st->if_mode_en = device_property_read_bool(&spi->dev, "adi,if-mode-en");
-	st->iq_mode_en = device_property_read_bool(&spi->dev, "adi,iq-mode-en");
-	st->lo_x2_en = device_property_read_bool(&spi->dev, "adi,lo-x2-en");
-	st->lo_ppf_en = device_property_read_bool(&spi->dev, "adi,lo-ppf-en");
-	st->lo_en = device_property_read_bool(&spi->dev, "adi,lo-en");
-	st->uc_bias_en = device_property_read_bool(&spi->dev, "adi,uc-bias-en");
-	st->lo_sideband = device_property_read_bool(&spi->dev, "adi,lo-sideband");
-	st->vdet_out_en = device_property_read_bool(&spi->dev, "adi,vdet-out-en");
+	struct device *dev = &st->spi->dev;
+
+	st->vga_buff_en = device_property_read_bool(dev, "adi,vga-buff-en");
+	st->lo_buff_en = device_property_read_bool(dev, "adi,lo-buff-en");
+	st->if_mode_en = device_property_read_bool(dev, "adi,if-mode-en");
+	st->iq_mode_en = device_property_read_bool(dev, "adi,iq-mode-en");
+	st->lo_x2_en = device_property_read_bool(dev, "adi,lo-x2-en");
+	st->lo_ppf_en = device_property_read_bool(dev, "adi,lo-ppf-en");
+	st->lo_en = device_property_read_bool(dev, "adi,lo-en");
+	st->uc_bias_en = device_property_read_bool(dev, "adi,uc-bias-en");
+	st->lo_sideband = device_property_read_bool(dev, "adi,lo-sideband");
+	st->vdet_out_en = device_property_read_bool(dev, "adi,vdet-out-en");
 }
 
 static void adrf6780_powerdown(void *data)
@@ -450,9 +450,10 @@ static int adrf6780_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct adrf6780_state *st;
+	struct device *dev = &spi->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -467,9 +468,9 @@ static int adrf6780_probe(struct spi_device *spi)
 
 	adrf6780_properties_parse(st);
 
-	st->clkin = devm_clk_get_enabled(&spi->dev, "lo_in");
+	st->clkin = devm_clk_get_enabled(dev, "lo_in");
 	if (IS_ERR(st->clkin))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+		return dev_err_probe(dev, PTR_ERR(st->clkin),
 				     "failed to get the LO input clock\n");
 
 	mutex_init(&st->lock);
@@ -478,11 +479,11 @@ static int adrf6780_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&spi->dev, adrf6780_powerdown, st);
+	ret = devm_add_action_or_reset(dev, adrf6780_powerdown, st);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id adrf6780_id[] = {
-- 
2.43.0

