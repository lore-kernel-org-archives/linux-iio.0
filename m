Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9927F3D5656;
	Mon, 18 May 2026 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094257; cv=none; b=Fe0Pt+mmxAp7NQPn89HyJGH0ylXHV95JvxWYCIKt2e/MytlmQLLLhM/d0TuJ/mtmHLl348+7cJpZfONx+krTKJDKGLBl2ETE3+MKPcLxyw60s1Ag3s+DkayC5QZnlM7eZ17MKNxt28HQFW7n6lYvVbF3d5puhW0t7PjC5w6ljYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094257; c=relaxed/simple;
	bh=mI6iacXeg9KU5qE1kGk0QzkTwSG6aGaD4ZBxk+3fjRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEg/auTBx53uPRui7clbRvNa7bTYHGVBW0bCbBZrw7IPlTMvVxpDxOcqKrz0QpcxwNf2bsJl+HLCiaRWy+FscAmpf4BFzLXkiX4ry7DtuU9bpQISdx+6A6iKdjc/VZeAYO2hiJmN8kwRCqNRpXqwUvLGXDiH2e9o3ozq6fn0i3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GHIHl/dr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GHIHl/dr"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I4IOlb676003;
	Mon, 18 May 2026 04:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jERQ0
	tjKzPLGGgreuUHJq9GMxqFG7Wl3SuoiCuLLPB4=; b=GHIHl/drU0FO4jS9rMm8M
	Jqf+Ru8e1byWDPhyUhfylO+PaMZeZGWPEEra9DTueiD7K/W306RrFP9BVZUUlvt/
	mbOyilixS8B2+FMKRWqN1kUNnRZam/bJH0FLetnHv5ny9yGuvAUYaynTS03HF9Pa
	hdY1is3+xe2QzRGr/FZAQD6fUQKYPVJuqG0wCd0+W/mX6dxehg1+zFZBO0CyVZ6m
	qms6DbKEeq341nhvOP0ukQ8J1pWNV3tCAhkNg5gcyX8qhj9HQTA+atZ2BvwktTGU
	P3oAcYcoqnFfCd4/v6FtIR7Sd/LX/SUMOqzc0oCIeOM/2Yyh74ECUJ/iDIry+Gz5
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e79wdtyks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 04:50:52 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64I8opmX019746
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 May 2026 04:50:51 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 18 May 2026 04:50:51 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 18 May 2026 04:50:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 18 May 2026 04:50:51 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64I8oeuJ019590;
	Mon, 18 May 2026 04:50:42 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Liviu Stan <liviu.stan@analog.com>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iio: temperature: ltc2983: Use fwnode_property_present() for optional properties
Date: Mon, 18 May 2026 11:50:13 +0300
Message-ID: <20260518085014.84790-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516175314.3f28a4b7@jic23-huawei>
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
X-Proofpoint-ORIG-GUID: J6S5OugSc2dLv1ngx6Obw3N1YQI52iNT
X-Authority-Analysis: v=2.4 cv=HKbz0Itv c=1 sm=1 tr=0 ts=6a0ad2ec cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=c92rfblmAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=08UPCBKS9iAeYEssiKsA:9 a=zgiPjhLxNE0A:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: J6S5OugSc2dLv1ngx6Obw3N1YQI52iNT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA4NCBTYWx0ZWRfX1+xgMp3Ez2rg
 ZO/SU/zZ0c6q5rvMd6AtdBzLj+YcEHymUJuvJH2fN/mIsFvVTgICqoEk5Cq/Gtg9x2kEEoV58YR
 oJCveTEgHHkTCIPqcT/3mxISWrO5ud5JNqohWFTfNosS/WSfN8nbQ0dFr8YiOd3vO0ShfHY/f9+
 hwLsinGtqf0y3ROMLwnieHuccb664wFW+MFJZxrgfRvtK4rcm8O9r4KBYvf47NnUeTduolZ/1yZ
 3OzE+IaE+vza97oMBduN0oxYUUpSSndO4xgMfi2yz9XOBnc3IHrvNuwCt3npBJSM1DWJ21GBT20
 GwPdJ98F8wjz0FxQCXsY+A/AQJS/aFyS2qRvb8azDYPsyroUmJtbnDBTpm6m5IWcmpT4qfXB4i6
 ipaL0VnRFaABhBfupDSXkVXtllMseh7DcQebRIMCDBJhqTputH4Jny9BNZiVYoS69/4df756vib
 9ytfIcwjzFwMRoMRjTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180084

On Sat, 16 May 2026 17:53:14 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 14 May 2026 17:46:51 +0300
> Liviu Stan <liviu.stan@analog.com> wrote:
> 
> > Checking fwnode_property_read_u32() return value with if (!ret)
> > silently swallows meaningful error codes when a property is present
> > but malformed. Use fwnode_property_present() first so that absence
> > uses the default while a present but unreadable property returns
> > a proper error.
> > 
>  Fixes: f110f3188e5639c81c457b2b831d40dfe3891bdb ("iio: temperature: Add support for LTC2983")
> Same again. Not a fix. It's hardening against unexpected errors.
> 
> Also, sashiko calls out an issue with n_wires and default value of 0.
> The binding says default is 2.
> 
> 
> that was always present but is worth a fix potentially:
> https://sashiko.dev/#/patchset/20260514144712.64374-1-liviu.stan%40analog.com
> 

Understood. I'll drop the fixes tag and initialize n_wires to 2 to
correspond to the binding.

Thanks,
Liviu
