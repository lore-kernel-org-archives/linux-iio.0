Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9FE481AA9;
	Thu, 13 Aug 2026 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629484; cv=none; b=XaLIqvtEsHIMQiVc+uGeoSCr2PlOSxeqO94pwGlDVuan1FmEZdBADbBGqCEegYanzAlUQfGH/lAfq+0nEcJewTH44te6slU+OgGqUrwTNy6j6/b6R/6hOO5Vuc7aYAazz6zm4k+CkWWgQb+V3r8AQCdGlnVMk29ka4APKzFygWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629484; c=relaxed/simple;
	bh=Ia5cdUwhQp5bspVUqQ3iF/ZRqYMDFIcD31k3fE8TCuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ryALwYoe8Ac3QRbjAsbsbKX8UxSwLoiEtzWCTHzx8RMzKoPGCYANH+nTXayDMBP6ZfV+sQENEIlBj7njGGj4QqbEnEC8GI3/SsIzp1xxMwekfoMFUBQAYS4ZRexd1tt6J7Y6z2xOahldHksy+juNtvRKM7L410ks8n831/OXaqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Jp2qA4oz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Jp2qA4oz"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCa9Gs2129073;
	Thu, 13 Aug 2026 09:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=isQfr
	O1kOgift38KlUFUSiekVqhdQPQpvCxC62CsfNk=; b=Jp2qA4ozg2FT0P35xFplQ
	LnyoOsVGx+TDIGHKnUtg9TvZhlSew8u+P3oIBKS1Avos/a1nB0JGtfg6tDnTt43v
	VzuPbbcQLM5d9W+Dzsel7zI9yqAKBgoIZjfCOYXde717Og+1MXI4qV+aIfypqaVT
	0GZx8CX1lvSRK06gowsTHjz8wcOVCg4U/Ezak3MOmQHGxTxe20fjqPZ6Zx6//Dp6
	CCWTdp0CKPryp0Sd9KiBj88Rlc6rI+0KcOzt1ZD6liFqcWZeUpkfl/n9wdeUCN86
	rHJLWLomgYmsU7eQJ7yuRqWbGKEG5rX0fl2Xrs1yZSTQ0py6Wd79QLi83wW9BNxJ
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e2wgccd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:57:52 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DDvpwH024627
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 09:57:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 13 Aug
 2026 09:57:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 09:57:51 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DDvOwV006802;
	Thu, 13 Aug 2026 09:57:43 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:56:56 +0200
Subject: [PATCH v3 03/14] iio: adc: adi-axi-adc: Initialize state mutex
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260813-ad7768-driver-v3-3-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786629444; l=880;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=Ia5cdUwhQp5bspVUqQ3iF/ZRqYMDFIcD31k3fE8TCuc=;
 b=oQfK7VzcS3kp6oQYyevlMmhFpg9D/2WaT/V2fzCyghFgvUgzem4uY7gUrUrjLAkPSt152NsVV
 9g7frGVSZ0XC7aXiFS/0kMSwx3x7c2rzQo/xhiLyLAaxU/BPpEIIFHR
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfXy+p3SRv2nYh1
 T0VWlYXdZC/9d98P5zDQeBSsorMzSrLGeMO/T/RoHv8xRDooob/pDX5EF9QYi+vHqyA6uSsgD4d
 a7AwyFi3k0//TLQ/197Mfpt/XLV2MhLe01NDyCS+909GWdhQHD8X
X-Proofpoint-GUID: rOKYSVvznp6u39O8MfQo8CWUhGxkzZcN
X-Authority-Analysis: v=2.4 cv=UJzt2ify c=1 sm=1 tr=0 ts=6a7dcd60 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=_ljTvifiVFBlT2kRk7cA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfXyLTU2CKwC1n9
 jLZW5NWgvawqXjkHo4hjQ967CS32it49node5i2GXfW+vODCHBrUgB03TMj0XAz8XFtj7Ld/oA4
 DaQ+LSHMYh1DpOaOWTqKWsJ62mEGkltNPlvErtZu+FHzIwSOwl5Cw5rv5Emyc/sqcYDDSsyABdY
 hppXhwSrrfs8moM7HY63f0rg9JXqQp0Bz/z/jLm7+5VHpKp2kbZ/heUS5L0PfZOJY4O+MRroCda
 3RS9sOUMPNM+83A1H2V2WLq7x7U2wXQXM+iVUVlzz1/wBYEEn80W8yYxRYllmJRcscxtOSI5xwP
 N+knlZ7J1cudv+rLnaySE08dMGyopIPozVIq9m8OtuiGE2Md75P2QgODHFExZq0TZPbaolRMrKG
 rtq+9UjbEAonXgt4yj3JBsLcRPR4Ri7QG+EwQXpr0BcaAkenxE9vFNbovmo2vUkw4BNTDyZCilq
 AVm3NXNMi5hMgG3B5cg==
X-Proofpoint-ORIG-GUID: rOKYSVvznp6u39O8MfQo8CWUhGxkzZcN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130099

The AXI ADC register access paths serialize transactions with st->lock,
but probe does not initialize it. Initialize the mutex before registering
the backend.

Fixes: 7ecb8ee5c93b ("iio: adc: adi-axi-adc: support digital interface calibration")
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 26b9c75bd4d8..b5e59b1871b6 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -684,6 +684,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (!st)
 		return -ENOMEM;
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);

-- 
2.43.0

