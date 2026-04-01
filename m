Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC336897F;
	Wed,  1 Apr 2026 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041746; cv=none; b=LtuCaRzUFKE2m/WyXS4eLELNhOrh5o7kclZdGDwATYspE0QeHhMZi7ANHZ7DlQvidWf5Ar3YgXTq05HNoyfEgegStIsy5LO2AhIqVKL0qk89wmZBn37wuCuRliA+0ijtL6PjPydMTTyZ0GdCIq8cpJT8tnH1DIOusQQwStCuYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041746; c=relaxed/simple;
	bh=b7xTkE2JkttAJutOWi+jas8PqRlUpSbWNIqBwKvuQ/A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MtqsPoPUq+/kpvEJEi1Ko/ECHSKtSzBk1PqcAvKYzF3JRRI4otJaDhx6H394wS+KCU4grPQDigordVYB4pIh6eQGDCUpMXbJeKEMIDVbFAYvEtTGsB/p8gerApZpIBaj58x+dsz72E6jQTloJbVfplHeFzIH/EAB/aU+sfGj71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mH+x79qa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mH+x79qa"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6319RZWb1912836;
	Wed, 1 Apr 2026 07:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=1UbV+K7R7G8Vj6QquXzZEsGhkoR
	1MTegK1b7Dfi6xrk=; b=mH+x79qa8ZQDNwC73S50vHmMolNmOaOnhHKAzlcPee5
	29ubVxnMFKTQLl5RYzi6PtGXtozlJMzvOiIkAf2gxuJxqGg3H95JqVWYexzc/LN2
	c13eKdLuAoDYH/cFOI/cuqw1QsSPK8WztD4UiH4IBo0N1tZ4EY40dPM2ut3DbD7k
	IU3M2ZpWGfi2ifW3wIsoK0q8+sZ+qWIK4S6SzD8feE+aTbSD26b1ue5kdFIp7Ga9
	VBdvqulrZ3ukVQTGvTPDubhZZIPAjobvXFEm5jw4XwvPhuFkcac12Ue/OTp4mrQf
	oF0OE9Cm0hh7dU4bM2BiTaaRG5JHzMHpmBIe+tFQckw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d90re8bgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 07:08:50 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 631B8nxC064319
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 Apr 2026 07:08:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 1 Apr
 2026 07:08:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 1 Apr 2026 07:08:49 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.240])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 631B8bCu009788;
	Wed, 1 Apr 2026 07:08:39 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] iio: chemical: scd30: fix division by zero in write_raw
Date: Wed, 1 Apr 2026 14:08:29 +0300
Message-ID: <20260401110830.7694-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=VqQuwu2n c=1 sm=1 tr=0 ts=69ccfcc2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=1MN05CAaS3PHtFS8decA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwMiBTYWx0ZWRfX1jU0U47m7gns
 3RQmQatf+Q134Ul2Chr/ZPZkYn30y7xWLdqdHlKGmpIkwETJ5cAmfPugvbTBo98hdXseIqXcSSA
 GrOg35h7A6X68NdPKTnmI8Y+0fAvqcxDCuT3pr9N57d9tms11Hcyddzg7XvcFixo77rh1qsgYNs
 ebrL0WaFlw/EzAvwiWBlGXrDpfQejXcXGhUjk0nqYgCSdkFuZJXMKFiTfsdfI+tE5A3O3awG9ie
 Bd+R4kr8ykNHG4/z7GZh4fadzOCXumm9dp2DWb9whV5AASUW8JKTLhoeQBXmx/YaZKjDo6H7619
 naTI2HKe6xGNfY4c2edPY54aQ49HAgZrjQa5Lag/pnyeqRBO6C63ivasZHqd3msuGxfqX3C5CT3
 KCofFxjG5/tZAi/CT+6cAHCdbVswEF+DR4XaSSZ4dpqmWkRWIiLiaJkakQSq7BPUqgyyCUsDs+z
 ICSKaONb16vxa84C+yQ==
X-Proofpoint-GUID: UbdM5dM-Xx6D0xH3Mq70TrNErIk1Td_B
X-Proofpoint-ORIG-GUID: UbdM5dM-Xx6D0xH3Mq70TrNErIk1Td_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010102

Add a zero check for val2 before using it as a divisor when setting the
sampling frequency. A user writing a zero fractional part to the
sampling_frequency sysfs attribute triggers a division by zero in the
kernel.

Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/chemical/scd30_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index a665fcb78806..11d6bc1b63e6 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -256,7 +256,7 @@ static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val)
+		if (val || !val2)
 			return -EINVAL;
 
 		val = 1000000000 / val2;
-- 
2.43.0

