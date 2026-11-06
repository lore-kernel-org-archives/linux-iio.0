Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981514;
	b=op3ReM4sy/48LxrHTdmNgZt1IJr1k7D177R5MRL3baqh5f7hpuV0d3pp4/00IkDn2YGb
	 8c12c1KiBshQ794n7v30J4xhePiw6DxjNptmiDjTDQwfAp/XBoWggPTgdcq60pm0NQJ1A
	 U8QZZSi6HjpqOb0tMcaSQUcXlJWrjDQsodHmHBYmdf48rWNrqVWUYYFvmEgXgDC7+stxG
	 SLNTxjDr5dvWoUx27x9jNUcqb3CMkv2Y2TioqHiiDw8ydXbGnlm8jzECiel3XAMKZmENw
	 2nT1JHFs2S4/HuP4L/E2vntGtZ4DidCe3IkqLJYy2gHrcqWYZ4Ba6tHwrC0ceskk3ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981514;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wja8uIoxJHQmdC0EKmiOw8xNORvki1GhVV0A1YI8oTU=;
	b=YeimzwggqqbwV7w/Rc12rdFt0jGfQv/2PpCYxbAsGKUkbrwWKsMPPfuKLo+Bkmovm049
	 Vj2uYKOovdMhK/1LjGeKngX30zsCBHjByFVkjw42xloPNeLioS/Em53gB9w0f/onFcBJn
	 1Z5nvsIwUlDGd3VOmfMuOeBL8Fe06HwGR+FyjSZ5Wed0SSjvOa7Qt3zlF9Wd/VxdIe32L
	 g2NTuyZnlokpj+SUf4ofka7ceU3jix701UMBFTlLyPYyXyXMwgZoNOskT4YtNpXCOpNpi
	 fBcyAl1R2kwaCo0BlD35+HiYtwXDgOPODC5r80vK2kJEZaAH/Iob0EAis/VXvb8grxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=BUwrIq66;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=bR4ktAI3;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960FB606A99F;
	Fri,  6 Nov 2026 16:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 960FB606A99F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=BUwrIq66;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=bR4ktAI3
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4DoB3366252;
	Fri, 6 Nov 2026 11:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=wja8uIoxJHQmdC0EKmiOw8xNORvki1GhVV0A1YI8oTU=; b=BUwrIq6
	6xC1zuGIRsRoNR34Ln/MkuRON+so2AJMG0AY9lovS6YTxNZxH1d6kAcRzpKXtlVt
	vLpIpMEBJPPjnQADmjxqG0qUHzbS5QTwfGxnc4VCqgRLSEnm6209d3IGYzdJmj8W
	kcHvs3W7fvuzaVoITTe/7isHTsxRn37tKUMA5YgEjq364QWdQPBc0PHD2snHFa1n
	OGtga4OMA+o3rTav5I3qZYVdDZcu+isn4u5TJhiKitcBSVqDIXPBm4JaENEKxIxa
	0BuEOqoREwlBnNCuHiolpLJMBg07uva9R0a4gbG/uXOqEGMaDSsFYNj8/jLy0iW2
	GJVHIXvROS56bUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wja8u
	IoxJHQmdC0EKmiOw8xNORvki1GhVV0A1YI8oTU=; b=bR4ktAI3ThgtrvkHFV7L4
	5TOOLle/O9j6qOsKAowWmENiUQTccTRAHomPsUtjJRbCOVM9ya+FPwpxCi/MKNpa
	fAnNKKiYJGxzi9OMQUBaZe89qeSQgp+k6awsEP6/RpuFTamQNwE7We+OavYIJ1uT
	CEMoEnX9+9Ge+aA1qOMeMeOdBtZpxubeB06VWPVsxiBbpkbove+3LdJr0cC/5a/Q
	CuCw/BJzR3Ph8Rqhp2NozL59k7yG1FQ3ppiXnXWx2dldyNweaLlO2kJBm1QpFO/Q
	+2lmRA5jA/rkvVjx2L3XI21ZoEwy3GklOzKABXb9D7d7TTSD+/4aF/eITZliGYj0
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3qad16r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:11:50 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A6GBnAO052763
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 11:11:49 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Nov 2026 11:11:49 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Nov 2026 11:11:48 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Nov 2026 11:11:48 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A6GBaHG016486;
	Fri, 6 Nov 2026 11:11:39 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        "Trevor
 Gamblin" <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: adc: adi,ad7625: add LTC2387 and ADAQ2387x
Date: Fri, 6 Nov 2026 18:11:34 +0200
Message-ID: <20261106161134.879712-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105-domestic-seminar-a5899614d882@spud>
References: <20261105-domestic-seminar-a5899614d882@spud>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX8pGv6IAYhqIz
 3bsl8IhqjuPEJyw7O1elOYU/KZ//Xpz/tTzZZU189ndOcOHxoSRDbIj0gNrECla04tpIhBR4zwt
 zyYmVuGuoZpSXuhcoPgMrR2/Y4U/OyuzprphtxAdy16opo65Xd4F1OdwDGtFiPC2vTCVLEJSoJ+
 P3pJ+5Ex0O0IfVx6Bdxs12MRfPkkkHjkGr7eyl+PQHyKy9OoHwL5VmqXQwS66hPykIewyAY+NL5
 1X8sNCB+3XdXDUxuUI8yajw0bHyFSDFxwuUTYr6txj0xVlhkQA2AR+LwYZ94ABDG0JJ/URfd+/M
 xyqyvhQi/zX8NyQoDxNfNy9rZ+S23nnU63X6Jy58UlsBycUAnRxbeBDjKjaWmIMeLKKoq3dF2t4
 jEhhmwiOp4HwyO6ocqNHX1srufa6BXytApqkLV+teaFrRqxlCwo4KzD4yaCRJPmW1JGmh8CbBgG
 jCrQAFYN/TiwvO26NPQ==
X-Proofpoint-GUID: OYopBVnFLl1m0FyGeYP5DuYZ6SgQWY8I
X-Authority-Analysis: v=2.4 cv=NbBzRGD4 c=1 sm=1 tr=0 ts=6aedfc46 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=2ZpRO2HCM4gvZax1RTEA:9
X-Proofpoint-ORIG-GUID: OYopBVnFLl1m0FyGeYP5DuYZ6SgQWY8I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX/xiKCF0L716+
 pbBr7tqu8T4CN0/x1EpO62/sD29h1qHk2WfsNUzCMiMVReJ7rGc/4C9LnGMUYa7w+15qENuENQB
 w6bfoeV6L5TgGk/wlKSHGVg6ykqFP+NO7j9kl8mfp34omI9qNx3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060064

Hi Conor,

Thanks for the review. v3 is out with the binding split:
https://lore.kernel.org/all/20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com/

On Thu, Nov 05, 2026 at 12:23:08AM +0000, Conor Dooley wrote:
> On Wed, Nov 04, 2026 at 03:21:42PM +0200, Nicolae-Daniel Deaconescu wrote:
>
> > +        adi,en1-always-on: false
> > +        adi,en2-always-on: false
> > +        adi,en3-always-on: false
> > +        adi,no-dco: false
> > +      required:
> > +        - vdd-supply
>
> Honestly, when the devices are this different, I don't think having a
> shared binding is worth it. Shared driver perhaps, but when so many
> properties don't apply the things should be kept in different binding
> files I think, this is just confusingly different IMO.

Done. The LTC2387 and ADAQ2387x parts have their own adi,ltc2387.yaml,
and adi,ad7625.yaml is unchanged. The driver stays shared.

Thanks,
Daniel
