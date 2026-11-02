Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621671;
	b=Pg/xBWCgY4iuqzO3Lt2R+Sa4SnB134J/DI1Bvu49O9EqqO7XsvZT0QetezMWNlSFVrtB
	 gQDv74b17PlhG9tF5BzAnUdNtss0mLti6u1+GSWFdgKi3xcqYcrYHCkDdvmSTtxgOHzAg
	 uxXCSHXuEE2TPyibBy6n/weKl5DsQq0R7XIG25IDBmo/SP+2b0/H3PGZsDjJpt+gadNOt
	 ktIUZxHK37ZdlxWUGYawQQQnQTohachHkiT821YfOse8NECaYkqMQhDOSRjdw9Fe+IwMM
	 QBzBgWURLJFSB7QVB8IXNn+K9TbyOCBwW0nxXNdqGSrGgyR+GMxFPm6Rvjd0KlmXLAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621671;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ye1bKcN2eoLGRqYawmbChs46y6GSDAyV4XM1dJ2dKT8=;
	b=JPGBvXR/9TWA/iYJFN3RKD4ov4IhvohV0MhoaprgZRM3GNxK7iFEaZzFLw6rJzhfG6cJ
	 A+8tHSljcu1m9KBKknONTcbxevUrd21jsBX1ZsQTH21qjBQOSpqK9TZwAqBDthjBnO0h/
	 gIYTnYRr0Ecg9nyEsub8Ce9Aesq7tUcJKtU0FmuLUk4Q0i0JZzpvPRu7V1B83yyLHLFK6
	 ckdxfuzLZSZiGYhtPg+eCOnZnnU9rM6z9R0inj9lXjq/D0MLUhQNkAJdW+f44jeIaXUaK
	 7yb2TC2cKcWZSsq+9MgsN05moT5PwDGK3BLVqLPlSWlH7pElIZATSeYiVk9oLhX1Ylw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=UFgwizcj;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=lRFBUwuK;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E14D606A32E;
	Mon,  2 Nov 2026 12:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E14D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=UFgwizcj;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=lRFBUwuK
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CVvq858754;
	Mon, 2 Nov 2026 07:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=ye1bKcN2eoLGRqYa
	wmbChs46y6GSDAyV4XM1dJ2dKT8=; b=UFgwizcja2VrZ1FuEibFFwKkr6mxiM1t
	+k+M1CSURYvxQ0vLegF4viok6FtotczfhiiT25s3Vm7Fa3hn84Us8TpRPPAUci6A
	WqgMNmuFsl6I7oMotNyaAxdlrQcFeW1adLVPwZUvL2Ft4OTlDcxtXfyKT3bP4l3B
	s6Dpj7InyySBgsmEu1OdtjHowZjKxNkCW3KblfY+jm9vUalQ6CPNLYBqwTygYvu6
	mqvAK0FnHLnIPI8hziHIguJ6u2kgOLDjjldI2twCa6rlH4vZ+m+Vx9FxG1CiVVlS
	VzD3p4su0Fcl07wxnrL9QPlAl4ve28nho6Ts4IPfYZ9HttoBLoFOEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ye1bKcN2eoLGRqYawmbChs46y6G
	SDAyV4XM1dJ2dKT8=; b=lRFBUwuK4han0TMyxtPZfkWVkNbKNyYfXJDNVoplsOE
	r4d3VfHlQ4PIm9ylBnVq1poo1IVTUHCRlhfaSOqfbWfvVzopQqVwKd7S8D0yp0VV
	vy9+T1tZua4E1N+xG0coRD9J6Vjyq1c1LDXnYuC6oHsgXhW8c7iDjdkqZUva2bwL
	Odtmmr6AalDgavMQS0A9S3qcYHpE81gLZGmcgVtjjL4taYkx+r0IrCCrbDhdPmbI
	DXvOgfbzL1YTub9VhKRkA0mtgncVcgYV09gnACZbDARNs3M8do3KrXjXIRwYVMLf
	se7QbhUXeDhA2JcUVZ/vRMiRTSqOnAa4EAtyZdZ0Q2g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hp2hmdhd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 07:14:27 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A2CEQHK001890
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Nov 2026 07:14:26 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Nov
 2026 07:14:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Nov 2026 07:14:26 -0500
Received: from HYB-0FPP35J6CsI.ad.analog.com ([10.135.2.44])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A2CEE0D021851;
	Mon, 2 Nov 2026 07:14:17 -0500
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: <jic23@kernel.org>
CC: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dragos
 Bogdan <dragos.bogdan@analog.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Subject: [PATCH 0/2] iio: adc: ad7405: Add ADuM7801/7802/7811/7812 support
Date: Mon, 2 Nov 2026 14:13:50 +0200
Message-ID: <20261102121352.23741-1-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfX+8BORWdC0a/I
 6Cz3KjhJ9alhnafsXihREZqX03JvVdHLW7gGbbCHPE/RKVzoWNFpONhKjAXxTUXCFVSz3qgoz+8
 w8WzCpKgjDpoZJVOjpqXfW9j5H+4Snxy08QVMRlnqewmYe6jXeANucuY+EnJFvNhzt+/xDEtyC+
 M8CE1j2xbDtI/m7D5IaR3ZzJyQLw5vEbh+T6wp6Yh31gt5kTjKCRe5wRzSBTV6EBoI7/XsLyCpI
 /5a3CBKTOdYtxbgSuX6v2CUmt9jH1fvkVvBsPoTHFu108dZ4WMRV9+T8UKYo5F6tc6MDeHzyRP0
 8c1hW902fEVERAqP9kljuND1YLRoEUqLGvuKsNVqoHzULAlPSu/GIdK5nAVeG+NnDVrUnEWg4c6
 5kjjiJF8lYmQmAhqB/TPyrCqte8KHJjgzZ5VZy/mOU1iCdLkFTLEE1b5gAkOseh3tt2gr5Ldhle
 wKLV9Eln7hOy6A0dc4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfX2jbqiX0KB2gA
 ondw3CGddS37n5kB55UIETweCvT3xMNg3BEF4adNkOYjfIGHDVcMj8BVVq7IavehZqMLpNYt3EH
 SguS8lmbrd7jj6Gv1raa1eYg5PZyCmXUwExGwuTkz/ijrKYwRyBf
X-Proofpoint-ORIG-GUID: 7PWreXIQPXtWuaDgIZ2ZyOJlYN3muqD7
X-Proofpoint-GUID: 7PWreXIQPXtWuaDgIZ2ZyOJlYN3muqD7
X-Authority-Analysis: v=2.4 cv=V/roQuni c=1 sm=1 tr=0 ts=6ae87ea3 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=MlxgLFpft0MLDe3TEZUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020048

This series adds support for the ADuM7801, ADuM7802, ADuM7811 and
ADuM7812 isolated second-order sigma-delta modulators to the ad7405
driver.

The parts are compatible with the existing ADuM7701/7702 handling and
differ in input full scale and maximum master clock frequency:
  - ADuM7801/7811: +/-320 mV full scale
  - ADuM7802/7812: +/-64 mV full scale
  - ADuM7801/7802: master clock up to 25 MHz
  - ADuM7811/7812: master clock up to 50 MHz

Pop Ioan Daniel (2):
  dt-bindings: iio: adc: ad7405: Add ADuM7801/7802/7811/7812 support
  iio: adc: ad7405: Add support for ADuM7801/7802/7811/7812

 .../bindings/iio/adc/adi,ad7405.yaml          |  8 +++++++
 drivers/iio/adc/Kconfig                       |  3 ++-
 drivers/iio/adc/ad7405.c                      | 24 +++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)


base-commit: d1425b382b9cc5bd19223fad8ba4a8af3dbe1305
-- 
2.34.1

