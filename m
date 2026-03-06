Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A212D47FF;
	Fri,  6 Mar 2026 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792756; cv=none; b=XBpL09196foeNY5Yh9t2lUNnmiAtH7//q/RAybfOM/u/LtVFq+7ZcOlGuj+zgX1Hv2qbvQ4S0TZftPmsoBOJLhRZDTEhfuJbJnNT1elw4WHDHWe4cPCeq6bNCqhVHtogFOpmceQXIq7ApPOjH5157j71LWGqCTS3HIsUmigkqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792756; c=relaxed/simple;
	bh=4i9MulE/ge4bMPf/tXyeJYfQedF+syiJqjvkIHHewVw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fYCQBA8UVJ2xxskmriHIupdAHk+nZ6tO5mw5Qu+lZZzXVPhDv4cIu014LrmdPBTHt4e/yD1k1t494jUXYmshKcRtFuTyDpmuS6OU2S86mwfxJbPMaVkKP19HUgGaUfZcRoUQg5aFpJVXnWqh/wgdvBqYkAt8/uY8sOSEsOAa72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=l6IgzRab; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="l6IgzRab"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6268PtYx3363555;
	Fri, 6 Mar 2026 05:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ew2q+qA4xjy3BJ8QnLANlY/cw6S
	LGlwuAtl7UhDZurw=; b=l6IgzRabpp9pmbAjpDJZp5mmmyO81vxWEkezk4CDXk7
	WhOmbdDy5d0ZRQ4Wv/eh+5jAmbEjifYZTqSNbpANEuGRfbvGJzdXoQeBGe1B5dj3
	ZvN7QVmcrLCnPC4ZZmxB+oaJ9bmuYF38q2jD09iLOrQDvSRstxTWH7e57yNnogHS
	2936ZsRDfYz6YUpzdbjXnud3KTnwsFLxcTj/WA4jpMq+jpTgXhyK149VyS2PQf3N
	ucUUZPbIVQRstIXwu/NIJZFB6O6Jjoz9f1ONkqS4T0orS8x1Zb5GKquE2zBUhOQl
	/QfslS20rLalLapVBgD67qvZmEvq8pXRuAsdbIL0K1w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cpdyx2pvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 05:25:27 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 626APQlS007754
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Mar 2026 05:25:26 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Mar 2026 05:25:26 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Mar 2026 05:25:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Mar 2026 05:25:26 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 626APG2S003684;
	Fri, 6 Mar 2026 05:25:18 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/4] iio: frequency: use dev_err_probe for admv4420 and ad9523
Date: Fri, 6 Mar 2026 12:24:44 +0200
Message-ID: <20260306102504.42395-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=Mc9hep/f c=1 sm=1 tr=0 ts=69aaab97 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=IvNZlhXjPkd7nd7cnj0A:9
X-Proofpoint-ORIG-GUID: hr1LeM0pgSHmr99HQVpDTiIVKQd3Js1a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA5OSBTYWx0ZWRfX41LjvEyo37v3
 F5hGK+oCf2rOaYpyy/T5NfizQK8gXyWSHx4/KKn2ipdJof81p7qxEw7EqE1qkjsFMOb59SmufsR
 +73HiR5TWesyI5whrkmvRJgzakRj9JOsGv8e/0spFJfEJZqqsZqqehR38KlIyAHYCcV9CMUpTjF
 MNLfjEhzQVN6ZlKSNEqHRqUJs6s0zeEWTHI+NuIPTVJDhkYZR3vyLPSepCgH0Jy236Syl8GWyui
 +BOUu4Adgze9Xrz+8NTpM3pyhMQ6XTYqzidER5sqf+LOaJtNVBxztdF3dgOQJLMv362HcgjZviV
 hmjqamjxIpYqXHD9VMOP8L2TC7HoWl7wInTbjnVw4x4C05NINoUwoahd8KAjxBzQW5c8Eustl8D
 zVZM/b83aab4ll4jQD7li8ktWIU5eqQwJTE4UOyH0N+r2CFn2f2wfVwz6aqDi1frYTbWajn+gP4
 8EyXDjMkYt1+5G7xLMA==
X-Proofpoint-GUID: hr1LeM0pgSHmr99HQVpDTiIVKQd3Js1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060099

Use dev_err_probe() instead of dev_err() in the probe paths of the
admv4420 and ad9523 frequency drivers.

Each driver update is split into two patches:
 - First patch introduces a local struct device variable in the probe
   function and replaces &spi->dev references in non-error paths.
 - Second patch converts dev_err() calls to dev_err_probe() in the
   probe path.

No lines are edited twice across patch pairs.

Antoniu Miclaus (4):
  iio: frequency: admv4420: add dev variable
  iio: frequency: admv4420: use dev_err_probe
  iio: frequency: ad9523: add dev variable
  iio: frequency: ad9523: use dev_err_probe

 drivers/iio/frequency/ad9523.c   | 21 ++++++++++----------
 drivers/iio/frequency/admv4420.c | 34 ++++++++++++++------------------
 2 files changed, 25 insertions(+), 30 deletions(-)

-- 
2.43.0

