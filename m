Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4DF1C8604;
	Thu,  5 Mar 2026 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710768; cv=none; b=PP90+mKXmFHCULPaP6rgyk4BQLPAgsp766F8p5814UbbH4MXW57kxgsEwbEA1secZy5pBjm6pauWQ3QXn/Y6dMKo5/RFTlweiUD89wTQ4jnUVjetQO4W6w+GXk5cZWxAvslHrc8bZX+VSrVHWOqcBoax5NurgoJqBF4cf74I7e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710768; c=relaxed/simple;
	bh=lOBeofY3Kfyqw7BVexwMxhocdeLZeNJs+JrrS2i32FU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bUipzZRxv8NGCHvCATqen1wsOKB7xW0oAtPFW06XxNugk2l7am04zsY5qDxHGR/HnegUcezMmcJuMMJ6s+KyOXjHiuwi+S8Styh3Humk412LvtpfNhJMEzU3J9ZGrZj+FWScocKIRJ0l3kA3TORd0pbqERoNaI7pdD4sQY0C3mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CEiwOk8e; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CEiwOk8e"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6259rkuF2756375;
	Thu, 5 Mar 2026 06:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Vj86U4DIqMY/b7VcSqEq67Ib3WE
	RR6rH26UprYrMsOw=; b=CEiwOk8e+p3wK35tJvqw0Zok9zoWUUFWJrfrLx6WQk3
	m35GNfuK8YcgHXOA1Xp92yDUwi7yOYDcDbBHR2jIwkkBfsU2OpZ2iA69zz+MfXP4
	6j+E0u49U7BcnKJLgBxIPq5d15tEJKucO3OqOvLf8nkSnd7xz8dbamxYe7WPTs1W
	PhgxjjhFvbBx6lYWN0iq8JWDshZbOQXWjFI+/d8nxf//THimfxA1AEhEFr1AFSJy
	jb0AQwqF4e8GTtbsyefXfNrGfGBCf8ctMCY+c05UB09LB5pfMEaFGvoLGHyLhjv+
	Ctqn3JYe1ilo128iS6Napq3I/iqq1mut7TP9eqIrMRg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cppt6c2sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 06:39:08 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 625Bd7ap058548
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Mar 2026 06:39:07 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 5 Mar
 2026 06:39:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Mar 2026 06:39:06 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 625BcrWE005601;
	Thu, 5 Mar 2026 06:38:55 -0500
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
Subject: [PATCH v5 0/4] iio: adc: ad4080: add support for AD4880 dual-channel ADC
Date: Thu, 5 Mar 2026 13:37:26 +0200
Message-ID: <20260305113756.47243-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA5NSBTYWx0ZWRfXzmZARLDHJ+BR
 F8BhEoL2EyVF5MiuaXGZ/1oiXhP8TbHnYw+FtfrR8fbQvcqCizk9i3bQnywV1VpbzaZfh1OU0iB
 jHPGOTtd1yK7A41AkSzdrgj/Rr7XnWWf6LXiu7G/nVS58C6ZOb71FT+k1RNEXthrJraUBwSZuKi
 97EpJ0OeRYVTNd9d0kiYdHwXw2nqrOao7nKbXFJqUG8FxUj/Gu1vmS777egsVgrtlq4oDI5qKwM
 PzjIsOhuLs13Sr+NhBSga3+3nCFW/OrUcfzasxH5+SJrKZ9pEsL6IVp6er2NQBwnmcZ9Lvju2Dt
 PILcebegr1kipsNzytbpkAHfud7/6JCxGYWp4+bfULhYZXn7X3c8bXNEu+wkvjECPV88sDSG1fP
 xwWO6giEfl67BObr4r+oMZZBJQivSTQQxMxUIHPR2ILClTwjNtTNnHS/4EhRNCh1ocMeQX47zxh
 XLZCZ2uNEbkBi2v7ncw==
X-Proofpoint-GUID: sqEqxbFpYaGAvEJ9skg6sJ4Hlh6rki6O
X-Authority-Analysis: v=2.4 cv=EKkLElZC c=1 sm=1 tr=0 ts=69a96b5c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=JEplbj-ZQJa3tgTfUoEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sqEqxbFpYaGAvEJ9skg6sJ4Hlh6rki6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050095

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

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4880.pdf

Changes in v5:
  - Drop the SPI patches (already applied)
  - Split the __free(fwnode_handle) cleanup into a separate patch (patch 1)
  - Fix "Get's" -> "Gets" typo in devm_iio_backend_get_by_index()
    kernel-doc (patch 2)
  - Declare loop variables in for-loop initializers (patch 4)
  - Drop redundant num_channels > 1 guard around ancillary device
    setup loop (patch 4)

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

-- 
2.43.0

