Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB12C11D6;
	Fri,  6 Feb 2026 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770394084; cv=none; b=fuZD46AONn6Uf7FBel3Az5LEP7tnMA35FA/5bGAd+AB9lYVAxfyzqOeKgSKwM6HfJxLhWf+MclQ+4qGnCAKMwChR4D/QcJw2aNKegTImTa7PSF6WpGzkCEZuMEzU61VUdDbDI0iSy1pwV4SzCZApozIS3AQ53/Vbd7mGBqZ92jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770394084; c=relaxed/simple;
	bh=6fslMzetCmJLfZDpuM7TqhUsCXvZPyx2yvVc0+aX7y0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Br1Du+O6IbdBlaiq4qGbEjyDbrJyugm4ocx8eX8321tKLJr8M4hKEs8R9+eaAeEJz25f9gxdkQRUs0IY4BSmwq57h0qvCEhWtOx7cmukfSE4Spd8nBl1TVIZnzwYjTwmjxdYK2oCXjAtgZXA5g+jGLhCRFSZkkXGg0XhKg+blYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FVOIQ6ku; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FVOIQ6ku"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6169sMkP897366;
	Fri, 6 Feb 2026 11:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=N9w9ZqnBG6whImRKW3RmFABOqc2
	YfonieY9LI5kt4U0=; b=FVOIQ6kuxOl0U3H/ltK5ZaGxL04gDPaBD1aEOui1gDR
	Jh2YOEbZ6CXXqDcpHA3nfkU/JZT7P6UDf9/trT+Qz0iOo7nc/JEH0O+LH+NVG34T
	FIWf4OfUfiHX/yNPNQ9FRF8dYR/+7LoWnZV5t/F5hwW3x+U/JaDHECnjA1NC71fy
	3GCgehbQIt17OqbaNSB0+R4U9HUSZEYjnxD2VtCd4G2JGtwuaZhzY6FV1jQ+YnQR
	GkB22qSOCyg+v+2GZyJ6dMtOFtXj2BNIHz73DLa6lcYUuJC66ViAlHemHP/aD69F
	0Se7J1eXbD62bo59VLpnLkclzgtg/Nr1Dd/ay/8iDiA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c5e32h4xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 11:07:39 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616G7c7U057136
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 11:07:38 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Feb
 2026 11:07:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 11:07:37 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616G7MAk000370;
	Fri, 6 Feb 2026 11:07:24 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Mark Brown <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2 0/4] iio: adc: ad4080: add support for AD4880 dual-channel ADC
Date: Fri, 6 Feb 2026 18:07:12 +0200
Message-ID: <cover.1770393792.git.antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: cuo0q2cWAbDehhVrlR0FebfQQz9C7EtH
X-Proofpoint-ORIG-GUID: cuo0q2cWAbDehhVrlR0FebfQQz9C7EtH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDExNyBTYWx0ZWRfX7D+hQ0BiP0vA
 Ay52lqjWJTkM33EbjDlEbvQqChJLtzpqXJ28IbEEFilBmkpH4lzjS/Ffe32MynyvrFc6J9zcCVX
 nXa7Cjw8yWWsveMTtFLRTnQZXmfR4gWV0Ii9vhIcdhe35+Eqk1m91vplqJbOQfsfWmduGnc8Clh
 3elV8fP9mHmX8C+pnJbj35iElf8uUG4pFGoNmnQvkeVySXxkQNc2md7n+MH24RdtvXvgN5OymkO
 aWyF781RsnBDvEqHMlpM6nZaPmjoxIb09LGz6INBKy32qMbtdLfJABykkRLUlF85BYlrEd9e77I
 1qPGwxw0YrMZqLif+360XkAOw+YgAJFJ/SBPwhr4+2uQkZ3SbCJzUV4x+eHRWj0EpxnC1GnDuAZ
 EIk9fJJsova2Sj3WR7Wj9Z1HoihYoW7cBU+fzk5ycJT+31YtV+v937Ej0TElTYkdcqUjULneBVc
 Fk3TP2kn6D6JJucua8A==
X-Authority-Analysis: v=2.4 cv=NPzYOk6g c=1 sm=1 tr=0 ts=698611cb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=JEplbj-ZQJa3tgTfUoEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060117

Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC from
the same family as AD4080.

The AD4880 has two independent ADC channels, each with its own SPI
configuration interface and LVDS data output. The driver uses
spi_new_ancillary_device() for the second channel's SPI and requires
two io-backend instances for the data interfaces.

This series includes:
  - SPI core fix to allow ancillary devices to share parent's chip selects
  - New devm_iio_backend_get_by_index() helper for multi-channel backend lookup
  - DT bindings update for AD4880
  - Driver support for AD4880

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4880.pdf

Antoniu Miclaus (4):
  spi: allow ancillary devices to share parent's chip selects
  iio: backend: add devm_iio_backend_get_by_index()
  dt-bindings: iio: adc: ad4080: add AD4880 support
  iio: adc: ad4080: add support for AD4880 dual-channel ADC

 .../bindings/iio/adc/adi,ad4080.yaml          |  51 +++-
 drivers/iio/adc/ad4080.c                      | 256 ++++++++++++++----
 drivers/iio/industrialio-backend.c            |  51 ++++
 drivers/spi/spi.c                             |  29 +-
 include/linux/iio/backend.h                   |   2 +
 5 files changed, 330 insertions(+), 59 deletions(-)

-- 
2.43.0

