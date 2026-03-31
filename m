Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686373A6B93;
	Tue, 31 Mar 2026 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952032; cv=none; b=FW9HzInnpetDafb9GbRcahe6hfmhrbLvOlYiLjYlpNoqJNzBqev1Tua53UndhJDQv7uhCZSNQ3iHGytZkZYqz+lLld24IuZdxUTfM3SbJ6GFDTHs00cnlD0hnmnLpRkkMjzKOjClGIaDOoiFHacOD0nTj72+pN65LAPnP1Lp0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952032; c=relaxed/simple;
	bh=W8RpYdLevihfVTgrICenR6CjhmtwcS+hRMzy0gmqdz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LvrSPODmFDieyfzPDTA9MPHKz9unAr5H5l5a0H7ZVbPgEMGQguqXI+SWO6QK6u3d8V6CjEe7ARFeKMBI/CYfY0RVKYBEf2fKGo8ayBK+VQWP/CVdzMSnCPaqdOlcwK79eZfPJPCdzKXUOz3HrPBnw8FSpXhwRvpnfX94OYpl/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=H9kmcnuS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="H9kmcnuS"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V813sL1140311;
	Tue, 31 Mar 2026 06:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=xTW7bko8K8pJn6Iq9E+g6FltYDx
	xxPVk7COfsyZM3F0=; b=H9kmcnuSaGrAk56s1+V0JguwX4HEDt2+0m7jgr3wPnX
	xwhbmmgnd9AkTWV9i8r01OnlACun3f/EG3GLcTHWVfnv6IKXKpv9yJYZsHfVvo1M
	bboohghlDyyWdfKbcgdF0mL0GjE2i13vyqZfOGvqN3i7IEl6/gMzYd9TWWrj3Z3g
	wrTZkAtbwNKeTbSagNNfoicquXqRlNWNp1Qz8jh1CTv3dKVKPj/FBBIbpaD+IoQq
	FaYzK5aAAxt9+zB10zdpTj4kZF/Jj2hDmTS3Px/rHiZmZLWCUlMy6w/pglSlqfBh
	nNZ942FqHsoTC7Ugvad6dkRRRw1W7H+XRo4v4s1bm4w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d6wab9wkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 06:13:22 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62VADLh5061783
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 31 Mar 2026 06:13:21 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 31 Mar 2026 06:13:21 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 31 Mar 2026 06:13:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 31 Mar 2026 06:13:20 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.219])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62VAD6bg008872;
	Tue, 31 Mar 2026 06:13:08 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Barry Song
	<Barry.Song@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] iio: gyro: adis16260: fix division by zero in write_raw
Date: Tue, 31 Mar 2026 13:13:00 +0300
Message-ID: <20260331101300.15853-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 4kRBzAX96jNxprKeYBFZ236GsYRxI-Rp
X-Authority-Analysis: v=2.4 cv=YJmSCBGx c=1 sm=1 tr=0 ts=69cb9e42 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=VFAxbAMRY3LBiGym-ZcA:9
X-Proofpoint-GUID: 4kRBzAX96jNxprKeYBFZ236GsYRxI-Rp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA5OCBTYWx0ZWRfXyWrOaXpNVh7W
 y2qqKP9KfPdWU1Th/uzDxItGsJ6cmdgaangFhOXNvghH9aZPi6bXT1CFIy1Sxi9jCVjHXek5KvC
 W6atA7aKEob19O+BLrgquWgydSAocJRxPTKOmUwhFevZSJ1d91xK/c16mn4qxPzJmuL6SMFA6z2
 Lw5VPF9Qv4Skov/cGjTDFif4Z+lq5R6qVwFLjnMecfI9gFxKoI6N9JNfEDLhxXSE5ZakH4tY57P
 MnLRnJCLKE5XpQBs258/cxLuIGSjI1pwrs/IHvidbNNLEtjuOLmo+NWsp11Ch6jT8lgBr++J4Nx
 +cjVzLqIH4KFQ8k5Hcbfkr2q0Tr1veQ4HTRfaJlhF6MRdGza5Wfn8S5ayqTHBEg6W2niY53ta1L
 aVcRg3px3QhqBNwulHd3qlRz+M+IpTfwvjHw+onLS+4aJOd6aJ8cr9EMJVHsUZI9LXOcPr3afAX
 Q03NU87qAESvrGD8keg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310098

Add a validation check for the sampling frequency value before using it
as a divisor. A user writing zero to the sampling_frequency sysfs
attribute triggers a division by zero in the kernel.

Fixes: 089a41985c6c ("staging: iio: adis16260 digital gyro driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/gyro/adis16260.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 586e6cfa14a9..91b9c5f18ec4 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -287,6 +287,9 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 		addr = adis16260_addresses[chan->scan_index][1];
 		return adis_write_reg_16(adis, addr, val);
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val <= 0)
+			return -EINVAL;
+
 		if (spi_get_device_id(adis->spi)->driver_data)
 			t = 256 / val;
 		else
-- 
2.43.0

