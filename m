Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691236C582;
	Mon,  2 Mar 2026 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454135; cv=none; b=q7E2A3kqze9AXxak6JYjlhwPT90LgEJh2Ndh/eju8NZMW5k7N0ZuOoz6ZyWAfQc+bR8hcI/A/xUkXQR4WD3Vs0x1GCm3nUoKNvVAT7JqY0qXyEmMJ6iSWKSEFoclMO0um9IDIwKFPTkbSg+69+Swu8rsxsXOup2AwVKxRhvV85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454135; c=relaxed/simple;
	bh=hYQ24hL/yQegBA4H/hEvH+qdGmRUbI+Zu9YQW3oc4JY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qmZfMMMxQHMo/yPc4n2xGkjl0f/FLTNmBfHYd75tovnw3GNCiqbKFYvkvt8ZFRBOe05M4oKUTZTfgNFcz0S/clCWqMO28Ys3R0bZjUuAcwD0wa8xufFbuzPV48A9w/0X6WAT9IqZfDRw3wd+CaOjUxmKRt846ZB9iOPoGWw6J9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XDVovRmM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XDVovRmM"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6227iDsN3411694;
	Mon, 2 Mar 2026 07:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=fWPrzLCFnrdzOTTY9PbsFjNqyGw
	fP5IljAN4Sk85FNI=; b=XDVovRmMEfwTevnGlf2+c5J+IclrayNadCTUqLJvkr/
	0eZhfI0n/EsSbBcF57CRV4B2eIVwPU5HQNdeBqXal0pR33RtC+GUfPY2ptypNCYb
	CgIMmvJdOiUN/LcB+haJ75g3EL9RRQHRLHDpI4VbJntvMtdnBGIXW53/CJ8X4tSM
	2KWJ0CSWtErEL4aKwwTn5njRflRUqlS1tWiCUct8IPnDZqygL+AwbmBFDOUvuf+P
	xxTXAJyp7jabERthCg5BtnFFBlZJWQiFJFf4+Vs1VLIcI4hrxQKZNJqUkGb5r9VR
	b1K7BIqEe/fQAmC1S5OdJSr1U9WWa9xytCk7jvt0Azw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cmfjcm9xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 07:21:41 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 622CLef1002120
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Mar 2026 07:21:40 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Mar 2026 07:21:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Mar 2026 07:21:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Mar 2026 07:21:40 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.225.130])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 622CLQqY010564;
	Mon, 2 Mar 2026 07:21:28 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        Jorge Marques <jorge.marques@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] iio: accel: adxl372: add ADXL371 support
Date: Mon, 2 Mar 2026 14:20:56 +0200
Message-ID: <20260302122116.1282-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=adpsXBot c=1 sm=1 tr=0 ts=69a580d5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=Q8uUoR3sjCQRHAxpCJUA:9
X-Proofpoint-GUID: 001vpwmCAQuarHnxP5QSAVoKQcOf1ALp
X-Proofpoint-ORIG-GUID: 001vpwmCAQuarHnxP5QSAVoKQcOf1ALp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEwMyBTYWx0ZWRfX6oPjjVgP6SN6
 /xJzpEZF0FFCZaCl8E2IQCDCSCnF1SOSuEe6ZiPLlT33EeCEdrOgPjlMkgfJA74uAjDlnp2a0Ue
 Ssk08Lrq1navRTh5PGD8y22io5GFFsSlG86X9LzBnsF7+h+aTTV6D3wtPXf+56+SK5Nke8gD6OG
 KFwe1Nk+0wDlwCNkQ34u99zKM2WZdCnJZPAYzM+P+Lr+3jvKz0sFmsOfUkme/mpTJD1sQBEe9ny
 lcOjvdzhQxb7Xo4R04Xj1MW8aOY9ANLMeJSu8rytrdCwE3vso/E1kak4W/v+VOpiSy0kbyqTIlk
 ealmJg/foiQeyB9cvtpC4e35yRx9fHcFD6z8WXLnWnFEH8BADCgicxKWUj3k0srU+XCBgCi6M+7
 +bpbketdXta0cGUS1Qs6PWB8h9KFr9iAmOFwUeignGFwsA8pT892XBV4+JQaBQpoUG8fp3ocKx1
 aqobJGW6CjawtGj74xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020103

Add support for the Analog Devices ADXL371, a +-200g 3-axis MEMS
accelerometer that shares the same register map as the ADXL372 but
differs in ODR/bandwidth values (320-5120 Hz vs 400-6400 Hz) and
timer scale factors.

The first patch introduces a chip_info structure to parameterize
device-specific properties, replacing hardcoded values with per-chip
lookups. The second patch adds the ADXL371 compatible string to the
dt-binding. The third patch adds the ADXL371 chip_info and disables
FIFO support due to a silicon anomaly (er001) that causes FIFO data
misalignment on all current ADXL371 silicon.

Antoniu Miclaus (3):
  iio: accel: adxl372: introduce chip_info structure
  dt-bindings: iio: accel: adi,adxl372: add ADXL371 compatible
  iio: accel: adxl372: add support for ADXL371

 .../bindings/iio/accel/adi,adxl372.yaml       |   9 +-
 MAINTAINERS                                   |   5 +-
 drivers/iio/accel/Kconfig                     |  12 +-
 drivers/iio/accel/adxl372.c                   | 220 ++++++++++++------
 drivers/iio/accel/adxl372.h                   |  20 +-
 drivers/iio/accel/adxl372_i2c.c               |  19 +-
 drivers/iio/accel/adxl372_spi.c               |  19 +-
 7 files changed, 205 insertions(+), 99 deletions(-)

-- 
2.43.0

