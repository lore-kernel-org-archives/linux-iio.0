Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981505;
	b=4DduwX71FBY7OZ9Q5qG6PNcthhQA0mdrcTbXhlHI5xB3rEFcn0pQZ149X5aunDPPGk+i
	 3zv0uKm1JGtovt1K9LHPk9nI97PC3ubO3rcNHB69xUrw++U//rAceEhQjiBCd0pYMuNws
	 qMdRl0NfFMLqaFHNWwy7fXJ6Q5AMuN5rlBMFQv9xWG5/Jb072Z/MFcZ3y+ISqy4ebL/h5
	 Fh6ky1UtJTY+zAB4Fzg2EdgNqDlq/YoYy7dgtuu6TnSjpxEHXJAxtin9jBOCRJfEq8dh0
	 i90uUPSV9U8b8uHAnFSeCgnsESPN+wQEPTwidb7Ld+uqw6WwHwCZI76qquqjVnZOgsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981505;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UjnPJ8bDNsOwAQwufwU9CiT4W7pC4/1PPz8c2x/Ss0U=;
	b=XyF16t/CbDSUJcI/SoKyxldhl6Mk+4+65kvz4AFCkMI3j3fWyWkMhpmuwJJ/0BPJIEi/
	 uAO3sH1pXh+wyJxQqaHy9Cfe59WICs2ftOUHwnssrWVlDJWWlWfp6iP8Uzt9u21Gf9GCF
	 RQJL45KFlN+uRiJx513XlIHgU1IehpfHFQdCtGxYwQX9WkpAMFqQwx4zYYIx17oZaMybP
	 6N59ikHmPeU247gqjZgY1s5xNK4LAxgNF48iucljdUTTd5Pdp1IayNRYxmQlf6q7XzMKs
	 5JNh8OCTiymHjJvBO3OEE1TJrjK8EPWrrZ3HWoVuDW8CmMiY/vVihUIS4pAOK/iFPjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Bptrt4wx;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=PlCyoJYo;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1BD606A9A0;
	Fri,  6 Nov 2026 16:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D1BD606A9A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Bptrt4wx;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=PlCyoJYo
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4CtR4107568;
	Fri, 6 Nov 2026 11:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=UjnPJ8bDNsOwAQwufwU9CiT4W7pC4/1PPz8c2x/Ss0U=; b=Bptrt4w
	xfHvyEEhndNC9DeiZwsVSJVpvTQh3kFTsNy93WSrMXmvEukydJ+HyTr7Toke7JDu
	F1ncEkQqErTkiqBOE/W6VmQ7rzcb+YQpap/goLHjKlMa3npHFZnffUKbIX8VjPJp
	PNn0MUQadItKeaShWFmok98xD2hpqa0zQZRVYPjWRIATTZJV9rzNlWZjdsuH+Zl1
	eCm6xgNBCJwZCfBctWNu9SA+rL/9+QDPspjb3Wh2GM8txlQeHZohyTijaYGOO3b3
	cCCN0j1eoqSrOTwF+Mfz1wDwKywqx9uakWwxVPmELSk+HIr8I0yRna3e6qYLHPVM
	RR4D8MVH001Wt/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UjnPJ
	8bDNsOwAQwufwU9CiT4W7pC4/1PPz8c2x/Ss0U=; b=PlCyoJYo+PIe4ZKtOCtB9
	x5VrZc1ywK7URmf6nKY6iVxvtZ7fciv2MLASFMbuyvqFB03YNg4E4gZ6dVKzNWFF
	QVdK1LtKaPYvhhY3m8LR8tQTbdfXiH4ojamwYvh/wBAzopXQ/aCMrwQEEW7RNyXL
	PE8yMESjIVyVcAaWCrw3763Y+r3iJignzCeFzbEXYBimAZZpb2Qxyu2a2zEVwwMz
	BCzCGRJGta+liOyKzaHcP8I9SjZkBd7xQaZif/XI8cXg0OWc6Jai3rfXGEgtEaRE
	Fvfj4dk3WuGzjbPAFn0WogO4wOItvfNCcphvDQtHNIm1TZYuss4R6o+m0q6Q0lqJ
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3pyw4s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:11:37 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A6GBaW4052757
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 11:11:36 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Nov
 2026 11:11:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Nov 2026 11:11:36 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A6GBPOU016481;
	Fri, 6 Nov 2026 11:11:27 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Trevor Gamblin
	<tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        Sergiu Cuciurean
	<sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] pwm: core: add pwm_get_waveform_step_might_sleep()
Date: Fri, 6 Nov 2026 18:11:16 +0200
Message-ID: <20261106161116.879558-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <auuMw8tKvGynTKsr@ashevche-desk.local>
References: <auuMw8tKvGynTKsr@ashevche-desk.local>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX3nBc25vN8RWZ
 uf0+/oAnVNMTeroM6ruya3tQoDEvj+t4jKNzNxjiS3BSt5MYLNYdBPdS6RL50mvCTyLYtWzxPmR
 nPDakcDyLyJ5k7fQheAasx8L0GlNLos8jLGdtMVssysk3fzkPlr8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX0TCXY+1G2wje
 jWbIxMLyM/b7MBQrUIQYc8rK3LSLXj9E8e6SA6QjNR4ODHx8dgV/xNVqk+sgeE55vnPOe/3yk3s
 BU99Zdzswat5gKgD9JCi+qt9FL6CKFjvZI88r5NqNn0PX57Z+iwsA+uhUBKWOLJa58x/tZr0FB5
 rY4rzk6LL4By+ycO7TjDuEXZVWQrmdgiOz8evXVV9jHruUhH+D73oqw5PClSzEorwSDce9vuVMb
 H+BnXWi2W7NExJuUfzi89WrbjzPWr/j5+i3CeHkL/pxh2ZQ2BaRZL8tiUf2Y+//I71rroChqF7v
 KdUrqvk/oMVqABfkHjoSwLflY0BctYy9WO9mna9p6OBNSkmiKIR25QFwRwEEPtTTJHIxJbkwexw
 W8H6Clx7bllff8t/R7m/3J3RD0y5oMiF3eLKhKEdThwZr283Iiq54wXpgeW1dsoXXhXFcUBNvL1
 28lmP+fHXaRc0oSVHAA==
X-Proofpoint-ORIG-GUID: BSJw8D-Rk8M9iXodQavExEV7ZeYhE7iM
X-Authority-Analysis: v=2.4 cv=TYcDJhQh c=1 sm=1 tr=0 ts=6aedfc39 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=K2YgyB2tnkTKoHeqKNMA:9
X-Proofpoint-GUID: BSJw8D-Rk8M9iXodQavExEV7ZeYhE7iM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060064

Hi Andy,

Thanks for the review. v3 addresses these:
https://lore.kernel.org/all/20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com/

On Wed, Nov 04, 2026 at 09:51:31PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 04, 2026 at 03:21:39PM +0200, Nicolae-Daniel Deaconescu wrote:
>
> > + *
> > + * Returns: 0 on success, -EOPNOTSUPP if the provider doesn't report it or a
> > + * negative errno
> > + * Context: May sleep.
>
> This is incorrect. The Returns section has to be the last one in the
> kernel-doc. It's documented.

Done. Context: is now before Return:, and Return: is last.

>
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!step->clk_rate_hz || !step->clk_cycles_per_step ||
>
> The second check is unneeded, the third one covers it.

Removed the clk_cycles_per_step check, the rate check covers it.

>
> > + * nanosecond resolution of struct pwm_waveform.
> > + */
> > +struct pwm_waveform_step {
> > +	unsigned long clk_rate_hz;
>
> _Hz ?

Renamed it to clk_rate_Hz.

Thanks,
Daniel
