Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FA93B6343;
	Tue,  5 May 2026 04:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955732; cv=none; b=C8psJMLsYd7PGZUzubMq8M0yiPqBJ3wRwJOxTxoNDjXTSpNwFDasY6yZW4vsyHEI97In9FmClPp97qG9YaTse0BVIF3/GoohYVX4HMaw6tTNr+cPU5Zof3toSlqmX6Tc0M9be6yqPMCLGhGkhTvrMdqmqwCAzOwUqpB2JIVXI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955732; c=relaxed/simple;
	bh=6eiP5+l6TITQQLmvxwIHtBIuCwNWVngHb+YVOHdGLio=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=t7qhe5zgfQJid1O5pivlZW+5duVCiVyL9TU25UhzWzL5bNE9QWFX5VCMO07fH41e1OawG5gdehIQcH2g4ZgdBaJ1/brlA/QLAMCzDjIwB4K/+tX36VUU1lCSF0Yfvxm7V5IO6zyyVvPut/3Cjc2VndQjfDUu7tLR3rYb8JuOCVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xwHOk4yd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xwHOk4yd"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6450ojRK025250;
	Tue, 5 May 2026 00:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=5lEe5pQHoDHtES9VMO5Mk03ETJT
	w2JW5T70LT3KmInA=; b=xwHOk4ydtdNKIeGmTE+Z81lUcYhwy8ybqsSauC+QP8J
	1XmiHQT/Dkz41zi4LT7ZYmUNWDvNgNcbA2yQdR9gF/aHb1qRtKMKlTFo94aMDk9R
	4lju9GSmBbXMQe0ASLeEyBnkvrv1BaNRUs4GIGgpJEYcEGhEFH97bvo+1i7rk+Rr
	odZE7JN5dyeFybvzbnATwcVIWdKaIqBO9QZcodrLQAftadplEir2ZhF0q5sF4Bel
	WhbnqrQgLs+f5Z+A26gB5XaT7QgvtjyIYrzLbZew273dl/QQHcUAWeyW07zxUwRn
	xUsEp8K5TGnyQEf3BaLBYcNEl1+QRSDHokIUVH9o9xA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dwe619ha8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 00:35:03 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6454Z1Be053887
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 May 2026 00:35:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 5 May
 2026 00:35:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 5 May 2026 00:35:01 -0400
Received: from 10.32.17.67 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6454Yn1O006142;
	Tue, 5 May 2026 00:34:52 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH 0/2] Fix AD3531/AD3531R powerdown modes
Date: Tue, 5 May 2026 12:34:30 +0800
Message-ID: <20260505-dev-ad3531r-v1-0-2b4cc55f69e7@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFZz+WkC/yXMTQ5AMBBA4avIrDXpT0q4ilhUO2UskBaRNO6uW
 H6L9xJEDIQR2iJBwJMirUuGKAuwk1lGZOSyQXJZcc01c3gy45RWIjBpFG+Et7UVEnKxBfR0fbe
 u/x2PYUa7vwu47weUIJQNbwAAAA==
X-Change-ID: 20260505-dev-ad3531r-2a3091fc7c12
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael
 Hennerich <Michael.Hennerich@analog.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kim Seer
 Paller <kimseer.paller@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777955689; l=1030;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=6eiP5+l6TITQQLmvxwIHtBIuCwNWVngHb+YVOHdGLio=;
 b=gasG+VFOdWnFzoYc6RsMeFXcYEj23kr6KYUb+X16tIS2DmPyc1y8vEcOYN7WrohhoWiszyINJ
 wUeQqkqgLq8A+WjN85A7WTaIBvE8JHW9zIn5xKCYdFKkYMI17PNTipo
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAzOSBTYWx0ZWRfX684d97J533a6
 WH+9i+bSeLwM2O6MOKkEq+0bbI/S6J2NfP92PXGCSWuR4bjTKfh3gAOzx4k+ENkCXqtea4g5DKB
 dD8lHrlM59vaHWA+yYsYwMxsaBZ2PdE1vXhVfwA/BxXwVpnlyhS7EkQ/fEm2xcNNPNMX3os19OK
 WgxST4/2zgik8+aa4yr/ouEDOHFqT6pIHmT9f3z31Cdp2ksj4iDlrYK1Q8vmoTx9GVNmjLUU95J
 JXCrX3hh51wULY8dgYV6iPt5jM4uByySX0KuAuRNJR9vrzOKgW6OpuJjk0RwY1oCXRniwB0irwc
 28s9VGPgxCpbOTnYKT7rnEBnUpgp5tvUy2QY1swi9tAVXD+nuCvJgXnZNGhH2LH0QjGX55P9w8l
 xoqaLFKCEFgFNChCQ8vYyFs4NubRohT7YKyJOwvyFD8svAoqezzl3Rz1Z9csFCtE3k8ja2goHJT
 bgKXlPIJgi7P2SF6QVQ==
X-Authority-Analysis: v=2.4 cv=YcONIQRf c=1 sm=1 tr=0 ts=69f97377 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=TSH7G3D_ptFMAbp37CsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lT9h3rYYEvHlZ0QUvgWqvItKotYYFh-9
X-Proofpoint-ORIG-GUID: lT9h3rYYEvHlZ0QUvgWqvItKotYYFh-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050039

The AD3531/AD3531R has different powerdown output impedance modes from
the AD3530/AD3530R. The driver currently uses the AD3530R modes (1k,
7.7k, 32k) for all variants, which is incorrect for the AD3531/AD3531R
which has 500 Ohm, 3.85 kOhm, and 16 kOhm modes per the datasheet.

This series adds the missing ABI entries for the new powerdown modes
and fixes the driver to use the correct mode strings for AD3531/AD3531R
chip variants.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
Kim Seer Paller (2):
      iio: ABI: Add DAC 500ohm, 3.85kohm, and 16kohm powerdown modes
      iio: dac: ad3530r: Fix AD3531/AD3531R powerdown mode strings

 Documentation/ABI/testing/sysfs-bus-iio |  3 ++
 drivers/iio/dac/ad3530r.c               | 54 ++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 14 deletions(-)
---
base-commit: 39b80c5c9830d12d2d6531059001301c4265322a
change-id: 20260505-dev-ad3531r-2a3091fc7c12

Best regards,
--  
Kim Seer Paller <kimseer.paller@analog.com>

