Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AE12DC352;
	Thu, 29 Jan 2026 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700484; cv=none; b=BUs/5euluSjpRapGY3zyt9Xl5hondld6RIP+3tVf0vlc9H6LmjpePbvxX8avos4vdqUbGa6fafBKcosEz2RYw76IZGgDjLFgnKMr99y6d+QKaUyefv4Qg2Q7K+w0gULbshKdpkpE8gvKsEDJcKSeQIyow4oFZlxNl9WZkdWbToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700484; c=relaxed/simple;
	bh=ZEvfNvQ5XDfnRWcle2VDoRQemHO3uCwYW6Ru6pEGvnE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lbkB/rBRvM1tXQD1QK4BT65HxqwuiXQEvBR4xpL3U2A1DnFoncwMFifoHvkB1GGS+pn0pW+hmcVjVYkhmEAvmPelg3j2D5nN4hGvogmu53czQXU6AWzGL8fXKhNSO0ZRV20YMMFQEET/Gi8xoWZp531qp9TCjcxq5qzwSvxpRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KQDCk3tw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KQDCk3tw"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TCG5tT3783159;
	Thu, 29 Jan 2026 10:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=mndA/esQnnQL+aY+KJznk0C9Jq+
	lEE4Wo5+E9neOnSc=; b=KQDCk3twS2WwyNVMBovPHpjYtAkhsJGYhRw6WkW/YDR
	2rSa+TBvRi/nZjhnZpFpmjxcgDR9ylsXmv9qj+fUr0ZLCFrHfpbX5N9VqutJ8NrZ
	6EGlVw4h+9IbG3Fn+f+jtnO0U1Rw3aFsdtmaoW3NMoFnvhVTSmEgVJ6wSgMn4IvT
	Z7XuswUMcWb3gciR+5jF5IoAZOrzOa3dwPGn0c/pNxtmXU25guMn7gt+GGH9M4uG
	TJStVv/1UApnU1VRIB1Mk8gmwZm6rt0fyNRRYHLJ77JeW/oiBdZIWqezm/Fy1YOp
	2vU13z2CE4+xkVJNP4u+SFQSlyfNlSXVJ3eeDNIPjjg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c011bj419-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 10:27:47 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60TFRkvO042233
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 10:27:46 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 10:27:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 10:27:45 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60TFRX1i002992;
	Thu, 29 Jan 2026 10:27:35 -0500
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
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iio: adc: ad4080: add support for AD4880 dual-channel ADC
Date: Thu, 29 Jan 2026 17:27:28 +0200
Message-ID: <20260129152731.154368-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=PvmergM3 c=1 sm=1 tr=0 ts=697b7c73 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=JEplbj-ZQJa3tgTfUoEA:9
X-Proofpoint-GUID: 3M2t6RuQK_FsL9Ilec6IDLCRtqG9QR3Y
X-Proofpoint-ORIG-GUID: 3M2t6RuQK_FsL9Ilec6IDLCRtqG9QR3Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEwNyBTYWx0ZWRfXxOjEcwKHrGkW
 902lt0g8Xiu3AG4yGQDFRrdnqPmUd9To4wnpYGI5E65A39YAPvc+EnkbuWoBdufC9Vm+5hkBBoT
 xFhicQqL0Q7ocJTGyr6g5mOllQriqwzSxAxRII9bt6Z8Bi9ht8T7Yb1yFhRIZEPdDNoAxjn7hoR
 TgBgeKjalHfz8XR052ljAeq/lpXd88weLJxMKlRpILTlu47JS45zO/AOowXxe5pTp+1iZitO5L1
 yPICNG/eZHTSh/tAWWaNur2jXbdGqX7LnHjfNvpwBrm63N+VJZX3egApQVpiANiOARD8wJeDLtY
 5Y+A7qViTHXicei/NdxUNnw4fSCy6AaiSAKerXpGkxjYSPlsvxC4W/baYg+klmAi+baSoHQLQ3H
 D006yz0aRvST2oMdA5uFW3D8Mwosf+r17g/z0uaimrd+KPdZkeFgxfK6cFldwYDWFnsPfeLEAvV
 Fko/FF+C0lr4bSHACcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290107

Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC from
the same family as AD4080.

The AD4880 has two independent ADC channels, each with its own SPI
configuration interface and LVDS data output. The driver uses
spi_new_ancillary_device() for the second channel's SPI and requires
two io-backend instances for the data interfaces.

Driver changes:
  - Extend state structure with arrays for regmaps, backends, and SPI devices
  - Refactor setup into per-channel function
  - Make filter_type, sampling_frequency, and oversampling_ratio per-channel
  - Add update_scan_mode callback for multi-channel buffer handling

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4880.pdf

Antoniu Miclaus (2):
  dt-bindings: iio: adc: ad4080: add AD4880 support
  iio: adc: ad4080: add support for AD4880 dual-channel ADC

 .../bindings/iio/adc/adi,ad4080.yaml          |  49 +++-
 drivers/iio/adc/ad4080.c                      | 236 +++++++++++++-----
 2 files changed, 220 insertions(+), 65 deletions(-)

-- 
2.43.0

