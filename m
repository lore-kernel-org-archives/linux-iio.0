Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543A2F3620;
	Mon, 23 Feb 2026 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863779; cv=none; b=qe9CEQtoutmVCFs6GGrQUmvQ2B2yLO8GRXyjBZs2GxHKtieKSKkLizo+uVlGEIlBb/pC5wJOAXnIS7BDzWbEH8WuSvnCmGiBMhyvOkjSwC6lq0x7KWi5kOHrA0+JU9JhSDj4TkzpRCjcRhzRryiiSr5cNs9Vvx65O4BdO2Tncxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863779; c=relaxed/simple;
	bh=Cdaxi19l2TGGr4992XgL6FO46fr0lrMEMsHoFPXvz1w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ddoqUD3w8NJgRjOsIuNqB0wP2qyN+EAWH28gCzEMS83jqSD71h7nmQxWCS5t+cMf2NvC0kr8Yjq+cxe2LxdGRcMi1vFeIg9TxJrKjTix/T6CTDPwgOW+WptXNDfzFEV/rkMwVlfR4RdSSDb5X+fDfePuxc+nSXm5qeKF7fWOfl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gUusct6g; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gUusct6g"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NBpInR3320843;
	Mon, 23 Feb 2026 11:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ac9Kvi9CHa4lgEFGFhZIyprjUM9
	pkhV9WRe+ewKRBnU=; b=gUusct6gn0n1RKTUkt28N4UvlVZ3EXh5zFm36qlRTSX
	jO7215llHyXQjLsNBvgL2M2fkaCxjp7pcxoCTBKYT62pmZLEHUe3UkspzTslrSqX
	akFkCYl3laGHLHCX3eRe8XhkrmiFDWKtYSFaQxa18ty2aSq8GmJXEj8M0uPylSRy
	a04mkCBS1U2HfvxI2krdi5/iDgokd3ELoUWew2xjLm+hgXodxQdiJ4d5GQITQ1Pc
	Vy506tkt8/esOfnQnsdq5s0MxDxl+Kv+k7Erc3wAi+l2/QitIC69xlRI2KuO4K6C
	SflNEp+tUWjv0e6pKptMBmLY0FdeIXv5PXcnNZkiuAQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cf7e1ywdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:22:37 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NGMaeM031798
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 11:22:36 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 11:22:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 11:22:36 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NGMJUb015342;
	Mon, 23 Feb 2026 11:22:21 -0500
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
        Mark Brown <broonie@kernel.org>,
        Sebastian
 Reichel <sebastian.reichel@collabora.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v4 0/5] iio: adc: ad4080: add support for AD4880 dual-channel ADC
Date: Mon, 23 Feb 2026 18:20:59 +0200
Message-ID: <20260223162110.156746-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=WsUm8Nfv c=1 sm=1 tr=0 ts=699c7ecd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=JEplbj-ZQJa3tgTfUoEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kwCogNv7Wfgr9LUrJ-pDWMj7U249_wme
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE0MCBTYWx0ZWRfX7n9/WxYbmUEp
 LeIdbFu4gbYo9nqHHvWwWmcq0XxVTXGUXkecYsUIhjxBdL14YT5CU1Apc5EWSXAbMekzataWKjd
 o6NzoHH0ANOBH4DD2Q1yw2/sRGZKdSR3Ls9J1J35etlpqJweqaxc+1AYUWpetZCM+4loOOORVOU
 Ozwt3Z9fKFYQ4PuSs3O1GEZV64Qx+SmdTuQIUeVEiuBfe2+Yw2FicoCCfUfcdj7DWt2ey3Esvrf
 e/7xxjgVxWWVY3+u8GmumbQs2d4jFB2GMEaNsNYA1tcr+aqded2ZRUrrjK+gi2vgWSsT6S5S1it
 bZMkiHdcV0wdFeBYuJLLY3JbxPaw6Gthg/SqXOSj0kmyCNuhb5+yVyUREW1LsavM1zHgCoy9JD+
 UusrUkWmHOfMrDcIKAUaB0Qhjy4VY9N0Czixzkfz1sCds6lbOjBNQosbrkEwvsoKd7tELDHKAsa
 Zg3H4kD0q1STtQ37oYg==
X-Proofpoint-ORIG-GUID: kwCogNv7Wfgr9LUrJ-pDWMj7U249_wme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230140

Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC from
the same family as AD4080.

The AD4880 has two independent ADC channels, each with its own SPI
configuration interface and LVDS data output. The driver uses
spi_new_ancillary_device() for the second channel's SPI and requires
two io-backend instances for the data interfaces.

This series includes:
  - SPI core fix to allow ancillary devices to share parent's chip selects
  - New devm_spi_new_ancillary_device() managed helper
  - Refactored devm_iio_backend_get_by_index() for multi-channel backend lookup
  - DT bindings update for AD4880
  - Driver support for AD4880

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4880.pdf

Changes in v4:
  - Add Fixes tag for the SPI ancillary CS conflict (patch 1)
  - Collect Acked-by/Reviewed-by tags from Nuno Sá
  - Drop redundant maxItems from io-backends in dt-bindings since
    the items list already constrains the maximum (patch 4)
  - Use spi_get_chipselect() instead of device_property_read_u32_array()
    for ancillary device chip select lookup (patch 5)

Antoniu Miclaus (5):
  spi: allow ancillary devices to share parent's chip selects
  spi: add devm_spi_new_ancillary_device()
  iio: backend: add devm_iio_backend_get_by_index()
  dt-bindings: iio: adc: ad4080: add AD4880 support
  iio: adc: ad4080: add support for AD4880 dual-channel ADC

 .../bindings/iio/adc/adi,ad4080.yaml          |  53 +++-
 drivers/iio/adc/ad4080.c                      | 243 ++++++++++++++----
 drivers/iio/industrialio-backend.c            |  61 +++--
 drivers/spi/spi.c                             |  69 ++++-
 include/linux/iio/backend.h                   |   2 +
 include/linux/spi/spi.h                       |   1 +
 6 files changed, 350 insertions(+), 79 deletions(-)

-- 
2.43.0

