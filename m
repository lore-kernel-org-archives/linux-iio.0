Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D2F2BE03D;
	Mon, 16 Mar 2026 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661531; cv=none; b=gd8m7KZtFp3xr+p2z+7VaAGuKUFeNqf+ioBuL0azKcNDiblh+AJhTKkuBA0un0l25O6htXtXDA+duPiVZmsYweRhEoxWay2vCNtHwwqxwrbROq7/HPFC9/jlT10QoGzfry5nNE1p7sCLlFEzThojfuzkNjMFfxW5Bel7ULgg8wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661531; c=relaxed/simple;
	bh=Ktk4QAotVZaXHMzDYBX1PUbaeBP+C57euopHMrjJlpg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bOir0x1U6BfRn8mgWa+LxQlCJeU/AJtiUljbU1oetyKhq2AC/wa92unn4TkGktjgh1pTCeXggfTFXko6jjXABzrhLrUuHqyrbnhrLPbO14HfrOnhLoUgkgkWrEeMqS/kTs92u9Nz/XYjI3HW3Cb1X+ZX8N+aeLUOvfPsORfSvOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=c9lUpo6I; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="c9lUpo6I"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G9dcYj268806;
	Mon, 16 Mar 2026 07:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=xObNWc3YrdkIsvRTVX+rQ5WZVMr
	yyfhpOYZHpEpTNCw=; b=c9lUpo6ICiaUoA7ct8GyTd6Lti4iuYFKtkSAB2SyTRo
	PbHWiQGMjvun62rrEgVa7z6uy8eEJZvxf0uBh3kmwRzwsTfa+3dLD3rbBsFWEevc
	YufPKhMEaMY+kKS9zAhOK5zksU8LpkduK10E/sEowp9lBBI5S/YOx2VtBQKRjm5p
	cGVs1VaqMsezwEDugrMJX0V7oi5ELvTRt800cMUx1CHNQdDkHRYc8oM+MKI/eHLr
	+wy7kP/A85fREzwHjzaV/6dOMw5hvOUPfeQhhsx2rwc4iTCuBVIhgJiW3dTXrody
	ndl8xlUr5t3rUsxKk+OuklWFX+HaKt3kdNh3M+80k5A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cw4k0xa3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 07:45:11 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62GBjAvf002641
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Mar 2026 07:45:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 16 Mar
 2026 07:45:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Mar 2026 07:45:10 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62GBixNm022944;
	Mon, 16 Mar 2026 07:45:01 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <cosmin.tanislav@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
Subject: [PATCH v2 0/5] Add support for AD4129-4/8, AD4130-4, and AD4131-4/8
Date: Mon, 16 Mar 2026 08:44:54 -0300
Message-ID: <cover.1773311639.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4OCBTYWx0ZWRfX7qK/a9pHZWOE
 Yd8yVlAEIya7tvAO+j9R6HTpK1a81WHEZ/hhFK2lXM5o67CL/WIIcFFkSGoJvzUbbvV4idFa2o2
 VZ4rKf3MhiH+cuUCgvwUGxGIJzhWNwX7pUZVSGHWfyb9rFCDwdxBRzw9H/PB6VjtMjAi1B+Lk61
 nAcrJln2B1NfO5+lSDSC8C40LT0DTD+p1mNKb2EHsYFsOREMB9zinntCtiE8nQ+OL6etazLAH1D
 +moAvua5hxTtIgjaUzG03b6O1KI3sFFT1cr3NtjTc14mKt/YpSheAGzIBxduBsuhAqO1p7erna7
 2BbS0M4DQ8V9yvbObCNoB1NgttbWcBMW6dB6Q8hbK1q5tmOGqhPy9tHTeRxqwEkdTSBziWyOwO5
 LHUUddkTNxj2Dgml804FY5ydA6IqIReAnlr2OL3txQ2gaPL12iSCzj53usWfVhjbOkBqhh2R77J
 reJs1sxtLCxSnY8FP+Q==
X-Proofpoint-ORIG-GUID: rC7I0c90N5JLLtHiGBmLiBosU9jIAhve
X-Authority-Analysis: v=2.4 cv=bYZmkePB c=1 sm=1 tr=0 ts=69b7ed47 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=r2fEcVj2N2yMaMJQ_G0A:9
X-Proofpoint-GUID: rC7I0c90N5JLLtHiGBmLiBosU9jIAhve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160088

This patch series extends the AD4130 driver to support additional variants
in the AD4130 family: AD4129-4/8, AD4130-4, and AD4131-4/8.

The series introduces a chip info architecture to handle device-specific
differences. The AD4129 series provides 16-bit resolution with FIFO
support, while the AD4131 series offers 24-bit resolution but without
FIFO capability, requiring triggered buffer implementation. The 4-channel
variants feature reduced analog inputs, fewer GPIOs, and sparse pin
mappings.

---
Changes in v2:
* Add patch documenting the interrupts property.
* Add patch for the SPI id table, moving its content from the chip info 
  patch.
* Addressed other minor suggestions. See individual patches.
* Link to v1: https://lore.kernel.org/linux-iio/cover.1772078999.git.Jonathan.Santos@analog.com/T/#t/

Jonathan Santos (5):
  dt-bindings: iio: adc: ad4130: Document interrupts property
  dt-bindings: iio: adc: ad4130: Add new supported parts
  iio: adc: ad4130: Add SPI device ID table
  iio: adc: ad4130: introduce chip info for future multidevice support
  iio: adc: ad4130: add new supported parts

 .../bindings/iio/adc/adi,ad4130.yaml          |  19 +-
 drivers/iio/adc/ad4130.c                      | 493 +++++++++++++++---
 2 files changed, 430 insertions(+), 82 deletions(-)

-- 
2.34.1

