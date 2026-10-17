Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68471389116;
	Sat, 17 Oct 2026 01:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202236; cv=none; b=IFD3gCesAS3FgUd3J4OZEs4c6LN3MlJKYwIFJdGrN5ikcz5jjE7n6G6k+9mWHrt3HzuRAIfl4qPipZQjLZQUx9T/gxFP4ip3y2JVA13mxzXxye2mxlSevi0PNOhwZstEZ+WMa6Tspu6H2fsA8MPxS7L+Yw2xBJyOi1rtUqzIZkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202236; c=relaxed/simple;
	bh=AJjToRqp8VTPDKTImZZo6jO4t1II30EFe3avEHbVHUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHvOXxgkJGTLcmYuJg261e5sqQmGkSbQJpSISzE1JGDNqF0Jn+hiaN7YiGLLlwPIIh0CT60RzgQQ1oy1teA3fekPdKsVr5aWACdK47MIzPIFiMlbg2B6nVcUzgrKV0fcjpLg7h67Jz99KZqgBbTGKNwm56Egsh1a1zih4w7k+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=ss9K4yvr; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nsYkRWGp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="ss9K4yvr";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nsYkRWGp"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNGx5e3829411;
	Fri, 16 Oct 2026 21:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=g9jdvtw/Tynz4ivUcpAnRVTMKBiO3hAgK4bwyKw9Ysw=; b=ss9K4yv
	rLTuVdfUNFkMClUmdVo0fM/J9Tsu1uP64go8YkKRNFhh892DGFaguYs3umMeA8RS
	BdKx45/+xTcYTwrnNaHbOLf9Cle+O3zOaaLS9dAoY/MBrXh+4xLEnxvapUgeSjYH
	hVyGQE/xAhOqkGCzxIVmTeCFEKXct81eD7a6nVRD8qEAQagAAA9HD9I4DQ/gAwQ4
	XLM0cVOqUuB6P3IXuPNGyQ7snTCGmRta0TiJtTS1GVetr6Np3USgaKDIS+PEAv8C
	28XysPafZ6DSHe+f0QWoOEg9e+AzjawEQmDtnNqlCSRv33ezYV7y7IHYusUVtsQq
	cLcdpZ9rfrXtS4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=g9jdv
	tw/Tynz4ivUcpAnRVTMKBiO3hAgK4bwyKw9Ysw=; b=nsYkRWGpuf7osrWaxssmJ
	ys0IZsahgjnygr5rp6QlMYUFtKQj4pcZASDvYI2zPtOohWnA6B5XARoUvN8erZh0
	j2E2G3klL6CBK5ObBu2FOoFUAmCEBbEFDLby08Sr2bNQLUhuxVYwnJqQiXkWAZ+o
	LiCSrqVe0xSkYu5hw2fV2n5Xw0i+MLWqtKYNq9T/K4jvDkxeZQVlgxCDT+OUEe7G
	SGFNpVj2d67C1i9tSaA+/dKLw8ygu1JmhwGRAkh33sjHHwVP9BrraudECsExZRp0
	fRHamlo2+tTSl7d3aXxj7izfqw31shaGfvC/ZMLhgdU6IE9lDuWcsaStd2KtTnao
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hbj1748jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:57:10 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H1v94R061458
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 21:57:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 16 Oct
 2026 21:57:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 21:57:09 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H1utpX004297;
	Fri, 16 Oct 2026 21:56:58 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>
Subject: [PATCH v5 02/15] iio: adc: ad4134: Sign extend sample data
Date: Fri, 16 Oct 2026 22:56:48 -0300
Message-ID: <22fe77930a156e3616b44d77e99b356ef2ad41ac.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX8PDFBaRPWok7
 MGJPUMZb0flvhUZ7KBCor17z90Yc8cEebz5rEtcw/iNmVf9eGJAutif4SlH/VkfQjpG8r3UA0Zd
 ZsGg2DKR8SfPKRu4SAv0cf5MXfRywP9RSv2ELV2iEMc4ilccZPh9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX6Z3OSOfFPmN8
 x2bEnDdbnmkt63iDbAJIRul7ShUnAACEJyH12IBLjCra26IC7PJO8nutMpURCmgBYcRoUbtBGVX
 xgvlQSZxvnYutHHfMJKdRvfzd0rU8asxlfWFC6NkXWq8POaw4wjmsCNpob96zH1cAz0zmkra179
 joZkmYFawxsVeMEqtTLtpPIMfAMEli+ZCj385OeFOarZXwvWQtRVkfFbV5yPv9G5umgDVajW05E
 qsh6ZfGPNUc5T2jXTBx6L8uf4ZVX/Wt81KlaP1LNrbs5sx3uvBcx/O0gRdDbcYT26Gu++1/D16Z
 2YKKfkXfOn3qAPPnEE3ytyZMYHe/e0ZGXUMzmOsYLbk0j+p50Wkbx1FU5jD+pN9kBBB6tfk0Kbc
 zMaGEoWOxnAkb1o5IZX43xLa+zrNFtxzL6iDuX7wI7ebr/5ne4FbfqMfIGAvoAIbG53+b0/sgxT
 SjXm+IHep/1L8fsqI/Q==
X-Authority-Analysis: v=2.4 cv=Wd6Z+EhX c=1 sm=1 tr=0 ts=6ad2d5f6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=pGLkceISAAAA:8 a=TOduCJ2NwqVHWOW4apYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LPXh9Q72McwKWb6Mk7APuQHserpkln0t
X-Proofpoint-GUID: LPXh9Q72McwKWb6Mk7APuQHserpkln0t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170007

Sign extend ADC sample data for correct delivery of negative ADC input
difference.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v5
- Initialized local variable with 0 to avoid build warns.

 drivers/iio/adc/ad4134.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 8400c3934925..40b27b01f126 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -172,6 +172,7 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 			    unsigned int *val)
 {
 	unsigned int i;
+	u32 sample = 0;
 	int ret;
 
 	/*
@@ -196,8 +197,9 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 		 * Clock out data from all channels to avoid that.
 		 */
 		if (i == AD4134_VREG_CH(reg))
-			*val = get_unaligned_be24(st->rx_buf);
+			sample = get_unaligned_be24(st->rx_buf);
 	}
+	*val = sign_extend32(sample, AD4134_CHAN_PRECISION_BITS - 1);
 
 	return 0;
 }
-- 
2.53.0

