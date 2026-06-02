Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65B424BBEB;
	Tue,  2 Jun 2026 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382381; cv=none; b=fC76x46Gg9nS89o6m3xUllBS1DSBnusOAOusE5DQWIaG+D2JOthQ1clkemWAmiptP0hoxI9KvEP7hlpNePgnE6pPFtiNSLNaLlPWDfAk8LL9VvswvumQDCU/1CElbXckVJugrDOUJ53/DvyJMKYsPjABrLDbsjRgwg0uiGFX/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382381; c=relaxed/simple;
	bh=Ld8iduNde6GKNr22MJMInfKqIYti0iqNR4hSxFhoSxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYgDfvmITKZs8S2tke9rF2VnDwzbLOR0W96moLKdXBR42+rC3IzNre7FWy0+cuS6Znb3VvZ9EykFQeQPJH7l+qExDYo/7tgqvruuR+5hu096nZtJCzfeKW+1IFv3yGNZQwAQ/FN3Hkkd+K8abbVxpvOv06PiBXOxrDKILiZvHqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dbINqjWy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dbINqjWy"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6520v0EB1251258;
	Tue, 2 Jun 2026 02:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ucaNj
	VD33cEHVZpUmvebqvzYKsXoifNX7q+4EkOy8/U=; b=dbINqjWyQlQIGOg1KKjix
	zP0mApm5FocDcAsy4/9hcWrRhiHPHENIHzWNIUzik3YkA4g/2ojQsUzsjC8i5VlH
	rUiDKwk/OP9LqNQUJdtx8bZg3pLNcfstU+BEfi7BSWAdYYWzOZ1pI+HuRSYM1Bln
	l2sh8RvEhB+YK4q46MvVT/Wx4kf6nQMRo4GbrmrL35nsUrXbEGarf/ZEJ6R9lrVA
	cOWTPCdt0WgK58YVeEGytNVmZ8RyJGMWdhv46cHW/o1feA/kQ1lCJqyNciLy2EIQ
	H2t5SSS/mzQaU94jVVyc8wJ503aoYDKZyKFlUw4YQVkmma59BLP7OuSaV7+NElfL
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ege7dqv8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 02:39:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6526dNuj044271
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jun 2026 02:39:23 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 2 Jun 2026 02:39:23 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 2 Jun 2026 02:39:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 2 Jun 2026 02:39:23 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com ([10.32.226.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6526d5Hk009442;
	Tue, 2 Jun 2026 02:39:07 -0400
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
Subject: Re: [PATCH v4 9/9] iio: temperature: ltc2983: Add support for ADT7604
Date: Tue, 2 Jun 2026 09:38:39 +0300
Message-ID: <20260602063841.404648-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527174931.55eaaa69@jic23-huawei>
References:
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=aITAb79m c=1 sm=1 tr=0 ts=6a1e7a9d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=c92rfblmAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=2KgOL9551wsClh4SOmoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: vxfVRPV3BNyV5eaemPQElflbP1MCFgjR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2MCBTYWx0ZWRfX2/Yaah7OUuJ+
 YlcuAUz7rsaWzvtvx5CGa2xgEDSmqE8CQezrmNw2VDQ8tXXSh6y7TOLguNtwpiMlbVGJnQq2v4E
 4YPUyDUptKXKJoG0DQLDLIHwi4HSU5iFYtO7KrwdZNks3SLfZ3xE+lQVOVmkvuE8HnmDQLW0+M9
 hgA8VIEcoBP+qyDEe3Xg7gGWuMgWPL+GqZMjXQfVk8FdzIALnRqawbXuzQVifVQMVZAAfokTAVb
 KEb/c7c9EWkPT1pbwvJOp9z7pAfTXOYLR04aceZnHQcE0v6xH6jsN3JkZc0BimcOdFbGtI0zm71
 YTVeWI1bnnj/USMOKNhuzVr3G9F/nWnay58dsZLEFKjpZhrKy3yU9regUFBqSxP4dlv0Zw97DmI
 yBIR5ByB6YASlCUQUzHiWBgs7HzMdy5UYuc2Iij2jebG+gviZkmYJFcnjz2Ylpq5jC8WyRWLrFL
 wxqoQrs6VobliKYV51g==
X-Proofpoint-GUID: vxfVRPV3BNyV5eaemPQElflbP1MCFgjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020060

On Wed, 27 May 2026 17:49:31 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 26 May 2026 11:47:01 +0300
> Liviu Stan <liviu.stan@analog.com> wrote:
> 
> > On Mon, 25 May 2026 19:06:14 +0000 sashiko-bot@kernel.org wrote:
> > 
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > 
> > > Pre-existing issues:
> > > - [High] Integer truncation of `num_channels` leads to an out-of-bounds write on the heap when parsing device tree children.
> > > --
> > > 
> > > commit 482bc8c51e04185002511817885173bd265542d8
> > > Author: Liviu Stan <liviu.stan@analog.com>
> > > 
> > > iio: temperature: ltc2983: Add support for ADT7604
> > > 
> > > This commit adds support for the ADT7604 sensor, repurposing custom RTD
> > > and thermistor sensor types as copper trace and leak detectors. It
> > > introduces new structs, parser functions, and hardware register mappings
> > > to handle these new types.
> > >   
> > > > diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> > > > index 130ab7fddc2fe..fc65d8352d120 100644
> > > > --- a/drivers/iio/temperature/ltc2983.c
> > > > +++ b/drivers/iio/temperature/ltc2983.c  
> > > 
> > > [ ... ]
> > >   
> > > > @@ -1348,7 +1672,7 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
> > > >  	if (!st->sensors)
> > > >  		return -ENOMEM;
> > > >  
> > > > -	st->iio_channels = st->num_channels;
> > > > +	st->iio_channels = 0;  
> > > 
> > > [Severity: High]
> > > This is a pre-existing issue, but does st->num_channels silently truncate
> > > the number of child nodes since it is defined as a u8?
> > > 
> > > If a device tree is provided with 256 or more child nodes (e.g., 257
> > > nodes via DT overlays), device_get_child_node_count() returns 257, but
> > > st->num_channels truncates this to 1. This causes devm_kcalloc() to
> > > allocate only a 1-element array for st->sensors.
> > > 
> > > The device_for_each_child_node_scoped() loop directly following this will
> > > then iterate over the children and write into st->sensors[chan], resulting
> > > in out-of-bounds writes on the heap. Could num_channels be changed to an
> > > unsigned int to prevent this memory corruption?
> > >   
> > > >  	device_for_each_child_node_scoped(dev, child) {
> > > >  		struct ltc2983_sensor sensor;  
> > > 
> > > -- 
> > > Sashiko AI review · https://sashiko.dev/#/patchset/20260525164013.118614-1-liviu.stan@analog.com?part=9
> > >   
> > 
> > The hardware has 20 channels maximum, so num_channels as u8 can never overflow in practice.
> > 
> All looks good to me so applied to the testing branch of iio.git.
> 
> Thanks,
> 
> Jonathan

Thank you!

Liviu
