Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E64C6D;
	Sat, 29 Aug 2026 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787983202; cv=none; b=uc4kuYDmlvNQsr6Yg+zCVSfex7cGhg2NdsR8C8gHqc/Ic4/ZT6Ql+jnnxvlkPI8cd3luVgsfVyFQqGuH3dH6s0iUNgax5SX47gbYHUgYr3vlYB9S9fQXEtI2jY6nO16UNvOubP4nIcR7X6oas6+X69czmm3C3E1hztG556Z3dEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787983202; c=relaxed/simple;
	bh=SqvRGnn+IhUEoK2N6AByTvHIxzmZJCKr0fzFRMHv+Bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Me3WiMyXKO7xeve6zSSTDQc06Fk9nA1oRXX+ZGB+16gip2MjAFRovau+5X58sMPWXPIwfx6/Ec2kiXgvqKeAYTCLLOv39hM3Tf6tR90swngzXQ7/NnDge8inyxPZod9seqf/g9MO9TNxiB8/tOxfV2a+0XUelVgOHbypSwdCAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GEw0cOII; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GEw0cOII"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67T5A0o53384988;
	Sat, 29 Aug 2026 01:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZH2tN
	kf9nle0iSvyskoHPhsLVSlLZkHFzRnKUGDufQw=; b=GEw0cOIIyE4pkTdIBPfml
	z3s6JPBndIJ/z5ibh72+piWDapDNMmt11lBwgYk7QVlqgzUqwwrl5+Aw5fdbJwHE
	+t56tEbda4OF2BImr/PZWr1+Zo8yRaWwXS9xxNTfqXoFwCCVIAQSBXc+CgGjagMd
	Ejo5uS/Q4kMYayxlfYKQqhfIguNYj0yaLl9iP/AV6HNJXwdgQIc6HMMlGCS8Rep+
	3Rs+hQ6zwY8H2TFriOH/K+zaUhER8dpb/AZKqkktW70qfXnkwQinUcrn3OSJlagE
	jOtZ9lRhWcpwrnKi7+U6gTaEptydCbKmcKQ3qJtyN/B9AIFVkScShqTrK7OjxxRR
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbqmh8cm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Aug 2026 01:59:55 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67T5xs8V035559
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 29 Aug 2026 01:59:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Sat, 29 Aug
 2026 01:59:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 29 Aug 2026 01:59:54 -0400
Received: from [10.0.2.15] ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67T5xYjA027223;
	Sat, 29 Aug 2026 01:59:47 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Sat, 29 Aug 2026 13:59:20 +0800
Subject: [PATCH v4 1/4] iio: ABI: Add DAC current powerdown attributes and
 15kohm_to_gnd mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-iio-ad5710r-upstream-v4-1-8af3121c7d21@analog.com>
References: <20260829-iio-ad5710r-upstream-v4-0-8af3121c7d21@analog.com>
In-Reply-To: <20260829-iio-ad5710r-upstream-v4-0-8af3121c7d21@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp
 Zabel <p.zabel@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787983175; l=2032;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=SqvRGnn+IhUEoK2N6AByTvHIxzmZJCKr0fzFRMHv+Bc=;
 b=UJPPB/8fV5RQC/NsAkiMkp7q8qzUGFk5K61i1bcR5okTbdffS1B6pz17inMYCpXyB69RcMmHg
 AbcttMJ2Us1A1bNwrGlxF7r4PB4a0Z6QFp5LoX0kaZNlBaVfM/qZfdQ
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Yf+NIQRf c=1 sm=1 tr=0 ts=6a92755b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=50yiy_OdUqj7sOdj0TsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pJoadH5ZPhiwxLdbctPTeFAPwN6NAWrK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA0OSBTYWx0ZWRfXz8XTh7RhmWvX
 vQnhQ3KYWCjgm5qMkDtu22TY1PnVhDPZJ7Fy1WnsUFGo9ZkSRjBm7ZROwDc6HKsIPvLOmk/RwkN
 0Jk8FHXF7TTUKwzlpaPkmdBT82k0aQOL4zr57ZYnIOXYwUlCCpy2nSrD/ziSX5D2X3xh2Pk+b1O
 OAAwyjyOHAl4pzcQm1muXhEZRLZkhjhSmAK+CqZBwp3Pf3nKOdzrDHGTYI3UjdhvZVWbyjrPlLC
 AXgJx5OYKiyhZ8Hgsw9ChzpawZRI4sQK3WP3YBAVkdFLIeB2L5LnkXUrHQHCqq0VWfsOW3YlzBZ
 MKuySr3Muob0PsiwEFNxNsVBruu8kIulTO5VD2rLFgYFyna9oXpMwsIt39jYc0/n4ikzk+ymzgi
 4RhVZjRCiyB13+nXFE5LtJxfsfS8XRZi/C5aSJ0YrPSnjU/TzMauDhOe5yIQpyO2AH7e6SOFu+d
 AS/pagRvJMM2IMU4IHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA0OSBTYWx0ZWRfX3ZUg30O5Kdn5
 mm3Cz83EqM+4AtsZqdG8baqPb6GE+KXylZHM85rqMzul23ogSH4dotzUIPVlWTxC4zdqCzenI1Z
 HTCe2NwyoorJ6g1JYA9SDGRoNyVX/BHG/nEXG6+ia58ckgeOkGVV
X-Proofpoint-ORIG-GUID: pJoadH5ZPhiwxLdbctPTeFAPwN6NAWrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608290049

Document the out_currentY_powerdown and out_currentY_powerdown_mode
attributes for current-output DAC channels, and add the 15kohm_to_gnd
powerdown mode.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a4f5595722ad..a0f9aada5c62 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -762,6 +762,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown_mode
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown_mode
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown_mode
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_powerdown_mode
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_powerdown_mode
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_powerdown_mode
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -774,6 +776,7 @@ Description:
 		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
 		7.7kohm_to_gnd: connected to ground via a 7.7kOhm resistor,
 		10kohm_to_gnd: connected to ground via a 10kOhm resistor,
+		15kohm_to_gnd: connected to ground via a 15kOhm resistor,
 		16kohm_to_gnd: connected to ground via a 16kOhm resistor,
 		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
 		32kohm_to_gnd: connected to ground via a 32kOhm resistor,
@@ -802,6 +805,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown
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

