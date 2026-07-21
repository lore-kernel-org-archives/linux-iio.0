Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFD13C0A10;
	Tue, 21 Jul 2026 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623679; cv=none; b=m7Y4Y35lov9VeBBwvEC8M5+sjvXeDs4h0EEVHE5cegUkR5N86zxnlRN0yxcoly5eZ5vVNwDvWPdAbFAhuyd1ezUaPO4WmFRRk3hEYXNYKhvwIrjaSocqHzz4uzqhmoCNIAgCXrE7kKTO8JorO7uHjANRvnaEfWQV0KDbYnkTKqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623679; c=relaxed/simple;
	bh=4mkqsIBlczwtHK84gd3q0sgpjtVI2lt33oJBD+ufPfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Q/G0hwDaeZJ3ge4xjBs8Pbmf0BPKL/+eQ4pw/bZgquN78HQg8kNC9xBPpPhu81I4sT5m8JS+DaOkkocRvREZ0uu5YWxZYFZwk5awgp6sDn8xXvqsYlV9OBDt4zhWcf1ZsqqIkojkNQ5GeRrfHNM8z3Dk96H56LLisZLTb7KMkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Spn3HB4i; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Spn3HB4i"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L50H552894564;
	Tue, 21 Jul 2026 04:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+j7GN
	EWzPyyvCfRoedFmG/pFrMYPvAcBFk7xpfcI3Yg=; b=Spn3HB4iJ4lPFR+Vw10Hl
	aCbL4a7D1jsFKXivqVc7hUtOuwUm7RuN5QAOnIp7VHdo+gUFdSuarhj0uazBe+Tf
	Hcga3Rlt7r1jEOLk2liXBEn8Op9lRbGQL3cs1KO5jT0Gbe6nx9jaZpER7Jj5WgmB
	8oY5JqSaR92BIGSISEHPsyi3HVIuTuR9B+O8CZ+nRzhdPyErIb4ubx4OMO3Je3tY
	tSy2xo1fU2jBi53lDBlnpg6+tIMN+ck/Hw8hb8vtFlAhGwE5ODfX7NM1bStk6/LB
	VIa0lTEXyGq0QpeH4Snk/cRLFNySb4FHqNBv9mEu8nUbsNrndbROt6coLIltEIYn
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fgqte8exw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 04:47:46 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66L8liDh000812
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 04:47:45 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 21 Jul 2026 04:47:44 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 21 Jul 2026 04:47:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 21 Jul 2026 04:47:44 -0400
Received: from 10.33.20.150 ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66L8lNHV015326;
	Tue, 21 Jul 2026 04:47:35 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Tue, 21 Jul 2026 16:47:10 +0800
Subject: [PATCH v2 1/4] iio: ABI: Add DAC current powerdown attributes and
 15kohm_to_gnd mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-iio-ad5710r-upstream-v2-1-324949dc72da@analog.com>
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
In-Reply-To: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784623644; l=2032;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=4mkqsIBlczwtHK84gd3q0sgpjtVI2lt33oJBD+ufPfk=;
 b=IwjhfXWaEEgzasVtB6t9mBU4Rq2W9f3HDY1f6nUwKOtHnLnfoQZym5P6rQwCPSJ0Vr5AVch6M
 Dtxnd7oVPDyD+v/yhNEcqK26doLHUx0OSINVn3XpeGNHX2FHIMDnMdM
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5MiBTYWx0ZWRfX7kdi7kDX7d1n
 Ia/ZjhH7YKpvSJhkO2dBcyddR6FKhkECrwDP9RrCqzfC/pWg+wBMP+InL4P65YQZ5xPxceoRWcg
 FrgXSSEHjG5Aplwej5fmjX4f9Yyl7Zb1a/Zl6zwSQQ4GcqqG5R6Udi3HGdOfM5JzaeRrLLJ+JzA
 0NssyrbVVWlCFOQnKmpNg5F26CgWXGzT8GH38St6070PYskt0mvoqRTcUsySmh+tJoNImPQwJ8U
 K8ffrzsj8bM0DGUp6KMCJFBmLgVTnb5XHRDhzoTa16FMzJOZtQYCOkd/Il25gGW2fZxxLTFuEii
 pczZhN7ZdVsMPTOJUjdzgTByL1wm/qwkwCcwIslfIezY0cXmJtKv1P9ZEGGExkhxZkGXnHO2S+5
 gSHOYaHm8PIBSfWcwz9xMYMr6Llp72LOi5+kVQVpAEdl+A4uVRmtg6h61behbpHrnQ7chuAH6YW
 NLuE/i0qtVED5eXr1dQ==
X-Proofpoint-GUID: qzXcjmWSUzdP9d5Uc0aLfuRf_8e1Cq-f
X-Authority-Analysis: v=2.4 cv=Ed/4hvmC c=1 sm=1 tr=0 ts=6a5f3232 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=50yiy_OdUqj7sOdj0TsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qzXcjmWSUzdP9d5Uc0aLfuRf_8e1Cq-f
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5MiBTYWx0ZWRfXzUKbZhRQdPtZ
 AUkXds1NNi1+IT0tfrp6GmsDyACVZHw/UI8H7PP5RipIs4zzMb2hqbuCq44WGNZ6FZLe6J/IEfa
 5Z+04lOw5rVv37nrf+lLOHLrLrHfYOA7Kubr0DmqVNGYl59qZvnm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210092

Document the out_currentY_powerdown and out_currentY_powerdown_mode
attributes for current-output DAC channels, and add the 15kohm_to_gnd
powerdown mode.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5cc2e82c4997..ed3dd189c108 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -759,6 +759,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown_mode
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown_mode
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown_mode
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_powerdown_mode
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_powerdown_mode
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_powerdown_mode
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -771,6 +773,7 @@ Description:
 		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
 		7.7kohm_to_gnd: connected to ground via a 7.7kOhm resistor,
 		10kohm_to_gnd: connected to ground via a 10kOhm resistor,
+		15kohm_to_gnd: connected to ground via a 15kOhm resistor,
 		16kohm_to_gnd: connected to ground via a 16kOhm resistor,
 		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
 		32kohm_to_gnd: connected to ground via a 32kOhm resistor,
@@ -799,6 +802,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_powerdown
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:

-- 
2.34.1

