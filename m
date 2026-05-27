Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F733806C0;
	Wed, 27 May 2026 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897604; cv=none; b=SHsLe6CycTZMSy/a4v2/btM+58wlm0wuSfMb+8oiiKNczLEzFxf6lS8Ojs524W9smdGfj6kbpbTtzWy4rus6UYiPTf2EbLDK61YwH/Em+v12pFLtKH3OHmqo0D+ZcNq8mKc6PIC8Izu+KgBDK/SgSUlIStajM/JNsE6PVucOIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897604; c=relaxed/simple;
	bh=CWU9+TVZMvKFmzx4keG9MJCrmNF/g3ac6eJWxBfwG1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNMkaMJ7M+BvSRbe18l3yc32OdeiRTh9HzI+/foShShdRwTwwKSg0kQ0fK/Kj1tnwSsg5/Mtn6ghgP9mNm3s0bS/7trQSbwXcgmv8mP5IJm79LMicUuw/6I4lSeR50OT2nfnK0S5RFnSdQmtrPJMV6VjL4mYspL3rk1wZMmvoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UiMIzM7o; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UiMIzM7o"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCDWkG1245420;
	Wed, 27 May 2026 11:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lm9yM
	bnRaV8OEEW5Jlctc8JhJAC0mk8dIN9cy9AGNdU=; b=UiMIzM7oXp9TLbR7jx1zn
	RJkUKV/3VKcwZHNhhdfpih8lS9EnKtuBjeCPwSrjYr69vbtlHgc/CLusYtcN7PR+
	ZLV5Dld0zoYW41XAdq9W8fgxcifSTaqBC8Rc73yyrpr8zy647wqmj+aoqZ2HA7NF
	peGKnt+amLWQ8qUWUcBEc/RAuOxfuGFXi2WTtDLZjP6xUVil+gXIH8O44elYTKU7
	DLo7OiJeqhV5yb80/jcoUXiRdf1Scovtk7n/zebD+OA/IqkfUqiGoU9Xn8lC8HV9
	lP2l5/Ox2PcwE/3fzgozS0QrrPF5/xthnxkCugRq/i3a71ak05YS9cxzzZMSvsXZ
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ed83e57hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 11:59:43 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64RFxgK6024743
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 May 2026 11:59:42 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 27 May 2026 11:59:42 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 27 May 2026 11:59:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 27 May 2026 11:59:42 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com ([10.32.226.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64RFxScq024516;
	Wed, 27 May 2026 11:59:31 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Conor Dooley <conor@kernel.org>
CC: Liviu Stan <liviu.stan@analog.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Nuno =?iso-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Antoniu
 Miclaus" <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 8/9] dt-bindings: iio: temperature: Add ADT7604 support to adi,ltc2983
Date: Wed, 27 May 2026 18:59:07 +0300
Message-ID: <20260527155908.402341-1-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526-overexert-mollusk-72b080546d5f@spud>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE2MSBTYWx0ZWRfX3V5d/gamzGuo
 XA1PFB9eg+fhfp5w2RyqOaHYIhLvkFldjcom6Ba80sPkSvCGUnJAP15Gn0b28UZo4lApuYfjU0g
 LaZLIy5rVYiWOTuRzauwfg01fAkLPo4EkYvLa7ESmPh+spg2/NnDNE8AjkAiteZWDYl7uw2Ovsi
 aisAqc2Hg/mZ4W4okOoR/AAK9sKDQQrH+TV72Gm32TlS1caH1b+2UxrAAso8NevpJjeyoGGjrFW
 uXs/1DHzmd2i0dBBEu5zeafz/asGVHRXa0ArPOJstslxRdqSpdm5rgANJoCNSOYT17c6AFhJ6H+
 Hy1JuoWlCRhrRPtG5GNeSz/GKe/B2h2mXUbfw00+Lz3Ztk4I9RdIu71r608EVTqiK9yyrthMkwK
 RkfzLvSk0O8st8uUvNzs6B5HYl4HTrpaIqUJMLDF9f6Mc37rSBeMv6pbvxJfMnCthrLkxoe62EN
 mpkpg++34mSkrFcXs/w==
X-Proofpoint-ORIG-GUID: 70MzinQvcDMp71bXbK6_1rKa59IA_JoL
X-Authority-Analysis: v=2.4 cv=es3vCIpX c=1 sm=1 tr=0 ts=6a1714f0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8
 a=LB8o0jXiuc9rKahuU8wA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: 70MzinQvcDMp71bXbK6_1rKa59IA_JoL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270161

On Tue, 26 May 2026 17:55:49 +0100 Conor Dooley <conor@kernel.org> wrote:

> On Mon, May 25, 2026 at 07:39:35PM +0300, Liviu Stan wrote:
> > The ADT7604 shares the same die as the LTC2984. It repurposes the
> > custom RTD sensor type (18) as a copper trace resistance sensor
> > and the custom thermistor type (27) as a leak detector, and
> > removes thermocouple, diode and direct ADC sensor types.
> > 
> > Add adi,adt7604 to the compatible list and introduce two new
> > sensor node types specific to this device:
> > 
> > - copper-trace@: maps to the custom RTD sensor type (18). Two
> > variants: sub-ohm (< 1 ohm, adi,copper-trace-sub-ohm boolean,
> > no custom table and excitation current) and standard (> 1 ohm,
> > required adi,custom-copper-trace table, optional excitation current
> > defaulting to the datasheet recommended value). Primary output
> > is resistance in ohms. For > 1 ohm copper traces with a custom table,
> > the chip also outputs temperature in millidegrees Celsius.
> > 
> > - leak-detector@: maps to the custom thermistor sensor type (27).
> > Takes a required adi,custom-leak-detector lookup table encoding
> > resistance (uOhm) against coverage data (%). Two outputs:
> > resistance in ohms and coverage in percent.
> > 
> > Separate node types are used rather than extending the existing
> > rtd@ and thermistor@ nodes because adi,custom-rtd is required
> > for sensor type 18, and several properties (adi,number-of-wires,
> > adi,rtd-curve, adi,rsense-share, adi,single-ended,
> > adi,current-rotate) have no meaning for the new sensor types, since
> > the configuration is hardcoded, and would need to be explicitly
> > forbidden or ignored in the driver.
> > 
> > allOf conditions are added to restrict thermocouple, diode, direct
> > ADC and active temperature nodes to non-ADT7604 devices, and to
> > restrict copper-trace and leak-detector nodes to the ADT7604
> > (some parts only).
> > 
> > Signed-off-by: Liviu Stan <liviu.stan@analog.com>
> 
> If this approach is acceptable to Jonathan, it is acceptable to me.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable
> 

Thank you!

> > +            leak-detector@14 {
> > +                reg = <14>;
> > +                adi,sensor-type = <33>;
> > +                adi,rsense-handle = <&r_sense>;
> > +                adi,excitation-current-nanoamp = <10000>;
> > +                adi,custom-leak-detector =
> > +                    /bits/ 64 <          0 100>,
> > +                    /bits/ 64 <  202020000  99>,
> > +                    /bits/ 64 <  285710000  70>,
> > +                    /bits/ 64 <  333330000  60>,
> > +                    /bits/ 64 <  400000000  50>,
> > +                    /bits/ 64 <  500000000  40>,
> > +                    /bits/ 64 <  666670000  30>,
> > +                    /bits/ 64 < 1000000000  20>,
> > +                    /bits/ 64 < 2000000000  10>,
> > +                    /bits/ 64 <1000000000000 0>;
> 
> My OCD hates that you have gone to some effort with alignment here, only
> for this last line's first cell to scupper it completely.
> 

Sorry for this, I can fix it if necessary.

Thanks,
Liviu
