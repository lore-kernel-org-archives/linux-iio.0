Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0C927C866;
	Fri, 20 Feb 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593557; cv=none; b=WIZJhoCCrmq3ctlSwcuvodULvqaPs8YFTMnhlkIEXrTsa5jfmyOmKfn5wds3lDAX2xmlYpp+6KjYGVl/3EEy3ydyxl5Cz4vmFpkxmG4/IQMQTHeMyCaGzPTojpJaFoKSqqm9yOqIDHVrVoA8iNWpfVqsn0oa+ZJOUPNvUWFoptM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593557; c=relaxed/simple;
	bh=PBQdTbPUilGriztUj/CWgGx5Pr0RX6yItAXHE0CzA6A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jcBF7SdumbAhUWlntXBeLlM0lyThJTpJyqYD9bftnOvvug75gKCpScIBn0eWozZ2QxQYeIMZsdmrf8oHQVdCVmOggGjn1ay+kxCVc7oMIMyAameta1mqOL3OKXv75usAOTfTOt8xcQKqyNzxCADT/kFGT6g9KOeZdaDS+oMDmhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xQeNqNGV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xQeNqNGV"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K87HBc3823415;
	Fri, 20 Feb 2026 08:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=HJ2rVYad0giDH06r+Q9F6W0A5BU
	HSa9+WQ/jLVG99Nk=; b=xQeNqNGVl6KBG6rHyocmcuYXcLd65/sQXJqUqvvkss9
	qFg4yRLvCY3mL0R9iB8Q9nuRfRjmwBtRL/J2sof/a66GIa2zW7HOGFL2xZ6Krknh
	Sczh5RK2x2hzKNLSHKyk2arHHmzJaW5R8qpqEax2pSFEOW413wUqBpSfHGH1t/kz
	SatOWJb9catGn5ZVMJtMiVjHfwQeaaca7M4LB4m7rHjstmMNi0VzrW3jmrPH8x6X
	znmEQoXAqqrWaX2x2G9FXOxvxeVXI0IHIsdpWI3/CPflf28HhU6dDUEaOTQARKr3
	hbpWrj0qlGJDl1Z2vjvR714LzxqUUxQOxSxySFeSqhA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ce0xvw19w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 08:19:00 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61KDIxRb000425
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 08:18:59 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 20 Feb 2026 08:18:59 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 20 Feb 2026 08:18:59 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 08:18:59 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61KDInCv009733;
	Fri, 20 Feb 2026 08:18:51 -0500
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
        Cosmin Tanislav
	<cosmin.tanislav@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/2] iio: simplify return statements
Date: Fri, 20 Feb 2026 15:18:45 +0200
Message-ID: <20260220131847.76968-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=AeK83nXG c=1 sm=1 tr=0 ts=69985f44 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=lom_e-6ZNwTbpAR4UMUA:9
X-Proofpoint-ORIG-GUID: gj5Oq0Uo8k17fAvcN8Ozz3C61a2A0lqh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDExNiBTYWx0ZWRfX171F8lgoPV8H
 XHzvDZKmRoDKSYaWsHIy+r5sWEdeSEraToYi6zxZiEzmKdpbL3C85FrAoct6M3Jtb+b/eVs89xT
 2nhHwNM3SlgJaYvW04cKwr6DfVM5Orl6KKlyvZNA8FnSlVb7bPGXlzqWKS0H1REt8mbX25sIcgv
 fNAAryufhQ7AdUjpcVWiJa/szADxFDnm7iNetaZ7Ni2uSUp8OlkUTuje0Am0A/TDY+Mlq1CF/5B
 zJdAkBTZfN7Zeh6c+Tea3GYKcebxgNbWXIkhZ4WKrtW8WGqx1Gd8uuO0d27eBLs95N8tlxB8uLV
 l1P2bLqn0BGjKOxPtEGPykjHwumKv4tkGN3PCXNP4DFtBAEkAUtk8lnHqvY1YIdaVwaTdL2s0np
 Z8axgDhnPUe3ThjNc8LPmLm2XTBvj4YF8aW/lwGsWslK26KfBN+5lM1/YxCfC7Yi3gU9Tf+Q1aC
 dtEKUFKVb2sCWGus8PQ==
X-Proofpoint-GUID: gj5Oq0Uo8k17fAvcN8Ozz3C61a2A0lqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200116

Minor cleanups across two IIO drivers to simplify return paths by
removing unnecessary intermediate variable assignments before returning
error codes.

Antoniu Miclaus (2):
  iio: adc: ad7266: simplify error return
  iio: addac: ad74413r: simplify timeout return

 drivers/iio/adc/ad7266.c     | 6 ++----
 drivers/iio/addac/ad74413r.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

-- 
2.43.0

