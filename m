Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361776;
	b=4OpJsINn/JJ65IO1zdm5sIH50Lwq4WfR9UVkz8l6sfcf5Yyzzo+ERAB8dSv27cgPdMmo
	 BqdsswiqC6qp7MvKMKo6DzkhiPPXL2yr5KSxblbpNrVsx4eOcKyHVxg5iuvJ0LTZjW+dN
	 4hbIdbO7SfP/d0t7PEPuk2nkNKjLn4g1ddPcRVF3Z7MpTdc6WLK0OlC3pw3syRuUnYrkO
	 hY++qXXCrSjLpnOqRvCwu8O2jdMpaEk/em9nc2ymYmZ9f/MYk+SNl+8WtzUnnX/YMxmui
	 ElFp6Bwc7oO6A645mfHm4EEdpnCmrgcKSxQg9EfuUMFp3ipzxxi5ttAmyDXxWx2PZ6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361776;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=c9S/U1H5OICMNEFW384lho6MZOsN+RV8JrxUnuTzmZQ=;
	b=OzDIvA+Ll0JvyjyT2PDEmIePmy7krKYGQMQc4/hipzt1OztH18688A1jA7G61QmRPwC9
	 IwtPZWiU3wR/ZnZFPC+vXvts279kKSugoCz2zsjygcQDnpoNx6bMfHya9AqNCiE7Rs3DU
	 F8iP/pn/ILRym4NnsjhyMm26U7DjrIfVViKUTVhFdtRYstFzkGQdgTgNU7TEenKGu0ERb
	 H9YpJKzO8w0DItCJ4WH/xEoYLBlztEdQ0O+jb+K5H1h1Lk6js9uEFB3HI9YPRBAYzgyBY
	 Wh1GDB8EJwQ1BSXedIp6jbZt9XNKE+it0ZEgnW8355ndmXxdDWBg4LgR9gFrGxtfmlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ccUsT8A7;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="C7Wx/Y9M";
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E9606A337;
	Fri, 30 Oct 2026 12:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 809E9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ccUsT8A7;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=C7Wx/Y9M
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBI6Dv1436848;
	Fri, 30 Oct 2026 08:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=c9S/U1H5OICMNEFW384lho6MZOsN+RV8JrxUnuTzmZQ=; b=ccUsT8A
	7qkv8Z9MWJ8dQahQbY1Ud63oYNtz+6LnE1L7aQJemqeT98KDbGHamMuGygwDgRQt
	T2Z4K4IbALGt54GW82PNdmVcDCTZ4ZLsMrEYtOmmHgUNCGn64hG2ZUnpuROfXYSH
	0tuu23EmKeoV3kH6jN4Dh9yu7tua1CmvJ9N+rH2odFd1X17pzJlQHDzyb916c8RW
	qdC91AIefeVsEj8ju0BH1UEKxWBlqiIfsEbxOym2gMnRJ9mb7njwHc/1+XYUdp0A
	6nlysQPPib9MwH6JXCAP4J6bov1Iss8lKWAWNrcjVXZ01f3nCVIq8GQlRsdJtkGh
	glT5Z/nPT7ggAUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=c9S/U
	1H5OICMNEFW384lho6MZOsN+RV8JrxUnuTzmZQ=; b=C7Wx/Y9MWuufVumUy0SeJ
	+VvcXA7FnYf3yv/E6oi0DWLHaNCPeok2oyE3tRCn3TyNmJFZwbtSEPcQkTG6jlbd
	1meIPGh0bP7bwfW9Np72Bi4Y3bFIoY6ImzfSFqIT/FGi0nb7TQdhYjQYv1trgG81
	x6pbI6+I73u2n+Lfx36d/YJvl+KZ2D6DzFc8ugjzJuZwKVc93tqBXsLGw4xW6wvZ
	q4kbbTVO+BxIo2HRXkl/iTKW7xHBRgBUz5tBvQft0mZdzx276tynSJBQbWhC1sA7
	IKQzWarOnzOxPobYLVJ6Bn96WCtTP57XafAd0T/XPqjPa3WZrxtFdoI8Kll8F72b
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7ac03u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 08:02:51 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69UC2omq006520
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Oct 2026 08:02:50 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 30 Oct 2026 08:02:50 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 30 Oct 2026 08:02:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 30 Oct 2026 08:02:50 -0400
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69UC2cS9029032;
	Fri, 30 Oct 2026 08:02:40 -0400
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: <krzk@kernel.org>
CC: <sergiu.cuciurean@analog.com>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <ukleinek@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add lltc,ltc2387
Date: Fri, 30 Oct 2026 14:02:32 +0200
Message-ID: <20261030120232.269585-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029-rustling-scrupulous-peacock-5e6b03@quoll>
References: <20261029-rustling-scrupulous-peacock-5e6b03@quoll>
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
X-Authority-Analysis: v=2.4 cv=bcX+w+PB c=1 sm=1 tr=0 ts=6ae4876b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=W8u4RvIHnHHQhm-UzlUA:9
X-Proofpoint-GUID: 81BRxWoFrnnZbA0Z-vlatwUqMQx8vm-H
X-Proofpoint-ORIG-GUID: 81BRxWoFrnnZbA0Z-vlatwUqMQx8vm-H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0NyBTYWx0ZWRfX6F7j1Xv5gCrU
 Z60KNqBCLCSI2coof7fdwIP8WAhw5s1ICMvbFxxEn9GiT6qeRVIqeXDpnqyrm7m8lK1ZIG/thoQ
 hm1+2BvCdM62bJlBQ75K8l8RUmdhAVnsHqxlNrTLTgnUpyf3r2yd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0NyBTYWx0ZWRfXx/K/IDpUeEKS
 ZwrrbULIHb9DiAl7xz7FF4nfsU656aEGxmMfT++47rU5TSKPoJrrvGkg2Te7Nk4VenxX4ljeirP
 wSsEA5/AaFXJOgFSc22FqcT6yTbWDAYu/NUhWHX87t9REdjtEP1qlnjff8eg3Mk34xpaaDvPLDT
 ELLOcBpuE4dE1qfDjRr1gedzOXdHZUb6p79OKGiO3sBRruSxkHl3m316KQatKq6S/Xx1k68oCZo
 W1JBPV0fJGHuJfksSeKHpD1mN7ezTlFe7zrVPVQOTG5BZNUbO0Cz9IxnKWw8MhAPOBx6ZTm2+gZ
 bTYQKY8cgg9gi7QAN/9zQzavUyq7Ahw9UknJlMc9w8CEiAPpNRLmexs01XaoMnv7gvBLys6sBCs
 GhL0w7PsMGId/w+s0BSBQBlNdZKUXd5JPn5FaC8NSxjS6oSNeoN6qCS2KVsp91CwB8t5mPp4hxD
 wpI34iW5KUckevD3Hcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300047

On Thu, 29 Oct 2026 10:47:47 +0100, Krzysztof Kozlowski wrote:
> Drop tag.

I'll drop Assisted-by in v2, and run checkpatch --strict on both patches.

Thanks,
Daniel
