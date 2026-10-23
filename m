Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794952;
	b=gGami8CJ3cX83Q+x6uCzgtOWXqKpiDCk4sltm+Z7oc8xthy3IUn8HW6iogcuYAJZeGQc
	 FZVetR/64NeuWReHbr3nRMibh36gauuo6ZskBq7MdLNyqWInieveqkuatvTQUg7PCEi4p
	 nYfd5mRllezPuKa4GduOxdK4rY0KF/VnDGjkkuGW5qkd3msQjHMnRDuKG/UJjjjE0xKHr
	 yxjoR+dc0NkKdwOF22ZRlvLuZP/EvzOnQsMQZgLwPSehPB3UKso7/v4EAAtLWTUni/jv0
	 zm15irqeWLLC0iNyPVAHxfU5Pd9ef+PrFelEzC6KS+BOMOhg/3fGm9Egj8lmmeZSUYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794952;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KatvA9ItFG3Rix17MUUmtgQuVc/i6Y9/uAKHLpw04Xs=;
	b=qZgR7BJE75fbCqd0fUxbIGdj2UMrR5hJrpXVCYfh3urHz67FpNgF5LCoAX+EGUFYsbkd
	 L8TRs83JucXZXOeV+jCuoEzCbl8eIvtKjVgjrOeJUkXerHpaMjWhcbOJl1oYL3ubXuVXH
	 oENfGda5j6DGNnZuoQ3nXqOLzhc2vIVPkJaYg6qAtZkX+M/rF+0iDbEkfs+v7mKMfAAIt
	 RMG8tQuqi9BhtOcl/VCdFlwrtI8EK/eK7m1kTwuC2jQGwfUGxSBH5cgiAq46ch98Jc0kc
	 X6m0fqY7hFTe7YlF3zBM6eNCemz+LbnCtcoOckmZ+9GPjnc5lIdRgbAu9ESNLIJ8LmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=mHdaqR4o;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=UO04KWNt;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC47606A31A;
	Fri, 23 Oct 2026 22:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEC47606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=mHdaqR4o;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=UO04KWNt
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLuxx81124716;
	Fri, 23 Oct 2026 18:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=KatvA9ItFG3Rix17MUUmtgQuVc/i6Y9/uAKHLpw04Xs=; b=mHdaqR4
	o98cc3JQCDt26gwwZIiDYcFLyq6Ywcn1I2LscRGLi+WyMBQpPXaAJpbo70fMPZz+
	fDuLGRiszfntffezqJt42GZ01JNOHKF8zuW2ftqhijYWzYscx/Wqkw899rW1AGOV
	CoErFsods78vL0qzdqmcZjOgyhf1Ln3v8dBrhOsan2kYgCxTSSlPnEa1QmA500M5
	9HBRf3nCYsjcnOAg/jxMLaMwo2X0dZ6SfpYuy3rePTQFkETXHrNtr6+8VTW986vc
	UuyE0WVJ1vWK5K1eUmAPFs/+hilWeYoE/7AWenk/+PBxn2gZAMiEa9l2HVSCjxB3
	3raORx5e+teamSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KatvA
	9ItFG3Rix17MUUmtgQuVc/i6Y9/uAKHLpw04Xs=; b=UO04KWNt8UU6rygGfJosV
	X5TmM/rOs/yNbUyblXICz0tbN4vUtThVT7dGADCaxCqfaKBuHPWSPz+DT8fIsmyE
	UdCqIynP6yDRaf/BdXJEHsv6sdStjK/gUHw9JaDzuhlBC8Xv1Cp0GMIdw5p4PhJ8
	pIHOSDQIyIvMwRmS7OAaE07H0xqmM0Qe2HrulEdhfsGLTlcld1yqurm3uZPBo3g2
	KtFObh/+cmmLAvM+4Ojca7hRA+uxG4UdgZ58b2HchNIJxjOLANAQjsFZBueDSw6G
	BDi4S784opwnJVF9RXOa+Dv4+HrsTbeJFgtREegDUWsvhM7bY1VafwOpyXZ2MjN2
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hgcnbs376-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:35:47 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69NMZjM7017608
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:35:45 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:35:45 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:35:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:35:45 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMZWaL005880;
	Fri, 23 Oct 2026 18:35:34 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 08/16] iio: ABI: Add sinc6 filter_type
Date: Fri, 23 Oct 2026 19:35:26 -0300
Message-ID: <d55e027f89919064b14f0b83005158776ef2fd70.1792792325.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792792325.git.marcelo.schmitt@analog.com>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfXxLW3Zz2CF5Yd
 afOIrstN7QQxZXRiL7LXeMsErzpqqkOkHyy+dZXLMtfq0H65Ux79XyhbNHKbysuT8h4OM4keOzM
 JG/PgisHWAIC/L4U12GE2MvA8nNvky2WPtsGEgUZArbuCsOahRyMICwnLewYesJvxHarsMWQ0KA
 zcNXJzyk4xG04n4WhSACDkG6veBus4RIzFdQCA4jtImcSqTUKcy8LLXh9I1dyDBQMhikYyQ02RR
 kpQcGVf6amnYyoStPJIAf9zUrdMzPyCdlqvdNasQRaHICgQzsHis/2VU+RYJ9TWe7sw/UOtV/iG
 AptmVW5y9DykmxdYSN5SHACV8qq+rq7xT0aALM0kkTTTAaPpuSxtL+ju8Jse+uXTGGH2DB8VnSK
 AN4hEZzAfnXdFnPUmYu4WgQQX24nHEq+vWZmanZkV3PifucdI8ET3kfv7XjmCcz6igQgpRLcuu/
 xhhESlMh1bjGYGzhtJw==
X-Proofpoint-GUID: e6l89BVKnx6bnz7c1XngvUkhMwafASEm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfXx12HMcBQEEHz
 5cfQl0ZrN2xWU8mEWdZfZzXJ+ncbwF1x3WnMtcR5lT6PKfXrZ8YGJUzR/ylgw5WdXSuGR3CNo+y
 aj7zRBDXKfJIMqEFE5CO7r4rKX2cWn+xTHKwU1AmNLA0GKEAat/a
X-Proofpoint-ORIG-GUID: e6l89BVKnx6bnz7c1XngvUkhMwafASEm
X-Authority-Analysis: v=2.4 cv=N9e8hG9B c=1 sm=1 tr=0 ts=6adbe143 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=Zkt8XD6kFnYNEgohzCwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230088

Document "sinc6" as a valid value for the filter_type attributes (used by
the ad4134 device driver).

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
New patch.

 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2b6f57041763..5e987c502b13 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2479,6 +2479,8 @@ Description:
 		* "sinc5+sinc1+pf2" - Sinc5 + Sinc1 + device specific Post Filter 2.
 		* "sinc5+sinc1+pf3" - Sinc5 + Sinc1 + device specific Post Filter 3.
 		* "sinc5+sinc1+pf4" - Sinc5 + Sinc1 + device specific Post Filter 4.
+		* "sinc6" - The digital sinc6 filter. balance between noise
+		  rejection and settling time.
 		* "wideband" - filter with wideband low ripple passband
 		  and sharp transition band.
 
-- 
2.53.0

