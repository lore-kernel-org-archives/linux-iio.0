Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8797F44A3F1;
	Fri,  7 Aug 2026 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093129; cv=none; b=boJbetII9XwfYvZ0zpc3w6iH/m7s+r1ciYR1Vj/jrqbo39m86mdUCsX/QPobxdtzLZJ9NkY+++iBspxneOUavu44ZUEDWt1IgbQR3vx+e5tAakz3gve8PWvok0rAk3/tG5Q9Fu+CWgRlvtjK39YaOuZRfxKeBwDBtnsA+whGpkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093129; c=relaxed/simple;
	bh=01Q1OoSo5DB4Bu7IXeXSucIYVMXiyPiuqcs+rY6NeTM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJwKQSVqmEVTRYCLyHAE3X+ty2Pa9+tLDoQHiyxXwi84+RRFxOnGBUwVZk1sKRw2Q4z8c+affzxtZmTZtfpP6n5gKuNdXs+7hgnRdnBV7LF1lOyjjQ6eHFWqNmH94Q4lRjH26YBaCe4kvDCerEm68gLSzfsgdXoQZpwMkP6A5lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IEUKj/NS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IEUKj/NS"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6776E675956453;
	Fri, 7 Aug 2026 04:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0OBOF
	Q5B3stEg78LZr10vV9aUz2ZQk22m6WmNe3TGOc=; b=IEUKj/NSmPHvV/TqSXL4H
	kZkTQFhBLCeKTh2DwHLWVWPiKA8lGuHb37jfpszFSxmmVXy2MN5nUqNmNHUYsyx4
	ltfAJFOydN2O7oA8xnfJI5yj0/meLx5/2eyKT5d5jl+eHUQO6iZBRrlGC1NPpaMc
	2FdDCdVxUK5RnKNqHKGTsHJoGlrK1jTZcTO7qh16wqA8aNl7upUoPZuWVnZ7gG9b
	RnMQVdrYlfH2GXnFUMfF80kEA7eq7zq5N57GKZBiRUvz0SZUoqRPGjNjGSvLtM+F
	XfROuJe/GdAFfG1/lrh26pBsVR0XzaRBqRO8jzGPSkkQ+c8AfkZYMx2HsRrQHjMs
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fvp4ty0et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 04:58:44 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6778wgOk059720
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Aug 2026 04:58:43 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 7 Aug 2026 04:58:42 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 7 Aug 2026 04:58:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 7 Aug 2026 04:58:42 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6778wTrB022705;
	Fri, 7 Aug 2026 04:58:36 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] iio: adc: ade9000: request interrupts after powering the device
Date: Fri, 7 Aug 2026 11:56:41 +0300
Message-ID: <20260807085643.5502-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807085643.5502-1-antoniu.miclaus@analog.com>
References: <20260807085643.5502-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: JBMpcJ_-HoAiOT93xNymD1PEi0ostkkF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2NiBTYWx0ZWRfX8jiW0unXozh/
 y4s8ovQPW52b7a3hfEQEWrR/p+Mh9RY9dfdR/xhchd6w0EZU+BftNvhFpygI20RRotTy1kRblut
 yGIcHJRUlGqUkN1I4sNgb3Cd6atx/h94BcNYbEKaOr8gRnDCy10Em1Aufn+E3HrDSkR//Uf+nf8
 izWRbCIyWy2msuBTDPXY8IDL0hp8PWrzE16RbqdhAkHW93jpyoR8MONvamTHqzwCJFO5LtBcPl8
 jSPAnmRUo1L1WfKg1bCWHywlgmr3gk/JFBWLhpJntbU2iFbRXozODOde2KCY6QdvnsFlVlWL5sK
 /zAOp9lYTaGNYneoZe1ZG8lvzSDU1cHMJlaLcPgabMuPlwt21T5XLhaAAw/tXC9KgEn8YIzn7/C
 1YaNgZg87aJWB4WeiFl5whyQryU+4eFeDjPrv369Hd7Zg+ex8dhTRscFmI4MvYK1rUViG9Gizxm
 77x58Pb75Re1IT9qnTg==
X-Authority-Analysis: v=2.4 cv=CIYamxrD c=1 sm=1 tr=0 ts=6a759e44 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=-ElmzxKXR75nSRxw42wA:9
X-Proofpoint-GUID: JBMpcJ_-HoAiOT93xNymD1PEi0ostkkF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2NiBTYWx0ZWRfXys7jGtUV6PqF
 ggYNe0J9Qbu5ea/t05vyhDko7pyf8iHuhPBEwGqXi0I3PW+l/BMyACHnPmhrmSNAKB4tNqib1to
 4+EBY0GZXuCMuTSwUin9wtYvTffxsrjwxAd1issT3Tq3/Tu5QNWr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070066

The IRQ handlers do SPI register accesses, but the interrupts were
requested before the vdd regulator was enabled. An interrupt arriving
while the chip is unpowered runs a handler against a dead chip, causing
SPI errors or garbage reads.

Request the interrupts after enabling the regulator. This keeps irq1
registered before ade9000_reset(), which waits on it, and lets devm free
the interrupts before the regulator is disabled.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ade9000.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index c6c3ea953fea..51cb43755a1f 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -1705,18 +1705,6 @@ static int ade9000_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = ade9000_request_irq(dev, "irq0", ade9000_irq0_thread, indio_dev);
-	if (ret)
-		return ret;
-
-	ret = ade9000_request_irq(dev, "irq1", ade9000_irq1_thread, indio_dev);
-	if (ret)
-		return ret;
-
-	ret = ade9000_request_irq(dev, "dready", ade9000_dready_thread, indio_dev);
-	if (ret)
-		return ret;
-
 	/* External CMOS clock input (optional - crystal can be used instead) */
 	st->clkin = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(st->clkin))
@@ -1736,6 +1724,19 @@ static int ade9000_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, ret,
 				     "Failed to get and enable vdd regulator\n");
 
+	/* Request IRQs only after powering the chip; the handlers do SPI access. */
+	ret = ade9000_request_irq(dev, "irq0", ade9000_irq0_thread, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ade9000_request_irq(dev, "irq1", ade9000_irq1_thread, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ade9000_request_irq(dev, "dready", ade9000_dready_thread, indio_dev);
+	if (ret)
+		return ret;
+
 	indio_dev->channels = ade9000_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ade9000_channels);
 
-- 
2.43.0

