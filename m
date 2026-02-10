Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E3531985B;
	Tue, 10 Feb 2026 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742240; cv=none; b=qpkDIOdrPXG53HqXWewFwYyMmlQJJE6SZfZmvOJTXgbM9/r2YO+8DaY3vYxAJdVyVCHyCjtd8lC58lQxtVkNCgBLU2I10dHuNYeFeyjFbE9r7JD6315GDD0ubxPhWWUVrlVejdZ5M89CN1amTl4RcNAc6FvvDsuSPwC7bWQV0gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742240; c=relaxed/simple;
	bh=yeepTlDoWvkDKdGGRfynvPj4vNY66YGV6vmhFiXiQIk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mf4EfIX5eA/GyWGW1xYM3X2UYN8ODyBsNegErLJ3V0NxmxTBQPjyxxiDFWk+1Yf1XBDLFcjgBRnOTgmubA3gHgkWKuZT2YwW9+etC9oBApfXsr8XC76nsWtY721+oWwPXOR0aoawBso3PgNrbTxUGMlt+kcd2yFjQ2zUqkmXIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=f8WSeAts; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="f8WSeAts"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ACLhkb2180263;
	Tue, 10 Feb 2026 11:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=krUSIKmaWPwUzfoiepts3Kiw+ib
	pjFiWl8vdjhvlbMM=; b=f8WSeAts4fzEG/VHgY69JwGzKS8ka8PKNeXzIYqFg9z
	mgjbtihMsXDYZEHs6llmemp4Sh7tsAxqwFbbZzcfeS5xcuhrcEkUV340ewVEI+a6
	oOOUMfjeC1YEZe2BmLg2WwyUn4rD+0tA93DXBhZ1Fw5DheqqxdUy7cHJLfESSNPe
	zPddmXwjMwo5jRaktphzhAVNV+ENMJ9TFAB4eYEP9jf0O93Poz3A6/sUtxDKX0hc
	SD6XHS9ReiaKsTwxxx49GY77R+hMFaXYZdiengpeXQqEi4VRrYpPwGIWyYVUitsC
	QeF+8QXjDzANIcP/KEcnsEw7bn1PtUKRVf3EiMhtnuw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c84m58wma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 11:50:22 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61AGoLLC063299
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Feb 2026 11:50:21 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 10 Feb
 2026 11:50:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 10 Feb 2026 11:50:21 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61AGo8jY028558;
	Tue, 10 Feb 2026 11:50:11 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Dixit Parmar <dixitparmar19@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] iio: magnetometer: tlv493d: remove erroneous shift in X-axis data
Date: Tue, 10 Feb 2026 18:49:50 +0200
Message-ID: <20260210164951.8511-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE0MCBTYWx0ZWRfXygjLmicJbEzh
 Nt3kyE/LDnRkFoJ2KLtdlmM8THeYxhaqF9EpvBMo87teykZEwvwnmP0jO52gGFU6Bw81NKSln5W
 XCgdL4UQ6MSvIdO/w1FLIxnL3OOPBiYi3n4yYSd+geywjr/cxA0PT2tkYcDbm2ncS1j1dfCe9e7
 8uuca2nMl+eUl31eTSnpgq6MP5OsBkuOO02n1n7fzhoDiZCKkqzs0MVtqIK4e+UZK0plbpCete2
 p+JUjBJ9NdHDThbLeZjEomn4qZN88qDvWXhca5thQeEwqzxowx/WaHa1w34Jn469Q1fUbUTvQAt
 jcgwnLrFnaB6MddeJF7kbG4zk4GlEtteo8IpyQKLMcgYrc3BpNBJOI7A6MilPK3v6+D0nesxn3J
 dHMZP6eezJx+6gO/FOPKeCoflizinLGtn5xaBCie8m4XDMMBhl/yZFhKd2T4zsE9nNdw+vlcqe9
 uiS0Se+OlsAhu3SNZ5w==
X-Proofpoint-GUID: f5dIjSHVIeWFY0xXOAIfsfkBQy7etB3m
X-Proofpoint-ORIG-GUID: f5dIjSHVIeWFY0xXOAIfsfkBQy7etB3m
X-Authority-Analysis: v=2.4 cv=Fa86BZ+6 c=1 sm=1 tr=0 ts=698b61ce cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=4v5TOFE3i8q4BdtMRhUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100140

TLV493D_BX2_MAG_X_AXIS_LSB is defined as GENMASK(7, 4). FIELD_GET()
already right-shifts bits [7:4] to [3:0], so the additional >> 4
discards most of the X-axis low nibble. The Y and Z axes correctly
omit this extra shift. Remove it.

Fixes: 106511d280c7 ("iio: magnetometer: add support for Infineon TLV493D 3D Magentic sensor")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/magnetometer/tlv493d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetometer/tlv493d.c
index ec53fd40277b..e5e050af2b74 100644
--- a/drivers/iio/magnetometer/tlv493d.c
+++ b/drivers/iio/magnetometer/tlv493d.c
@@ -171,7 +171,7 @@ static s16 tlv493d_get_channel_data(u8 *b, enum tlv493d_channels ch)
 	switch (ch) {
 	case TLV493D_AXIS_X:
 		val = FIELD_GET(TLV493D_BX_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX]) << 4 |
-		      FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4;
+		      FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]);
 		break;
 	case TLV493D_AXIS_Y:
 		val = FIELD_GET(TLV493D_BY_MAG_Y_AXIS_MSB, b[TLV493D_RD_REG_BY]) << 4 |
-- 
2.43.0

