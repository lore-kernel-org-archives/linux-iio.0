Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363866;
	b=exxn6lGTTFvFOVYmqgttvndBwWBWyOnt2cU54TYU7do6GJ8SJmgosf/2zOMIRsJoeeDI
	 NNvwnR2Q83A5opn01U78RxDONnlwtE+p7/3YFSZAMWMt08X4T0Ygry93gJ8uQoih9MC/b
	 5N/KJHYwu/f8F+wAmOULQbAedKHrRSk57KT6vGbjBkxFk8T3OLOzTp7N5fLsNJjF7sC5o
	 1NWyd/e0L+J7qUYaxWnSgi12ievDWoKexu3YDadvTZsGCexFhh5qhaI0yYsIN/JQUcjV5
	 SzzizVH9aozWfcVrzeTk2N3Zew4Fh1aa3iMshyEfKJ87SRNl3MHF8oATiOY20rZQl1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363866;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HIT1gA/uiyE2ZeyS6P02z17BC0t98TWx/E9biD6Jw+U=;
	b=yL43f1yImM28ui1EOsntGfLRzfVBDfPC7j5MWG5tvwB+UjwzE91a9LGTQLBeShx4S/aF
	 OXgdbf0+zfNvTIgfvqkF/Dv462kSDJFYWzU9RbPXbPzB7YOVqG4haZ2ExSicK9vnVJUt3
	 9HSghqtVlVwH/yQddzJJ4gMxUdwcVyhk1ZoIaI8Sbj1jKjgaqi8MJnuYzP6nN7z1P0SKX
	 QthFYY41vF+p5WVnGTxpU5m/2zVO57MejMbk8kf2Ke3py1o+ufbX8XjXbYE2CpB4X1HQK
	 ljE/hat8+a6r3ya73i+VHvjkPQV5NeS8e8r9/d7ojmS9PFB285E6VhhXhaAC6wTjEqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=IjEZ7idq;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ax2mN206;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FFE606A31A;
	Fri, 30 Oct 2026 12:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69FFE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=IjEZ7idq;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ax2mN206
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBHklX3601577;
	Fri, 30 Oct 2026 08:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=HIT1gA/uiyE2ZeyS6P02z17BC0t98TWx/E9biD6Jw+U=; b=IjEZ7id
	qqJXAA6aA3dDwdZUVbTxKiVWnIxGZG0mR5n+91IjRkDWfj4demXpoPjQWXW7CiSO
	DHJVroXLDTNE4CFKWY2tCCJ31LAxVVOQllgPenxil2DwDtLeN0dCkJ2ygNpls/Ef
	Q2ql9zc0ujbozb7uulsWjf+nyjM4EQGOB8bSmUmpf/p1zh4+3utaHP891xgo1S83
	dXmA6d7i//HYPRb093QIH7WApI0E6Eh82YvgSAvzYxuBMvR2Hsn1bHBTkEt5sbTZ
	rl0k7jC7fqLE0AG/qxxn9J+LZTlM5U3lcUiydwolrR1bPHkBYQII9q8eEkJsr7Vx
	Ma8epJqTkveWk5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HIT1g
	A/uiyE2ZeyS6P02z17BC0t98TWx/E9biD6Jw+U=; b=ax2mN206NzCaSheCKibNV
	7MoOz8syaHBD5jizVqANzKgkEHRRi2FZh3vQ+LvkztxbNes60Iw0z0qFjXpNjCVv
	rGxiZYJt7JOS+2kca9ciBKzz8Z3TfQxyy/SAAVUV4wQ0o1nr0BJrz/voHmuZFwEk
	LSbCmNM3ORO8zVRZVc1lHxu9ntlDN1xwFN+c5arFcRVD7KIe6fDHk86QbRQ4A2d6
	qBFIXoHMmbtzkECzDchXyWLSRpdBaaEfPuE1xMIOpce4cDqlaUdJjCzZviMsuMud
	liR4tmhi0ax6XhC/STspxYzZzlY/M259woFrAH//jBsxuKdMvcu9Z/EGPlcnD3Az
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7bm290-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 08:37:41 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69UCbeoC028648
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Oct 2026 08:37:40 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 30 Oct 2026 08:37:40 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 30 Oct 2026 08:37:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 30 Oct 2026 08:37:40 -0400
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69UCbMUM023339;
	Fri, 30 Oct 2026 08:37:26 -0400
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: <krzk@kernel.org>
CC: <sergiu.cuciurean@analog.com>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <ukleinek@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add lltc,ltc2387
Date: Fri, 30 Oct 2026 14:37:16 +0200
Message-ID: <20261030123716.296299-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a9d1b3c8-e7c0-475e-9fd8-408670ed4f2b@kernel.org>
References: <a9d1b3c8-e7c0-475e-9fd8-408670ed4f2b@kernel.org>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfX3NT9Jzd+Iix4
 Wv77ed71r+e83v6RJ5hw6glTs4AJp262wuhylojRSF9yeXW8nDA/vC3o5H7FhibrVLdM0xOB/nT
 xJoKFS8HJoO3G3oct6Llsc32W+z2nyBWG2amGyZUO5g6oSq/s61NBR2ra6zDcHR59/OTZIQ7x2c
 liFjEVoGKUyHjyAs8YivjB+tAFcX38vl3IFcHe68JihbqUXqS7rdBLJX+jw4OJwg4hNKAf/KDLn
 mldfHWeTv+SK8zvDSB4Hh368WEfi7uGWlNG1uYn7Cfo1NFlmz2+ZHmR1YG4aKSljEoLR7vKgg7B
 Wt9KiSrqgGoZnbvktEoVF9ykUuK7e3m+txmvRrmX7uaD/gtHFux6AV8pbSK1gcNX1tjFlLZOQKl
 TRkfAVD5UB1R45k6IfO3XPG/SVAVtrl4XqpLy2hlJwk+ASu9ocO35YwMJjrvDq3R2JgKLBWAKRr
 o2ONH5FyTiFMRBmCUdQ==
X-Proofpoint-GUID: KKvncvhn_9bRTnUk1kPADyZMdr-hZpEa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfX1um37yz4vBwv
 dLYNYO9vy1J4k/n1XPVYSc1P5P4pMgdAwqqARr2iocgYm2lSQzuUV3+kcfbESGDewKBHnRbnWpH
 wYxr6E0axbFHOpYZnAnzkX9sNw9jQrkd8LCZGkc7+/iaaUqiU7bb
X-Authority-Analysis: v=2.4 cv=XfMcX455 c=1 sm=1 tr=0 ts=6ae48f95 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=8CewITcD-NaUE93ftHsA:9 a=QYH75iMubAgA:10
X-Proofpoint-ORIG-GUID: KKvncvhn_9bRTnUk1kPADyZMdr-hZpEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300050

On Fri, 30 Oct 2026 13:07:13 +0100, Krzysztof Kozlowski wrote:
> And the rest of the review as well?

Yes, sorry, I'll fix the dt-binding spacing and style as well.
If you meant the other comments, those will be adressed in v2 too.

Thanks,
Daniel
