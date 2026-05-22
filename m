Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEF83E9C3B;
	Fri, 22 May 2026 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450227; cv=none; b=Gye6OZ6DSQwsW8iB14aGgh7mZOoBGxNjvAuSa42Kz7/HKMLQHrpENMu/0HqttbZIiUJI/4zGgbXoOd7FQEYDiihwi1JZHdenbHYRiC9BrmMinAbaHwsiFtD9eC1iDDSl/Z2qkBtjDS/qk4X8gSqEf7qYMsN+gwhhXRm0cbe2GOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450227; c=relaxed/simple;
	bh=PNohBehMFqzLU93NHb3SGWwudiTFnfMxEwTzlYnK00Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSZb/jHbPf0L3ExWdWT9Ba+cYRfw6unecCF0/NFkLK53Xl7MG4NVhFs7A29lumaVMUJqSLDjlT4DPuZIsbfydJ8zJRUIt6DF0rMBu0lDI396FXtevwGDNYRsy5biXxPeaeWs7hgFe9YytUTvjAm8CVSoeoxrKWcSCgMEBjXwYTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GAng/fMD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GAng/fMD"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M9WhmS938988;
	Fri, 22 May 2026 07:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JLjl8
	5p2pUS1qBmV8Ydozk1K/c/beEn9fiuTsLgc5RI=; b=GAng/fMD8aj3v0r21spey
	l4WguAIYRgnYR/qfkEPZPYnqlM89AfHVOZv688LYhUi8r7z8JdV3u6OwJdWAndmS
	zrLihcviCp+Bzqj7iFCxZMFhILy0c6W0PYAt5BvfSnjWI3xXxkL+LV6W30xx/cX+
	1VmHiK1ls8399MgS3o5CwqGjUxpWmf1ioS51RDees0LbdB4+pZZpsKQ484U7GL0E
	Im57EHtoKyDJnPDxRyConmmIZXgs0kwOjd22viw9Sq1smFQUGWW0CeVs7DG73JGT
	cF1VKHGFJB5+0fi323onEco6GqV0Is/mF2rrY327UQ+Oa8Pe6XzcSF4p/vb1YeM8
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4eaa8rtgkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 07:43:36 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64MBhYUV019568
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 May 2026 07:43:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 22 May
 2026 07:43:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 22 May 2026 07:43:34 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64MBhLID027161;
	Fri, 22 May 2026 07:43:24 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Antoniu
 Miclaus <antoniu.miclaus@analog.com>,
        Liviu Stan <liviu.stan@analog.com>,
        Francesco Lavra <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] dt-bindings: iio: temperature: Add ADT7604 support to adi,ltc2983
Date: Fri, 22 May 2026 14:42:53 +0300
Message-ID: <20260522114259.841-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260521182308.4E2731F000E9@smtp.kernel.org>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNSBTYWx0ZWRfX3TDDGZaU+HWs
 JTlrTITRfewDDVuQTJuvycpABCMX7tHpbnhbfA+SYZEA/h7PiegZlG1Vxu+jxdVFJbpZwywVOxr
 quQBHM8egFR1EvVmnp8IGBPDdDXyJfz+ed6StuLUX0sbVmORumN30NUwZHbpLKnq4RKbVjNbx8f
 zoGPjfrZeQgPyuMiQLxbSUdN+3Vsm5/HHkyIy/LSz1ptUMp1sj5VV6mdgXo/eWfYF7+Cj34vIhT
 ZF8DOpM3X4uikbOAxmWe9Pjwtr54I5W2jOFAUv5p3otmw/Xxjpu8/89TozSJeE68eaMl8LHbmZS
 LnlRGKbi3AX3Lde1mVzCEBy3LWqQVWUI48c0fF2sDa/AbNTHdFFHE1qc3gDz7BIOXrcXmd3xIWm
 4jGBQjoF/m5L/sQdgKRbr9tQ5++Ic3POPdTEZt8mXLT5XwFLufv00531GTS7LnrbgnvQP8AdZ0n
 VsYKuif5IGEZRYeS8rA==
X-Authority-Analysis: v=2.4 cv=FIorAeos c=1 sm=1 tr=0 ts=6a104168 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=mgCjuoWyZGocCnt7NIEA:9
X-Proofpoint-GUID: 1XbsHrwa4ZOeHPTEq_U5ss4vBxZx_LLk
X-Proofpoint-ORIG-GUID: 1XbsHrwa4ZOeHPTEq_U5ss4vBxZx_LLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220115

On Thu, 21 May 2026 18:23:07 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] The new compatible string 'adi,adt7604' is omitted from the existing conditional block that disables '^temp@' nodes, violating subsystem guidelines.
> - [Low] The schema allows invalid 'adi,sensor-type' values in '^rtd@' and '^thermistor@' nodes for the ADT7604.
> --
> 
> commit fbbcd3bcbfbb106e48a6545868dd2b27a56b39b5
> Author: Liviu Stan <liviu.stan@analog.com>
> 
> dt-bindings: iio: temperature: Add ADT7604 support to adi,ltc2983
> 
> This commit adds support for the ADT7604 to the LTC2983 binding schema. It
> introduces the adi,adt7604 compatible string and adds two new sensor node
> types: copper-trace@ and leak-detector@. It also adds conditional checks to
> restrict unsupported nodes for the ADT7604 device.
> 
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > index a22725f7619b7..14cfa28809edd 100644
> > --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> [ ... ]
> > @@ -477,6 +597,22 @@ allOf:
> >        patternProperties:
> >          '^temp@': false
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,adt7604
> > +    then:
> > +      patternProperties:
> > +        '^thermocouple@': false
> > +        '^diode@': false
> > +        '^adc@': false
> > +        '^temp@': false
> 
> [Severity: Low]
> Since ADT7604 shares the ^temp@: false constraint with the existing devices,
> should adi,adt7604 be added to the existing compatible enum block instead of
> duplicating the ^temp@ restriction in this new conditional?

I think keeping all ADT7604 related constraints in one block is more readable.
For the block above it's different because ltc2984 and ltc2983 share the same
constraints.

> 
> [Severity: Low]
> The commit message mentions that ADT7604 repurposes the custom RTD sensor type
> (18) and custom thermistor type (27).
> 
> However, the schema doesn't restrict adi,sensor-type = <18> inside ^rtd@ nodes
> or adi,sensor-type = <27> inside ^thermistor@ nodes for the adi,adt7604
> compatible.
> 
> Should these restrictions be added to this block to prevent invalid device
> tree configurations from passing validation?
> 

This makes sense, we could restrict sensor type 18 and 27 for the ADT7604, even
though the driver's supported_sensors bitmask already rejects them.

I could add something like:

- if:
    properties:
      compatible:
        contains:
          const: adi,adt7604
  then:
    patternProperties:
      '^thermocouple@': false
      '^diode@': false
      '^adc@': false
      '^temp@': false
      '^rtd@':
        properties:
          adi,sensor-type:
            not:
              const: 18
      '^thermistor@':
        properties:
          adi,sensor-type:
            not:
              const: 27

What do you think?

Thanks,
Liviu
