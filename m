Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17153E717F;
	Mon, 18 May 2026 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092780; cv=none; b=pN+IzdD7flWhnAxvkUK3KjlTUjCNMaCm/iT4VPa8wKZ83+LKvLfRJ+YditvDieEq7PewzaLxScKHq/+V2lqu6qXqLtLx2TTbkMyozuIFHvEEoPcq8nC0nRZ71/ZCA50l3WDykrdYlzwWKfjLCGnBjuOsaBu4+GIyaRfiP/QV+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092780; c=relaxed/simple;
	bh=DRt8cmdzrE1cOlGqg62nka/r1fTVUnblw3kazYEmFLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9wwxgLyOYF687DiANGa7GBvvvh8cBsdXNJNoT2hV8ZAUeMl+kwL3ucKkV/gwmTjitV0lt05bJPH+E98w/30s233YuXjymVV/2JGcdhYgCxjFA2C3r9bFc+PFchuKK3HK+8TvT0OhrWgVPeuyQhj22RZfj0WYtmfA2NITXbuSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YSQHiLGl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YSQHiLGl"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I3rZAH3482905;
	Mon, 18 May 2026 04:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hjRkk
	kfpqHe9bhimglBKNRdmlbASZa9afVevm++yxvs=; b=YSQHiLGl3NbGdZzv5axCl
	KMsXaRqyRPcyB/sN2YAo8xYzh+mdYtvvlsc16Ha564tKiCSHyQUQc6ykmWdXp8tl
	6EfJXqduUfj7jvu/RDFYdGEuJnZ1IZagTX1g5vkVCTlY26hOo9lgvbixKjFRQy9I
	XT92DZnH9f9GkMQfU1IHajmzGgoH6VjaTWXxqfVtHMA7e2+dL1FsFN+Hvh3YMKpo
	Y/0OATYcN5wZqpnnfpwqCkA6aQ+6t+8lsTJ/eQvjb7cmublUM8JWT1jnBuuJukBP
	wpKTP2jCU3Py08g6AvA5jH0t96xORKSXbpCzNLWLfX7Fxszu6usSiPqY2uXXRCIK
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e6jdxnkg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 04:26:12 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64I8QBbg017783
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 May 2026 04:26:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 18 May
 2026 04:26:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 18 May 2026 04:26:11 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64I8Q0Cf018813;
	Mon, 18 May 2026 04:26:02 -0400
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
Subject: Re: [PATCH v2 1/7] iio: temperature: ltc2983: Fix macro parenthesization and rename
Date: Mon, 18 May 2026 11:25:55 +0300
Message-ID: <20260518082557.83813-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516174318.3d613a42@jic23-huawei>
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
X-Proofpoint-GUID: I95qTuYISs9dEJCmNob92ClU8Wxafqlc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA4MCBTYWx0ZWRfXwNOt2H8ID9iD
 RAFX7fUakQZE7ie8B7z8gkl6bjC1drbaW4JYGaBbBCOVm7Z9OSVuHpdc0nXdz1Ei2/ncqhArPWe
 P1nlcjdliFqK0N/6NlZh6c7N9IJHQlEgLpPNiioQrFDE4rRWHT/D8PjiXZqECJrkFCO/1L2vHFF
 ZGP/HChr9x38c6w/IBihUnn6ad4nGlXYudmol3PM3fFLAlgFtlFRvQ2dTNQi5M9zzRqIWd/bE0R
 uDKXOhk+VotuzsMMDi5BD0VmJ4A8L1sze+F86rp3iHJqmDKDF7COY1e427rAHnGX3JusHvNnv5Z
 qIT1lu/sMyObVWnWp09D9CmAnwX2TzAG4k3DhDR5wkLIqASzX48Wq8OU0WuooOuS26ceb01+9jx
 1h+oHTPi626pVqq/CP3e89wiPcG9Z/UjOL0UGdmaUFYuIUEJMvrWQ2qZUICwgRtW9EZywAuJhe4
 6z8W9a+3GwHbSABqI8g==
X-Proofpoint-ORIG-GUID: I95qTuYISs9dEJCmNob92ClU8Wxafqlc
X-Authority-Analysis: v=2.4 cv=FfwHAp+6 c=1 sm=1 tr=0 ts=6a0acd24 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=c92rfblmAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=j97isUV9xlIqGOTbdRcA:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180080

On Sat, 16 May 2026 17:43:18 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 14 May 2026 17:46:48 +0300
> Liviu Stan <liviu.stan@analog.com> wrote:
> 
> > Wrap the 'chan' parameter in LTC2983_CHAN_START_ADDR() and
> > LTC2983_CHAN_RES_ADDR() with parentheses to prevent potential
> > macro argument expansion issues. Also rename LTC2983_CHAN_START_ADDR
> > to LTC2983_CHAN_ASSIGN_ADDR and LTC2983_CHAN_RES_ADDR to
> > LTC2983_RESULT_ADDR, to better reflect the datasheet names and avoid
> > them being confused as related.
> > 
> > Fixes: f110f3188e5639c81c457b2b831d40dfe3891bdb ("iio: temperature: Add support for LTC2983")
> Firstly 12 chars of the hash is enough.
> Secondly why a fix at all?
> 
> Looks like a readability improvement but not something we'd backport.
> 

I understand, I will change in v3.

> Also as Sashiko points out you need to mention the additional parameter.
>  https://sashiko.dev/#/patchset/20260514144712.64374-1-liviu.stan%40analog.com
> 
> Also, build your series one patch at a time.  This looks like it won't build.
> Jonathan
> 

Yes, I mistakenly placed that change in patch 7. I apologize for that. I will
change in v3.

Thanks,
Liviu
