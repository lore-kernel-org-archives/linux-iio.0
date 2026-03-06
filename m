Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C2436A005;
	Fri,  6 Mar 2026 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811572; cv=none; b=ZNu0D8P/+IBdJYpnzDnn/VIXcBVeDtL1+XiJbwOXR8kkVKhCcqPRCI9D+yyXZg7zQBEjag/VB3iqwaJJf1Xz3rc5QszgmTyJr5a0KZJK/xDiiJz9yV3DkA7tWavlrCWLDraB1QQN3CkAqorrEnw8EHVv4Y85k07ob/5JHTwoJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811572; c=relaxed/simple;
	bh=hZqa2Ge4elYOix7DeZvr2o+4Ers84XgvipGHfsUfj/I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YYsy55xIDQqJe6M/G94fa0soNUkfy5tNqa895BOCfFQbVnCzvdkF40uiTwkE6VMS3bNoEMqf84skHvJaqGQzbaVtIhgsDepFJYpgkK2s2XZVK/gYgPTqyTlVgAfNQRJaEk6KQX8kUpppTsSLpszysjlfusD1/iFQsMTAHljmesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AzsEjrQc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AzsEjrQc"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626D7qW53330862;
	Fri, 6 Mar 2026 10:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=zCaQE7kwtGBqjOSCYCNF9hWHXs0
	Pch9PxcvAjIwgMBY=; b=AzsEjrQcAj8t6VX/SaWVexLIRLnWwgqXEBqfyh1xmRf
	x+QCthlsgnVewC1abh9P70pMormNs/fNI5htI63szvnnBkyV2khCk1us8SGBlkpi
	QqFhOSAFvWRVF8jvCtUXUF7dFjozsvLEOFjPi+x5XAivsLIMiwQtvXUXvWnrq8MK
	ADhHBJXZI+wurELJYKw6CNTQhnyCJjJsYP7K9BMx5sByH7FdDaG8anhkeYDsd58R
	eCVdDPHaUMk8Lf/karTbQP0T8yEDui3B/isNdw6AwuIXjNrFLUSnQAwm1lx/BJxO
	vc+NdYpqlAolC5HLdYpnXvoagYoiuFILsEsI3SOo0XA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cpb6jvn7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 10:39:12 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 626FdBfH045254
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Mar 2026 10:39:11 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Mar 2026 10:39:11 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Mar 2026 10:39:11 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Mar 2026 10:39:11 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 626FctKt002837;
	Fri, 6 Mar 2026 10:38:58 -0500
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
Subject: [PATCH v2 0/4] iio: accel: adxl372: add ADXL371 support
Date: Fri, 6 Mar 2026 17:18:20 +0200
Message-ID: <20260306151859.131934-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=J4inLQnS c=1 sm=1 tr=0 ts=69aaf520 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=ctuvn1yZz-JjkOzOYcMA:9
X-Proofpoint-GUID: Vg7YaiIMA6ysD6n8jTyfR8VMXcJCqSYe
X-Proofpoint-ORIG-GUID: Vg7YaiIMA6ysD6n8jTyfR8VMXcJCqSYe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0NyBTYWx0ZWRfX0goaqd7ZR5vG
 xWiDoe7RwBVYQWisvYFBrqp8KSyT7rnHe02G4qJ5cqSHExjxDAYS/hPqhyzKXddYXzHtfTUJ61u
 hofUg5ICWd0dXD3sLYJQG/b25W6TPh4xfFr/PisBwweU1ZekPh/PjdNf966Zgz+whe2z62blaoi
 mjZFX4NhWuNFenhvgtie5W6wiMUtTKLNmw1B2oLaGCNhX16+/2t9ites5HfHdveFzB90yzroRn7
 /j7qyi+SZR8nfazR5PpB9CW9Ni4Gk8OfJ+R0qGzKEfxASZ0f3Hz6ipDr/DDRzNn43wqOuYbkebX
 cDRkWcEbs7ciozCb8+t2pD22b9D53aTNIyXDBbDIoK1rTRrbDQkn8D1+jQcuNufX6AUvw3BM4ya
 HXO71ErcGdd+XI5M8Bw3AhWHK1yyZkfDaRmYz+JyGY5wD0cWZ8XaW0p3GHrXMP9OP1u6ErtspVG
 h5Pk/MAmAqwPrdZEfBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603060147

Add support for the Analog Devices ADXL371, a +-200g 3-axis MEMS
accelerometer that shares the same register map as the ADXL372 but
differs in ODR/bandwidth values (320-5120 Hz vs 400-6400 Hz) and
timer scale factors.

The first patch introduces a chip_info structure to parameterize
device-specific properties, replacing hardcoded values with per-chip
lookups. The second patch adds the ADXL371 compatible string to the
dt-binding. The third patch factors out the buffer and trigger setup
into a dedicated helper to reduce probe complexity. The fourth patch
adds the ADXL371 chip_info and disables FIFO support due to a silicon
anomaly (er001) that causes FIFO data misalignment on all current
ADXL371 silicon.

Changes in v2:
 - Switch from custom sysfs callbacks to read_avail() with
   info_mask_shared_by_type_available for sampling_frequency and
   filter_low_pass_3db_frequency available attributes.
 - Add new patch (3/4) factoring out buffer and trigger setup from
   probe into adxl372_buffer_setup() helper.
 - Use designated initializers for ADXL371 frequency tables.
 - Add Acked-by from Conor Dooley on dt-bindings patch.

Antoniu Miclaus (4):
  iio: accel: adxl372: introduce chip_info structure
  dt-bindings: iio: accel: adi,adxl372: add ADXL371 compatible
  iio: accel: adxl372: factor out buffer and trigger setup
  iio: accel: adxl372: add support for ADXL371

 .../bindings/iio/accel/adi,adxl372.yaml       |   9 +-
 MAINTAINERS                                   |   5 +-
 drivers/iio/accel/Kconfig                     |  12 +-
 drivers/iio/accel/adxl372.c                   | 273 +++++++++++-------
 drivers/iio/accel/adxl372.h                   |  20 +-
 drivers/iio/accel/adxl372_i2c.c               |  19 +-
 drivers/iio/accel/adxl372_spi.c               |  19 +-
 7 files changed, 227 insertions(+), 130 deletions(-)

-- 
2.43.0

