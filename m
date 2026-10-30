Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372856;
	b=2kVq6u7spEtkOPShOWxTSgsuDo7Bi87zRlIkACUMitbTZKZIPJNRQhLPmQ5IjepkwZOe
	 GoMKI4UehMoyWTFFFqNT6iKt1THMPorpe6hjove8YOJbcS48RWBOxv0XpcXXWZzyoX2Ky
	 q5Oil4QwcQSURfcQwApNWXhOF2K+ajGehjxFL4wh4J+g9C9dGXoIxTQXW2Fhwgrf0jORf
	 Ts2/N0kOLo6j+VZtuO4hiLX7ylTxO31MuUVz7cGpl4sTwB5qxtE0H6/Zj+4+fluZMePZ3
	 5I90GsaNPOvmysxC23GKvnTe+YCj8xsYiZZoYyrdJruigiB6sZP2/wwOyh/fu+HPxiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372856;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ZtDYzKCNzb7bgZ2aWPtMicfyGEULEG1oSrYBD1rl6QA=;
	b=l3fRWVQllY68xfhs0aSevZWrP6kJuXvIPqcoHj6jCUtinBO6ynNuX6qWKTKBImv+dMtJ
	 rMcwTEqXWzcfL0/1WnJIf3SUgFj/s4b7oqYM/OR8REDMTLXOHRoR7zqRI86Ta/HJbmnDb
	 c0NOb2ARO4r4wr3VOcZXCxlKmn9w75KT46cpUrHxzwWgi1Ogs9qCv6RpR1IffAAnWhOyw
	 13DQEdqhX+IA6u7J2XZX3jGaCNiGqwNmqnRjEH4yQenkw/AzjcreftWMLqOMZx/lTJ/K0
	 eOjZTkKC+6JIsEZImyMTYT70zC3Fe0WL/xOqnhvW9Zi8g++rdctnM0c4CfmmhbhcdHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GT2vI8Tg;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=TnOdZuTo;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411EE606A31F;
	Fri, 30 Oct 2026 15:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 411EE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GT2vI8Tg;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=TnOdZuTo
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UER08n473570;
	Fri, 30 Oct 2026 11:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=ZtDYzKCNzb7bgZ2aWPtMicfyGEULEG1oSrYBD1rl6QA=; b=GT2vI8T
	geEyrRKAc7EcgKMBRqACVPn/lL2gz6mHVsvSWi652ZTOaNrOUzrOA2D/IXWD2J/s
	0FnC8ueS+k73NaCem52rnC5QQBLqufBzqWOjM3JY0m+OM26xiMwJGBDdcJrK4A17
	KUhtQ+OL8FQwIZMXySOWjmk8VP3l9hFVhK6cbcrZm6q1kVCrgMeTYBKfqXOWuO78
	hRkhHXEZuz8EacB236Nqk2rT79woleBFh81MO7HgyxyxCitfm2mDZeJOVXJOn6Fz
	zulVlK2WFo+lLFAg7CWdGKDIjCdYdn6RqnEH7EURvxuV22uVyQ+aaEaZUBeXk0Pw
	ppnq6nF+2HREO7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZtDYz
	KCNzb7bgZ2aWPtMicfyGEULEG1oSrYBD1rl6QA=; b=TnOdZuToDaTFdut8ya8Iv
	wj4fMWhMIvLmC6Cdob/kVPaKf+PyC6+ACTQ4J/Y8kU2AeLOM7oa67a0rUnHFkiH2
	K5OoMbsOoGK2ab5fqZ60XO+RKRMA++Z5+j6/TJlIzjZEkks2xwhy2UfvA1QEi15l
	3BkWmwtCXjcBsIrT7cgBHcxUlKwN6BYaaBNQUmEj2MJ7btwXf6gfGMOaXQOtpzIC
	2T2rK88fzG+qr9IoXnjn4V5QWQ8Nfj3lC99BYzLzg6iTjY7HOoST5k+s2gy+0FF8
	QwhRKntJknnFGzGDoTgK/HeDwAggpK1+c+wj8cvBY5wrter8WRwtLf7LUXUoI6I9
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7bvx1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 11:07:24 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69UF7NP5014905
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Oct 2026 11:07:23 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 30 Oct
 2026 11:07:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 30 Oct 2026 11:07:23 -0400
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69UF7BmG028551;
	Fri, 30 Oct 2026 11:07:14 -0400
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: <andriy.shevchenko@intel.com>
CC: <sergiu.cuciurean@analog.com>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <ukleinek@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: adc: add LTC2387 and ADAQ2387x support
Date: Fri, 30 Oct 2026 17:07:05 +0200
Message-ID: <20261030150705.411102-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <auSsl5_xQNXCNphJ@ashevche-desk.local>
References: <auSsl5_xQNXCNphJ@ashevche-desk.local>
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
X-Proofpoint-GUID: 5GSdl94ZMrpxxyVN4Ha1JgC7CZb4mFSn
X-Authority-Analysis: v=2.4 cv=T9AZ3PKQ c=1 sm=1 tr=0 ts=6ae4b2ad cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=lqvLhWEU_XxSqjk564gA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfXwah9Va40KVj1
 xUNOQGwEVufKaNW1BM+vCaC9PlHKQlxc9pO6cZpY6hhITu5v0K+X0rF5nxej5oToP/Yq98eMbMz
 rlzSEgWRGrD89XbcpxuuFcfYeaV24UML0a9BSqAWbBf0362+UE0X
X-Proofpoint-ORIG-GUID: 5GSdl94ZMrpxxyVN4Ha1JgC7CZb4mFSn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MCBTYWx0ZWRfX+aYDnCLX0HW/
 G1oE/dEApfV5U9r2fbzZwd/R2ADSNkRXibCYzvVIzxFnkG+CBgDNrSUgUIDZrhzt0qjQOsAwW40
 RTNwnuCv5OhvK0KAX0/HL8FtJ6zI3Jp2hhuAuA6mJtJZAlgJxW/tZbpKtYoGOQHPWQ2zvNykS8/
 ZkNGX9xDQtq3MReI4DAQX+BNWy4gIrQ6aPSaSk+FFyT8H+DcwNLUHwBa1mC8QM+VpzjplwbRJf4
 w2rozNkb83AYOVAUpCjannwsqWNQ9bANilq7OeFAs9zt/rYD7Yo2w9NBDk5fA2V7a8Caw9s+JkO
 mb61Un+FFWzg7LATDsIk+5Ds27QFdbE5XMBJ44sGg4HpfWP155oUs/Z3c9JLjk0/wjjs3xIZLtt
 TzIAHnkTI9OnO2vS0BxiS0VkBQpseS8E/2FSjXwCADPbhlT4mAzVFhiDeR27kjIyt6cD8ji45NS
 /UhkQmh8m7qo3tbRkkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300060

On Fri, 30 Oct 2026 16:41:27 +0200, Andy Shevchenko wrote:
> But these difference doesn't explain why you need a brand new driver.
> Is hard to configure this at run-time by choosing the respective driver
> data based on the compatible string?

Looking at ad7625.c again, most of it can come from chip data,
like the driver already does for max_sample_freq_hz. The lack of
en pins could probably also be parametrized.

However, doing it this way would risk clashing with the sampling
path of the existing driver. Keeping it separate would make testing
easier, as well as isolating drivers for unrelated families, which
might be out of scope for this.

Ultimately I think keeping them separate would be simpler, but
I'll integrate it if you believe it's worth it. We might also 
need to consult with the authors of the original driver, as I
haven't worked with the ad7625 before. 

Thanks,
Daniel
