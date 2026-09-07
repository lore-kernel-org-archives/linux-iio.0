Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A2313E36;
	Mon,  7 Sep 2026 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776389; cv=none; b=hI4RGpMjxsGLz6pEaE/gT7GMywu+qPFEfpoFNh5M1GtZXLi0B0iiKjVvfWOORqpJRgrlUME9aKLx9P7coN6bGMU7neYFdl1K4SjHO3AzXmvrXSqnvINOz39lnxX4yl7k2UfThGyeQ1crJ7PK1mv1SvsZdxRf5w5/kwYq3qiXKrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776389; c=relaxed/simple;
	bh=cTnwrrvK5JAGq2MG516JvcJZf63g91S6Ujah1NaYmbc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K56Sd/PxbaxLt/HJc1S+UB9NvBTDZsGaExlSKUGRXTcmIlbUco449xcrXk9LChLTeNiuJ+sav+IBwwc/bvd4NiNI0yGgA7XPsr7K0EBkLUMlqV2o3uPlMNteeB82nhtKib69CV1b9kZ+9RbWi1U48tYpsmZENt0z+6ZOIrQPWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fUBhBjVP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fUBhBjVP"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6879Ym703717815;
	Mon, 7 Sep 2026 06:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=602vTFFOeIiwC3fb5WyEU3XM+/V
	ScGu2QA5C5arB+Zk=; b=fUBhBjVP88jsRpeEaXa7U8T92OoyiOkNvQR8L4Kr5SW
	5WPjSMBXE+av3I4+Zqq5WUkNTMDvvfnMTt7oSBESqdMHTyhnp/ODl6iUMJdC2ceq
	w54r57J1wxFnVpV8wB0gYbU1X1EimHfJEdMFZNfJWRBTIcH3AtWE0hieNb0IRAGX
	ges3eh8XKfsPFeOPnfY/njBk5xDZh7boKcrD/hWcrt7TN+rIgTjxS64toyR5MM9U
	ct3FzskE5GegLv2qQQBTfrcfI8y5DW8fVcOklVD4wGOM1liEZhkPRXZcej7OE/WZ
	1A5M1pMHNGPRUiP5jhcoyMMeIwF76w4DZJpwKQODtqw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gh4dg4d9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 06:19:35 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 687AJY7a010633
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Sep 2026 06:19:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 7 Sep
 2026 06:19:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 7 Sep 2026 06:19:31 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.185])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 687AI3Dc007412;
	Mon, 7 Sep 2026 06:18:06 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>, Salih Erim
	<salih.erim@amd.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jakub
 Szczudlo <jakubszczudlo40@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 0/4] iio: adc: ade9000: add ADE9430 support
Date: Mon, 7 Sep 2026 13:16:17 +0300
Message-ID: <20260907101623.8730-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: FFA1HDCl5MnmJQDiSZRBvt3f8l6Ar__q
X-Authority-Analysis: v=2.4 cv=f5N4wuyM c=1 sm=1 tr=0 ts=6a9e8fb7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=DGy6LBCQMxw1tD2xdiIA:9
X-Proofpoint-GUID: FFA1HDCl5MnmJQDiSZRBvt3f8l6Ar__q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExMyBTYWx0ZWRfX9W0m7Ydiq9SI
 aj5FiFPkUFM8xfN/D2f82uCxjx74sEyCTTZZCTEv73QkBh+rCQri0gPvotvhzAT5XL0LOLe2T8r
 3dmRFWOexI0PYKsBLDuogyxO8XJi9nKA1uU5Ijz3wpc+x7nrYLVO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExMyBTYWx0ZWRfX5ri1SZ2GjBOG
 /JzgciFBTc7h7NTGiqqeTBD6S12hTiEQ3Qrf8gb4GemvWuR1xqVfIBkw6mKDMRimUJtp0qPz4tX
 xVsbPwR3HTLjQ3zqPBvN94laA46venjZKQiuEVD/ankfKwuwZ7zjJe80aVSBd/9sFknmtyiRo1h
 cOt9x5rp4R4SxReEUgC3nrCyLdy2P9TIV97G9p01YQV7DMQ1jxXOLpfWJUg+FC4Z++3l7u1XFfg
 DB9deGV8pq8jB70+IoDNSJA2Rz1fU8HNzV+e5oZhIfPkYtZb6pKkfNtQoKItRZU3hDk75IFKpUP
 MKVdzwGGXvygpE3zXLAbPicciSUncKLbYf0hejKiovZBMZIUP+BciytHuH4lPRi9/PscyAs2eNP
 hPo/Q41mCb/ityeU/8luhBR9W1DJ0SLamR7nPiwL1+93sd7KfZU80AMKo2jOmdDKKEjDMa/2poe
 QLz68bP3ynlE1BcaqtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070113

The ADE9430 is a polyphase energy metering device from the same family as
the ADE9000. It is register-compatible with the ADE9000 but omits the
on-chip dip/swell detection and has no on-chip digital integrator; it
relies on an external analog integrator for Rogowski coil current sensors.

This series adds ADE9430 support to the existing ade9000 driver, reusing
the dip/swell-less channel table introduced for the ADE9078 and adding a
matching chip_info for the ADE9430 full-scale codes. A has_digital_integrator
flag in chip_info gates the DICOEFF register write so it is skipped on the
ADE9430.

Patch 1 is a standalone fix included with this series because it corrects
the ADE9000 full-scale RMS/PCF codes to the same family-A values the
ADE9430 uses. It carries a Fixes: tag and Cc: stable and can be applied
independently of the rest of the series.

Antoniu Miclaus (4):
  iio: adc: ade9000: fix ADE9000 full-scale RMS and PCF codes
  dt-bindings: iio: adc: adi,ade9000: add adi,ade9430 compatible
  iio: adc: ade9000: add support for ADE9430
  docs: iio: ade9000: document ADE9430 support

 .../bindings/iio/adc/adi,ade9000.yaml         | 22 +++++++-----
 Documentation/iio/ade9000.rst                 | 36 ++++++++++---------
 drivers/iio/adc/Kconfig                       |  1 +
 drivers/iio/adc/ade9000.c                     | 29 +++++++++++++--
 4 files changed, 59 insertions(+), 29 deletions(-)


base-commit: 26bdafb3bdf58436579a1f6f0ef1ddb9011015ea
-- 
2.43.0

