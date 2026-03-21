Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C82F305E1F;
	Sat, 21 Mar 2026 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774087717; cv=none; b=BU9qlMP28fsxehXn7fpfUjbLn86iwxwAVmGp5gQ4RPNrXqU7cJ+ipLCem34ha4FQEMXivIOQgdt2jphgj6i/4W0gsuhan+ZyTHTEekEFQhYkRInsku3iuBY/TSt9dl/hg1Q8E22mMX5wbjiyKTIj2gWg94er/C20XN3OcGv9K8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774087717; c=relaxed/simple;
	bh=U56G/S7RD0hC0Tc2ONYdEM6wDYsPi3ceepnfjU7iZLA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KeGd/hGQctWO7NCFa84dXSHQA484bk2sB6zdP+0POuxX/AqBp/3RHjPPNPz58V1UQg/daXx9Hui82hJCanqterh09QzhsNlOFl4g6sVJRPNUK2+J21FRnacnQxPVcY2hyX8AYfYm4ssyc8JhptOjKQjdbaneP5ilIUNxDr03V/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=h5faJUX8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="h5faJUX8"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L4qUEh3520946;
	Sat, 21 Mar 2026 06:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=RqwAmiIuO+rRl/XzC9U1mqmb3NA
	AtgWzH6at+f2JoMA=; b=h5faJUX8ouwqgfy3bps0/k082AoTT1sDrnHP6fpzY9C
	i0TZ7OXMFqEQu1P9HuJe00GCTesk7nvy5qLo8wCNJHPIPuzFOs3L19Cg8YfoKL4F
	N5A7QttOXISetjXgon2IvMkbjCq017hcSmnbQgyzqlRvN/9MqV/hZW4FbyUNiLNP
	wOb63oi2d/LiUZXdVNguhqkMdbFSYxhcjGQHk/ye0UfCwUFRv8ylzEjhXtpO6JKe
	bVoa0uoq7+lF69x636F9oKL6S0FP6loksyiCDKu3rOxLRSdrAAPA57a9z5uPe2yA
	qvzL6WbL0uiq3aDnqk+dlaEKVBKg0cdo4cJDgTLd5Hw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cyx8m4sta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 06:08:12 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62LA8BeK041631
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 21 Mar 2026 06:08:11 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 21 Mar 2026 06:08:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 21 Mar 2026 06:08:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 21 Mar 2026 06:08:09 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.226.156])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62LA7nOI016475;
	Sat, 21 Mar 2026 06:07:52 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        Jorge Marques
	<jorge.marques@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/4] iio: accel: adxl372: add ADXL371 support
Date: Sat, 21 Mar 2026 12:04:55 +0200
Message-ID: <20260321100729.2440-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: bNckD5QO1ZuWjGpQEseFpNwuX3lQYzRx
X-Proofpoint-GUID: bNckD5QO1ZuWjGpQEseFpNwuX3lQYzRx
X-Authority-Analysis: v=2.4 cv=WfoBqkhX c=1 sm=1 tr=0 ts=69be6e0c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=A7jdoa9-WqX8bloHAjoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4MiBTYWx0ZWRfXwjsH++uZDR1o
 Om1mHNesbfX2+opESATcS6Y3NzhueGXuvUHr//FKmNKC62OPUgDgF/qiWiOJBFSnAsbSUSI/pfZ
 HUE99lbt4021cAXijh+K7zfSzRjeDmxdGRELBugSkRgy5Os0tj/QMLXkWiuMYyejAkTEJ8AQuOr
 vFBxrJzLFv9fWxsn3BKul5l64j1PMOSr20mdbMIxG3ehk/LSL6Uvm2CjmSGAPNoYWC3ReTlRVOG
 qyfdWMQ0TyowEe+7dP8VwaujPgmuwObYtTxG0UIQs55C1ItESF8SQe4HMK1ARvHxkr6CpZJIbu0
 XzpsQQ+t99LOFoTkzW0CLNTsNGsgT9rs6KW/d88FdeLJ+DvWVAS6TuRUactyZ9hN1aJvVchwgko
 xD0NAU2DOfAi/1gcFecsLuIsk20/fJF1GRkwRSAEMREoftXaIsHKg5vVdC4cJS9uWiJOgcsv+rQ
 7+ZdKXr6xt3Y6+Lytiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603210082

Add support for the Analog Devices ADXL371 3-axis, +-200g MEMS
accelerometer to the existing ADXL372 IIO driver. The ADXL371 shares
the same register map as the ADXL372 but differs in ODR/bandwidth
values, timer scale factors, and has a known silicon anomaly (er001)
that prevents reliable FIFO operation.

Changes in v4:
 - [Patch 1/4] Reformat info_mask_shared_by_type to use consistent
   multi-line style matching info_mask_shared_by_type_available.
 - [Patch 1/4] Drop trailing comma from ADXL372_ODR_NUM enum
   terminator.
 - [Patch 1/4] Drop redundant NULL checks for chip_info in SPI/I2C
   probe functions since match data is always provided.
 - [Patch 3/4] Use 'if (ret)' instead of 'if (ret < 0)' for
   devm_iio_trigger_register() and devm_iio_triggered_buffer_setup_ext()
   return checks in adxl372_buffer_setup().
 - [Patch 4/4] Drop trailing comma from ADXL371_ODR_NUM enum
   terminator.

Antoniu Miclaus (4):
  iio: accel: adxl372: introduce chip_info structure
  dt-bindings: iio: accel: adi,adxl372: add ADXL371 compatible
  iio: accel: adxl372: factor out buffer and trigger setup
  iio: accel: adxl372: add support for ADXL371

 .../bindings/iio/accel/adi,adxl372.yaml       |   9 +-
 MAINTAINERS                                   |   5 +-
 drivers/iio/accel/Kconfig                     |  12 +-
 drivers/iio/accel/adxl372.c                   | 300 +++++++++++-------
 drivers/iio/accel/adxl372.h                   |  20 +-
 drivers/iio/accel/adxl372_i2c.c               |  17 +-
 drivers/iio/accel/adxl372_spi.c               |  17 +-
 7 files changed, 244 insertions(+), 136 deletions(-)

-- 
2.43.0

