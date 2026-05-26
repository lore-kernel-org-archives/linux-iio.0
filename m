Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333B63CDBD3;
	Tue, 26 May 2026 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785253; cv=none; b=E7nRoRdaUe4U3gfh5yBX9KESyZz7UMQIiO9ytlY2q7Cqy5Pec6gwdHsYeB4Ci+a8nvoTMwcDAmofUg8Zv79Wzq/ucGq3psLnitdMZbxvhrU8Dwpe+1t33OFGz8xgJ7bKqECgCpoGUnN+IIf0Mw7yQ/JbivaJWq2hSd8T5o022zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785253; c=relaxed/simple;
	bh=UkAl8Dq+PkppOD4e4Mo1mXDyr13knwyIAb/gmdjK4+I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmQ0jAz7by2HOAuv9LTTqdgdYnEwcDEb83Oyi+JWg2uhDCf/Dks3Td+a4o75bhPXgSM+a5hQz2tRKgsWgypWHrMak2e8AoMZuuLbODAC5QF4PDAAWwXb+6JD2lHxb/iJgmFYiD3ajKtYcLKDgD/rAlvu703znxWqKuGBE/Xonw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zQnzxiGl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zQnzxiGl"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q8W6KX265316;
	Tue, 26 May 2026 04:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dKlRf
	50l4cg5pX5mHB7tXk00yDKVlbuvsMuxNTQWRpY=; b=zQnzxiGlSjC9Y8rxOxG+d
	moht49p+e3zy1iQI8QjdbTq7Is5F821Xc4MUAbq4fEU2h3oQb8S4qBmzV4URF2qW
	uAD3Z1l3aUulVXpmKQEYDHhlPkJahhsv6+eNd7Tx84iMvPke8cCbtn34ewBohxPM
	G7wZXptLLt8gojeR5opI949aNtGalnsQfmqC/9EqMREmWD5ltpR3CM+4pjowVSZ/
	VhIsItEZQUd3lezR2Ph+1HATrHPSSm9CGch2Hul072D8QaMImFMPpo9Gzf0oTA7+
	XBy+V3TplcNQyni96i5aI2fIW+QY3tHcXaDM1nf4DgSJCaW24iK5wLMPw9/jAsFv
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ed83e01c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 04:47:23 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64Q8lLQ8041476
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 May 2026 04:47:21 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 26 May 2026 04:47:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 26 May 2026 04:47:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 26 May 2026 04:47:19 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.195])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64Q8l6Ew019775;
	Tue, 26 May 2026 04:47:09 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Antoniu
 Miclaus" <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>,
        Liviu Stan <liviu.stan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 9/9] iio: temperature: ltc2983: Add support for ADT7604
Date: Tue, 26 May 2026 11:47:01 +0300
Message-ID: <20260526084703.133327-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525164013.118614-10-liviu.stan@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA3NiBTYWx0ZWRfX6QZ/ojYFjq+K
 lG7tfWHq+WGwDEh0y/sIBFKNQSVjdyOA2P0e93g/vskcx7KPZbAJI/h/U5D0DwAGnyicqY+XJEx
 J4bVRdMIeKoLLIfwxFR41ySkfHswp1ytFa0dcpsR8eWOZ8ntr4TVftscAEvv5nKkbSiCkeO5FPn
 GfcLptpJBhlGKiQP477ggW0fA2x9RIG+Akt9ZAPzTPbfqL/wG4XBgOlO9Z9oPyPLWXFlEc4F0x4
 UHq2EteHnbr+y2BrcNrI9yZbjpxD9VDVu86a3aimpsAjr/ptUBO4Mwl5GwZw+H09Gjd3kRFRTl3
 oTLLsuUtWB7K1jayIENJ4GGcUuQFyBMtSadSS+BxD2W9MrDxCX5PMdT2zjpnOXJawSfncASC7x5
 zRuJIpQFqDNgc0tDu9OfP9WqWaj4AERz9J2QLMpdPDSfLCwJfD45injAoid+2fpLv6JNd5uFBph
 b1Tp5KEI+VetSg7i/8Q==
X-Proofpoint-ORIG-GUID: 6BmmELo1gO0ehUykXRpNRjnZ_naHhWA3
X-Authority-Analysis: v=2.4 cv=es3vCIpX c=1 sm=1 tr=0 ts=6a155e1b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=c92rfblmAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=3UmEi2wzclwzjTVA44AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 6BmmELo1gO0ehUykXRpNRjnZ_naHhWA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260076

On Mon, 25 May 2026 19:06:14 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Integer truncation of `num_channels` leads to an out-of-bounds write on the heap when parsing device tree children.
> --
> 
> commit 482bc8c51e04185002511817885173bd265542d8
> Author: Liviu Stan <liviu.stan@analog.com>
> 
> iio: temperature: ltc2983: Add support for ADT7604
> 
> This commit adds support for the ADT7604 sensor, repurposing custom RTD
> and thermistor sensor types as copper trace and leak detectors. It
> introduces new structs, parser functions, and hardware register mappings
> to handle these new types.
> 
> > diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> > index 130ab7fddc2fe..fc65d8352d120 100644
> > --- a/drivers/iio/temperature/ltc2983.c
> > +++ b/drivers/iio/temperature/ltc2983.c
> 
> [ ... ]
> 
> > @@ -1348,7 +1672,7 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
> >  	if (!st->sensors)
> >  		return -ENOMEM;
> >  
> > -	st->iio_channels = st->num_channels;
> > +	st->iio_channels = 0;
> 
> [Severity: High]
> This is a pre-existing issue, but does st->num_channels silently truncate
> the number of child nodes since it is defined as a u8?
> 
> If a device tree is provided with 256 or more child nodes (e.g., 257
> nodes via DT overlays), device_get_child_node_count() returns 257, but
> st->num_channels truncates this to 1. This causes devm_kcalloc() to
> allocate only a 1-element array for st->sensors.
> 
> The device_for_each_child_node_scoped() loop directly following this will
> then iterate over the children and write into st->sensors[chan], resulting
> in out-of-bounds writes on the heap. Could num_channels be changed to an
> unsigned int to prevent this memory corruption?
> 
> >  	device_for_each_child_node_scoped(dev, child) {
> >  		struct ltc2983_sensor sensor;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260525164013.118614-1-liviu.stan@analog.com?part=9
> 

The hardware has 20 channels maximum, so num_channels as u8 can never overflow in practice.

Thanks,
Liviu
