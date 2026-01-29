Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040FC34B183;
	Thu, 29 Jan 2026 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707558; cv=none; b=fnyStoJ2vIVGcert5uAFmU43and9w0GHqbeRgRYMBWlCdE3wwJVtFKAMuSaeBspB7Vzul2PPmzECp7XDy/r7eeHIvH/WEjvoZk+UyKU7Cv1lmpLcinNTt8F/G2ebNp3Z7DhtjY9QGoFmU+sM7drkY3xxpbdZC2LsifNOc0JCd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707558; c=relaxed/simple;
	bh=3N45L+7bviop9K7E7AjN4aYNUtbBwDXjwts2ZXI0crg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVKra2IAGyR5rokTBg9ur8N3HiohKOHpDWiYegnmALf9QyXdqS1AffBIF5aQkh9uCLvKCKHFevxJfXbjqzb3/N0bgvrDEdF9nWZEEdraLmS9mAI5MYDHo1vjnKtfEDOyX//j1nsFRJUmO0ij/MlfEsMrNf5zqS4ikIyA2bWfY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Sa5YtSvx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Sa5YtSvx"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TDoqKJ009211;
	Thu, 29 Jan 2026 12:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0de66
	X1k6+6iw8h4HPNZuAwNKEd1c4pFqnD25VXTYGk=; b=Sa5YtSvxvoES2rIE3XlAn
	qq6EAhZ6i/GeWdwYMEX3mN/EsyPFUucAzjX8K49VZVVJ3v43hR4UDZ1s38UEzF8S
	zgFshpJirtSnOl6uGAtVdJePowvaY3gJyzsbhtPvuegPmydxDWK5kIHCseAmpEjj
	xVKlDoiFXEZcYCsvUqL4Ei/jzW3g3zIhBC/uMO+KjYOXPDTk/PAYNwnVd4ryIHaQ
	GsDl8CQ+Dg2OU8FRIhudiyQA+aEIYllpFOGr69g5iAa6XSr2bQWMuz19CcZI0IwJ
	IxT0hRUGbEH8m4ExC/l4Np+JKi/5h7M0Va5IrofET/uW1brtRLKkMF3N2OW7fqk8
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c08su8w34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 12:25:38 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60THPbNh056040
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 12:25:37 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Jan 2026 12:25:37 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Jan 2026 12:25:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 12:25:37 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60THO5rs008516;
	Thu, 29 Jan 2026 12:25:28 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Fabio Estevam
	<festevam@denx.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Linus
 Walleij" <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: ti-ads1015: remove unused enabled field
Date: Thu, 29 Jan 2026 19:22:04 +0200
Message-ID: <20260129172340.34216-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129172340.34216-1-antoniu.miclaus@analog.com>
References: <20260129172340.34216-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: R4ywDuANs-Ws0BClYZuhcmrBEyGg7Cez
X-Proofpoint-GUID: R4ywDuANs-Ws0BClYZuhcmrBEyGg7Cez
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyMiBTYWx0ZWRfX3mz1xvWExgRX
 Kpn68VzMXzZ7YP/b60YbwkVAsUdvoQ8UXGetYie6kHkVGm83l8ye/PzgTmyroiz+3FAMGTIKUHZ
 4L4nHeW6usqrAY2MJm63PWu94Pw3g6WcGDvHnL824fxQ940AkcT+brN42IWB5d3U38wG5tJjasK
 aKQD7SCmCOQB0iRfmCTHw6aNtpq2hLPrGBQdl+f6N/wjVtK3AC69Z/AKxcJEI8E5KrzIfi38+jV
 IMS2wot7NenfisbparJVt6rDLeOVYy13OZXEOw/K1KVXhBOUDad85S0iNmoXI1/H3cxdVd8hyE2
 AbEmOTcNdhafbXdfVU3g99AWUFnTCPlypbl6LluX4fs1Y+x7Z3bVpe1ATIJt3cbdkjvKS4jDdg4
 RQnBMvmT2HkkMrtfwBESj57Y3mHe1Kd0G5mjsZj6aZnmfmYaLiV2bSDPuxJ72NCgYxLTnASDlK0
 xPE5XnDy7MjzWJi/AUQ==
X-Authority-Analysis: v=2.4 cv=IsgTsb/g c=1 sm=1 tr=0 ts=697b9812 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=iQSssSEnmO4gRBikR1IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290122

Remove unused enabled field from ads1015_channel_data
struct. The field is declared but never accessed in the
driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ti-ads1015.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index f2a93c63ca14..c7ffe47449e2 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -231,7 +231,6 @@ static const struct iio_event_spec ads1015_events[] = {
 }
 
 struct ads1015_channel_data {
-	bool enabled;
 	unsigned int pga;
 	unsigned int data_rate;
 };
-- 
2.43.0

