Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD2B3C5DA0;
	Mon, 30 Mar 2026 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869663; cv=none; b=YrWDaJBOY8/cf50mcYwracf+THkJ1vNwqsmxqu5hgGFKp2GT25ygtQkmb0ZBHVLdHrD638I+CidwAYV1KjLiEsCdgJx6shUdqgqxacrzC+gQ2wMNnv2dYKvfQrYYQFUhrX8ad9cet45ONMwV+YpANZrgvrSVgYMGTExErKElIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869663; c=relaxed/simple;
	bh=m9B+u6RfIIHkXUE4GM+Y1kUNK5pZSHQWBcWQ3QVqvQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7Pugwh/KzbNse+acyQdkiFA9bojpi75BbQKaYS8Q44iO6I7deUlYj9SOJp767agQGE62U/vaoCoMPqoeES6qmheofdfd3q2qHO2sdpXC3PAQ1/w6mtlZMCx7uMzkehEmlcBazj5L0DPEy5Z+UpVcGPcRDhkMbS+ORu+xnfF3TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=D7x5vAji; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="D7x5vAji"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UB0SLQ1037170;
	Mon, 30 Mar 2026 07:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VH3Yb
	MevbBgekDyPQ32AoddQYfOLus4euxdyGF8Iwnw=; b=D7x5vAjizEPwBh3oEZ6ky
	VfBdAsh5TWFGdvO3S7nGWfK2YytVTHzFLqfjHEC5tvA4b6Bx6vst4mfPb9UbwE0d
	esNp49COOCTJt3RPHE63h+ulCuD0lH+aPtuf/4F0jwCr8yP7nIujT/yl6qpNLLbi
	t5DEFyp94mL1IdZ5u57RUh57cHSN4XrUrKRd5UZ0C+FL/F/oBGHLnp6AF/7npRvA
	3KWEqw25x6sVCGqS7gjvwRvEATbynpB2svj77KcoYHp5RlojJgbdD30Z77jJsUdH
	BbUlzdVWJyNCbXTg+JwRdq1xhg9vzsaaTU9tEaE3AP+G57IwKmEmEtImQPhZ8AX4
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d740ybbte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 07:20:38 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62UBKbiX026897
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 07:20:37 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 07:20:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 07:20:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 07:20:37 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62UBKDgZ014225;
	Mon, 30 Mar 2026 07:20:31 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jorge Marques <jorge.marques@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 06/13] iio: adc: ad7292: add dev variable
Date: Mon, 30 Mar 2026 14:18:49 +0300
Message-ID: <20260330111856.121589-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330111856.121589-1-antoniu.miclaus@analog.com>
References: <20260330111856.121589-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ANnNY0ku c=1 sm=1 tr=0 ts=69ca5c86 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=ZS_pxjKD1y5eJwAqsaYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfX3SL6luomgifD
 X6cnRRc2QIWq+a8EHAMScDxVsaALXBThaiBugRzbjDCQNNyNItqaaO2G2HGkftOGM1ozCzbA24K
 iejtJzlkmDAwLFx0q2RWa5547sXwUZSHSZcczDEtPYl+Egi52QjptXf9hBKPS/d3NJySjZj0H+B
 84ZtyGVkFU93G8IfW25VK++Gnr3hr05BufeRVP3ZD2OSZZfXr3E6GH8BrLDL+1j1zfof93IqPc8
 AhRFW6yL5IrJh3Cku93W4rixv/9YZQOVDgDjbWmrcUu0+wuUchcaJTn7l3e8qsUZMmi59r0Lnow
 58r5qvKvC4xFkKFw9dXMWlLCcJeyJMBlFuO5eAqIMAGm0aTrIg2Q1bhekCpPksTvPiEoTxhJkvB
 iBO2DJcXAU2lsSIFb7FqPC/D6rIm+wor+IS4SxunYikMLbw3wb/lDtZhVv7lID08InA2RYQh3K8
 FQKcasmn9yeJU2kir5A==
X-Proofpoint-ORIG-GUID: mGN0Ezv4gNwaSVF_LFbF9apnodlrdZmm
X-Proofpoint-GUID: mGN0Ezv4gNwaSVF_LFbF9apnodlrdZmm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300089

Add a local struct device pointer to simplify repeated &spi->dev
dereferences throughout the probe function.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7292.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
index a398973f313d..64d40b053582 100644
--- a/drivers/iio/adc/ad7292.c
+++ b/drivers/iio/adc/ad7292.c
@@ -253,12 +253,13 @@ static const struct iio_info ad7292_info = {
 
 static int ad7292_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct ad7292_state *st;
 	struct iio_dev *indio_dev;
 	bool diff_channels = false;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -271,7 +272,7 @@ static int ad7292_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
 	if (ret < 0 && ret != -ENODEV)
 		return ret;
 
@@ -281,7 +282,7 @@ static int ad7292_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7292_info;
 
-	device_for_each_child_node_scoped(&spi->dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		diff_channels = fwnode_property_read_bool(child,
 							  "diff-channels");
 		if (diff_channels)
@@ -296,7 +297,7 @@ static int ad7292_probe(struct spi_device *spi)
 		indio_dev->channels = ad7292_channels;
 	}
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id ad7292_id_table[] = {
-- 
2.43.0

