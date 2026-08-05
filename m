Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772D403EA0;
	Wed,  5 Aug 2026 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923070; cv=none; b=QgOPnw6OUivlRHDhCGRq+ek/rHEiAEH9kQzPvi2rcI10p8doKfv3wE8ldEIcfysgwTxG11Y0B0Ax0kYpWPBXnCzDAgwWlVPrWfn1qQIx79EH1LQnaRbQEDwuv5BoAqXrbAZZlKNic7qMpxhUL1UIrlDPOe9pnGe+CQs+7hWYIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923070; c=relaxed/simple;
	bh=JpUpg6pBYE59cria0Nsx4NjW4BZpnViIeVnstnAJCWU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RtIKaBYaj/tGN3cEQUcCmLKqMl3a6IQhYnXieYzndDFlTBZRlRAp4EyoF+yP5ZxyFF2ir72DmK1guYN9CggR1i1BqjPMpvuzeF8D/Lldd08qrXcOBCN5JEHcqbOisn9AKj6h9u9HgB/uOA4vSxRM0U0Z3DCPv8Mhy2vRtTHX0B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WpUfOyxU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WpUfOyxU"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758fMQg413574;
	Wed, 5 Aug 2026 05:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=4WPSCb6+vNzQEfakDFWEQHhz0zA
	KSp5niYQF0ZwJWpo=; b=WpUfOyxU9axwj2RRJZTktG02lFurvvYwJagrYHHRmGJ
	5ytgTXWXCe9v0MZ8ck/By6qujSb4A2lTI9jQ048LdKXqTLbh2Lfl37AXNUXQC4oX
	/L5n4tWlUEkCdM7T9qOc7dSn+KcqX8zv2l9pKroeySD7Gv754WWA+jH5CmmLzotJ
	O586gJgcg7TshKPhXLOofkbfjvjaarEQmvplPQotwIxZGruEQzVjFUyO3ldSyzVC
	s8BoxpwFVMCmFXF/mdcPHM5jBhY7zgrQoqLqHdWIhoLfr3ihpF2WEpWgHWTpvD/j
	4DTsfOtokgPSP/i2Z+zUqRy35p6LCNVMykHF33LwCtg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fue6wnc92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 05:44:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6759iMRK004988
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Aug 2026 05:44:23 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 5 Aug 2026 05:44:22 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 5 Aug 2026 05:44:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 5 Aug 2026 05:44:22 -0400
Received: from HYB-li3PrmDPxTz.ad.analog.com (HYB-li3PrmDPxTz.ad.analog.com [10.48.65.201])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6759iBgH028984;
	Wed, 5 Aug 2026 05:44:13 -0400
From: Andrei Stancovici <andrei.stancovici@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Andrei Stancovici <andrei.stancovici@analog.com>
Subject: [PATCH 0/3] iio: adc: add LTC2499 features support
Date: Wed, 5 Aug 2026 12:41:26 +0300
Message-ID: <20260805094135.11762-1-andrei.stancovici@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=SdzHsPRu c=1 sm=1 tr=0 ts=6a7305f8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gM_vYgSqSg-Sw1jdCGIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6_J2YAandXO6cS0uaLaYLpJnCKj0EEm3
X-Proofpoint-GUID: 6_J2YAandXO6cS0uaLaYLpJnCKj0EEm3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX5IZW48n79ck3
 FN/CjWgijiin3iI7lQyZ4vh8vrnlJIUZZrDmRQpYb46kS1WMeXt8lw8DhjcQxiF8uJF4BLPuK32
 rup6tnsqnZRbKAR+UvWY0dbEJSZOIv/7Ilk5OH1EC81QJUZNwkD1agSFJcFy2R45NV8OfYPW+l2
 0IMBCyR5iYNEIvhxT6ZWAyHpfcWxAb6vfznxBsw5JOqcAUvCtcPA/F4fyFk7SsoQ5xtnkHPkxp3
 GowMxJgOGH2xtrmCtG2ekXsrxoqypw92T4rPQb56ljk5jYJwfUvd79/G6qk4wEXKSe0xPXcqB0F
 gvo6yivR1HIWCRXuQsfA5FhaBVCPYveknQKNEioMyIzOlK4e7NevU/CChPuCxJnf9tZUjyFVYPC
 1zfzTra/rc8dqxgxOXwQCzrQK9awkFAdkN20bynh2DgoYpFaFSa33CJ2Elj5eqOs3oYtWrRek5y
 Y4BvIPbwxHWyk1Jmn9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX2Fw5vUrXwrG4
 SzvtuxwCM8a2JQnDwiQ+phcH4LxglnvToizFKRnSpNnyjsFeCmdWtXuuMhZbkNNFBPu+VerqYr7
 xZm23+HNaxMH2wUsavBCLguVese7MFrola1RykbO+uM/cjcdFHON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050077

This series adds LTC2499 support on top of the existing LTC2497 driver.

It includes:
- a small binding title correction for LTC2499,
- the LTC2499 internal temperature channel,
- the LTC2499 2x conversion speed mode exposed via sampling_frequency.

Validation performed on Raspberry Pi 4 hardware with an DC1012A-A board:
- temperature raw/scale/offset read correctly,
- voltage channels remain sane after temperature reads,
- sampling_frequency 1x/2x switching works,
- pyadi-iio LTC2499 validation passed.

Andrei Stancovici (3):
  dt-bindings: iio: adc: lltc,ltc2497: add LTC2499 to title
  iio: adc: ltc2497: add LTC2499 internal temperature channel
  iio: adc: ltc2497: add 2x conversion speed mode

 .../bindings/iio/adc/lltc,ltc2497.yaml        |   2 +-
 drivers/iio/adc/ltc2497-core.c                | 221 +++++++++++++++++-
 drivers/iio/adc/ltc2497.c                     |  37 +++
 drivers/iio/adc/ltc2497.h                     |  36 ++-
 4 files changed, 284 insertions(+), 12 deletions(-)

-- 
2.43.0

