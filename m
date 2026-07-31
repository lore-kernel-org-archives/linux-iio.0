Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1598A3D411A;
	Fri, 31 Jul 2026 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486653; cv=none; b=Wvm9ISGkU5rAydRQl/LCSef9NCfCcesBKF5YTGwU+APYI4AdFENS3WGwtTCcC2JIRbLMbcVCQFhKMYZd1u0yewXIZZA/ucdnBQA4GTaTxIY+6HT1EC2NXxXJMRmE6ihdlrcWy0jZege6Ae2Ce9lYRIxMGl8y5darMlQWqzO1xuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486653; c=relaxed/simple;
	bh=875MmK3q0FCt74sb8cP8FMnOYT4YdmEAvebDWQdLLXc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CU3twwj1Is7DlZfAMhN6c6VuA1BYjfCXAk5CZeLdMziutXOdTDvDQtoOygTb17DUeVJ8CpuTkiFbj+t2Qq06sBgPfThPj4SBVEhDlbdtipJ0QuruXTZxfBly8HuedyR8arKq5ktD8nTz4Xv0VXIufWCuu0OnHLhfKJYJQeDBnsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pnEjX9wF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pnEjX9wF"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V7x5jq3069474;
	Fri, 31 Jul 2026 04:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=PyyUX2RMl/iHAykHdWwi664oS65
	9ryLXfFzvWgrn8XU=; b=pnEjX9wFt+rVRF+xpLTy/vZ5f+FQ61wBsEhfFlaY+Ec
	CY+Yv/uSI7+2gdXtsmnzAM3xUv0xTfuQRJIex3pjopE3ci1sTNJK8n6kZBRHq2Z0
	KUSWUXDYoBZaqtJ7E201WWbby5mARuGsH18ARfd2V0XKS64vH8Jcf91umW3ktQgc
	QXmgapUdrhrq+VaS4A+N3vQlMmCuF61CH22l5Ubc5vh/T48qz5sJ2uhDiKhh6Akx
	W63bmsUghvF1Y7WANbf5OUZ2MuB2xIMcBJoECEeNHrfmjzORYb6wYmXuD8As0gY8
	rIqxO84yorVMUoFQoC18rAadmWBqZexRooSy7JaMRbQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fqj4f9hsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 04:30:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66V8UUNH039891
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Jul 2026 04:30:30 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 31 Jul 2026 04:30:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 31 Jul 2026 04:30:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 31 Jul 2026 04:30:29 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66V8UDN6026738;
	Fri, 31 Jul 2026 04:30:15 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Shuah
 Khan" <skhan@linuxfoundation.org>,
        Radu Sabau <radu.sabau@analog.com>,
        "Marcelo Schmitt" <marcelo.schmitt@analog.com>,
        Jorge Marques
	<jorge.marques@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 0/4] iio: adc: ade9000: add support for ADE9078
Date: Fri, 31 Jul 2026 11:29:46 +0300
Message-ID: <20260731082951.1228-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: PiHbYgxtWr3vDytYKvkVsNSJMy_xUIdV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2MCBTYWx0ZWRfX94SOC/p/4te/
 L75lZFPtGsbqmmlGwhdpeWNVazg2KnT9YM4u62BypLu1ZNrCv8NENf+eCyNx445NfEYUc0ZtvvH
 YRgrh6g1XvtsTonCOi8e5EQTNrVad/4BvVnN1kWDHXR/eaUbLGS95obIXRtGYpr1EIF0fQAjDlZ
 kuKb0GIBAnWFJK4IDwIVQcAa7iHfgP0FhRixhHrIZej7y0WVT5Vs3CXB5FgDVlDY5lhgg3t8+AV
 EmaeXf3R4QnyqRA2tzEnx2r8GAcdIeV8y+gLSgRudbyuue2Irf73qTnlhEA4rxc2ioHNSSuYwbX
 9PpcG4Tym4GYeZ2ldu16HuSHkC5RxRYSh/t6eRUFJVk9gl8FfehXo8ofe5X6JtD1ae7/SEgI2Yt
 UrCfGDaci00W1gwaqCCVEt+D0VE3DjTgTbuti7VK/IiJW2XLZZ9GZSMbOKKzOmgpRBejBA6OLjR
 4dg/Z6OQOQYdVPxI/iQ==
X-Authority-Analysis: v=2.4 cv=EMk2FVZC c=1 sm=1 tr=0 ts=6a6c5d27 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=zsVk_H6PqY_VlGaDqAMA:9
X-Proofpoint-GUID: PiHbYgxtWr3vDytYKvkVsNSJMy_xUIdV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2MCBTYWx0ZWRfXyT6tO83BXI6v
 Vcpbv2eTShctYanpDs7qbThqGTt1LEsC+cZazECfPJ4nN4nm3/CL6zdrqPxhbYYTtim/nLKNSZ8
 ScwSgjJsjH7ojma9WcyBhHuFsoO/w26uyUfWbWWDaH1yo8UfmUS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310060

The ADE9078 is a polyphase energy metering device from the same family as
the ADE9000 and is register compatible with it. The main differences
relevant to the driver are the absence of the on-chip dip/swell detection,
a lower maximum SPI clock (10 MHz), and slightly different full-scale ADC
codes.

This series adds support for the ADE9078 to the existing ade9000 driver.
It first refactors the driver to move the part-specific values (device
name, channel table, and full-scale codes) into a chip_info structure
retrieved via device match data, then adds the new device tree compatible
and the ADE9078 support itself, and finally updates the documentation.

Changes in v2:
- move the "respective datasheets" comment wording to avoid churn.
- use a generic Kconfig title and list the supported parts.
- duplicate the RMS voltage macro instead of a shared base macro.

v1: https://lore.kernel.org/linux-iio/<FILL-IN-v1-MESSAGE-ID>/

Antoniu Miclaus (4):
  iio: adc: ade9000: introduce chip_info structure
  dt-bindings: iio: adc: adi,ade9000: add adi,ade9078 compatible
  iio: adc: ade9000: add support for ADE9078
  docs: iio: ade9000: document ADE9078 support

 .../bindings/iio/adc/adi,ade9000.yaml         |  30 ++-
 Documentation/iio/ade9000.rst                 |  28 +--
 drivers/iio/adc/Kconfig                       |  16 +-
 drivers/iio/adc/ade9000.c                     | 180 ++++++++++++------
 4 files changed, 175 insertions(+), 79 deletions(-)


base-commit: 0b5e142ced4bcf20532da051934bd694d1bbd470
-- 
2.43.0

