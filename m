Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338A53E3142;
	Mon, 18 May 2026 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093419; cv=none; b=qtXAFycyyXeZ73i+dYP11jo2FN9TMd8b3u0hNP2tTvot/2l7nXN/vFLTI9Kw/NjA6knelnCVzwPXHV7dt1RkNO6er2GWvU7vSeYn3LAVRgSuiK2IJjuEAAlLUSvpjeNVGrdvFXu5eKmCbhjqAoYBKcWPTuAAt6misi6OWdrBK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093419; c=relaxed/simple;
	bh=8HxM9NAXQ/OYR3BVxMP+CMYTTeNzmdUCAmcIbA50uoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PX7/CR0dcKFIXa24WA2beU9wPb/uU+BRkLY4n6LJAutzCvkP7Fqj77vISY7LCZvXUMxwSRwX/aIqwnk8RM1eUAyDlmS2sgjx5QHZZPIQDb39u9oiyEUfAkHpE4Uku030RPUGFwj7/flAhedNwtMOBMihHpuTn9x4FczwblTnLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=M9b+ibU0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="M9b+ibU0"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I55AWx1210052;
	Mon, 18 May 2026 04:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=h9DN2
	l5KO1TLvw6wivzKlvO9fm9A9uUBzzAgYbkuLwg=; b=M9b+ibU0DscWLZ+ryD7Lj
	47qmhDOLWvXFWxIsOfs0bAmRvSosKubawGY4f2HFQEm52+v8sw00b6tBX+VBvPF/
	yFuJ3nnUSNk2s2hiqh4wgo24SNahCyKrIXH2I+M02mTGHzwgS2KlHUMuI3q00xPi
	MctZaZozAEwrP/igqPlck9TgQeWl8gFHPzBe1oaFUPfRk5do3ve5mtD8wEI55gaR
	Jn+fysaJ0n09LnyOK4qGtURq0fOn3rMIq+mhrd+3ZwRvoqxLVeYBtPyad7cMpxxp
	c4eNDH7M/+9zskhjGZELziY7bgBKTQY6Lygcb0DlRWwKqcWuZPrm8hzSeVMlssk7
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e6ng0w5d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 04:36:54 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64I8arZV018673
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 May 2026 04:36:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 18 May
 2026 04:36:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 18 May 2026 04:36:53 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64I8ag9h019175;
	Mon, 18 May 2026 04:36:44 -0400
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
Subject: Re: [PATCH v2 3/7] iio: temperature: ltc2983: Fix inconsistent channel wording in messages
Date: Mon, 18 May 2026 11:36:38 +0300
Message-ID: <20260518083639.84374-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516174811.76580432@jic23-huawei>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA4MiBTYWx0ZWRfX32rRKf8Ns7Jp
 4pyDvL/TIV0uvNPrqH434nFHMiZjcjkZa12T3Y5wowVbun35owtRvXC7gwzOEuhz5ruet3M0nK5
 89Msaxf6qTYPkrmVIxH4zEny52C9nuVdISGozLxpe2OKDRKpOBFOPJKLjp/9Ji0xlgzEnEDPQNV
 NDnSkkVv5GJ2lRp4TSbaSdDteyDAt9YPU44cZxBxC+pxstqr1FcEu1B209vje8zb+ff+2TRXo+M
 A0dSoBtr+BUizf0xseN5DN3zGLBE3iHg7Hx8agj/DL29JE/vN8nWr70ZxVhr7ewJqrIs3ncl39B
 Shuqw6VrpIhC9A09njo1ucEJcL8foz4yqSLXH9P/AQ4K64rnJkclT0LHKKmLin4KXgXsE8Qeshi
 Y2Mf08RAwL59v4fojjWKNxOCi2JRap0wKOr6tZ2ayEIa8c39vpi/NFRPxs7u1eyobmwwlNlqL+g
 EdHqiMc5Z4SHwb9bBvw==
X-Proofpoint-GUID: 3E4ZHPQPQKQhnUej8ZgqHgJ8hukvigFO
X-Proofpoint-ORIG-GUID: 3E4ZHPQPQKQhnUej8ZgqHgJ8hukvigFO
X-Authority-Analysis: v=2.4 cv=QpFuG1yd c=1 sm=1 tr=0 ts=6a0acfa6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=bg2DPC6P4RyFBVl4yYQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180082

On Sat, 16 May 2026 17:48:11 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 14 May 2026 17:46:50 +0300
> Liviu Stan <liviu.stan@analog.com> wrote:
> 
> > Replace all occurrences of the abbreviated 'chann' and 'chan' with
> > 'channel' in error and debug messages throughout the driver.
> > 
> > Fixes: f110f3188e5639c81c457b2b831d40dfe3891bdb ("iio: temperature: Add support for LTC2983")
> > Fixes: a00838cae079b9b9b90969c2b7b031b1bfd9ab3a ("iio: temperature: ltc2983: convert to dev_err_probe()")
> 
> Wrong format and also what is it fixing?
> 
> I think you have misunderstood what that tag means.
> It almost always means we should backport. Which is not something we'll
> do for consistency in error messages.
> 

Sorry for this, I will change in v3.

> > Signed-off-by: Liviu Stan <liviu.stan@analog.com>
> 
> 
> Sashiko did call out a few more cases, but I think they are fine as they
> are using chan: %d to tell us which channel a message is referring to.
> However you should relax your 'all occurrences' to make it clear it's
> not 'all'.
> 

I can modify them too to "channel" so that they're all consistent.

Thanks,
Liviu
