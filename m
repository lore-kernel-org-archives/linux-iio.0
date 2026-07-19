Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC31DC985
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784424889; cv=none; b=Alo9X9h6iZaPVjuRGAer86EU7l1LG3EARDFqLK4PoXFRBJA9dHqEADuidqZo8dH1ol4gG0gQ4U4e5HUN/8BvvkVTC6pQUxI9s00Kofbu3RI0teNSZ7K4t6MOVNOXHvWTf5fXDaDQlk5Yja6FOnzj0D77wxVuPxdrEp+QTBx+DKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784424889; c=relaxed/simple;
	bh=IuIbcXu/o2tL3GBFMD6CQrLT2R1109uRJSZnZMtHcwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmXA3N/MOmGFhoJpqZko9Portz0QCBQSW2A8kGKBV1RviBcHX2B0Mf/DFI4X9dtJz05IkTjHXi8XQpJHj9rESEwZGTCC0R7vQsLe2ndBT/0PDMrUm28qLc2DZ+De9m4bEAoBpiJc4UNcMa81/EUKkJhKQkRosTkarmLLWCXVOw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YpwcgqAf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bl3kjZEZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YpwcgqAf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bl3kjZEZ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IN3QVC1738954
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 01:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qJgbFeKB+r624rP0ry/B3RltSEhCVlIORufmQ5zSrNs=; b=YpwcgqAfw/tspHq8
	dDgDG892L5kGs/hw5z3cWQIpBc1FS25bQHKxTi4Zma/2WYK6dHjK9godAJigcbbs
	zoPUZL1ITlwDrVfo4L8XzFJmh5YxanpsxVjRm5Ld6FOEemzHVwdKrQY+usRyiRMX
	fUV67RUVcIZx5JABO6B4qtDF7UGX+/wVkomRObAqN9gcbhugMvEnNTw9BjvKGYZ9
	NX8OdiHtcrXaLYRf+6Q4AljEE1qdZOmtUUybO0yGgCZAudY37m/XmNZtwVMS5LYz
	dlgLQM6AISpkh+aKjQNX+p+dSueq7dtLk6Wlz9cxhBdJNMNoqd+a7igCmcOUcXig
	nNpYSQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2s7su6f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 01:34:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2caf4173b1cso111600355ad.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 18:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784424887; x=1785029687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qJgbFeKB+r624rP0ry/B3RltSEhCVlIORufmQ5zSrNs=;
        b=Bl3kjZEZy1UlUeyNO2pyly0YJzbDLeJZZldkc1/Itj9Ie83WrmrK7zbWd7hTrdrvrB
         xZRCftf6HqYKC79yvZEQXDnnR2e8aTiVLyPNiMon6/OycgmgDR7IpjjT4HGrGRRJJc/g
         yLK7davRGpZDXwsicptyMZOEgyuCKTeHd+/5Jw2iJYwvZraBrexBrQYMvLWfibBEtUyk
         yNbHAIwMbr8l7X5H8JxuEcIikk+bqf6OCrhk/JdBACAt2G7Pv9+OXHl/xAP64fxNW4AK
         1gI/yzslvtwSjwhfMvzY9hFdDN35g7Bb2hgvg7iEdEfMLYdwreapyPt1Yd+2DeG6+pdv
         yUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784424887; x=1785029687;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qJgbFeKB+r624rP0ry/B3RltSEhCVlIORufmQ5zSrNs=;
        b=Vt9jC7Iv5j/BKbfqDx6wOyc+A8HIFEiSM6Qs+M/T7vFGSWWHFZz/+N0v6jscVW3Ib3
         sZItYU60+aSHk2DAdY0KdRQRqSoeTDDVRvYGvb/TRBMynnN/xCibHWAnDzBPDbNrI0l8
         Dcc3IY2kBkIaQO5oYC+/N7DFdPrvdOz5GY0z9QtuKIcd3bt/SDp2gDj7+xbrwhdVmQM2
         xG0jW1DGUcj6yIRQI5ZzPGpa1UjsEyBujWSo63k0NB6in16cyziyB5Um3LkmxnnIsRdT
         El+qp/yJw+DHXssNMFxW+p1IpBYL6uGMIyfcZJ1D/yD2x9srwRWtkcBoS5rIFdBlNgZB
         S5wg==
X-Forwarded-Encrypted: i=1; AHgh+Rp+rm/U3CALcBZiH8J/O/KTj8ggQkDrQ/2EkvDPDC3C3HYMC+bRkImwzbi5J/T8LA/3SG/UX9txhOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQtWgzT7JV+rr0WerKG2hDAscSpNaRlHG8ABgac1BwRHhcooXO
	4Re3gugN8NXM42/NWuQaWTa75JI1QT2LAKOFiQHf1B+/atNe56mOzviOoZcVwU2fj2C5GkpWUwi
	vOFB7nbGHQ0geUFka9NqoqKb/wMkRSKpoJDE1XbHfyJNXvyg/AwiC1NVkcf076XI=
X-Gm-Gg: AfdE7ckrueBDJ9mFHnMkSuBl+1FI38QY09oEGdwtn0Ybgdp3zpjicXxB/7PIk8grafZ
	8U1Phk5yBdaQXyNsk8kgzPNiif1AdOdLCFAXldShgkncmEZD7l3qDv6gzMEee42c0ejAnfv9l9j
	DR8sbDxwIRbMaA/wzJHIVbzfEsRgGNrt9e40kMpkAAUH3aSXTSV9uBOtKBAgsAZcBIp5MztO0RZ
	C6RZtFGJcKL9/d9Rg6Plcg0cjscah+83RNLQRttaoQthF5l2q8UXPx+5PSDPxHyCfYiQKMjKacH
	/Px5e6peakOYOt6fM18mZGWA5ahWkqRZ59Qe27fUzRw22MNODppkXN0PPJroQhe48lX8bAwrOxK
	hTyn5SOoQrF/mDMwI
X-Received: by 2002:a17:903:24f:b0:2c9:e9c4:82c1 with SMTP id d9443c01a7336-2cf3494af9fmr95376345ad.26.1784424886868;
        Sat, 18 Jul 2026 18:34:46 -0700 (PDT)
X-Received: by 2002:a17:903:24f:b0:2c9:e9c4:82c1 with SMTP id d9443c01a7336-2cf3494af9fmr95376065ad.26.1784424886420;
        Sat, 18 Jul 2026 18:34:46 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346da144sm33789245ad.38.2026.07.18.18.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 18:34:45 -0700 (PDT)
Date: Sun, 19 Jul 2026 02:34:39 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Esben Haabendal <esben@geanix.com>, Lars-Peter Clausen
 <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Kepplinger
 <martink@posteo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        David Lechner
 <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Martin Kepplinger
 <martin.kepplinger@theobroma-systems.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] io: accel: mma8452: Allow open drain interrupt
 pin configuration
Message-ID: <20260719023349.063bba25@jic23-huawei>
In-Reply-To: <aleRUWg9MZWgXMVs@ashevche-desk.local>
References: <20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com>
	<aleRUWg9MZWgXMVs@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDAxMyBTYWx0ZWRfXwzewf8ch1bW/
 dixjppU0ZNSwah12wOkigbsl5UhCCx7AoBQRjvs8X269WlPa9Ic8VrUbnEkKAxoWQO2qJG6vQDi
 aLZM2r85KPQv9bZv0pOgwJde2ZZ2m7L9oCF6gljWTicNhRahLVkFb2Mb1swmENhGqrv8NleBXdO
 8m8FecJlzHLLW/WUsnD0vK6wa/mA5E4lmxxkPs/bK1c6AAMEry7tMycs+CEhVrdQaXdKFnXzJ9L
 9nWw4HPxiMc+Lngc8xLLIYwrMC3q12NNS6qUR3oxsgle7JQLeTeyWNzICGXsNGCyGevYtuXzmSE
 jKOZZE0ItSjqQQAd9423reOUPRCcnWBX049hdR2iJfFhFTo2zb8V8F/8JuBWvGvg1RT3GBwehYF
 8EJbyCLXnezondtgN/+IVir64IE5tkYTE7ua+YHPCM/NBaCCUU1RJN6pfjYxCF9qIj+ZZoWJMra
 QU96+lXHwJIl4XqptZw==
X-Authority-Analysis: v=2.4 cv=eKsjSnp1 c=1 sm=1 tr=0 ts=6a5c29b7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=QyXUC8HyAAAA:8 a=RhGOBlXrcc6CtF-tMBAA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: _k2tuJck9IDUyVmekxSY9dG10a3TM5fG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDAxMyBTYWx0ZWRfX7mEoBZgwC0Gl
 Iy8pS1jBnUYU7oWy1EW+sZ5iNQSny36MEz2ChJciNixIdlmF/ucGb7gpkhEW+q2OKkOfkkYvdhF
 ixaDqjsNV4ZNawgzhqFS6kxM/cxRMKw=
X-Proofpoint-GUID: _k2tuJck9IDUyVmekxSY9dG10a3TM5fG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190013

On Wed, 15 Jul 2026 16:55:29 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 15, 2026 at 02:33:26PM +0200, Esben Haabendal wrote:
> > Extend the mma8452 driver with support for configuration of the
> > interrupt line in open-drain mode, which is needed for hardware designs
> > where the interrupt line is shared with other chips.
> > 
> > Adding drive-open-drain property to mma8452 device-tree node for such
> > designs to enable switching pin configuration to open-drain mode.  
> 
> NAK.
> 
> Please, do not send a new version until everything is settled down in the
> previous round. Let's continue discussion in v1.
> 

Even if the conversation there hadn't been ongoing, please slow down
with new versions.  At least 24 hours, preferably a week between versions
of anything non trivial (and this turned out not to be!)

Jonathan
