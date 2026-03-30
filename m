Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271E3C5DB0;
	Mon, 30 Mar 2026 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869664; cv=none; b=cWm10r/BoTeRy7cxGp04nGcUCGVXE8KLaoKQmk1PSFf89NQvbsX9mlpOT46GUVYdMo81EXWOMl4jW4q+kV+SPY6k/Wv9Gpad9Fadsm/2qVlfp2Q6AA8kxFAEo4UdKHtv4cx4cUaGDhV6m6iw3HhJ8QhMkL9L3DF7uEAkkTuYV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869664; c=relaxed/simple;
	bh=kkU7Xhy3geAlDcN2sR4Z8MdZNXkXSwqhJihLYHrd5dE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUkKFyDCdPpcIoO80SP/X6eyWEr6KVfhWhAmF+ONoer8P/wokhsV/4Yoc9f4SHLnPTlJP+OSA/fc3gNMHFsZqUuJ/NGRSxbPoqXm4vfJc3yzKErfTCCtMKhrpjyB8H1W6/iP9WG93bzYdmUayLWTgKUas5W/FlPVgPpc5bdlhY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cf3zJz2L; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cf3zJz2L"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAwAUM216998;
	Mon, 30 Mar 2026 07:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=z6ev5
	v3cOGVegvUFhUo2M8XWvFMj2W2PJcISx4umswQ=; b=cf3zJz2LZFn9y73AtJ1Fw
	wQM3xz6cyVu+knVxw4CwwdvymuYaYE4sajyIWp1iziUJh3TSOwC70Q4aug9YBwIp
	EnqbPFZv707QPOmk5pcoLxIRyAqYd8LtrDCINYI4JMalcsi+OqzngOboKTqux34q
	szQA22uGtqhrD+Gc4IlTCBv+T+FC971UbygZeETPFVn3NGUi6/VAJrB1IZJdgthv
	5kSXc/3/oHxFTLvFKhL8W8iznpiMIi6sXO3m8WdZAXQrOO/ZNxrpPTY1gnfzQmtZ
	5eQJXwHtpOvT+Rmdp8Jv/5rHKMyC0kNM5XOc5K1HMAb5G347qxLLBJdYDWZD257/
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d6wab477x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 07:20:38 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62UBKbF0026894
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 07:20:37 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 07:20:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 07:20:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 07:20:37 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62UBKDgY014225;
	Mon, 30 Mar 2026 07:20:29 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jorge Marques <jorge.marques@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 05/13] iio: adc: ad7793: use dev_err_probe
Date: Mon, 30 Mar 2026 14:18:48 +0300
Message-ID: <20260330111856.121589-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330111856.121589-1-antoniu.miclaus@analog.com>
References: <20260330111856.121589-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: A6AsEtvyxR0s-Chty-R27F71qxYn2gpU
X-Authority-Analysis: v=2.4 cv=YJmSCBGx c=1 sm=1 tr=0 ts=69ca5c86 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=t-RRPw6fO018OCHZOIwA:9
X-Proofpoint-GUID: A6AsEtvyxR0s-Chty-R27F71qxYn2gpU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfX/eHixe1b/7ar
 zu7ZvfmySiXgrjr+LGGjQZckTow4j/knqZ1648wlpuMFZWafqCZlscW5hcbHqJWfd44FNCrKkVo
 Ew/O22kmOIOxJswVE1nCdhGYC8Oj7rr9/2MxGM5o5v9ytCfpl9i2QEE3d7MRV3S8o9/ptxY1Nzq
 YKR5am2tPyAjc33E8DOxqbjIuJGxzboMqZQGbenJhyOLZcyxXEgp6meDeNkp8PCx26OpKgZqZtH
 kiZQG/ao6kjedlquSyoN91ZEsZZ08PtJ08zmZ3mkWbcpGIYolZCTh5d3E68JDktPhpu8vmCyqRO
 R/hAhIcj/EvO3iX5nwEApVg+jf6aWjBmP3AZOdH0Z1G9qObyZHARTNH8vVhb5bbGSaPgMcVPcxZ
 qHIW6EMgBAaHlyoJe1Wwooaekf1bPLVaU3jsentN93UyCwk7LWOgzIGNWZVdXyP61jRZsBjPT10
 1E46wWwwOWF4C0KuYdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300089

Use dev_err_probe() instead of dev_err() in the probe path to ensure
proper handling of deferred probing and to simplify error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7793.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 21c667e37b31..624530cce938 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -278,8 +278,8 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 	id &= AD7793_ID_MASK;
 
 	if (id != st->chip_info->id) {
-		ret = -ENODEV;
-		dev_err(&st->sd.spi->dev, "device ID query failed\n");
+		ret = dev_err_probe(&st->sd.spi->dev, -ENODEV,
+				    "device ID query failed\n");
 		goto out;
 	}
 
@@ -338,8 +338,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 
 	return 0;
 out:
-	dev_err(&st->sd.spi->dev, "setup failed\n");
-	return ret;
+	return dev_err_probe(&st->sd.spi->dev, ret, "setup failed\n");
 }
 
 static const u16 ad7793_sample_freq_avail[16] = {0, 470, 242, 123, 62, 50, 39,
@@ -780,15 +779,11 @@ static int ad7793_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int ret, vref_mv = 0;
 
-	if (!pdata) {
-		dev_err(&spi->dev, "no platform data?\n");
-		return -ENODEV;
-	}
+	if (!pdata)
+		return dev_err_probe(dev, -ENODEV, "no platform data?\n");
 
-	if (!spi->irq) {
-		dev_err(&spi->dev, "no IRQ?\n");
-		return -ENODEV;
-	}
+	if (!spi->irq)
+		return dev_err_probe(dev, -ENODEV, "no IRQ?\n");
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
-- 
2.43.0

