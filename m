Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBED4252A6;
	Mon, 20 Jul 2026 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554895; cv=none; b=ucDdiT0sx65PbQ26iGvrTEPyF/rE/JQmAFQx1GwiDHHiqpeH3kWKqgRLjckhhXvs8jpO0xTJjyx99aUjpiYIjKKqA4i8n2SdJg9THyEww5XNkUMEToVEE41/IgmQht/whEbxny/8Mla2olHVIuGK7rjxn1mi9qOO5bnFYcpOP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554895; c=relaxed/simple;
	bh=TNi6iMC7hSghE6u709s5cowCWZoMXrVRVu8OYEQrc+0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B4Vd8Ba266FetjeCwvqYOt7FhDFdoiJhm71gs0uIlkc0oV9m/bnkIqwqm7GiUxUgCrvHwDlEAJKte0VnHex1q/xEAQfJ2dZvrUbdNe+YJnp16boh0UZX0aB2auH9GcIuXG3ooSY+IVXC3c86N7WZN15quihgakS1e01cLl5jgWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=e5Mjemh1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="e5Mjemh1"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KAxiQg1900816;
	Mon, 20 Jul 2026 09:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=t8hfAjiVA5tppmIOGDqmb5BX+BE
	m+l/0qFeINKxeJ58=; b=e5Mjemh1vpuVQrFUe1hqtTHQJht/oHZYofZc41398Rx
	v0T1NgYKdgiF4893h1P9QeH+NvQnIIzTKwbWbCOrqI409LU4Hp9J1gsvw6wgfBi9
	ksExo89jGhk+PdNvdBWs96YGPjNEXOuBa6TWZOJxeG6bQl2WOPmFduCKdxAyo8+t
	7rMIGDxUxpYDoaA8va/9fD/upWBvXoJSFxpvfyMOtllIYrGxzwDgWLahdgf9m5H0
	DVBsiJnMp7FkH7eVSig3PjwY7DH+7LEZ/e9yZpbFJ70zgsUpV1rpZh0uZB2xl7Gb
	rj3tHC1ye8n982OozD2BRW/ixs28e3tEz0FOnDMw8Gw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fg3axy4mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:41:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66KDfHEu011947
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Jul 2026 09:41:17 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 20 Jul
 2026 09:41:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Jul 2026 09:41:17 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.186])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66KDf5qG018405;
	Mon, 20 Jul 2026 09:41:07 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iio: adc: ad4080: add support for AD4883
Date: Mon, 20 Jul 2026 16:37:05 +0300
Message-ID: <20260720133707.103366-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1MiBTYWx0ZWRfX0K85AB0a62bC
 ZRMvj+EsJjA95JxvD02+Py63IFxMeUxAoJ7LeZF9oRJCnRBGdzBYSgpVETGWFgo6vn3cNxiMtaM
 dSaQbQMYOG0zIqRDVrPMdP6trpoqHb9NMsGyps3LCFavj3U7bx/d4LWo51EaX4IIx9XFcT/XN7U
 SRo6tjSyzkppKb1baDTvxjJ02ebsnPVz0KqHykhDgEX7BHUf0m8CzDNH6RJytIFWRLLzenFH6zV
 i//SkEhwL4Pk3bAfqkDFa+5eezOE298jPYXI9fKFUCP3OsVwnM01LDP0gs9c2TiELwLIKaV6os5
 dyQotlV2fFA/8k+gVqsFf80aZO3qbhr+xNjmsKCdVuWaaZP1Wv4ywU7LZufYUY9Fmd5LolaCArx
 tD4CwYh/lKTn29jA5poWJ/scNZRW/HAn+/8hitWfhrYbsqoBS+FfHPf4iCxTJPE7z90f8sycV91
 gYmry+U4OW9d1UlBEMQ==
X-Authority-Analysis: v=2.4 cv=evjvCIpX c=1 sm=1 tr=0 ts=6a5e257e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=PKhA-qpQWIjb8puGQ6kA:9
X-Proofpoint-GUID: Dqofu-hK3eHE0JkI806_MLttdBzvAwF7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1MiBTYWx0ZWRfXxDxgge6o5PQ+
 nfxdGqAeAsDjQdfhnqHy/AEn+7uQNQUyW7rG1YLR6ShPcEw+pSEVd7Ap0q+EhroSwswhEpKEDLl
 C9pBTnNg2br/nx7H15kbo4s6BKrA1RZVl5Vmesoh7hzyQFcffWxc
X-Proofpoint-ORIG-GUID: Dqofu-hK3eHE0JkI806_MLttdBzvAwF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200152

Add support for the AD4883, a dual-channel, 16-bit, 40 MSPS SAR ADC in
the AD4080 family. Like the AD4880, each of its two independent ADC
channels has its own SPI configuration interface, so the part requires
two chip selects and two io-backends.

The first patch adds the devicetree binding compatible string; the
second adds the driver support (chip ID, channel spec, chip info and
device-table entries).

Antoniu Miclaus (2):
  dt-bindings: iio: adc: ad4080: add AD4883 support
  iio: adc: ad4080: add support for AD4883

 .../bindings/iio/adc/adi,ad4080.yaml           |  2 ++
 drivers/iio/adc/ad4080.c                       | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)


base-commit: 7961435cd21903f761712cdf8fe3ed5ea24ebdc7
-- 
2.43.0

