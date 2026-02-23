Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99B35B64E;
	Mon, 23 Feb 2026 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848008; cv=none; b=PUjeYFZvP2T9pnuZSXQgJk9v8smjX+3WGm5x/l3q3blSIPMT87DDjRveROg2eHkKvwat3DO1PszrxmoegpHBNgCbXuUoNVKFYZV40L3foIuyjorAaZvE/5i2S1dzSmK5c0KMghprUOSuNF+Kl/nBIpgFwp0SzvgJju0H5c///gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848008; c=relaxed/simple;
	bh=TSHi2QcPjsTf3sTc6kT7lrBBkZuicJfI9Uvo/EGLq6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeWa3DtXiHLazpjiBtmOK/d9qHzNTxLq+j1ssBmDl10KyNXSawwVj46BUjBCiUQypcIVcbfB5MU1TvDz5Qo7eZEA/FbBl4umPJntrYBsvyBgmWjOHRHxM6cphBN30l8YoXpCO/QEzpVGoSyGi11+Tzb3qqvVWROI6VQoX4KNgW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GwmQn9dx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GwmQn9dx"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N6nDba1743194;
	Mon, 23 Feb 2026 06:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Jf7Og
	tSVNZ2cNvuLt9zMrBs6tKnGFvMZwtNRhbnZSPI=; b=GwmQn9dxbyT8Twu1I9qGR
	KB5pig15axMwDLfb8QNV5R5A55KZ8mvo4mTTJ0sb0WxSiL6A52ffELYHGiwsB53y
	CwaPA5brrAFhL2DZX+sbNlNID7dMlj7nwMOie86LAgknWNMxyIj1CSrECX98IrR5
	jIvOct+DZv3RE/6781pXfZ0TKGX9Zsvf0JI/u58M9+3wHwOJ4e+7KmM4kK5NqprY
	8L10XNgxuOqAWzQe+N9DQFYlYRifHoBzWxrZherKVqlYD422OPbqXGHKIVvnLgYw
	i3XGX7jysCEyYy81e5lAF5pnG1rc67RhAnV7y6HFkvGtzWG/sfJXMzr271ISovpw
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p4jvb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 06:59:51 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NBxofR000995
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 06:59:50 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 06:59:50 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 06:59:50 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 06:59:50 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NBxZX8017968;
	Mon, 23 Feb 2026 06:59:38 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH v2 2/4] iio: adc: ad7768-1: remove switch to one-shot mode
Date: Mon, 23 Feb 2026 08:59:35 -0300
Message-ID: <19d4a44bae3561ca7a3e608dd657de0480f35391.1771362939.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1771362939.git.Jonathan.Santos@analog.com>
References: <cover.1771362939.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwMiBTYWx0ZWRfXz7s1OdZKfX/o
 W6Prsnhj5Do8+KH+lDfB4T9v5Um1SnbSHiH1uGm1EMsvmbqEDQeNVbbPmkqLJ2m9QtWZSQkYIOO
 z7B7Y4FgYELZNfeRgw0Fc4CRDIoAh2MzA1ry3mFhnYw2oKXQTFk/K3Ke+GItVI/LOUDB0Vzm19l
 JmbSKMAxejr0hOTx5z/ndBqLCXnzE4KV94m7cwc1ZgOpMkT1FaTVU7ECRHNEtOov49ZuarFz9XW
 brdiHzrZ23AcWfy4WXP6EqD5eLPYnolUv5ngZTYkc7H3d1Hv9LiN930IIgcZwgc0a5GCdhw61DL
 XOcoXzzK12OBlqGfR76cDbj/hhc7Jd3grh1fgOgcH3mV6/SUCb/Q726l3dgBBmX/2HOuc99Afh9
 o7GbKknd0PRiTIb0kJ1Ic8VWHa+USp4gJ1WanA029YyJE6tJ1wnvMBgQTbN5kbWFUXaKfvxyh6Q
 VV/E1vhxkeRJE7+rHkg==
X-Proofpoint-ORIG-GUID: dhXIv5dA1W7UvOCcHgiMbajKMAbo1nAb
X-Authority-Analysis: v=2.4 cv=LfgxKzfi c=1 sm=1 tr=0 ts=699c4137 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=NJqpzZaRi1aEPO-UgL0A:9
X-Proofpoint-GUID: dhXIv5dA1W7UvOCcHgiMbajKMAbo1nAb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230102

wideband low ripple FIR Filter is not available in one-shot mode. In
order to make direct reads work for all filter options, remove the
switch for one-shot mode and guarantee device is always in continuous
conversion mode.

Fixes: fb1d3b24ebf5 ("iio: adc: ad7768-1: add filter type and oversampling ratio attributes")
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
* Instead of restricting the one-shot mode for some filter types, remove
  it completely and guarantee the device is always in continuous 
  conversion mode.

---
 drivers/iio/adc/ad7768-1.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 4cb63ab4768a..a927ae288fbb 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -463,17 +463,8 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int readval, ret;
 
-	ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
-	if (ret < 0)
-		return ret;
-
 	reinit_completion(&st->completion);
 
-	/* One-shot mode requires a SYNC pulse to generate a new sample */
-	ret = ad7768_send_sync_pulse(st);
-	if (ret)
-		return ret;
-
 	ret = wait_for_completion_timeout(&st->completion,
 					  msecs_to_jiffies(1000));
 	if (!ret)
@@ -492,14 +483,6 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	if (st->oversampling_ratio == 8)
 		readval >>= 8;
 
-	/*
-	 * Any SPI configuration of the AD7768-1 can only be
-	 * performed in continuous conversion mode.
-	 */
-	ret = ad7768_set_mode(st, AD7768_CONTINUOUS);
-	if (ret < 0)
-		return ret;
-
 	return readval;
 }
 
@@ -1248,6 +1231,10 @@ static int ad7768_setup(struct iio_dev *indio_dev)
 			return ret;
 	}
 
+	ret = ad7768_set_mode(st, AD7768_CONTINUOUS);
+	if (ret)
+		return ret;
+
 	/* For backwards compatibility, try the adi,sync-in-gpios property */
 	st->gpio_sync_in = devm_gpiod_get_optional(&st->spi->dev, "adi,sync-in",
 						   GPIOD_OUT_LOW);
-- 
2.34.1

