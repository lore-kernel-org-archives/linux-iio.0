Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB359473C89;
	Wed, 22 Jul 2026 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706918; cv=none; b=h3rGWToD3sy1Vdv9VzjjVm5YfjO+VNBquouRIHXHnhRkgZ/qNjuljfx3I7EIpnbG5YNXOai0/efcx53WXlWxfzrvKIN1Gp6CYPeyYSLbjB40FA9OhkS1SqK6fo+MbHWERU4DDZ5Va6WUKLCv8i975OcTkMGpqxFUobpY2YE5DVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706918; c=relaxed/simple;
	bh=LVCg6ZEYQJvO6Rbz0tpTVChpr/UYOzduuJ6ncVq3GLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qSkClVIthzBSz1CGM6DJjfrjTQBG5Ci8Hdp2juCeaRlDIy6OEyA/Rt8TuxO3Z0mqFDSL678TqZDglVsLYeGO542/z1Jgb9ND8YdHRFuP0s3l+VQL5fF+VLq8C1gjpkbmokGKsuiTITWPc6IeRKvY2yfqVytwQwbmpHDYWGA023E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g7RGdHyB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g7RGdHyB"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M54eZd2558557;
	Wed, 22 Jul 2026 03:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TNPaT
	qBwEakDqLkAXc5BVi6J3bHl9A+ArvnJz6DsXfQ=; b=g7RGdHyBaUhiwTqg6IFbL
	ZboGyZidAG7XVO/spCnQYsItq87H7oMV7N6AI5YcPNMfHo/OOKNh9yM+ZU4ShsTI
	HZRW+fK0cc52SM0D8GFR080jUTqUHtZXzV/Ry+rp42yN612ZAZwehPX0u0WJF9Hw
	KuIdbdJaVlhZaT5TUo9SeZ/ZEDw9EevoMSGOfK1CmR8EYTTvgfnr8NxEXF8lHrWt
	7zTR5UvmhKK7twkrYqC3TdVznr1+uRVOWWGEu1nyDhaDnTK70WrTo/dEFg92+n/k
	6naXu9886cC4O2cLVxX5n4bv4EIibtepz5HIdf+hydCr/VVpTO7BsLFsGIUCDUx7
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fjnd9h11v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 03:54:56 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66M7stjv060609
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Jul 2026 03:54:55 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 22 Jul 2026 03:54:55 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 22 Jul 2026 03:54:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 22 Jul 2026 03:54:54 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66M7sK4o006639;
	Wed, 22 Jul 2026 03:54:45 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 22 Jul 2026 09:54:15 +0200
Subject: [PATCH v7 3/7] iio: adc: mcp3564: Add support for spi-device-addr
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260722-ad5529r-driver-v7-3-7781cd74ad75@analog.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
In-Reply-To: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>,
        Marius Cristea <marius.cristea@microchip.com>,
        "Marcus
 Folkesson" <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784706860; l=1134;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=LVCg6ZEYQJvO6Rbz0tpTVChpr/UYOzduuJ6ncVq3GLQ=;
 b=fMtc64ribz1V4wmvqLlliTt85SvmzOx/nigrm+kDoVDscqEQP77TJHiikCLfOcq3R3FZ47IEZ
 5tBT0OKnlx1Dwse61+4radGhr1eYYe3E7X/yYTwqt4rgD89Bzyx3ClD
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: JYfO1lrbmN2LjzVd_dP5WHFRbPyvNeBn
X-Proofpoint-GUID: JYfO1lrbmN2LjzVd_dP5WHFRbPyvNeBn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MiBTYWx0ZWRfXy6tEyAgv1jfx
 QsIfVS9S5S0RAL1Om4/tipvwG4t8AoyCADSLixrxozCBdJl19gKdt9hPQH2tPLsNwjVzcCTgNor
 bWGCrB2wGDyXk5YG5l82g/qXiDDpTcYRKFL5O81T4bd/pEfipIV/cgmfxKkgl+BvEtYkZsUQ8BW
 vUKEkaXozxLwx9qfylfgn+84Cb5rjZL69XoMSkOLK5kdhBItMOVEooUOqlDgAzKgIHnWAR3wz76
 iLYTm70S5Hupkx+BwfxKez7yVk8qN3bjEiOs6Q/J3u1fRA2XMD3Zj3Hg4vIhZjXaWhCv0E8bVlR
 KTRmIpb2Lqio+21ji/bkjR2aUYOgdprW5ZhQ+v7a3nKTmVfg2VSFxilYQPj8BTKOJg3bEZZT4mq
 mHANz9AZPo5YIXTzyLvlxeNM59876GMskz457cvUGHZ9rwxoL1yCOQc3kbYLFgRUjNvlXD5+/J3
 jvfYgdxoNR0dkAnT1mw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MiBTYWx0ZWRfX+aZSWZWtMyq4
 TZUVUBgco6RVULc00gY/njRc+dSkvvIW1EN6GOZefO4Nea4wtSL7UvHVCLRrbpdc5B5JnUhuoWq
 YKesX4VeQQB9dUvD1vY+7zcOggVG7DcrEUijsHKrHGl8R8hNdZTD
X-Authority-Analysis: v=2.4 cv=BYHoFLt2 c=1 sm=1 tr=0 ts=6a607750 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=YFkBFquRG6JSY03WmVMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220072

Read the generic spi-device-addr property when determining the hardware
device address. Fall back to the deprecated microchip,hw-device-address
property to preserve compatibility with existing device trees.

The device address remains 1 when neither property is present.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/mcp3564.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index 36675563829e..71deb05e878e 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -1122,7 +1122,9 @@ static int mcp3564_config(struct iio_dev *indio_dev, bool *use_internal_vref_att
 	 * addresses are available when multiple devices are present on the same
 	 * SPI bus with only one Chip Select line for all devices.
 	 */
-	device_property_read_u32(dev, "microchip,hw-device-address", &tmp);
+	ret = device_property_read_u32(dev, "spi-device-addr", &tmp);
+	if (ret)
+		device_property_read_u32(dev, "microchip,hw-device-address", &tmp);
 
 	if (tmp > 3) {
 		dev_err_probe(dev, tmp,

-- 
2.43.0

