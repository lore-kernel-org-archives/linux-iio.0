Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A54226CF6;
	Fri, 17 Jul 2026 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274648; cv=none; b=QKmIlUHPHqfvcGelzq/NH2lM5TEO/MKrL9vbUGcA0dwa1GPY9OR9zCiYhKI4gKRgnUDdM+DzWsxXerWbibSvtGmQLWdIiJi1tNKu/Hac2MuJUtIfWHE7UgVCH7IUKYd0YioiQhSNrKw7nzCHdwdltgqzrx16HzFUc8KPdJ867KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274648; c=relaxed/simple;
	bh=kgAGybEsaOjp+xPWEc4RGfD+Mh0ktDu3vgeJIJ8nl3Y=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:From:To:CC:
	 References:In-Reply-To; b=dvN7UJZPJx8nZsAFAzOr7RqNCGh7YkZDxrXlZbvBse0ZixNfGoFcRIIHwOeS5f6DhXMTnDpTfB3DQRUcsetsxC4aD3FkmPgugJ6jH/mAuEjugcpmbWo54nuIcqDyKUA416US+syDjewc0t3xvBvT4Ic671EEm0uq6f3NGEw5HL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sCLm3amu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sCLm3amu"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6bC9O1510284;
	Fri, 17 Jul 2026 03:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4eeob
	4l3AjjxjDVcQjSngGKQONDdDpbpdG/uhtKbDhU=; b=sCLm3amujfN0umhW0SEJb
	xoX+bn49G9ICm+UUkunQOATB9X0MrrhpeIJDeqdcT2lhhWMSobifBdKs1XPfK//i
	FtvRpaJVN89l/yLKHzU8Eg+mGgloijjilE8OHaS4aORakWAX7hxOX5aaXg0ye/Uv
	KljK71Tkkdlo6f8qXzeHx5qGBY+M3M6o6nc82C1mJC/bRHjIw5eD4uMODIcA0zow
	hMTNzmFIcgBkdHtgJlr6E2qJZET6EK9Lxnd+XKtFiYA2QuPTG2i9huDELNKXOawl
	KEQ/qTXs89LKs5/J/AVzKx5otC0KcqVHkneb4EHPGkAWTgHiabBZ4rmljeFdMVB9
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ffbpg1208-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 03:50:35 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66H7oY0x013146
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Jul 2026 03:50:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 17 Jul
 2026 03:50:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 17 Jul 2026 03:50:33 -0400
Received: from localhost ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66H7oGAb008716;
	Fri, 17 Jul 2026 03:50:19 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Jul 2026 15:50:08 +0800
Message-ID: <DK0OK76VQ1QV.3U5B7UFI0UB9F@analog>
Subject: Re: [PATCH 0/3] Add AD5710R/AD5711R DAC
From: Kim Seer Paller <kimseer.paller@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp
 Zabel <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
X-Mailer: aerc 0.8.2
References: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
 <alkbtNdOe__XP7ud@ashevche-desk.local>
In-Reply-To: <alkbtNdOe__XP7ud@ashevche-desk.local>
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=YqE/gYYX c=1 sm=1 tr=0 ts=6a59decb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=JQP-ejImbwYSbvTK7cUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cGro57Bd-sCOjAWCPAwWV1tXrC_DKXFO
X-Proofpoint-ORIG-GUID: cGro57Bd-sCOjAWCPAwWV1tXrC_DKXFO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA3NyBTYWx0ZWRfXzcJAB6YK9v7k
 QCY3bPhsZnOJDZ+djcOc4gYDf81Z4pYdhMsw0S3HhYF6JEGGtdFDTyFRd0059GIA5GfR7mv1RPn
 rBH/igpoYlivZkdPYiamZGXJbP0n7dN2idVH/2gYgJKIP7SWmoEZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA3NyBTYWx0ZWRfXxv/LOPEuRCPu
 8lNrtecymB22qEaM6HcG4Dz9IgrD7YQkMt6fjy/UBfLXSIYfD2nWTJs2Z8rtW9UWj9mMbUmetLt
 DKhRFa4nckm25y8lbncy47ik7bxFgH8Pq9LNwbkpYvJasSR1Ql8JYEHsTlqdit4/uzu963Lb/vc
 Mn3zIYqm6ONifxnsWZZQIclB+7xoEirvU+VoQgBa/SCtBVNKStlMYxJs8AVW7qDy5g7CTwXkIaC
 dFs8u9aJk6LnW4UoZ8icBkG88rp1K6DlkWLc5U0bT0n0HpOlDhQhFT2HdN6bBa0XpG67cInXojy
 dDGkxH4e8W5XSrzokEK5uDQZkNH75PNkKGBsxLm1G+O08GmwSgrW+0uOHSFlHIt2NC/V8cXwcz4
 8DadjirbR3ur6UjKyh2DJJUa14LAtgqCW4pIAapa/r7YPHdcoVTrko+G+vWvP5T+RlrAkWhMtK6
 XQ2zRdAkYqZ5rQXOA0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170077

On Fri Jul 17, 2026 at 1:58 AM PST, Andy Shevchenko wrote:
> On Thu, Jul 16, 2026 at 03:59:24PM +0800, Kim Seer Paller wrote:
> > The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
> > configurable current/voltage output DACs with an on-chip 2.5V reference=
.
> > Each channel can be independently configured as a voltage output
> > (0V to VREF or 0V to 2xVREF) or a current output (0mA to 50mA).
> >=20
> > This series adds support for these parts:
> >  - ABI documentation for the high_z powerdown mode and the current-outp=
ut
> >    powerdown attributes
> >  - device tree bindings for the AD5710R/AD5711R
> >  - basic IIO DAC driver, supporting per-channel voltage/current output
> >    selection, per-channel powerdown, software or hardware (LDAC) DAC
> >    updates, optional output range doubling, internal or external
> >    reference, and hardware reset (with a software-reset fallback).
>
> Why a brand new driver?

After looking more closely, the register map is the same as the AD3530R fam=
ily.
I originally kept it separate because of the functional differences: per ch=
annel
VDAC/IDAC selection described in device tree via adi,ch-func, selectable 12=
/16 bit
resolution, and current output path. But those can be fit the existing chip=
_info
abstraction. Given that, I'm leaning toward extending ad3530r to support th=
e
ad5710r/ad5711r and dropping the standalone driver. Does that direction wor=
k for
you? If so, I will do it in v2.

>
> > Datasheet:
> > https://www.analog.com/media/en/technical-documentation/data-sheets/ad5=
711r-ad5710r.pdf
>
> --=20
> With Best Regards,
> Andy Shevchenko

