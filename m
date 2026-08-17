Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14F3B0ACE;
	Mon, 17 Aug 2026 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948677; cv=none; b=swN/GTkldPQ6vNOOJ0FGORaWTdQl3DLj0EWrlI+1OiFsxtNFXfpgEHtLAfYOtGAoXEyzQDNha0hGD/JFaOU1cMuCcZoZ/o1YAslnZtbbhFybgLQ4ctFmW5rfOV5biG2/QcWgIknIhrlKtwHn/zJnqXhUZZCufNtbr7wZAvYaiWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948677; c=relaxed/simple;
	bh=SqvRGnn+IhUEoK2N6AByTvHIxzmZJCKr0fzFRMHv+Bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EVkzWd3Nz6Exfdwn/LtSt6wJReexwn3sgDkg4G+bnXXchKp46QhutJUk4QPfsWNYP9MspggwnqkGhVNpG/jvwhjgMETnHdgqFGCmHH+LxEbsUO3zCXm1ycVWxYC/DGP0msYke9eIWanUbLzhdImLQz6QFXVu8r4cH4USKJfCN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eZVjI0oK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eZVjI0oK"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H6A78u2809427;
	Mon, 17 Aug 2026 02:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZH2tN
	kf9nle0iSvyskoHPhsLVSlLZkHFzRnKUGDufQw=; b=eZVjI0oKZsoyqxc5TlQq4
	NhwBD+eqFWNKicNFPvh4XUuBX3jIBC0avQGBHPQyAlL+zeI/XTvSYBcyfgoJK2hO
	oV9cd5sD7iZPfOu1f+84tYnlsnOVWG9DBLIs4rvKkg6NpYn6uXGRclCWbA3CcfYT
	WwFXYBXvDf740MJSgLfb3INSFs/8CcOTnemN42TKQuIK/wzQm3FBCV1ZAY8BuzkH
	uiC8VLqKDfqTC5cm9FuvDZsyIR97SExMvA3b5JMN3CzQr3lLsikhjxUaXFMMsD8P
	oSOL5v/pkp8HG2MZTHaF7S79QOTjjavpz+R/huMb2LuKALgpjRPSltojdSkqNjzR
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g39efkcnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 02:37:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67H6bnKc012498
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 02:37:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 17 Aug
 2026 02:37:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 17 Aug 2026 02:37:49 -0400
Received: from [10.0.2.15] ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67H6bW5P022522;
	Mon, 17 Aug 2026 02:37:43 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 17 Aug 2026 14:37:11 +0800
Subject: [PATCH v3 1/4] iio: ABI: Add DAC current powerdown attributes and
 15kohm_to_gnd mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260817-iio-ad5710r-upstream-v3-1-3a4bf7b9c78b@analog.com>
References: <20260817-iio-ad5710r-upstream-v3-0-3a4bf7b9c78b@analog.com>
In-Reply-To: <20260817-iio-ad5710r-upstream-v3-0-3a4bf7b9c78b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786948652; l=2032;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=SqvRGnn+IhUEoK2N6AByTvHIxzmZJCKr0fzFRMHv+Bc=;
 b=PZLCcKjgKDk3lnRViD7ImyUIZRMN6t4hAFapVTwtqgZQzI5rt3vpiv1dZgvQ0EMfXH+2X/xv/
 HAUJG83aLBYCsTSLqIZvOz+xsSbTh/J6DHqCha7iQr6sDOyXrlyqf5q
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: xWjMZYviHLbi7UKggfw_B0jDAr0VVC_p
X-Proofpoint-ORIG-GUID: xWjMZYviHLbi7UKggfw_B0jDAr0VVC_p
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA0NyBTYWx0ZWRfX0eTc5llOyMtt
 GQ763SplyTraV7TQ2CIyrsZMGD2Wc/bazXtfjpX+KbPtHdFDBziRsA4HAYpd0bTcIpDdsAL0891
 Ehk29blApsnXY0yQ60zyIlWbr+ABY7pFdR3CsuX6WFC3iVSIrIVX
X-Authority-Analysis: v=2.4 cv=VM/tWdPX c=1 sm=1 tr=0 ts=6a82ac3e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=50yiy_OdUqj7sOdj0TsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA0NyBTYWx0ZWRfX4cYhW10PrUYD
 r21qItrkcrNyzNWvd9TduxaG5/UttejIqG5vOsfPYsJ47/Yp0G/04pNUKja2hSIGvCYXNKkVUVs
 ZJAF1omKccJMO4UV1AUpEMRdMKzVNhjmXgFB0YWnEmOB0MWKF55roJWsGt6qgWPPRblZJ2DS6ZR
 mG8c6YapL5QtOK7Rq9DcZX2u/kj9OXlr5KKth4hXxthzkehdQOqige1VkX2/bx12/jxu6PkSMnC
 uRfK7Oo4FjK9jCVt7UOPHMudDX+CzbeY4AH4pLGELXZcM3MPmZMFFmBIK0M9I6IPTm6SxnE5fR/
 x/JZ1CKDlsF2CQzP5XTN8nJ4M6Wco7J8zjnMwkKRsxZfIxeJ5CaMMU1AVWi7kquSh6DztvsyKe9
 h3Vnjs9KMS9PFjCpiYesJvXI4gOtt+CDKGYURN4jhyIEa1GuXMg8/MenhDdRPPPpf9YY62xzbOV
 +ViJV2sEwuxPgWWvhDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170047

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

