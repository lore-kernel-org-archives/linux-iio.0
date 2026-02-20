Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118A313281;
	Fri, 20 Feb 2026 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594591; cv=none; b=bbXtITJlDlpdGzACYk687lIB7NnSHmyxkPpXUDk40ZJxCijyOaGfHxAMbyDotlg4HSyQEMzVvTcBJOpphIerG2bs1TULYTuGH7/DJTHXjQEkjgnGADJlGmuPVDm/syCfgW87JhTXqO3YC9flqe/a7UM5tGbLn+9ZQ8WPZPcJAQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594591; c=relaxed/simple;
	bh=tvjTSm5uq0phtm17U41US3qFniV4o0D2UMNWuGab85s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ozU05RQHdKQ2FE3WSMdGVju5L24lFc30xraxmq8IIJ+/m92WBReMReKls/IP9j66k2y99Y9hfLNx3+DzrqMzw+EPDYc+3WVxCstzK5eJAEyV3fDkS5pLusXysRWsKtEXGRa0OJs/5G9yLbidB6qXgJt26en20/+8J7Q7Mr+Q+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eEAZhFxa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eEAZhFxa"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K87J9L631937;
	Fri, 20 Feb 2026 08:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=GDV6eVr9yc7gtIK8NHtJXDs0sb1
	vbv8Aoz24IzbB0tk=; b=eEAZhFxaRyWxYGOv9lXTdEj/MJT0KfrHz/VHHPhO78P
	Ebs5wDPA9zZa2KuoSKLugZulIaLMMgqhh1DDL98EtzvBJWzD9fhDqH8hLtbpPhOi
	UiiuxS1DlvaRJci3F7RCNY4xtCaFH5GIIN9T4N5bWFo0aC1daBDhsZvTx7LI7BXd
	Gn+9N70Ghm3mwEOOMvYS7G4bUN8pnXmTtv7zRrjRpztgV+zSBoqA7ebwmxV2heeS
	7FY6xIs8fn6EynTpdjirQ+56J4ICebSWfJ21xI1cZPcWVIYbIACoKHkBhxQL2ye5
	jEhZlI7Jg5ptFhJ5JdV2dCrn+uGmSRiAPAmbbBhWKEg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ced6fa9rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 08:36:15 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61KDaEJr002400
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 08:36:14 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 20 Feb 2026 08:36:14 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 20 Feb 2026 08:36:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 08:36:14 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61KDa2Q2010396;
	Fri, 20 Feb 2026 08:36:04 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] iio: remove redundant else after return
Date: Fri, 20 Feb 2026 15:33:29 +0200
Message-ID: <20260220133337.85216-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: 6lQuvpHZ6AmzXFP1OYvNY829H-rLC5cG
X-Authority-Analysis: v=2.4 cv=fPg0HJae c=1 sm=1 tr=0 ts=6998634f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=OBryuAIN34OxiQJIbK4A:9
X-Proofpoint-GUID: 6lQuvpHZ6AmzXFP1OYvNY829H-rLC5cG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDExOCBTYWx0ZWRfX89RWmYvRIIEn
 872/dpvowxL7G76XBKhSGMXrxPJmp4SceArNUqtfrwvTC4erk7DfA4PjdjAVX8lVEktDFMD00mh
 U6Y1F2IdeAFHpsVrjclPPtTWoCzT1zeRrFV/TqqDmAx2QrzWPf0QP3LWx53YOVnNrV2DReC7CcN
 CBC/4HiF8paAGs94bKOgQSH4HJFWTGfNWAtVVXWz76VRz8+PWFjwPXGF8gxN3uRRUaIUv+qzON3
 MA51997h90xgNIhOdKmkyltgEiKQqHKy+J/OIHoyvabesxXcYsGs0bF/LlNrbIGQjq/KnjXJZvs
 yLJqC0A3mcXnBM+6hpiUymgFmgJAue30Lj2jqCREBs1WL/eDaMbiuyETj/L6fXxKUBhqZ7CRxhu
 zGuRBGvl56Ysq+mXCzRHLeQdD2uCWygbG/woYYtISNeuJmo4X88tFTITf0Ajx+RaKCfZ2RQBf6S
 hrmglEeRjmVs4GaGa9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200118

Remove redundant else branches after return statements across several
IIO drivers (ad7298, ad7606, ad5592r, ad5758, admv8818) to simplify
control flow.

Antoniu Miclaus (5):
  iio: adc: ad7298: remove redundant else after return
  iio: adc: ad7606: remove redundant else after return
  iio: dac: ad5592r-base: remove redundant else after return
  iio: dac: ad5758: remove redundant else after return
  iio: filter: admv8818: remove redundant else after return

 drivers/iio/adc/ad7298.c       | 4 ++--
 drivers/iio/adc/ad7606.c       | 4 ++--
 drivers/iio/dac/ad5592r-base.c | 4 ++--
 drivers/iio/dac/ad5758.c       | 6 +++---
 drivers/iio/filter/admv8818.c  | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.43.0

