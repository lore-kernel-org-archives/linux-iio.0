Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1267426D33;
	Thu, 26 Feb 2026 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123462; cv=none; b=kACcYZSiGJLtE3Dgb2mgndJIvVJ0KPEUnHxSgKKqTcAqp350GOr2Wbj/tPtgCV5yDck/uiWT4okllwj+oFa4rRx6iQhmvGfG6b9TzGEkvAttVVFbVI7Z0fOHhc0MNwuzoRjhIMt/+JjOOtCt4tlRmlBC1O6WHotXpUs1NslBivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123462; c=relaxed/simple;
	bh=IP4dG8wVTwCtivGzu6lHhyXLXDb5IFEG6cGh510bEAQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vEgbTy/fEZhn1zSO/JLRZdrmVRqhTmf366ELwp0+Vw8+zKRKbsl3NBjI7qQxX7t1ppIzBpvfrnpfkeIGr8ZenB7eBVzE3PaU65jBvuoGexWcN9J+JerVYAnZXDIpK1aHmlSA/W7wPtLIgy/Wo7RbLm7mZklAwGy6pLSCGQ6VVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xB/XHtCT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xB/XHtCT"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QG3L9x3025220;
	Thu, 26 Feb 2026 11:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Nq+og7JEjiVxSMI2oIKATYStpKa
	XdS0SiQo64AGgiCs=; b=xB/XHtCTqZK/l3WzOnxeS4YaAufSG3Ykgi/hbJAnlE/
	zv+YHLq8Aooj0LyUkZtx1+PpNkOm39Pxpu/TkLnKvcxe/iugvzK9nw5UN+ixZmDb
	IBEGlAcengesAgNcLXXiQK4vvSBL3Vn+1gXaUyki5RKEX+r59hNbK3aPtcaB8DSl
	YXhGkNi6cVumDtBiHatYaN9tZ2G2bJK56Ed0b/TTuS0c4p+uWqEKjUETB42KFvms
	imeKMzdmFyuIYRdkERMVZIsUAN6Fogv1q1niqV+XC+uP3mMGPRkOBWNYNEDti91z
	WwV52n6ceLI4HtYrlaQcA8Yj3BrHM483UFZpMTtzWKA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cj8tdc0sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 11:30:54 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61QGUrL2056435
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Feb 2026 11:30:53 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 26 Feb
 2026 11:30:52 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 26 Feb 2026 11:30:52 -0500
Received: from JGERONI2-L01.ad.analog.com (JGERONI2-L01.ad.analog.com [10.116.32.144])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61QGUkMn008067;
	Thu, 26 Feb 2026 11:30:49 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iio: temperature: add ADI MAX30210 SPI temperature sensor
Date: Fri, 27 Feb 2026 00:30:39 +0800
Message-ID: <20260226163041.169786-1-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=NubcssdJ c=1 sm=1 tr=0 ts=69a0753e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=0zRNOIqFuNFAU-9kz1AA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JuGsnmTXvUEofvRjpLN96K4JnafWZQzC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE0OCBTYWx0ZWRfXxe4QL9uIeEAR
 /NbNajrXLhnS5T2LYoMrIYNdi/m1IBOjhST/ITtcV9KkLl6qHZm01SDdvnYxwFc4mAh9NVcZKa4
 lf/dLMJPpsZiyO8zTxUXt19upDhrKnCfRJKyWLXZy0PAPsfB02kIAY+zz7i85Jg742R22fVYYsj
 FKhhvkouOSwSA8pt5xLI+tw99FgOQPNRY8p1RgPulp56Qk414lhzZ6zDcdclT8GBEYcRLc04OAj
 pzuIedhzXVVb5HsDjbAmZKv5NnnNNdFzOsoRd58zWXgkTkGE761rZf0Tjbnks/6s1Ug1YZXjvhk
 rGgeQQNMmCOSS/Wu10IM9oP3VB3//WiczeCflo8uEeMVBfRlr2TYgywxUwvr77uuff557f5JzxO
 0QwS5rD6iwkS2d2+U1MAQggMSFxqAt+VjT2yKKy5tQwEtpwpoBx/dKPlRZXtoF0tIjy0blohkr7
 PfzagrE1AXc+gVTOzTw==
X-Proofpoint-ORIG-GUID: JuGsnmTXvUEofvRjpLN96K4JnafWZQzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260148

This series adds support for the Analog Devices MAX30210
SPI temperature sensor to the IIO subsystem.

The MAX30210 is a high-accuracy digital temperature sensor
with SPI interface intended for medical and wearable
applications.

Patch 1 adds the device tree binding documentation.
Patch 2 adds the SPI driver implementation.

John Erasmus Mari Geronimo (2):
  dt-bindings: iio: temperature: add ADI MAX30210
  iio: temperature: add ADI MAX30210 driver

 .../iio/temperature/adi,max30210.yaml         |  71 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/temperature/Kconfig               |  10 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/max30210.c            | 758 ++++++++++++++++++
 5 files changed, 848 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
 create mode 100644 drivers/iio/temperature/max30210.c

-- 
2.34.1

