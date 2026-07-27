Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06C429CE8;
	Mon, 27 Jul 2026 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187967; cv=none; b=K4hnvQCtKbNiugwz30vLU40TjEFgYYgd5bjX54+k7tq5kMZv7fa/21irZT8UeLag33lLGVI6C+h+DV4tTYfdIN0IcJpIr4gce9Q1gfIRWATo3DqLexMuqJb9PsLnZWipM9yfrQIPrC1hNvIxKv8rvf2XdhX0wtgVvomqmyejpg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187967; c=relaxed/simple;
	bh=+Iv5MoQ5AHUJ1thY1AYuSF5/JqCSDZhuxPVTO1I9smM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KS5Fc60xr+4jpxflRJwcyEGjF+co76t2wXfJwM3asjm9lm86C3zPftt2/FvCz09PPCe12DfO1EF1uZAz/W0iOHr5VxDRsSjtd4+U8p4x7IdbmsxYpkf3jLiRHLMg1ATHpgcjy+bfomfxIeSjuO0pGEKyILyZ2xiafBo5sOqbvK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cayMKLL1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cayMKLL1"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RIGUFh763139;
	Mon, 27 Jul 2026 17:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xeEUV
	KBSr2vA7rQAZZQH3CkFdJdUjCi1fMfdaFEDiaU=; b=cayMKLL1+q/bYHnT47+D+
	3vOIMZ6GFo1DGOtrqgOFYifEdUq9+hk8S331REaBbK2eLtyutf60cqSS7/wE/wl6
	X3/lKXisfVY4nlFD6+NibX5uXuG5MKg28Zc+EhygHgzk05rqUFXbSWv5B+wHmVjc
	ZeVEm+sVZlIZ1pTPDK2J5JfbcruZe5cQ8UM0Ho9rvxipwov8JY4hY22ng80zFINA
	xSqNHUwdZmZHRLBMV3FkrVXlYvB9P8vWehgWmLAJZO4Y+pJM+jW/bbJDFk1+VvZv
	6Vshy+MQ4OTHK9eIQcpgDVkpvCg73yiLLSODUJ+cq7oD5UuUVTa7ufUxOFI9KUWE
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fp5f7jbhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:36 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66RLWZMI004073
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jul 2026 17:32:35 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 27 Jul
 2026 17:32:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 27 Jul 2026 17:32:35 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66RLWOeg017488;
	Mon, 27 Jul 2026 17:32:26 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v9 6/6] iio: ABI: Encourage differential voltage ABI usage
Date: Mon, 27 Jul 2026 18:32:18 -0300
Message-ID: <959734dd1111f76c5928515b82dd17f3a9dff5c8.1785186980.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1785186980.git.marcelo.schmitt@analog.com>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: v-0412SOaXU9Q1RkdSxWXOXiZdTste34
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE5MyBTYWx0ZWRfXzgC9ssYmByRM
 Ndj4+aN6SbS9/YnEYE5UrmonBCOuIISIw9SPU1LRzXtAj8TOfrSWQM5WbaLM2mLbfJV9Kv/A9Cr
 zEHAnZhwN7ZHvALjU107pcA2y6i6qyUPWaF31iFBAaYNAMD5rlH2RTxB8douVxQp2++ZhoU9oFk
 +kCe3dTcowW0M+Pf25lU2frD0WZd6aw5TxAfyLiwXrXoRYX6bCWNoLFLXGlOtj0jFmBZobB6FdC
 rvYCaUeA/ZMMko4LdOG12HSL/zHEHoeo7p5ZRaQxLt8mj2ITlfrKJ2kb9GGKOzYFmzOTbs4xfOt
 tisj+wQV19phsyy8VO6sijPs4IyQhaFYCtX8HweMhcIOnzvjPmlo3snuz6anR2IOeW6zHyCpqjQ
 HsQghbTN8URL2rXnQUo8htlet/w4wjZNvwrSoG7g2NS2n17ny4T589hvcCf2vEXHGORSslx50dR
 ISBmO2HDzA5ITI1myog==
X-Proofpoint-GUID: v-0412SOaXU9Q1RkdSxWXOXiZdTste34
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE5MyBTYWx0ZWRfX8dn11qB3NZOd
 WuzRrFsc3dKevd0ZXD9GRjy26Ea8aOgAl+Nsns3emyQykMZZ6MGdSLZfof89s6HSGrkIzfIe+/U
 OoPmdMJNIp8KdaMgximGl+Q78J5qsA8NgO2u82rONTikNor3Lshd
X-Authority-Analysis: v=2.4 cv=dPSWXuZb c=1 sm=1 tr=0 ts=6a67ce74 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=Gew9_8sOxj8TDnYfsgYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270193

So far, parts that could only do differential voltage measurements were
only required to have a consistent labeling of their channels by complying
either to voltageY or to voltageY-voltageZ ABI. Over time, code maintainers
came to the conclusion that the voltageY-voltageZ ABI is better suited for
differential-only chips as it provides a simple indication to users that
the channels measure the difference of two inputs.

Adjust the ABI documentation to recommend using the voltageY-voltageZ ABI
for chips that do only differential voltage measurements.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v9.

 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5cc2e82c4997..7446e07b9ab2 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -162,10 +162,11 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled) differential voltage measurement equivalent to
 		channel Y - channel Z where these channel numbers apply to the
-		physically equivalent inputs when non differential readings are
-		separately available. In differential only parts, then all that
-		is required is a consistent labeling.  Units after application
-		of scale and offset are millivolts.
+		physically equivalent inputs when non-differential readings are
+		separately available. Even though differential-only parts had
+		been merely required to have consistent channel labeling, this
+		ABI is preferred over the non-differential one for those chips.
+		Units after application of scale and offset are millivolts.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_rms_raw
 KernelVersion:	6.18
-- 
2.53.0

