Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B81356A38;
	Fri, 22 May 2026 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450901; cv=none; b=BFX4O2UpwvxOH/OiqJMtPILzD/f382ITrjgQZhQJgyM60jDj+CHQIsewDI9vzIngPnFwuPyZowHXNt66qvneAanZbFf+PNPBaXHLS1CUYaFwdr37iUgh0OPHXio0A/KhpwwdW3TWWZuv09lF3OKouykVlpaYbN24qncEY/BDhKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450901; c=relaxed/simple;
	bh=9XI5/jC1yx2HEp2cObPipuHsGiXHvHDA6wtM+CwrCAU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YRYiVCxqSpQI8KuuIrDr1Mb4SFHPt43/gqySK71oml5piH78Sf7JirBNPtpNhCMwYelWVL8LaSzf4C7vqTLr6JYQdFljfBbjlPFUCJh8pmZH/12tjuSm0v1N9KONZN140q40uh12h63X/KAgurobhtymZn7w3y0IUAr7koddZhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CnGNNoHM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CnGNNoHM"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M9Whng938988;
	Fri, 22 May 2026 07:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=f6D6bCLNvQ7BFEFG2xYmngUKXCG
	KT85MRI1WG9Exi9w=; b=CnGNNoHM2AA+evekGc3K1GIBqOdVhZmyky5i3B1VYzy
	yT2ucfEvu6nEESwYXx0cZK31sgX+4Zvkue0iuP+WFspx+c/H1T8iMeJ8XvZVn/cG
	iYR+tFSGGaH7D2J046PUDmwUvKqe52k0EP3WMIjf0Be+bw1V8MS3PiXlAsPQjKSF
	cAgB/32FTIX9x/7CiswClpsbOgSVq5ycrwK62p2eJV0geIKJwWBjwjAPLPVYDREg
	wU+CPvXhj3D80zNqnSVJNEb7jL2JIjiyhrP39fHrNR0GjN8OCQGGaXMC4JWFrt05
	Au3s6P7TtRrS0nH6fsWPcLpVb5O+xhbWxvUZT1JCzpw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4eaa8rthc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 07:54:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64MBsuPB020253
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 May 2026 07:54:56 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 22 May 2026 07:54:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 22 May 2026 07:54:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 22 May 2026 07:54:55 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64MBsi5x027511;
	Fri, 22 May 2026 07:54:46 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iio: adc: ad4080: add support for AD4884
Date: Fri, 22 May 2026 14:53:35 +0300
Message-ID: <20260522115337.18188-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExOSBTYWx0ZWRfX0jmcI+DO6/g8
 WFS47i3cX8fvewLknIMhq8Lj2mO9MuCxhW2aAg4ibRIVbM2OH8BNjWN5ReMOYiPbpIX+qdhdiL+
 qM9JzSDRpAaYVWmIXCVUKEepVcBLv9xizPIANx/PrKJb7bUpIcF/WG6AzLqM9kqGX/H2DnZ57MI
 JeEwtbM+Ua3UCZ6ObyzJ1gIVtpRAsAP+A4SbIdMFtUH2wWv53Hu3ArzDFN4Xp4gmYrV/AuRfnvF
 nn2xC1MgsGDp8xqvVQfqYI+7Xv+bQzV6NxT6B6nEWreJJ6+aIBwuHTacb1cB+hYFhpCVD8u6Kvg
 iHCYOkgxyftA83ucTma9Q/TLiaiXZybUeIL9/vlrriKnL3xUl/EdCCFsizQQUv2JHrGVe2VoPUn
 QzUvAD6uuS4RUwOq00M+rec7reyBwUWHTdd0Ggr4EsZOqXyC9Kt/HM7OuWphRq1M6NJc54DcNe7
 h6fY9GDQv+aVsvFuCnQ==
X-Authority-Analysis: v=2.4 cv=FIorAeos c=1 sm=1 tr=0 ts=6a104411 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=mHfdNUOf9pWPJ8OnG94A:9
X-Proofpoint-GUID: 5VXeSFwVeH9G1J26bFemLhr5XzYIfR4z
X-Proofpoint-ORIG-GUID: 5VXeSFwVeH9G1J26bFemLhr5XzYIfR4z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220119

Add support for the AD4884, a dual-channel, 16-bit, 40 MSPS SAR ADC,
to the ad4080 driver family.

Patch 1 adds the AD4884 compatible string to the devicetree binding.
Patch 2 adds the chip info and device ID to the driver.

Antoniu Miclaus (2):
  dt-bindings: iio: adc: ad4080: add AD4884 support
  iio: adc: ad4080: add support for AD4884

 .../bindings/iio/adc/adi,ad4080.yaml           |  5 ++++-
 drivers/iio/adc/ad4080.c                       | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.43.0

