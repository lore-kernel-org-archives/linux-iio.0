Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E043CF02B;
	Mon, 18 May 2026 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094413; cv=none; b=A0rItSokr7adgMiecCtgv7dV+H7zDknCfK92o2SqS85oj9AzIT6bJIbRU0rw0eeoylNsUfW4YiKjhxreefxo2Ew8O6O0eGpVOfFTEP6/fCOEJ/pEYlw4GPZxPCvW1XIItFqQ01Atkru4eBdxdvg4IzYL1Ls/4bbrCuAOa7KAS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094413; c=relaxed/simple;
	bh=id+xDE+D3/7NW/Cs48q0pe98aShIUv0qm1aHapMiId0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJ/dpQY0TBDFTR9dythuZtmf9/92ZE6W+QUAA5Zr1GHpheHZIMkoZfeoMRhZrzBE2edTljye9uRPWg76TOQ5hqivitMcu4wJCGDIXP4L+SrZSzAsNFE15cNzDZzrZs7vTalxI5G6jgvnPYH2INzwMj7p7K2qeWWON5rS0dyjmcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sK7nAf0u; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sK7nAf0u"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I4D0FT1211791;
	Mon, 18 May 2026 04:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Yf9QL
	0yP7JFlhwIjrYSHf2DQt+VuCG9/+CyqyVHNT9A=; b=sK7nAf0uXo5L/AcYDYq7B
	CMmKFQgkYysGbMbFI7GJeSZFi3zuX27psvCWZ/2xoJp/r2JGDfJxbUw6I0nk29p4
	H3B1OT5NVm6Uocu21bEXa6FUnM6nA8T2M0r4AjFsNhmIg8GxjBIaK/6KCnGpTLx4
	CSlXL5OFtAgEWSvhXDe06/tBpZtSvy52vLvJ0WR70oeKjxAtypgyDzHE+ok6nKiy
	jsmjQqSkuOfpvw9GEXHaknRZ6Qh7En2bMh34lMvWkcPtAkLXzbZZPmFlgXSSpSNu
	PyQPYrL3hF499qZotg7PCP6sHdzCGZxibkQuwPLaQ4eu1j9HagEDQZ349FcGlRoq
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e6ng0w6vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 04:53:28 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64I8rRHN020065
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 May 2026 04:53:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 18 May
 2026 04:53:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 18 May 2026 04:53:27 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64I8rG3S019783;
	Mon, 18 May 2026 04:53:18 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Liviu Stan <liviu.stan@analog.com>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] iio: core: Add IIO_COVERAGE_PERCENT channel type
Date: Mon, 18 May 2026 11:53:11 +0300
Message-ID: <20260518085314.84905-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516175814.5748124d@jic23-huawei>
References:
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA4NCBTYWx0ZWRfXzqMl0rBzRXCd
 kuQo55VFvzuaWo1qd6d9Q8xaqKQU6a3FKpRN2Q8mHgYmJZ9NB+mG4gd4iF0UaW6k5XLxxqCevg3
 VRj8WNMvFzb0QzA4fUQz0sbbYPnEBWy6psagLxOihJOxLXRHz8IseTC6aoQIvLLCFY5T8ubE1gC
 hM2ceVqxKxH8PmFRwMosLPEP37T2BlcMUAHxsw8mPPynXPsv9TCF8NolUi1UfNFg9HSmK1olY/t
 rN/veDdBQT3NtF9el+KiFYy5BZ6ep0x6GytyP7HMpgpZlqsOEhKuwBQSRzVfp1I/3z7+q4rkd3M
 VogF0KOIuB9VCvT3igfgBGJMGDGF9rNx9j58bFlktfoV2GBjDhdO8YRdOdtwIeO8lkc1OmzC73y
 L2koK55IAiIglwGYu0I3aFUDM8fPR9lacuJHoj58QOElY/zQT2fs5R+s7aii2jzbziXm9TVEtRZ
 lZQ6dJJFFOIgFqNY7xw==
X-Proofpoint-GUID: OKt75vce8X33hiZGjjOtU8TMcnPHhm6i
X-Proofpoint-ORIG-GUID: OKt75vce8X33hiZGjjOtU8TMcnPHhm6i
X-Authority-Analysis: v=2.4 cv=QpFuG1yd c=1 sm=1 tr=0 ts=6a0ad388 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=QRDiui1dR8SsSWLG3-4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180084

On Sat, 16 May 2026 17:58:14 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 14 May 2026 17:46:52 +0300
> Liviu Stan <liviu.stan@analog.com> wrote:
> 
> > Add a new channel type for sensors that report fractional coverage as
> > a percentage. The first user is the ADT7604 leak detector, where the
> > value represents the portion of the sensing element that is wetted.
> > 
> > Signed-off-by: Liviu Stan <liviu.stan@analog.com>
> Few things from sashiko that you should address.
> 
> One I want to talk more about...
> 
> > ---
> > Changes in v2:
> > - New patch.
> > 
> >  Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
> >  drivers/iio/industrialio-core.c         |  1 +
> >  include/uapi/linux/iio/types.h          |  1 +
> >  tools/iio/iio_event_monitor.c           |  1 +
> >  4 files changed, 13 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 925a33fd309a..0570e8b8f5e5 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1980,6 +1980,16 @@ Description:
> >  		Raw (unscaled no offset etc.) resistance reading.
> >  		Units after application of scale and offset are ohms.
> >  
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_coveragepercentX_raw
> 
> The bot raises a valid concern about having the unit in the _raw attribute name.
> If there is a scale (which incidentally probably needs adding to the ABI - as
> _raw on its own is a bit meaningless) then it only becomes percent after
> that is applied.
> 
> Perhaps
> in_coverageX_raw is the way to go?
> 

This makes sense, I will modify in v3.

Thanks,
Liviu
