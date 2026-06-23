Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6CF2DA76A;
	Tue, 23 Jun 2026 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205680; cv=none; b=prFwrTni3gtrG9lsdOwTKmcZuc9OlKmSmV0nVWranXcCmjY3cHCLgwFErFZuW+Ytg2LfTK0v14312dSiKwxCGZ0utghFNmgQ5f28uaZ8bwQJ2CEWe5LpX18Fzuk1WKiOU0RtqkPNsGMKBIPcrTwb3m6YXTm2RrIqbDXUH+Re0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205680; c=relaxed/simple;
	bh=SMWU56ofmrT8LZe5wuwhZpHsecJhfSuiDSzo5XMLJn4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PvZCYVqN7Desn4gEJoahxlEK9A461quQQzw6aHjaUEwmFG3MSsFMivP/4KPZU2US2DnX+OsXws5EAevnzHTdve4vFWHLTL9ikgbR3hke91l7MPIpQXQDsXYTKd/gAsItafli5D2QjMudh5wmZ7Z8GmXTgizyrW8XffxEzpM3cLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qibV02mq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qibV02mq"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6jYPQ2205666;
	Tue, 23 Jun 2026 05:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=SQTuTqu9PHV2mo2y0EFFQtQS5cF
	4sG3BiIPAeRdG3KQ=; b=qibV02mq1cU6qQmtWvrL3iiSPYLYKOCYjtq3B/SajZB
	Dsb1GRqeH4JmvJ2kQSMVBRGs3heNMsa2Ety5vIUoBF/DjW8N3Q8iuzrry+DlxbWJ
	M4GaOKDHxdZOSyKgywWYDF7Q9wNAHOmjPlMygE5YzFo4xzdEj7/NZbXDtzPOMsAG
	tsUnnLGA6A+FnkHfXqf0EXO41Qslk41xiYQekjyliR8n9+RlUgL271aj2x3gu8lN
	EwKaQZExXAN+SQ6wz1Bi5lEKdq8nLxBGNKzA2OEKj+8mIE5ZUM0Nhx5XRH4vjoSX
	sHkkE+ARlmtkOwyg98tivLwv8My+RNArQfG5qb7WanQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4eyhsu9jp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 05:07:56 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65N97sRi030612
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jun 2026 05:07:54 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 23 Jun 2026 05:07:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 23 Jun 2026 05:07:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 23 Jun 2026 05:07:54 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65N97Yor008608;
	Tue, 23 Jun 2026 05:07:38 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iio: adc: ad4080: add backend data size configuration
Date: Tue, 23 Jun 2026 12:07:15 +0300
Message-ID: <20260623090717.3296-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MyBTYWx0ZWRfX3dYz0NEwa59m
 7pAsTx76ZezjCOj2oTIr+pvHAToiAFTjjsDIpq/ejZhgZDzw5/8bsfiiMIh7UAYamR67eCrjIha
 QeooJbXc6hHjEAQT6kvsV6o4/q71hlJHb92UjuvZoK8GQ5lAqF6c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MyBTYWx0ZWRfX2FFHaYU2lW+M
 tUwg4kJ7kP+BQEb61/8ejRKNZeiqESl0OJexXBYzBpM39UmNkR7qjoJfr7OFuGt2/ITjNsFJNF0
 Q/qmxec+1fgM+xwcSlCZTdPCOfte//GTWVF0MEumLnMd/ur//nqMuyWgDjHjzXor01VfZIg8wOX
 U6q71PBD4Le0P8Oaba/1iYNfURNm5LyT40VyfL0c3Up0vM2YKdOcg3dPeHIutrrXaNi7evw1myH
 vGEUq2h+th0jPDzIm8Gug0XY9+XAeTsrasTlLAZ2waBUTHM3FVlhFObb6JloUQRR9tGnUkh0MNb
 YuhmdlifmyYRYhsEnICi0jM2rYxZuZ/gEwmZJDuWnASQFbzjqlGk4+p0GNtTnwX/H1J0qwdcogk
 Ww/xN6VswoKxaFN3xsHqC/AvFk1Yra6iVoxFH+6Tl/0Kdru43L710CPtndD2n9nJ3CDYYy4exQM
 wne3blMgm+1b19UZ4rQ==
X-Proofpoint-ORIG-GUID: bRCSUNO4YiOm_UCsDiEInJtlMMyeMIVA
X-Authority-Analysis: v=2.4 cv=JPgLdcKb c=1 sm=1 tr=0 ts=6a3a4cec cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=wI1k2SEZAAAA:8 a=Mtvq1wGsQdfWT3MW8gAA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-GUID: bRCSUNO4YiOm_UCsDiEInJtlMMyeMIVA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230073

The AD408X AXI core can pack sample data on the bus using different word
widths (20-bit, 16-bit and 14-bit), selected through the packet format
field of the CNTRL_3 register. Until now this was left at its default,
which only matched the AD4080 20-bit resolution.

This series exposes the packet format through a new data_size_set backend
operation and has the ad4080 driver program it during channel setup based
on the channel resolution, so the bus packing always matches the device
realbits.

Patch 1 adds the data_size_set operation to the adi-axi-adc backend.
Patch 2 calls iio_backend_data_size_set() from the ad4080 channel setup.

Link: https://analogdevicesinc.github.io/hdl/library/axi_ad408x/index.html

Antoniu Miclaus (2):
  iio: adc: adi-axi-adc: add data size support for AD408X backend
  iio: adc: ad4080: configure backend data size

 drivers/iio/adc/ad4080.c      |  5 +++++
 drivers/iio/adc/adi-axi-adc.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

-- 
2.43.0

