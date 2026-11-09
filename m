Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233263;
	b=aRaSpCfYilgULc5flyqPDlLEjqs5MLx2FbR1zpwvH5BJdqX0tM8YXEF4p/CAGNBwEV4t
	 uLnuoRG3AKSBN8qheL3+mdnV4PN3Q2Bth9lZrWuL+cL22C1Ekb7ikxkBdpOSwD7xpfZl0
	 ZQeGQnsFH7OJpaFTfWL5tWyiSu+BewtADmm5dZPaQv+SmFE2IFOTkELxK/jdcC1xRWQYt
	 OqKYL6i4bvrLHJj6SHmEjl4/DUqp+5LSEr+jlg/AHRJPZ4UZYoPr0qP9BUeb9gEQaX9tA
	 zCfMr3N+VV9sXNVXzt8qlQY2y50QMrE+uXRAIvOESKjL1JLe0Fz4nQqiwwOnnQ/B3wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233263;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BUQXqw+R/YtPFmmZFk5QXBn6Sn8YsKfXrHWHkWR5adQ=;
	b=GWf6yPdXZT7OqTFOibLaHJU1je45bS7kBw/Uj3iOQvScAhiZLg56jF7edR/qFdqVj0Oo
	 yPChqAz7SzzcSSyi9ccUn/3ZY015FiCLRYfC86RYBd/gIlc3EdmRYtBN+/3Bb5MEyygJK
	 C2PR22rD7yWQGETJ4QYm3MNfJduzqur2Xpzv092H5uXeHPsh6bROEcVOSCeuofX58Fv2S
	 mRnR2PoYtGvjyA41ZV6fhp+VTQy5vChvGr85rK7bnvAO0VCS5NVstzwPpDBMepaXJlbKX
	 yJXLWcU0Kpwaq7fvK2envrMlQdlH+yFY/acegysa+lgBveTtoYsC3i3YPRAA4JsJ2ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="mAM/xgtM";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=LOW9zmCr;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F8A606A31C;
	Mon,  9 Nov 2026 14:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9F8A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=mAM/xgtM;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=LOW9zmCr
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DHLNo1279784;
	Mon, 9 Nov 2026 09:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=BUQXqw+R/YtPFmmZFk5QXBn6Sn8YsKfXrHWHkWR5adQ=; b=mAM/xgt
	Mo5vwF+aN/+EZECsWKzJ7F2gqWAPjK5VJROmEKdgBeRzw0+OwoLWEeYbPwHBtDaD
	lkx2yAJByUoZ5lpdpJdeRADDOGNvob7NrN/3Xoeebq48rse5Wwl21cXLFMt/qZA0
	e3U5MiIEqQSNppsn+odOUvifVayFbYFZ/IADjBZjnKGiAdpjVLNVItYNnsddATsp
	hTs2y2y0O1imGnQtRaSEiv4HKr4NFUNPUXqOXJ7+P7LlNGrYZ/PnWctgp5vcLWao
	z6FV7oZVb7r8rugp2TWUdVZ3fCWhgJJ69bnPlaT82dc3mM57vCz14usMof2jnmts
	166BzuAXIqoIZTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BUQXq
	w+R/YtPFmmZFk5QXBn6Sn8YsKfXrHWHkWR5adQ=; b=LOW9zmCrODwa2mXcR4MNy
	Gw3o/tGPS5dQygIEkFWfyeLzsrHxKg5Ef0mS0ETP4ypt/eXD+DxDD+QU4BtGjRwe
	uPVD2lzB4R7CjHut0zJAXjftSVrTBKXBV43O4h9dE4j75hyHy4OYmFUgjncnH2GG
	THuLZSMvh55AWIHkp7vkWJ04mORMq0JMsFda/JLPgq2pjkv/Hat/SjAThbnxG22T
	hACVw5JgWre3vDIuoUqfY3d5IFLGS76yZXelWFh8jnMblAY8E4j67xCfNe83kXuh
	B7mcdBkXIKwvcl23W7LCIxgDwGkcX/MP9HrxrrP2ki8xKuOmRMocp0Kj9V1qAQuz
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hucbv1kkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 09:07:39 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A9E7cGU064629
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 09:07:38 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Nov 2026 09:07:38 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Nov 2026 09:07:38 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 09:07:38 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A9E7R4I024971;
	Mon, 9 Nov 2026 09:07:29 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        "Trevor
 Gamblin" <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] iio: adc: ad7625: use standard unit names
Date: Mon, 9 Nov 2026 16:07:15 +0200
Message-ID: <20261109140715.36796-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107015531.32328dbb@jic23-hlaptop>
References: <20261107015531.32328dbb@jic23-hlaptop>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NiBTYWx0ZWRfX4CkoVTaN6JBJ
 jby+f8eBrm7ewsEbp0pt+hqW5cpWWGnli/WvH7hNtX/+5GVRu1nay/eiMY6MW9Gqk37hZhLdX4D
 yDWWWGJC7HzSdfBUotUrUKQpsBhyfhhsWt30oxun4R2bez9TTeyg+IzgJOEv1UEzd+qYEGxKUZ9
 CtcYWzyPxWFZWzz0kQAWIFSupjj7cvo0V5DMCh5kDVugbc0xcQpMzQ1YQrWtLgipYxzIdpHDDoQ
 cSBzWruI4Qt8TJXrk16mQTiCPnYYFRXMMDxJjjGLBDjonum0eJdwSKKtqArvy9cRXZ01B9gZ2rG
 O5XGHI59jm91KxFvfrNNz29uQdC/GBpAjBlZojPqnMzCvmwFKeT21e8R7vYqN9iyErHN4FjVURy
 vcZWSY6WB36KVEf7vLzVTcxDiTE/GJGSAdMORdrl+oX6Ytda/UUxB9hZ9VzQKsqGEZOcanpzYE9
 refe1IbdfcY2PnBZVWQ==
X-Authority-Analysis: v=2.4 cv=L9aI0OT8 c=1 sm=1 tr=0 ts=6af1d3ab cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=xNyQZvpqp-kBkZB87tUA:9
X-Proofpoint-ORIG-GUID: haChGuvnuRtjvXxVH3MZmMVzGx2EMWqC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NiBTYWx0ZWRfX28RDLRps+Dh4
 1a+lcz155kqsfYN7HEHR46UthSG1iTluL68orveZbtfesMVA01Eb66E0IJ1IRSjKZUXljbE6jir
 UpxQRTkiJztgpAVgYcDMX1TpGL8yp02r4Jgxps9jTtzS2wzdz7Gk
X-Proofpoint-GUID: haChGuvnuRtjvXxVH3MZmMVzGx2EMWqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090056

Hi Jonathan,

On Sat, 7 Nov 2026 01:55:31 +0000, Jonathan Cameron wrote:
>
> > Use standard unit spelling and macros in existing code:
> > - Rename vref_mv to vref_mV and ref_mv to ref_mV, spelling the voltage unit
> >   as mV.
>
> What about poor Heinrich Hertz?  If we are doing this let's acknowledge
> his contribution as well and use _Hz as the postfix for those.
>
> Also Volta isn't doing well in some of this.
>
> I'm generally in favour of this stuff but it is churn heavy to
> tidy up in existing code.  So my preference is keep these improvements
> for places where you are modifying the naming anyway or making lots
> of new use of an existing variable.

Fair. I'll drop this patch in v4 and leave the existing names alone. Hertz
keeps clk_rate_Hz in the new PWM struct.

>
> > @@ -517,7 +517,7 @@ static int devm_ad7625_regulator_setup(struct device *dev,
> >  				       struct ad7625_state *st)
> >  {
> >  
> > -	if (ref_mv == 5000 && !st->can_ref_5v)
> > +	if (ref_mV == 5000 && !st->can_ref_5v)
>
> Why is it 5v rather than 5V?

can_ref_5v (and can_ref_4v096) are from the original driver.

Thanks,
Daniel
