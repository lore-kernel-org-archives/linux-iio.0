Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544103F8EB3;
	Mon, 29 Jun 2026 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724338; cv=none; b=CDGlUf6hfCA72HT5d/+ZQ2xSkp5GKb47X/bNGssEE0w5J1h3NWrlImWBdQHIL77hKTiFOai39AmdHO1GtGmfZsEcBpxkHn5DvwD+1rLiaGk/x6PCuKDRRYKA6r2qBB6AM4P32vHFF1HO4ipntuZRDcFPNktvLs271oBfk1yCcjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724338; c=relaxed/simple;
	bh=x9UR8siIKA6bnwnWLZFTIbHCKZskbD2YgEM5xG+8hII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Z+tXSAgf1MsFXi5h4lYLNnbW42XFi2MxAyzy5AgZeIj0ihvscxGt1rWvKdToxYVcDu87M09b4pl6lhdFSYtxkO1YTJArHFj34FvpupgaejtvU74gJzBiacPZfwmNqkxkuDW1+VOHsFWIeT5vQ+asEfdl4MjPKqcTuPohjSn2xKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HUqpCXhb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HUqpCXhb"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6k5X31390909;
	Mon, 29 Jun 2026 04:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8bIBR
	yREFxPiZ0+qJhBjtcsvIDzTnaTbyQKPPzVPOYc=; b=HUqpCXhbVtqhExeQ+Brzh
	zXuzCRS/FstHJE5JbOasjsQXvBV7BZalkDXBfQUFY34BEFv5BqJy8pTxE6CSM0IZ
	tesiql36TbS7BlqepWC8rn+MH0YJ2PEQvUZWg+Cp3y2KA/stjxYCjxj8Y7ImTHVE
	2V7YlqxZlyM1Uuyqca5d39qTL9xYfvuXg5jF1z3qTApT5K7ck2UJg/P4p1jQiJFU
	cuHuh+YUMn9yiDOe5ukF6A/9ZXxDByrn1JYXSY5ZlyncE/qK0Iz5Tt6Ad5GAiGtU
	m6sbU9svDQPk/psiUjGPi0dZDAoyv0jdD/miazDnKuVppRB7DRDifMVAdvoEXyQm
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4f2vud3wca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 04:31:43 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65T8VgAp022788
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 04:31:42 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 29 Jun 2026 04:31:42 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 29 Jun 2026 04:31:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 29 Jun 2026 04:31:41 -0400
Received: from 10.32.22.147 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65T8VJkg012929;
	Mon, 29 Jun 2026 04:31:34 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 29 Jun 2026 16:31:05 +0800
Subject: [PATCH v3 2/4] iio: ABI: add DAC 10kohm_to_gnd powerdown mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260629-iio-ad3532r-support-v3-2-f6e4f4abebbe@analog.com>
References: <20260629-iio-ad3532r-support-v3-0-f6e4f4abebbe@analog.com>
In-Reply-To: <20260629-iio-ad3532r-support-v3-0-f6e4f4abebbe@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782721879; l=932;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=x9UR8siIKA6bnwnWLZFTIbHCKZskbD2YgEM5xG+8hII=;
 b=zBK9o/g0r/X0No379CQdK9iOG52FSIOa+axKoPk3ygvmWW477kYvCNsT2VB30HjM2opQjjIvw
 wQA+kNogXrpBfwK4aryydphQ28o5AnOrB1atl3BG0KHnwhmO17mnS7V
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bvJ8wkai c=1 sm=1 tr=0 ts=6a422d6f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=c9qRhK4E6t9TYzrPtjYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cRscYQi4wsxaunfQ6QbJm8caNwcjHlbD
X-Proofpoint-GUID: cRscYQi4wsxaunfQ6QbJm8caNwcjHlbD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2NyBTYWx0ZWRfX1+YUXf5RUgjt
 t/V7RoEDSvYG2r62c7CS1NZNtSjl7RwwrfSes6ytGhpo/I570X0kjPNATN5LFb5itRlosm4G+xf
 K44vy6Yf6+cx9VXYUWGgaXs7lkQkA8JUoSnzRVqWLV9PEukLpoYc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2NyBTYWx0ZWRfX9+RqQWnEvkkf
 yffvn4ybdS4VEU6VOUvh9jd29qVzEdgaCFYIrilTPuPEdEO0LKXChZgAJShTCHNrkv4c8vdm9Fz
 xq562UtbUJQ4yYtvatcCGSlpv3dt+BMabFjJIj1vRkw0E1H4T0SHyG97Ydl4ewEle7MZ/xCe4zw
 cOb6JW1BqB7kG8I3MKalNX29/j4+ZmNu3MXcJNEW/MQy6vBLsh6mq0F1n1lTiRVYCp7xjqcDHm/
 79YYaBkSR25biPFpNwhelwMqhcwDnildxvT5A/E5d+CpINDROaxELqC4r1Z+taIkfu/THZVkrgs
 lzawlLR+SpD3jMJF+RmLKnTy9Xdia9oQfVwmIRDfsnl2efpZjYJiQMEEqriBAyCgRFtSQeJWZPL
 18K1ccawgxva4++hbFv3JFZ6lxRHl9jHHMnds3qrjWEB0EdZiSEHmqIq8+g+fOSkDpLx2KaEfg/
 wNY1XhL78BOms5gWvUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290067

Add a new powerdown mode for DACs with 10kohm resistor to GND.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 4ea5598e7cd2..5cc2e82c4997 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -770,6 +770,7 @@ Description:
 		3.85kohm_to_gnd: connected to ground via a 3.85kOhm resistor,
 		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
 		7.7kohm_to_gnd: connected to ground via a 7.7kOhm resistor,
+		10kohm_to_gnd: connected to ground via a 10kOhm resistor,
 		16kohm_to_gnd: connected to ground via a 16kOhm resistor,
 		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
 		32kohm_to_gnd: connected to ground via a 32kOhm resistor,

-- 
2.34.1

