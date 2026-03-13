Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB740390219;
	Fri, 13 Mar 2026 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403177; cv=none; b=GYcHy92fgbKFohu1etgj4n3ZxYI7yeepjG4GSQ4WK/R7kO5fuX9ICwbL73Eun44ZKo5dnq7yjq5xY2GhwyIoY5VctAIunkNu5QnjagPnpJgA8E0VCDlMi5zQ9lYfGBnYx6yjtEkMTJ77hV2q6YcgqN2NYZ7OpU3GcN1Xfp+goHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403177; c=relaxed/simple;
	bh=PGyPxuopJZxgt0EejqcqK+I9QXRT1wa5M+CP946Rn3c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ldj5fM0IJ0iaPzXeVB7GWcWvYzj9prvfgSymb0IjHec1/tXaGgXduhwnnhLKc3GkS3lHoqKClxFKa7wmHpe0NYQLtAE1S0QiA65N3M//EbspynwWk0rkz1fE8XgKyexrRojBOq8uk2Z9xWGTqpnk1rv8gzU2q5e/iGCmtdu+gJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aLXQu9Ba; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aLXQu9Ba"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DAbrqA2906884;
	Fri, 13 Mar 2026 07:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=UCI9HviS6PhtSY/EinFF03gIHwX
	dL/WcmJm991bS7O4=; b=aLXQu9BaQUfMs3usWMWzLHnw0gALUtotx9cLTiQSsBP
	zCczKhwObaGqJ3CFxznlz8lBymNcdr5jz1ww5AXGIAW5DDFuOIfKuv+41hO+3sbK
	ktELak53wWA3wk7jcgxvsAaPzCp6exSLMBC4nPEbQa6///l5c76zSuIJbXc95xgi
	38pogwKBDCYFeOqWxi3KFB9O8j81pv8GJxsGnK+vnswxec9SfVozNtuXqIWxOx+K
	ZXjpm0wDY0iAK/68zfF7j+cQSb870RE6v+Judo/cFl1sxNn7MsiB+by+IoVUw+Gk
	fJPSruweWwE8N/BiSuK3XmxsCA7vsmpuFtOo3sep3PQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh50y031-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:59:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62DBxHnu017644
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 07:59:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 13 Mar
 2026 07:59:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Mar 2026 07:59:17 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62DBx4a9024568;
	Fri, 13 Mar 2026 07:59:06 -0400
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
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/4] iio: adc: ad4080: add support for AD4880 dual-channel ADC
Date: Fri, 13 Mar 2026 13:58:49 +0200
Message-ID: <20260313115856.87763-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69b3fc17 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=JEplbj-ZQJa3tgTfUoEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 69040B6hWiRIlvv4S47SmxiJfY-nPoaR
X-Proofpoint-GUID: 69040B6hWiRIlvv4S47SmxiJfY-nPoaR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NSBTYWx0ZWRfX4m0ye/lt3kWX
 FTDnqVUWl17oZzH/KO3mgMjLYuXh90nKD6qqrCxoyQGWfUB1O7HNT/VE1j3eGheusqjMLhBj3ZL
 rzsAUISdCsSGUAvG7sIN6eO0ElLK5LwH9IgkWbcNIgYQf/6SMSCiqxS0dQHRkISHcyq1jaf+kxo
 CfXCu15HHjWxI1TD+Oqc/uXctcS43RZz3fc2Ky4Ayzix2uPFqwuSR6+g0fvWuoFUk1Cdxz4veLR
 EwnAbmldNEj559Ha3Ysigm6ZbEKr9AHBPawDpgqXHy91yAD8DC8KX0TzswPkClZShWWFvropJwp
 WvgNgBIwZaPkkkh2d1H2R+f8blAtTW5HFf8ezBkSVP9/W8s7rmd3SQkQQEjm5d0BU+ilUZJIPkZ
 NGvmFbCP2wF9I5MEucRiK52lnRz139enSjS0Jh259mWYiq8+GJmQR6yPQFQwqEeDx2q8dfdqAKx
 rTBP/44UNNwQMufuiZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130095

Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC from
the same family as AD4080.

The AD4880 has two independent ADC channels, each with its own SPI
configuration interface and LVDS data output. The driver uses
spi_new_ancillary_device() for the second channel's SPI and requires
two io-backend instances for the data interfaces.

This series includes:
  - Use __free(fwnode_handle) for automatic cleanup in iio backend
  - Refactored devm_iio_backend_get_by_index() for multi-channel backend lookup
  - DT bindings update for AD4880
  - Driver support for AD4880

This series depends on the SPI ancillary device patches already picked
up in Mark Brown's SPI tree (https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git).
Added base-commit in the cover letter below.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4880.pdf

Changes in v6:
  - Move fwnode_back declaration back to inline position above
    IS_ERR() check (patch 2)
  - Rebase on top of broonie/spi for-next and use --base to declare
    the SPI dependency (cover letter)

Antoniu Miclaus (4):
  iio: backend: use __free(fwnode_handle) for automatic cleanup
  iio: backend: add devm_iio_backend_get_by_index()
  dt-bindings: iio: adc: ad4080: add AD4880 support
  iio: adc: ad4080: add support for AD4880 dual-channel ADC

 .../bindings/iio/adc/adi,ad4080.yaml          |  53 +++-
 drivers/iio/adc/ad4080.c                      | 230 ++++++++++++++----
 drivers/iio/industrialio-backend.c            |  62 +++--
 include/linux/iio/backend.h                   |   2 +
 4 files changed, 278 insertions(+), 69 deletions(-)


base-commit: 2cd3974b9ae59ac731a4792e1608be32621b6e98
--
2.43.0

