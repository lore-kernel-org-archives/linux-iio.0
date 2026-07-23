Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD233B83E8;
	Thu, 23 Jul 2026 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836438; cv=none; b=H1gn9KiDXDS9pM5grr033oADy62K/mUoACQhgwUlgYs8ykm7lXcQLnm4tsb2k8zJcF2PLTbyKA6KPGEc17m4otic1gQnKysj4m82KkLHXLqjUArbzk9iMRj/4Dvvh7yy65waFGvE/EPz7fLNdzaWghvM/APAorktS5H/Ky9BKqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836438; c=relaxed/simple;
	bh=xV74dqSO6y09UvkWdLgQqWpAE0g0hXZqw6+MJYpmQD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAz1hXqRZtSuGfs3oZizXkRo6sJmDNU7trHP3nH2+uxo6dsU7E1zr0zmoRynfLieqIi3MkTLTwfG7pA4D5lMeJiPSYELikBOEyOKOCaoMJ2ntHrSXht/OB8SQtfKriyUWvfWhznvkU7LAqfdZOLC0ggjyQPItQiu0LSCf2GBhHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wcsWMMm9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wcsWMMm9"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NImI0q2703474;
	Thu, 23 Jul 2026 15:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/r/sI
	t3CGJT9LVAFlwseZkP+dIpiZQwViwYClAgcccY=; b=wcsWMMm9bw380aEclEYXs
	LGnXCKifh1SflGY9F6ZMufEHhB9ANm4QbHCdwjt1V002smsQpfnXHl9aqq4LZPkK
	IxELmHX9jkPfpw22NgHtHLDytcuLgAetq2cbniQ0oo/6nz9gZVadhg4K0DeSI8Jq
	3/DvNUR8YOMJEs9EyvKHbDoMC36fNieI1DYuI/B+/nmZsUt42yB/wMo80B5mdj+P
	bIVE2MUyBXtFfEYuhA9DVGtIAIxf2N8c36eZtXzuRQvgVr7xFNVaPP+VCJR9/Ddb
	j0H210/COktUyP8KGvhQV4fVNZ2hg3Jz12e+s2OqkWube13sfWNOnysQa0cD3uAu
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fjgp0su29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 15:53:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66NJrpsx049576
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 15:53:52 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 23 Jul 2026 15:53:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 23 Jul 2026 15:53:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 23 Jul 2026 15:53:51 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66NJreO8030737;
	Thu, 23 Jul 2026 15:53:43 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v8 5/5] iio: ABI: Encourage differential voltage ABI usage
Date: Thu, 23 Jul 2026 16:53:35 -0300
Message-ID: <9f47e67f188a910c3e025255dcd1354ef2dc026a.1784835663.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1784835663.git.marcelo.schmitt@analog.com>
References: <cover.1784835663.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE5MyBTYWx0ZWRfX0DiA0/2uVZhZ
 rcmnXche3PF4FLR100KvYX5ob38Yj+RcdhE9xVTKTp4W5icIL1qQouql1MjTsB98PGa/aROaIDn
 exlsyOrOZCIFLiQP8al31DIIlVeZk/Xa1YXB+b3s1II7ocL6alRU
X-Proofpoint-GUID: n8DqUgbiDn-1gwohYNvDGfKUdFsuZEnb
X-Proofpoint-ORIG-GUID: n8DqUgbiDn-1gwohYNvDGfKUdFsuZEnb
X-Authority-Analysis: v=2.4 cv=cPXQdFeN c=1 sm=1 tr=0 ts=6a627151 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=iGya_9aoYPPjgpMbcYQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE5MyBTYWx0ZWRfX0sWZnA+tnUPF
 gfe91rSw8Bluu9n9gaTh1aXe0Bb6OL23yJxVv1IL5nCt9mi/F5qqNCwxd0AXo4o1cG+vxc6MVhC
 oydFoUQ43GIWnr+yOEor1+wzSJrEf+v7drzXPqrgktrkPqEK8FnNSN17MlmpM1Pw5nGguEm7Wq0
 TT7K/GmSi/HBFI6SgJ5Hg89TfqUX+3ZaJqbcsQQc3gl0wCXZeXIfO25x9DFlaOpOxJNMqVueJqy
 FA95iEuM5a/PL8L2sV8tBiSgaqOEZGajCxcjbx5q98r2dxH7wae+PL5qs1eJEPrkKPNdpXA9ISW
 YzNOE/a9ThgyjnLuTJcX31MBwMLyvloXQrS/+oFppR01e1E0N0UXb2siuQF/iva5mdOpBALhzdV
 eWxmGd7QLxTOvh6mfQba8ktwnH4H/+K1vBPKxUX+p/bCKA6AoawaVL98x6wS124V36P3TFUX2Xx
 fBfwIM20kiHhOyQypbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230193

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
New patch in v8.

The updated ABI doc might not have gotten very clear, so I'm completely fine
with any modifications to this patch. Also, since the documentation update is
minimal, doesn't add any new ABI, and might be picked up through Jonathan's
tree, I'm not CCing the documentaion mailing list.

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

