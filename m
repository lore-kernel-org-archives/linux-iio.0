Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243501DDC28;
	Fri, 13 Mar 2026 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403111; cv=none; b=gLOhd45xiIN1INluEoz0FFNddDeGhE+btfwu4prXR1xYnCdQF/WxeG18b44js6IuKp8agD/eqHPYIN/b1jLNWhmyQr3OezusoeBvpFX7gSfEgQdWthmNKGJJXeT16qHQ+8X3GQ/+9YnxZVXls39mOPYF/oTZmoTv685Jd1Fn0Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403111; c=relaxed/simple;
	bh=+k+sf/I/cFVWyw0Yzc127mFsOSyMAoO7ELAZsKNEZYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWdpK7cl7dCuUyq/dWrDvljwduH5m68Ih9Im0VFCi2ebHhLbbK329mB8ik4qqFoICzRxafzWIGlRHxNklzzNkzjFM8yvBcLb49TxWLnVQdXBfBx9YXsToOuQsNH5OKIcR3hGujU2vvPsWsadWvTlHXif/GH2+ZLQgQe2r4w7LEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pECmWWPg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pECmWWPg"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DBdIPB3650902;
	Fri, 13 Mar 2026 07:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aYT6d
	w8V0jj4UVYHOcmhzsaaGN3QdWfCCU+wqOx8DVo=; b=pECmWWPg4GavR5xA3wEja
	XWLGzidXHO55xfnZWpo1Z3qusVBTV33rwZeDBDyXNaX7ewTrW/+sozAy5AS6cL95
	EvM2JsGCviHFGsbxMXRftm+Zo6vilrupBce5ZEX97wdlntVcwu+i38uPeoBACmRi
	u5XTdgn/zLuC4uWQUHHtSg36t8wUvWC9wh9hxv/aYS1pGthJpH+zFB2khYWx/xnO
	O+//ArDDWYGlVfm/wbBjTgZK69U2jLhrMU7CPL/c5uHIeZPukme2F1kN6nSXQ34b
	xrsDXTWcguiMJyI2N98Ml3Rv02j8CKCt8h5syPCd9SxnUMr6SREQRyHlP2r32Nk4
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh6bf12k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:58:16 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62DBwFGf017542
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 07:58:15 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Mar 2026 07:58:15 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Mar 2026 07:58:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Mar 2026 07:58:15 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62DBvrv4024538;
	Fri, 13 Mar 2026 07:58:07 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 4/4] iio: frequency: ad9523: use dev_err_probe
Date: Fri, 13 Mar 2026 13:57:44 +0200
Message-ID: <7a43f75f91e94b7c91684cc18b16ed7ee9a91825.1773050333.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773050333.git.antoniu.miclaus@analog.com>
References: <cover.1773050333.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: PVBpZhCgYpgr04ruIph0uX7pqYAL3nJm
X-Authority-Analysis: v=2.4 cv=c6amgB9l c=1 sm=1 tr=0 ts=69b3fbd8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=uzGMpvntIC49hWhQwZ0A:9
X-Proofpoint-GUID: PVBpZhCgYpgr04ruIph0uX7pqYAL3nJm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NSBTYWx0ZWRfXy0cmVg0slPjn
 pT+/8TjNM8fAXun+uoSxg2LZH/e4DYEhcEcQJDSGwV/gSUWB55bmMQmq66LPV7xnUlD0efGvcu+
 HS7lwr6+gu1ILS6rWLySkE5+JPHn8rjnAT8y6URezmlG+gn26+Qfd+5zsNvx5RtP9cTKCB22oMs
 SGMcpKCDb6mziVtcjUzFZAxciJE7Hz0louXkAUHFSuKMRzbDn7yGZHLldoSGdl8eB6EfxsritDC
 Zo7RkkXi56W5Brq6pZ9JrWqd6NOdIneh8ZOHcJR2DjRoU4IVVhiflr5eXzoJHBbbt/iCQXJW/mE
 8u0x6pWUzwLTxPwxyU5SrANhh+8SXSGyxSJfHmz8nCx8MXFp3TkgntbeYYG1PLQMiqscA+Y10bs
 7meEvcI0ql2KcSGHujYBYnXoNIEXOp3FDcHkLKDU/ZUmR8hus/n3ZbbiJffhYofWAoA3MnlJPt4
 NHhap48pDQTMXHIsRQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130095

Use dev_err_probe() instead of dev_err() in the probe path to ensure
proper handling of deferred probing and to simplify error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
  - No changes

 drivers/iio/frequency/ad9523.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index f4e80ea0c6d2..ea4d2763564a 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -955,10 +955,8 @@ static int ad9523_probe(struct spi_device *spi)
 	int ret;
 
 	pdata = dev_get_platdata(dev);
-	if (!pdata) {
-		dev_err(&spi->dev, "no platform data?\n");
-		return -EINVAL;
-	}
+	if (!pdata)
+		return dev_err_probe(dev, -EINVAL, "no platform data?\n");
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
-- 
2.43.0

