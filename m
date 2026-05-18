Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFCD32B99E;
	Mon, 18 May 2026 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094547; cv=none; b=M1Z/RfkIzJWbBALJZTnuzDiP+e002KtWsfiz0UjopMb7AXwLloKMXr/UjRQNcASOw8Og7AYvqWuivghX6i6GTQZ4t3XjPVmPHL1pBqQ9UmzUSTLXJviT1QIWNdyw/Ou7O83z+BnXtOgKRKDf0+UjlmxZT2CHp03tDelQgkBCOeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094547; c=relaxed/simple;
	bh=l/0QBaIVRAi74g3JzPSXWF+89gHglLGuyCFTiDEvMro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxskKoVE2OdRAdiLEA5Nt9xQxdv15sj/obALzuHlYxDb4fSU62NYW3o9lxzDVZjMPkD5hBfBEclA07IHdSM/VLjahM8KouaY/RJrKQihProcCY4oDxIZ3gmb/wcYf+szsbgpBe6P5y00ZlxW6hlkKgtAKOmxZyZ9Q65vHw6meJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KPMuZx4F; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KPMuZx4F"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I4n50c675950;
	Mon, 18 May 2026 04:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yVQIY
	5uXiyj4OBIsHKs8RtNgEMBy2EqjMlY+/fcuapw=; b=KPMuZx4FW8S0FyLm8QJkP
	QQwfcnZ3m4v7czBI3RGHFLC7r/lPXFJiHV8gl0RmYE7VTMIeBgS9PP6p0fjpcKj8
	CmixfL2DvClcgv8K1gf2/9MQn9ceoHjeSWe8hxeqtIf5YGKx6w0S3ZTBDsy8vyWX
	b75jO5VD+4BI52itvwGqrbnRoG88BY+VzRxgFM/yG8eiUpPPkkG8pYBML4V0vp/c
	p3iKDj1hlpH5H/BKdJkvgA6lRNkwxBTt3zOa/VhyPjFgkd7xk3nDxjOgzB9eiqro
	FkixYoVuWrJWzkI5ti1xtl+mWmIONc5uMyXH77jn5Swc2NEb3oKADSz4ZQVXZmHF
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e79wdu032-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 04:55:42 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64I8tfji020398
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 May 2026 04:55:41 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 18 May
 2026 04:55:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 18 May 2026 04:55:41 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64I8tSe6019844;
	Mon, 18 May 2026 04:55:30 -0400
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
Subject: Re: [PATCH v2 6/7] dt-bindings: iio: temperature: Add ADT7604 support to adi,ltc2983
Date: Mon, 18 May 2026 11:55:21 +0300
Message-ID: <20260518085526.84987-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516180358.094e6c2d@jic23-huawei>
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
X-Proofpoint-ORIG-GUID: qYEyVreoTZer4o6x5blIz6JBGRdHAX_V
X-Authority-Analysis: v=2.4 cv=HKbz0Itv c=1 sm=1 tr=0 ts=6a0ad40e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8
 a=K6Ps094s-QnVl3WvZGcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=t30qsMHlJzOsgWiHt2r7:22
X-Proofpoint-GUID: qYEyVreoTZer4o6x5blIz6JBGRdHAX_V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA4NSBTYWx0ZWRfXzccUjSFSfY3Z
 UI1oV1pd+qWYgyPyBFTM8AqXwposVKibaHUo72yMpXa7L8TdEgyr1Oz5wsVW4d3GaC7h0Yj64b+
 r4xJEzoQJrTiQtiwSHPUmLm3TGEpKCmnsmW8xDRW4GZgmW2TRXor9FlFF4wug4bC9zq6Y6yJyqB
 jLxjhvZpDwdRWcCByT5CQhxoDN10ZDOzwh0LV2TnOKT9sb87ZHJ2TCdT3H3TEVOVVzAdTFLU4FO
 dc9XGLdaNPcqM79DeOshzSpqDsAHdI1HDkR8QveOsvQ1Fw/MWaT7SlcaicKsdrHUVjPISdWVJ07
 uEBViaGmF5A/m6y8xzfoFWd8D1dAutR7FuGAYecKdfIr6YP1o3FHNTzZPGA7pugCZuWc2jigdwm
 +QhcaCrCwoRQHD6GO0AD8VSkNkaZL0qGeNssAPSSHg4YThZ11ICIadzmihaKWtA8hpfQpAHuweE
 Y2DbsGiNevzvrbB1zeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180085

On Sat, 16 May 2026 18:03:58 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

...

> > +  '^leak-detector@':
> > +    $ref: '#/$defs/sensor-node'
> > +    unevaluatedProperties: false
> > +    description: |
> > +      Leak detector sensor (some parts only). Outputs resistance in ohms and,
> > +      when a custom table is provided, a coverage percentage via
> > +      IIO_COVERAGE_PERCENT (raw/1024 = coverage %).
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 2
> > +        maximum: 20
> > +
> > +      adi,sensor-type:
> > +        description: Sensor type for leak detector sensors.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        const: 33
> > +
> > +      adi,rsense-handle:
> > +        description: Associated sense resistor sensor.
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +      adi,excitation-current-nanoamp:
> > +        description:
> > +          Excitation current applied to the leak detector. The correct value
> > +          depends on the electrical characteristics of the liquid being sensed.
> > +          For example, 10000 (10µA) is recommended for PG25 (see datasheet
> > +          Table 39).
> > +        enum: [250, 500, 1000, 5000, 10000, 25000, 50000, 100000, 250000,
> > +               500000, 1000000]
> > +
> > +      adi,custom-leak-detector:
> > +        description: |
> > +          Lookup table mapping resistance to coverage data. Entries must be
> > +          in ascending resistance order. The coverage data field encodes the
> > +          coverage percentage P as (P + 273.15) expressed in uK, i.e.
> > +          (P * 1000000 + 273150000).
> 
> I like sashiko's comment on this.  Why are we having the hardware / driver
> offset encoded in DT?  Just put in the value without the offset and apply that
> in the driver.
> 

Will do this in v3.

Thanks,
Liviu
