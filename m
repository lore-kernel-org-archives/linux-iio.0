Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD233EAC71;
	Fri,  4 Sep 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510972; cv=none; b=SalSiwtTgJ//KjX2V1wDT4wGyoWG3O+nxmquYjQ1AJKsTVEtu0NH5HeKVzcFy+NuhHy8c6EP9tqsNkV0vBin84m1QLCEopP91uPIGHtN0XC5CvY8ROi813UoMiBNw8ZMItwegBJ62+OeFKKVG+FoaPMnkYp9htrr+BXiwAIoN20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510972; c=relaxed/simple;
	bh=SqvRGnn+IhUEoK2N6AByTvHIxzmZJCKr0fzFRMHv+Bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Il8IuNGqUPMZtLBBjdIwXWmJdCIWELVwtiaK9TJm66dLql1ZKe8rsS+Xm7LHwi1CYVsPYmWM5+TqEhRrF2QVpRgjFcjVB29O1cuqB8ddFc28fOxiZj7EBbc/kU2dyoP9nfl0Rz9hI5PWm9NBcRFG0Pc78MNsBa3iK7uyJw9XtBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rqzP5ew4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rqzP5ew4"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464slu3147526;
	Fri, 4 Sep 2026 04:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZH2tN
	kf9nle0iSvyskoHPhsLVSlLZkHFzRnKUGDufQw=; b=rqzP5ew4aPuhCc5CusEV2
	UJpKht7oLp9pPM98CZQ/vxAGlJrrFjppJTHZsKFIq5L1znp+RDQDvndIwOmfJWmi
	VYGr98rBSjlKGzQc/4pyYrXgQZzdcQRvVVkn7poSLc8cV6l2+o9ETVV9Jr/p3uJ+
	9P/PG3rH44eM+fRs5Olb32TxGCXlZ1OSXDxSzj+lPJfzy8i+mFCotnx14g+wKdmL
	fOon6B3/iYo2dY10PoDLqbv8DWDh7nDaJ1jeOHb+mfFZQ6kMBh6aniC4zqd0OC0/
	jfvtC81CrQrT2t73lEVGcvuaA6JUUNRUhMrZSJwgn017eFvshgE7aV56YR5xmYdC
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gfqgxrw7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 04:36:06 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6848a43D007206
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 04:36:04 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 4 Sep
 2026 04:36:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 04:36:04 -0400
Received: from 10.98.41.145 ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6848Zjj3026621;
	Fri, 4 Sep 2026 04:35:57 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Fri, 4 Sep 2026 16:35:24 +0800
Subject: [PATCH v5 1/4] iio: ABI: Add DAC current powerdown attributes and
 15kohm_to_gnd mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-iio-ad5710r-upstream-v5-1-76f985b7d0ee@analog.com>
References: <20260904-iio-ad5710r-upstream-v5-0-76f985b7d0ee@analog.com>
In-Reply-To: <20260904-iio-ad5710r-upstream-v5-0-76f985b7d0ee@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788510945; l=2032;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=SqvRGnn+IhUEoK2N6AByTvHIxzmZJCKr0fzFRMHv+Bc=;
 b=zb0mpxHUGQWp7xS57CSyISZCsOqxq7Ab3CWTvEJDRHzrXCTOHg14VEpQ9/d+F8W01n+Z7J1QR
 V+R8qEJSMCiDJttipXS3qpxtu2QUVHBxcAQUSoSrwOm8N5aJWLLNarK
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=cKzQdFeN c=1 sm=1 tr=0 ts=6a9a82f6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=50yiy_OdUqj7sOdj0TsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA3OCBTYWx0ZWRfX+nkqIGKZFsbd
 SUZXKomJIzU6okndIQx55XYnn50GqvxH64q13aMp0b9yTZC+KwiXb4lwG1LybHbS/2ev9hrPwWb
 Q6Fj+JjD8eaIO1PAOSckpcJQLW56gFWXkMslnFWDBLtQ2JiggBnm
X-Proofpoint-ORIG-GUID: RTpQW_ZEahZrbzqWzT1q3mpxwEK7Tq1D
X-Proofpoint-GUID: RTpQW_ZEahZrbzqWzT1q3mpxwEK7Tq1D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA3OCBTYWx0ZWRfX7huVBlOIno24
 m/4NG/ZOAEqZNbcLgfHVZe6ehYWdM8rm0/bLqs26rCNccPU2FAhz+ZaeALt564HWY5DH4XdWU2S
 6thdXKvI9eCvElec+9uUE8JrF63iT023OK4UDvvf0Xfo36WVUdH+qS9w1x5WnFORxVgh3U79nFG
 0K1Hb1AwlFAlaXnDLI2j23I3SBlIbL8O/f2/W1AR+DGZnY3uge1pJI1Ysul+wdZap46YK9wBzGX
 9AZ2jI+hrpXVJfz0GffSHpd8UebASBX8MCrT6WPjO5kc8EV7NV6Hwxsb2TTX2wt1AZfVmb4S57M
 pSGwxOus0q4p05Y7xKGv95Pjxg8Abxeywc7gOyQVWl7Vhw5MwbWH5g+kFW/sfiYc+wf1BQ5Xtfo
 3vy3KgwhWr1Po46OFln53x53k8B/WV7NvBinS10GKhzHnV65aDw4tknnD7RlXTka0oUytXG2eIu
 ktXXe4Y1NFFelHsCRyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040078

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

