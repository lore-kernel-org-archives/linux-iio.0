Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAF1DDC28;
	Fri, 13 Mar 2026 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403107; cv=none; b=Db0M0wsF5BHCdJWhtzFX5TteWqOt5gwW0JuWpoqgZIahRY+L5HgwhHoQUv4oA1baB107KQCvBm9Fq3LOwK7NwLfFMkUsETB5wRoibNRcb0EyRAwkmEZhbo/YUIjYB6n/owIkHjA4/Ozj3nA3GLG6PY/pkVZJSwkfcg5ewk/av8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403107; c=relaxed/simple;
	bh=0saWHYlJvZSqOR4C0RQY7CuhVYF35JGzVKzonDuEVF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6EoMsbWr6oxI/V859x24raUqpzMgIJr6yxQFksRQiR1GPkpn0HFKRcU/J/svRwxUxJ9fZIQGNJjHE0IIQiJ35JjgFUCClD5EzrDPs5zLk0zirO3vS6X3nJM4TbchyJ0TA7lgvOov7z/ON1HqrZesk/Cc4lwm8wY8m+zZ9+7M70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eSACi5lQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eSACi5lQ"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DATGCi3650897;
	Fri, 13 Mar 2026 07:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SLd14
	gYSeEuzgXs2UReCp1exp7e4AuntZeqie1uXqf0=; b=eSACi5lQjtbrVeY1RfPLi
	bEmqGYDNLFpF8TO9afrbn7SrURM3dXgYn5yl1hA1+DTHq11hr5T+WAUFbxQs04H8
	LEBr/MaEobL2ZjHRiUFUAiBQ1QI6wAA3n/hvAQ+TqEVcMGf0fBqUrKHTKl5GEuga
	EJ2kK0JgY/l+jXJPju4AY7NrEwZOxCLWcj+0aAZHaB+dnaPksytCjKC+eDyoeX1y
	7kz0eVx+zdRxo3Lw7UwjpiSAAvgUcmB7pEkpDsIe2/lPcj9wKzAIP8uXoZ7nT170
	UGMYXwqb0iCGPsPaonjIUTQuOfIuoH/QdqpUQYsak4FpE5lc52OxX4L9+xsjFONT
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh6bf126-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:58:10 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62DBw9Fb017524
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 07:58:09 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 13 Mar
 2026 07:58:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Mar 2026 07:58:09 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62DBvrv2024538;
	Fri, 13 Mar 2026 07:58:03 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v2 2/4] iio: frequency: admv4420: use dev_err_probe
Date: Fri, 13 Mar 2026 13:57:42 +0200
Message-ID: <5f839124a0f831664fdf650761e70f058627e4d8.1773050333.git.antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: jiUwty38oFMtvHiySczuvFPFdeE6e4nq
X-Authority-Analysis: v=2.4 cv=c6amgB9l c=1 sm=1 tr=0 ts=69b3fbd2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=nRDzGk8YMT79mXSh_94A:9
X-Proofpoint-GUID: jiUwty38oFMtvHiySczuvFPFdeE6e4nq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NSBTYWx0ZWRfXzG2w59sOFmE4
 UHB8fS1ycBITtzUAj9BYqXa4cYG2htY9E054v0UEpckhe1Es0Vc6tUOFLt6e+OG5cC7892yyitW
 9TDs62hUZzyBdwKw3HEq+fjRFZc25sibXkm621zBhzF9dx+vrQ9bn3BxJEeVQuPoMlqluM+zzMo
 HetLOd4C2TcqAtHM/nzjLl+vpVYfrLfFxR3jzPOEKf2/+SvehVqFqouZd7MjsLSAKepfe2/AFw7
 2Zgw1W4rKoQOKEnWGkAwWnRA5smdEzJ9STnd8z4E9ApO80ki/7pa6ArnqWEvGsE8X6Pnlo2v7xQ
 +EURyv622Tn5KQVTe26Hoad3zkMRNJYNwvDKDZh+2lXTOmTVBwEEyV0rMB5nCXUYyC35Of2dM8f
 nPj+w8/sALOGJWdRNYNdxy+3TX50JYGDo0N9LPongkIl531Xf3jiCLlxHxfGUYIOVTKwduSNI12
 2o7D2DFEsINiSMK0ENw==
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

Also fix the format specifier for vco_freq_hz from %lld to %llu since
it is u64 (unsigned), and add missing newline to the error message.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
  - Fix vco_freq_hz format specifier from %lld to %llu
  - Add missing newline to error message

 drivers/iio/frequency/admv4420.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/frequency/admv4420.c b/drivers/iio/frequency/admv4420.c
index 6ebfe08fc211..618511eddfb1 100644
--- a/drivers/iio/frequency/admv4420.c
+++ b/drivers/iio/frequency/admv4420.c
@@ -279,10 +279,9 @@ static int admv4420_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	if (val != ADMV4420_SCRATCH_PAD_VAL_1) {
-		dev_err(dev, "Failed ADMV4420 to read/write scratchpad %x ", val);
-		return -EIO;
-	}
+	if (val != ADMV4420_SCRATCH_PAD_VAL_1)
+		return dev_err_probe(dev, -EIO,
+				     "Failed ADMV4420 to read/write scratchpad %x\n", val);
 
 	ret = regmap_write(st->regmap,
 			   ADMV4420_SCRATCHPAD,
@@ -294,10 +293,9 @@ static int admv4420_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	if (val != ADMV4420_SCRATCH_PAD_VAL_2) {
-		dev_err(dev, "Failed to read/write scratchpad %x ", val);
-		return -EIO;
-	}
+	if (val != ADMV4420_SCRATCH_PAD_VAL_2)
+		return dev_err_probe(dev, -EIO,
+				     "Failed to read/write scratchpad %x\n", val);
 
 	st->mux_sel = ADMV4420_LOCK_DTCT;
 	st->lo_freq_hz = ADMV4420_DEFAULT_LO_FREQ_HZ;
@@ -305,10 +303,10 @@ static int admv4420_setup(struct iio_dev *indio_dev)
 	admv4420_fw_parse(st);
 
 	ret = admv4420_calc_parameters(st);
-	if (ret) {
-		dev_err(dev, "Failed calc parameters for %lld ", st->vco_freq_hz);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed calc parameters for %llu\n",
+				     st->vco_freq_hz);
 
 	ret = regmap_write(st->regmap, ADMV4420_R_DIV_L,
 			   FIELD_GET(0xFF, st->ref_block.divider));
@@ -369,10 +367,8 @@ static int admv4420_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(admv4420_channels);
 
 	ret = admv4420_setup(indio_dev);
-	if (ret) {
-		dev_err(&spi->dev, "Setup ADMV4420 failed (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Setup ADMV4420 failed\n");
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.43.0

