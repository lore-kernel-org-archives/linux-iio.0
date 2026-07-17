Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF4632B118;
	Fri, 17 Jul 2026 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275160; cv=none; b=uLju3KvrmjPJph+R8rEGqKsYH7881EDL8IaZswTKt8K6gfx1jcyBGgwY4Mks8BrFWyKj7ayfKncJVMdh+K6Z8WRhVqEguDcNu5mni+c4iCZkuzAcLmKixWg0J8oNiEvsrhvwJ/vgAHn0qg2CQH3wj3rHU1rBwg1Yq0sGFKhcriU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275160; c=relaxed/simple;
	bh=Q+EVn7Icoe+5G9RJNubvOmg1kDD1KCJtqeY6TdN1HFM=;
	h=MIME-Version:Content-Type:Date:Message-ID:CC:Subject:From:To:
	 References:In-Reply-To; b=tSVHYetuEQQ3Mb15fUHt7M81TmFAdJdvFgQuFP+7+kGDrGyqjhzmYR2stbhaSoBEE6fV1QW/PLhnJQm64NX/5Nu3Pm2GWPiLewNjWfs6LfdbnP3oWu/JRZ0+mTYLJmXMV13JtEIk7R9AmyoESGdgtdLnaSLP1CPuTYQg2HAY1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RSPk+Ks5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RSPk+Ks5"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6b9ob1510276;
	Fri, 17 Jul 2026 03:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BSiUi
	wfP4JXN+h2q1J+srAmHmyCGKrFG27JR2xy0ykg=; b=RSPk+Ks5fvWRl732CZ4EK
	HzY9eH3/I4midUU4gb79gy395ESH4UpKWau6EbuMTPjoayf3wSS8ZTd+8mxtxBs7
	+rUjf+7wat3PnKkApytXZeeP8aZ7+KbNsJwctUpz82xDYUZLXjiUZpept2irUFTC
	QGRuo6UwraSCqVCnUMwgxNgnvh5Tjf7QlP4nSTAt43ockod05d2Z4dUwI7V6eRU7
	qAG+/JrASMWWyhCTvJHjYvDS2/5F+eXvhyigu7cpP/rrjcCJI6KU5+b7ZrlW3TEG
	WyprxjCQJT5KfYAOKxDDgfDDSqv6o7u9YTEXXInuaPdXga9rZaHcPdYH+nL0Flah
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ffbpg12pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 03:59:11 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66H7xAiY013697
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Jul 2026 03:59:10 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 17 Jul 2026 03:59:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 17 Jul 2026 03:59:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 17 Jul 2026 03:59:10 -0400
Received: from localhost ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66H7wotk009002;
	Fri, 17 Jul 2026 03:58:53 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Jul 2026 15:58:44 +0800
Message-ID: <DK0OQSHG4QF2.CCD4OGSWXFBH@analog>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: ABI: add DAC high_z powerdown mode and current
 output entries
From: Kim Seer Paller <kimseer.paller@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: aerc 0.8.2
References: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
 <20260716-iio-ad5710r-upstream-v1-1-e848a4bb701f@analog.com>
 <alkcBaHV0gHY37wR@ashevche-desk.local>
In-Reply-To: <alkcBaHV0gHY37wR@ashevche-desk.local>
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=YqE/gYYX c=1 sm=1 tr=0 ts=6a59e0cf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=tdLBGZj91k5LuzOrVg0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QOa9qxn6_HDcDbqv9B46cTz6fUGHEKoQ
X-Proofpoint-ORIG-GUID: QOa9qxn6_HDcDbqv9B46cTz6fUGHEKoQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA3OCBTYWx0ZWRfXx3P0aBL9iuas
 Zkd/TCs3IumXtAo8lGrVafLYp5gGHUnGKIFNq4852CPtrKPcLWMyLf63gMl5lkEpqK1UTFboFcn
 2eQpoFFTwVdYXpcRZU5KGZIPPuhkGOUdqhzHAqhNpvKPOdGF9m4x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA3OCBTYWx0ZWRfX9uid8WQoCHfr
 ckiv8spe8xEglophEQzeobRVEYj0sp9HbsuSJq8SjMhmYh5WAWY/qSKWDkKK4zow1B9Nv8KuEUU
 0grFgCa926t5oJalfjTbi3yzbFNOCj844Cr7tUf1XMauRvxPM2pWNF25KM83j/WYhycD7a0eaDC
 Y36SkTa3RPur4MQOkgOck47r4/9PO3qbA30W1otvwcYH8pJyMeml2iqj95ZcRSER2IkzCfh1Lo4
 j6mcOvfL1QSVfbfCxaO1is+T0+fB54rMiNOflzFapO5VEVHavAM0/NpGbB8zvrMZxHZOynkc5LY
 BQwrxToDYNsSbzi9+uTRvNA+NH7SXBws6sHQ2zJFR+ORvdKk49iM+UzR1lcZuWtBc0ULenNQTg1
 lRJtz5+EX8jUvmPo4Y80Ih/S40v/bAGS2o4Wu86R04o3lq5Sbm+e4AIo+p+zXQuP3YRG4m0AfmO
 DYlPAfiWnF0rA67hWrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170078

On Fri Jul 17, 2026 at 1:59 AM PST, Andy Shevchenko wrote:
> On Thu, Jul 16, 2026 at 03:59:25PM +0800, Kim Seer Paller wrote:
> > Add high_z powerdown mode for DACs with high impedance output in
> > current mode (IDAC) and 15kohm_to_gnd resistor to GND. Also add
> > out_currentY_powerdown_mode, out_currentY_powerdown_mode_available,
> > and out_currentY_powerdown entries to document current output
> > powerdown support.
>
> ...
>
> >  		125kohm_to_gnd: connected to ground via an 125kOhm resistor,
> >  		500kohm_to_gnd: connected to ground via a 500kOhm resistor,
> >  		640kohm_to_gnd: connected to ground via a 640kOhm resistor,
> > -		three_state: left floating.
> > +		three_state: left floating,
> > +		high_z: left floating.
>
> It may be less churn if just located before three_state, but hey, why?!
> three_state is a synonym to high_z. What's the impediment to use it?

You are right, thanks. I added high_z because that is the term the datashee=
t
uses for current output powerdown mode. Since three_state means the same=20
thing I will drop the high_z addition and use the existing three_state.

>
> --=20
> With Best Regards,
> Andy Shevchenko

