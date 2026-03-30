Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FB23C5DB1;
	Mon, 30 Mar 2026 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869664; cv=none; b=mu/NDSxoJ3ONURPueamxdwWOyQrgv3ml8J6AUMHeSxsrdfhMQtziYC3VtO/wH+WavNP9cr9hNpp74qofNnpE3ZMrDsMoRgv4tdMkv3YNvFW83X0kTpkXcCEv4e8xz0ae8fJPb5qFNOql+F8AsK+1IKmXSUe5kN7uPMe/6lYQWeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869664; c=relaxed/simple;
	bh=WkbsMETcrZbavo/sscetFZr/SEVsZ2wdFx7akWJKLGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndqgDLzHNBSca65mwKIVT9fJhSpPh3kSfvxy4JUtyUwUF7s7+hLekxe43+dAjdb1Edq+N9k7DMADF/9qNEiRkapApWPYgq/HmuC9T2im5nQYgxRdnTmkD2Hf+JpExT0pTss1B37Ewh0K0Ya5eWzgMZinSsR5qIFR2St3JS9gJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HiFpM4Fh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HiFpM4Fh"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAwKOt3973543;
	Mon, 30 Mar 2026 07:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GB4Fg
	9w1FCmgADZmdu4Yv+DTzfZkc3nKNEy5tEV+evQ=; b=HiFpM4Fhc8GurisLdRvFh
	Yjg8Y6927G6ujQin4RUmXuQqylwyC0kpeL2/CEJ5zZSwpTq6V/TCZdH26WmNDkFg
	41m45xCF3DZ/Wxi+GExX841or7zlFpZ6jWeHgpWqeuYiDi3cLLZvJHkINAceY+Dr
	xOCaY0adddNPj3rZHBc+Gb9DPPdNtWeREEC+Bldc78BYL02U1/hP6MWIwtey3AAm
	mjZCHg3Ow7A5DS5WYATGz0Beue2mIZ8UJ0RIy/zkBZsWvG2kXNdjFViB54use5P0
	VcLlnoK6wb3u8M6TlkbmcDuzvvQwcJ4v788jrKk0t6IUCNkRKFTGcL5i5UVbTtHD
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d7gkv9kep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 07:20:37 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62UBKawt026888
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 07:20:36 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 07:20:35 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 07:20:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 07:20:35 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62UBKDgX014225;
	Mon, 30 Mar 2026 07:20:27 -0400
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
Subject: [PATCH 04/13] iio: adc: ad7793: add dev variable
Date: Mon, 30 Mar 2026 14:18:47 +0300
Message-ID: <20260330111856.121589-5-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: TVaIwo2K4-MpBCkMZxkh4qpwquv_tuNV
X-Proofpoint-ORIG-GUID: TVaIwo2K4-MpBCkMZxkh4qpwquv_tuNV
X-Authority-Analysis: v=2.4 cv=TeqbdBQh c=1 sm=1 tr=0 ts=69ca5c85 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=ZpqOwzHjV6la0-d30qEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfXz2oQz3FEIKFc
 GQA8F5W4XrLPgSY2rY90bM5rA0ePd6UifxiJSpSbIcfSZeEAC2ZLmGexUkMs/A9B4D15R4B60NZ
 fJDSWs5k8/JH7xH7laN+Am+n+Jz6NTVq5BZKK/jywcavP09MLxHHAHgDaLk7IkGiJq+ETGpEUoZ
 84ynpnBZbMVzgPy6z3rtsCrG1ierr/+wj59eym1Dg9dPzRHUuVSSWfa5/rCg9ON0PweJjNQkKs6
 YLdX3e3vuhI6PggHFT+c93NsiQFghTp+7BeR8eXE3yxjpHtZfiwNKC7kia/8e/UQhEMwX9VfHq2
 rSTn6E4cByAQoIs1qtIzFhXqUcYT/+UhrvQUnb/jWfPunxJG88l1VX/h0sDmWm3/ZhA8W5gk4F3
 WSsmnAITJBkDYFASMeX2mX3OAoI92cpyWyNLCgsVDMxDc8H7ekAmCyxWRwM9m767Cy9+Fb0X8ib
 WlovR+WifxetsiZ+66A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300089

Add a local struct device pointer to simplify repeated &spi->dev
dereferences throughout the probe function.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7793.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 8ff7b70d6632..21c667e37b31 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -774,7 +774,8 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 
 static int ad7793_probe(struct spi_device *spi)
 {
-	const struct ad7793_platform_data *pdata = dev_get_platdata(&spi->dev);
+	struct device *dev = &spi->dev;
+	const struct ad7793_platform_data *pdata = dev_get_platdata(dev);
 	struct ad7793_state *st;
 	struct iio_dev *indio_dev;
 	int ret, vref_mv = 0;
@@ -789,7 +790,7 @@ static int ad7793_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -798,7 +799,7 @@ static int ad7793_probe(struct spi_device *spi)
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7793_sigma_delta_info);
 
 	if (pdata->refsel != AD7793_REFSEL_INTERNAL) {
-		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "refin");
+		ret = devm_regulator_get_enable_read_voltage(dev, "refin");
 		if (ret < 0)
 			return ret;
 
@@ -816,7 +817,7 @@ static int ad7793_probe(struct spi_device *spi)
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->info = st->chip_info->iio_info;
 
-	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
+	ret = devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);
 	if (ret)
 		return ret;
 
@@ -824,7 +825,7 @@ static int ad7793_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id ad7793_id[] = {
-- 
2.43.0

