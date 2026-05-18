Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D663D25CC;
	Mon, 18 May 2026 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093070; cv=none; b=CfUyyJIgToAmgnL46KCLa9z0KQGdTe1uiQr7+vdkDMVKFXroaP61Wws7kKR7hXVEgnvUC+kksCXPzO/y07ECI20TKCHFCJq6LVFSoGAluyOV8pYT6qAUQEUeROPXolhTLi6BIlptPfVLVPGzZfRnZ3odEW9CUpPxUJ+X7FHRZks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093070; c=relaxed/simple;
	bh=SADX0lXRLZUuqR2d9TjOO73ASDi7pwl6910I9ddvpGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pj3W4CFWbawslUHtfoAzLxUXiH8bDLApyZqF8yetGcbA9Q2zFT4xPveVUL/vWfZZ7QL4RWOh9Lf4tHJ1dfcNTgZr7FyEQsRkqEXwcMaCA5GFZKQtUJ8e6KBU/f7OVZ9m2L9SS5S12N69twNfHuRAUtNvMb6S1V/ngfPOHtjWrww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kmT3fm8p; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kmT3fm8p"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I3HRvS3484968;
	Mon, 18 May 2026 04:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SjTDl
	y7Ke79nVAIwwYOrilQj+622VxSl8QQaBPRum4Y=; b=kmT3fm8pd8NQHxNPUEfk/
	P6E5PP6yo1NQuV5W3tkLyhVac32xDXl9mCNDx1sEGQHczBAzsyCt0+BK4JVKd1O2
	qsro0JyEWfRbzofUNAAItOUeswOlW0jc1aEEwkAS4dr68oJNVPTa9eDi70f5NJfI
	IuqPI9z8+fnYaff/yxE3yakA/2fNFQI9oevwBA+1L/shmil///GdG561FdYqFA18
	sG0ojPo48oD15sR0DIkIz0uCO6I6tH4n9KgJmfMU1NIf2MyVr0nh/RwwjbNXDpIO
	bslIYaFcJKGETCPNnGeXq0tOpNQDPbhM28usRNhBnv919OVYBkDqQlJOfyy1iD96
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e6jdxnkux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 04:31:02 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64I8V1Av018202
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 May 2026 04:31:01 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 18 May 2026 04:31:01 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 18 May 2026 04:31:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 18 May 2026 04:31:01 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64I8UmYF018901;
	Mon, 18 May 2026 04:30:50 -0400
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
Subject: Re: [PATCH v2 2/7] iio: temperature: ltc2983: Use local device pointer consistently
Date: Mon, 18 May 2026 11:30:45 +0300
Message-ID: <20260518083046.84277-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516174600.65a65782@jic23-huawei>
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
X-Proofpoint-GUID: 6uNyZuTXS8y8heKNXRsDmVZ1qyTHxdgw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA4MSBTYWx0ZWRfX9afKOHPJuDjc
 Yf9ZC/8/OVXo/vpU0dRKy2NwrzlEjyZDZUatAKpSro2nD/jEflyN6tXJk4xqAiDHnc4BGNuZzzQ
 ihJU3jVrrJg9WIo2BoHuXzpyRoxY2ikx2Db/OX3qYvO9KEiEnvifYfMBL4Z/gkBPBFmMVnlnmYX
 zeEwDfawhhC//z0UIyztNCMbQ7SK6uF1c/pOKCFPLCFFWKeLXlR79UaovltGjldmDfeWapoTC6F
 Ae4aQqlBC4JvN0jgTLGELt/ZmgR104h4DerPXWFcDslVugLP4kSQirOuGoSGwF+HfSFrE4gVM4Y
 KcpVNdmVHkT/NxaSvnqyU4fQDn6c8vBEwjps+Paw1b6ibtR11TbeiPlw+Ozf7TlaAQnB1j1r/8k
 NCS6LHJSXv+qKEHPKsUcklkKAmrUlJ7na7wOg0X1bD9F4j+oQ2+iIdLwaWFfSFjNgQEbwy1iUvs
 RGsb1he3QKSDxofrlyg==
X-Proofpoint-ORIG-GUID: 6uNyZuTXS8y8heKNXRsDmVZ1qyTHxdgw
X-Authority-Analysis: v=2.4 cv=FfwHAp+6 c=1 sm=1 tr=0 ts=6a0ace46 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=6pLfpNmeyTFHXFBGyh4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180081

On Sat, 16 May 2026 17:46:00 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 14 May 2026 17:46:49 +0300
> Liviu Stan <liviu.stan@analog.com> wrote:
> 
> > Some functions define a local 'dev' pointer but still use bare
> > '&st->spi->dev' in some code paths, and some don't have it at all.
> > Replace all bare references with the local pointer for consistency.
> > 
> > Fixes: f110f3188e5639c81c457b2b831d40dfe3891bdb ("iio: temperature: Add support for LTC2983")
> > Signed-off-by: Liviu Stan <liviu.stan@analog.com>
> > ---
> > Changes in v2:
> > - New patch.
> > 
> >  drivers/iio/temperature/ltc2983.c | 81 ++++++++++++++++++-------------
> >  1 file changed, 46 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> > index a292274e6ff0..e74ea4f87ec9 100644
> > --- a/drivers/iio/temperature/ltc2983.c
> > +++ b/drivers/iio/temperature/ltc2983.c
> > @@ -351,6 +351,7 @@ static int __ltc2983_chan_assign_common(struct ltc2983_data *st,
> >  					const struct ltc2983_sensor *sensor,
> >  					u32 chan_val)
> >  {
> > +	struct device *dev = &st->spi->dev;
> 
> Why would you do that if no users in the function?  Bring it in when it is
> useful only. Note sashiko also spotted this..
> 
> Seems that you missed a dev_dbg() call that should have used it just after this.
> (that I didn't know but sashiko called it out ;)
> 
> 
> Again, a patch by patch build would almost certainly have thrown a warning on this.
> 

You're right, I missed the dev_dbg() change and placed it in patch 7 by
mistake. I apologize for this, will change in v3 and do patch by patch builds
from now.

Thanks,
Liviu
