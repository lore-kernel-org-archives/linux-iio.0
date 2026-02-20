Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEF6344020;
	Fri, 20 Feb 2026 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594598; cv=none; b=qF7NjV4TkcuiJPccJzEwTKRNCmsFV2e4nCkExmsFlm777FVZ4Z6qqNtmidXPIr3tdknyYSNs1APETOjwvLOGRr0TRdNCMFgsgqa8Asa7iUgEUuLDRXQIldXxaD02TGjA8/ZR7YEEX5b/x29JXgJi+pO96HAlSuhoji7XDNNVNMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594598; c=relaxed/simple;
	bh=Ue5bLao7fQMct+FdDZUl5W/eRuQbPY17JRoGWsHcgxs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2oIJKeRWDJ3NA+JPm4JLZ+m3rPXn4mmNSoXpVjJz2mA2mc5HZS8uKawrV2t3Rl7O/krCzRoi5lefZMmkVic2DTod61aw0Ud47ZrK8y7+fiAuacYP0OYOvdV0QWN4NWuf67sXesvK9G1Rl8BVYLTF2g9XOPBdwXfbPthXsRueV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rgP4CpRl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rgP4CpRl"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K87EJH631899;
	Fri, 20 Feb 2026 08:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/yAmH
	RD+uXhKjNfm7VF4AGb3FvuLEbA9QcQPmiumFcw=; b=rgP4CpRl85wa17vE0EIzL
	/iI+4MWBRVahEW9VbVJ1lFsOCaDAmJvf4zcoUGibJGIsQvadkLex4nD5LDnYMvHS
	rdtAwvk7gzgue1fVd+DDOlEmmsYM1gritncjBucD8IkenHDY3erkRETXGWxk313l
	14TB1kNTt2T9jdGWDzijR7MqgP4I6YxXXjOsa4+98ler7q6x1aJCUs2II8FiuXo9
	H0dXdyFMNyTD2rG67iX1En7a0LVBzDHVQY27LpWSrmAmZYzVuZB8ImJmu5Ztgoec
	4XgiSEcrZQ9nJe11TYKGjBb87TPPTaC831lnwLD3+lJfMwddd+bXqqLbsriC5zNF
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ced6fa9rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 08:36:23 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61KDaMW4002411
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 08:36:22 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Feb
 2026 08:36:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 08:36:22 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61KDa2Q6010396;
	Fri, 20 Feb 2026 08:36:16 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] iio: dac: ad5758: remove redundant else after return
Date: Fri, 20 Feb 2026 15:33:33 +0200
Message-ID: <20260220133337.85216-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220133337.85216-1-antoniu.miclaus@analog.com>
References: <20260220133337.85216-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 8FBslrwxs-OANwIeyafjJhR0HAvVkn7v
X-Authority-Analysis: v=2.4 cv=fPg0HJae c=1 sm=1 tr=0 ts=69986357 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=-1ZwWFZWTwCslO4bRewA:9
X-Proofpoint-GUID: 8FBslrwxs-OANwIeyafjJhR0HAvVkn7v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDExOCBTYWx0ZWRfXyio+coRlGQxT
 rEdz2AjfokZOuil2OS8qLwPhSDzrkQsCfB5Ay8QvmcGjIvGEXdJwR0X4wRiifJD3uOg8cCJv1+Q
 Wj7pDnrTEsbocfZJ8QO3Ezfdy7yL5EtfZLYcDElnCJ058SUpMRLj5iywgG9oD6gARPs0BgSXb7t
 7M7YpJa0yWYlQVWS7Il9unqj3wJ0CgjazwUJieUqKn3IA4SSQ092gGbef/JW3bliw74UfuDfI0d
 jqZOXx8OHssYjfxFtVr/JXTdZQstK8jaw4BK5rCB838YalvQ7FRxAft8OxRBmB5Hpylv37a1Ypr
 YAivyRQoadfi0B9Cg+INueYGPCmZeaxCkQyVI4mcczhrCQb1nRilxcrp6JqMPMuf7bmByJNeDYO
 zBvBfvmlPQN2IPV6HET/zzFnblGaaonZh66vEhX/E1jOXwoGO4jRJg80W7qscJn6pk7R4qKulGm
 M/xRxPIV9/310KKrbBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200118

The else falling back to software reset in ad5758_reset() is
unnecessary since the if block for the GPIO hardware reset already
returns.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/dac/ad5758.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 4ed4fda76ea9..c4424a80a35a 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -483,10 +483,10 @@ static int ad5758_reset(struct ad5758_state *st)
 		usleep_range(100, 1000);
 
 		return 0;
-	} else {
-		/* Perform a software reset */
-		return ad5758_soft_reset(st);
 	}
+
+	/* Perform a software reset */
+	return ad5758_soft_reset(st);
 }
 
 static int ad5758_reg_access(struct iio_dev *indio_dev,
-- 
2.43.0

