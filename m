Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354917;
	b=zReVz1s6HmpokVYfYHm57q2aN6jRQR/kMmOBa3Af8hbAe4Drg6l5b5mnwPJKgvB13Omp
	 CRWP7sKF+bTDNZOZF9liFB38t5LXXryhNaF0g+V87GIn7hz3gt8eJLQE5DDfEBrGAHkYS
	 OYSLzNIR7ZHzvaYij5K9zcyIrThEsPo/gIRh7/gmlavtACY0Upt7XqFEKQOO2eJb0Miw9
	 p7qz2/EruOBPMD/x6kdgcME+XhHWuvaoHiR7t2S9nQZfB5POrJcPm3Jt5dKQh/EP0NFlZ
	 SMmHUq0adeS81vKOj/2YY/OSXq8+LOPJdj1pSKv7JXKg3XcJlW37OHBItrVSMrtt4Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354917;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rB83N3gV3BeJ5vg2nmtSPJxp4JMkDHnYRcorV3eP9TQ=;
	b=AJeaJ3vAkEEulJucdydbeWFRD6PQP9Q5AsItoE0JFxD1kIybkVi1eRgK2YDp97gK0yMH
	 RAi+iNrb4AB8BMdu/HPWZOjAV5xmAy6ERf7C90MPtJeirDr4tEOToyZ+wa8CPWG7VrjS3
	 MduT2zJHop3Z+FHw3CzlR4NxlxEkqiPZTR+kQsprAnNm8/EOadp5k611DYUpWnF2SpcnH
	 eisIZJP7RaHu+1O8i3pfEQ5XPVsRzB5C8oRtvp0qeXgPZP5OG0Vy2enAyrtDwyh60KkbO
	 SdRrROvFMSddtpPhbdF1dn4MTb1HksJoLEPmtgaAniySObMpXklHJm/CYUjO2abpoDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="o/PJ5Mcp";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=CmuYqQ53;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF95606A31C;
	Fri, 30 Oct 2026 10:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FF95606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=o/PJ5Mcp;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=CmuYqQ53
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8H635602163;
	Fri, 30 Oct 2026 06:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=rB83N3gV3BeJ5vg2nmtSPJxp4JMkDHnYRcorV3eP9TQ=; b=o/PJ5Mc
	pjaHb/X6EI3oPQuxxA+GEz3s6qqHmxg7FpgKMI9/rUBt2y91JlmXC4OG8Dvat8dh
	w5/6y9xQjbTBg1fdL8T59Dpsr0QhltFxxp5bN6698rt5/hkwrzG/dXz4KCpwVJdZ
	V1TwSXLWfJJvugGXTIsTvQS5JIUlS0vlIYPsBZDMmKirkqmHTqDhhIc+FTLD/L5y
	MHTdboWJQHryMRi4pi5S1A5hNHrhh3C6+jFKr2Rb13Md+wSyeQIg6WvibAnWLS7a
	dYForgNn1pEgQ1sBsCi/QXOWuZxdhGJm5EU4Wx45sRGYkvU8hJLFUQiHQllFFum4
	ZrN6VPFARI+1bOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rB83N
	3gV3BeJ5vg2nmtSPJxp4JMkDHnYRcorV3eP9TQ=; b=CmuYqQ53BKrE2PwWZyoIJ
	NwmJZjDoOcKGFiBUfevb6y4EKAzaf5WYiZCYSl8lE4EElw0IiB68T5ddBV9AVGLn
	HgeY2zEDjzHiaFEpHsnK/A0RiXbZgtufSat0Hu/wNAbbAQ49qjrWCpmEzMNiInLm
	coFmfxJ/ODTZdWdT4CtZwzITn4VWAISy9bRnBak6zm5ccVEzEd+2SxQ4qAsFC7ph
	EHsthd1Xon76+cO3zah7xtHdl1qwzrEmJFr4cmDBNBqkf5ehCqEuholNuonvSScv
	q01l/WsSDe0XTiOT7yp3xFya+Kv3idkDI8ZMN8YXJ9LQHE4dbvgb2FOMPXi30GwR
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7d3d98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 06:08:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69UA8VGL001023
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Oct 2026 06:08:31 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 30 Oct 2026 06:08:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 30 Oct 2026 06:08:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 30 Oct 2026 06:08:31 -0400
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69UA8EL5029419;
	Fri, 30 Oct 2026 06:08:17 -0400
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: <andriy.shevchenko@intel.com>
CC: <sergiu.cuciurean@analog.com>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <ukleinek@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: adc: add LTC2387 and ADAQ2387x support
Date: Fri, 30 Oct 2026 12:08:08 +0200
Message-ID: <20261030100808.217874-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <auDJu8u85flQ9bjo@ashevche-desk.local>
References: <auDJu8u85flQ9bjo@ashevche-desk.local>
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
X-Proofpoint-ORIG-GUID: Y9IXxxQKZsSwnW_0Rvg35XwwaMMAEpyA
X-Authority-Analysis: v=2.4 cv=Yt2a1IYX c=1 sm=1 tr=0 ts=6ae46ca0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=2yiQNUo5oANuN7_DN_sA:9 a=TUjgQ2XdYqcA:10
X-Proofpoint-GUID: Y9IXxxQKZsSwnW_0Rvg35XwwaMMAEpyA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MCBTYWx0ZWRfXy9dkJ7CHkft5
 GBT2+96oS21doNcjvaGPqAK6tkZS+CoAbzqdfs0JbzPT3K6+KrMYL1TlDwyIiiIcmxgUqQ/VgZ1
 735GdTzacKp0hRWZnKdB0U4BxJB/AC4c4X7YniH66y/e9ZUDZptmySQkygNj4sroYR+KH/f7K1/
 7VHNHJ53oSBAn3jCJNsW2dezTIMQgeHc3sQBekYM4L8ApHqbtdRIlyUmxf50ESiaNypNDMI40pS
 309YrSAHmaN2o+fZpitj+GwbsDMrD+he1Uv16Vw/TQ2lH/jaktDNc3VbVr9vlS/8CqlyElkQ4I5
 mp+J5ZJ1bosifmuj+oB+pXaFH1f1dYQskXXKme33YgpHBMJ6YIW99309nb5zViufB4bFgloWxYH
 uSjyDKQk0dvE/K3skFTFGAK+uRDh+2UF6xJAjHtQoempkEY9megyzjwAdAF6/ZgYeo9UWxsL34+
 i/60lvvRyK7cGc7lxhg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MCBTYWx0ZWRfX41MKkoPiFGbl
 GK+PYXPwUZ24EaeqL5wIqJtwqQSbgBbvXJlHDB2p0Kp7XnwYVw4ak48CWrfuqZBccwe2Y0dpQfq
 Ez64uakrPlePqqrKWAf2IuwEB0zG6WznfD9aUklncsGj6WHH+t+U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300040

On Tue, Oct 27, 2026 at 17:56:43 +0200, Andy Shevchenko wrote:
> Why have you written a brand new driver?

ad7625 is the closest existing driver, and it shares the transport:
CNV PWM, clk_gate PWM and the AXI ADC backend. The converters differ
in a few ways though. For instance, the LTC2387 is DDR on one or two
lanes. ad7625 is one bit per clock on one lane. Also, the ad7625
clamps the period to 100 ns (10 MSPS). The LTC2387 runs at 15 MSPS.

Thanks,
Daniel
