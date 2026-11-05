Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859238;
	b=cZM+ckTLN4bOUKY5swwlLsU2oSV58M4ioq5g14KVO9alIoUu4yA70cwIc8llPiJd4aar
	 64AU9hQx46Ks9nhHn1GfaF8SSdyZrYuLg4ydRempr5i+7QwUpjQ4bZRt7672hBZWga7as
	 ZbKgFBKq2fUJbp6LLcLyC8yxDCiG/UYbb/HdxLkrO0UrNZRr+z03lIkcYj3U0n2SKfgjg
	 BYf/MgeHRfUBKEzV+dKQ/84i6EnvqUP1TarIdqh8WN/Ce4ohylFsFEfPWz4XlYfArGrUE
	 E2w0ogEch0RJxkdc5wzK+vpEGH7BLgmYRb6U6BvwVJQzg/s5yo50W0FnIw/Vm7xbsLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859238;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=36YHDyAFumRwB7syNh1gtnQUDv870tWGTj0kMYjKy84=;
	b=qLiPmipgFAb3RPAHJCoAPcEALc2B3+OmIpMb9ZUeWyNzemwUtFp7kzrUaIBV0mnBDKTN
	 Xpmgw6vc2+2P6kH2iDc8glh+Ww00WiW25TGQGmsEUuRBDMVPR1mXgajshoX0d6iUmoBgi
	 BpEecXLKC4dD8BMwLpqLMiZv97QY9BC4BsxP6BP/VZiG32B3Jfu6n89KJVOIETpoF5ZHu
	 BeHPNN5Hk69zbfjY2hOOFslp61JWNifBu/yuM2s6zix8dJHc5uyRVwH4JjPyxE8ChPDdi
	 /Ve/YxwxJA5uf/ZrVXPCTk6SjQV6vWEdRDR3pF9FvshfwsVOtdcnOxTjhiUh782r98w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Fp0oVP9s;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=pnSu8a7f;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E469606A31B;
	Thu,  5 Nov 2026 06:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E469606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Fp0oVP9s;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=pnSu8a7f
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A53g8eG3589332;
	Thu, 5 Nov 2026 01:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=36YHDyAFumRwB7syNh1gtnQUDv870tWGTj0kMYjKy84=; b=Fp0oVP9
	s9GiSioEhOhmFxsD0gs6Ul7iSJPSnSMhFOOFxpwtFc+12Vrqal1kp15x7i5JbEX0
	O6NlCV4xHhrcAyMzz67R9C0+rXJiR89tTjAg+m31wOGPu7+yfC6mKCUgstYZg/UX
	TP7n3pNaW43AVSofJIE8zZ5ahZwzYNOQVgVC9NMCmPw4WvQtqqVi4cKqEdLrFFI0
	wH8vVosv55T2/zAPuTljNyELq9PabAoyD6bv+nCboQo2JL4zTs7s1IMl1AByHQ3Y
	bY36YUp6KUXowW9cAXsZm0d+v0kQ/OE6ZCaUoNYr18U8BHcQDqAA2k+eJLkYKlz2
	usP0stV8ydqx5Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=36YHD
	yAFumRwB7syNh1gtnQUDv870tWGTj0kMYjKy84=; b=pnSu8a7fOFoX2Vy0bup8i
	cCZjRJptmUNffTLNAAlGJ6FqSSfKuRTnn2a4OvolJuVcRo6RxkrJTjbMzSnYYYfh
	IUD3uTcltFwsKoyjEl7iJXNoWiCLGPTu/Xz7osdh8whxxNLlTlcMjHwN1j2vfgc0
	CgoXW3S21EMYs55990WV6CRjGs9xkMNlS/OySlXJrmzeAypxsn0uOAGRbRCpEfbS
	4noNbLvmZ2f6f33ZvDNYgT2SKiwQz/pHAyjgOLKbvyTv/SKY31QqNBkqm99o7wXh
	CbKYFUMZ3NR7Gz0/rwNcxzCX92BKCkWC+SFOKI+OAVqtiX6Tp6PgEY3U5751wrEI
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hr9xd3f7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 01:13:43 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A56DgC7018491
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Nov 2026 01:13:42 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Nov 2026 01:13:42 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Nov 2026 01:13:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Nov 2026 01:13:42 -0500
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A56DTi2008946;
	Thu, 5 Nov 2026 01:13:32 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <krzk+dt@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
        <Michael.Hennerich@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
        <conor+dt@kernel.org>, <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v5 2/2] iio: temperature: add support for Analog Devices MAX30210
Date: Thu, 5 Nov 2026 14:13:23 +0800
Message-ID: <20261105061323.1187-1-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20261024032406.2b06e47e@jic23-hlaptop>
References: <20261024032406.2b06e47e@jic23-hlaptop>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAyNCBTYWx0ZWRfX+4If1gK4rE1r
 kKVP9sudnA3r3VZLQ3v/QH6GrGIN61RKLzsGxrluBXRzKZ4BTOoLgfeU+7QjLzeGOvhHCaQ0FGb
 gEYbfPMoRrzn20oXsJCmztpt3vPCS0dmI7iKfcICI4FUk7qDAp4q
X-Proofpoint-GUID: pgCDHK1Q6Mu4mqMctMcuYGnw5A54lM2f
X-Proofpoint-ORIG-GUID: pgCDHK1Q6Mu4mqMctMcuYGnw5A54lM2f
X-Authority-Analysis: v=2.4 cv=JrVkP84C c=1 sm=1 tr=0 ts=6aec1e97 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=x1dtyChXVFZaEs6LlPUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAyNCBTYWx0ZWRfX5bCSqtxFBm+n
 tNPCvCmop8WUMj/lVbyzgkRumF86ZGhHOPRODF4gDXv5QgQnk6LiY1fhjJUEWM77IF3EAwLJZMd
 sB2zJFv4iuexntYpYX5HeqxpOXhv8o0ll18OLSv5GxkCdB4n/Mtp7OAhHU4vFIUWlyJN08tMdk5
 NSeNI3Poa2EqKqRAh3Ocu4+pnq+KTK4dc+cNsPSY5hLE2mQrGar+miLG1Bcvbzd9gLvzJGcDd3F
 ywZWAH/Tfnj8lQSTEMpBFND9P6/x1deKct3pkvrbTHys1aqheNF1qdBtVFOcab+hWxNLjTtgu2q
 NPqj9VOGRQH6SnbG4YQfnNu3RBpd7iP6TjhyhNZnvtJEUbPjcTLlN83Sy4LTFXKY+JVoDM+yWAw
 hXtTLFL5w93FTLHgJaIUY/UJLdEXr91bzGk6lUU2AgieFGfht3TX1m0AgngpZ+sEKXMdBaWNmN0
 CzeC+siSZjTe1DVhP/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050024

On Sat, Oct 24, 2026 at 03:24:06AM +0100, Jonathan Cameron wrote:
> A few things from sashiko
>
> Feel free to just reply to the thread saying why they are wrong if
> they are.

Thanks. I will address the sashiko findings and your guard/goto
comment in v6, with one exception: requesting the interrupt before
devm_iio_device_register().

The report says the event interface is freed in iio_dev_release(). In
the current tree it is freed in iio_device_unregister_eventset()
(kfree(ev_int)), i.e. during unregister. With the interrupt requested
first, devm unregisters the device before it frees the interrupt, so
the handler can run iio_push_event() while the event interface is being
freed. Requesting the interrupt after registering avoids that for now.

> In particularly it reminded me of the reply I made to patch 2
> about what we might want to do to fix the event interface lifetime
> issue.  I haven't had a chance to get back to that since.

No problem. I am happy to flip the order once the lifetime is fixed in
the core. My test setup runs a 6.12 based kernel, so I can only build
test your patch, not run it on the hardware. If you post it as a series
I will build test it against this driver and say so.

Thanks,
John Erasmus
