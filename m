Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D67309DA1;
	Thu, 29 Jan 2026 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697817; cv=none; b=Syeb4ijBa5ShCvIph7/GoNNX+PDrwRSv6pfQ7O+bUhtflfyfzdHRFvGY7dxs7MrRrfTYNuvmk9QQ5aiUhz5tjKA5txs1fEi1JArMDDdzrJuYnjBC5mZcyjFx/6Oc1zp+Ng35EX+6r45bM9A8QjiOfe6cRT33dGU63tOoAZznX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697817; c=relaxed/simple;
	bh=Tdd9oebaPURw/e3hy7nFDUO5pBqeMz7HlkZk/IUX5YM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZGK9StA8GhNzvvM/jSyPxhX6ev0cL8T24ZG6zBRn8n004KLLqqwnEWBUdNcTVfH37b/F2IQFSedtIfLVnB29qkF34hSP5FKzhMjG/FZZjYMIe5Gdm4l/BVUvSv3dB3AYO8vGyNfZytY1sFsB6KHUk0shCzKwttI0xwQXRIYU/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=X9txxADD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="X9txxADD"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T8eB8Y2649131;
	Thu, 29 Jan 2026 09:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=uTVX7tl0UYtG/wEEEhLy4e9gJCv
	/7M9Vub1bAKHb6is=; b=X9txxADDXJPz6uEUNPtaMJiIbmw0sBn3mosgTo1g3uf
	LSIGTSOmYC/+UcaqvEZndnyrZEGrs5uoHGxA+iHqraIXSKqKvLTC5V/nfqmaulFO
	8Xy80QdeA8Zdnx+u9bw+YqmT8i1DX1hk0JzgjZHq3gMxaCfbsJFkbAkFYEGTR0DC
	htZ7nuahezgSVVsJAAwa8u3xPVMoSGblWgNEl12IOZsDw6kPCzcTfO1XcWVHOJgj
	MQnlKOPd0zPvVDyCdPyluqQP6WQn5B4/07ceHNp7oYJ68GYv8c0DguhvWnNwaGdF
	VmUmcqEbZEgm7D5IQZfcmrKc5SwBpmpzE1BTehK7yTg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c048917xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 09:43:33 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60TEhWRV036836
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 09:43:32 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 09:43:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 09:43:32 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60TEhMig000518;
	Thu, 29 Jan 2026 09:43:25 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <jic23@kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] MAINTAINERS: add entry for ADE9000 driver
Date: Thu, 29 Jan 2026 16:43:07 +0200
Message-ID: <20260129144307.118520-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEwMSBTYWx0ZWRfXzq1AmJN4CUt/
 ZHAfk9Mbk+tC5MjZQ+L+bKNHhSfXtFubblmdP8uE9zkct02yW4FHEmazkp32xfc52EjnrMQpcFX
 gcC6kU/nErrD5NCr3SBKAfi0W/ybtcOiT44AKn9wVLs4vK/fITFGUXM3Wv4+VqtD3PMmXTcKOE5
 rrZ/BBQj2gKO5Y03La88770lFqKQ5NRu972tCj5DiCl8T74F0gtvIGcLlhp/n/VQIRm/T/knL2s
 9lpfzzjaLSAltH2EvjyYrVo8GEx7Jz3swTosZCyU7OLI5bQko1dvqM7BO+oEQ8XWsafsnlBKbQJ
 7iQZv3djGHZ2/nC9l2BnQ5q786PU0vww9PNPponmjLbspUYwz9H7nk1LL51WdQTAlDYir6RFsoU
 XNGHYuWXSMHaR8W/RphVQPY3AsYT6U1lEoXscjrhuFnsTcLzN0usnNX/QH+06O3Kktp5pg+Y0NC
 3UpvY+lmZOLKwU3kQQw==
X-Proofpoint-GUID: TU33MoVraxLxdYbebr7lo5W5U9VUVTkP
X-Proofpoint-ORIG-GUID: TU33MoVraxLxdYbebr7lo5W5U9VUVTkP
X-Authority-Analysis: v=2.4 cv=dq/Wylg4 c=1 sm=1 tr=0 ts=697b7215 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=jysksSqXYiuB1AMBxvMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290101

Add maintainer entry for the ADE9000 polyphase energy metering IC
driver, including devicetree bindings and driver documentation.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 67db88b04537..308cff2de993 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1604,6 +1604,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
 F:	drivers/iio/amplifiers/ada4250.c
 
+ANALOG DEVICES INC ADE9000 DRIVER
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
+F:	drivers/iio/adc/ade9000.c
+
 ANALOG DEVICES INC ADF4377 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.43.0

