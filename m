Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793366559;
	b=3PX7au+rjmP6o/f1u9MPDEUNVASEOqCT9qAhYiWxHomQl26H42oJ8+wcHGTDGwgA/CC1
	 TCT791XQzoEGWICj8hwvT9sIcQ7VhLUJWH9vOalsnIGstD0bjVmkLH8KXTUl8mcaP3H3F
	 5zMcUrQ8yitZ1g/WVi2++8DHO3JZ4Ci+XrE6nPx3bTOdPiJn+gYG74hxcCwPwVUbT1agA
	 oPvOoCu/kXqQvX/D2SCagta2zirzF8ncGVrVpg6Emx96GhHYigXn7t1gHI0zX/+F073rL
	 fZywPQDHI0dh4VkQ3mKb/ZcIogU36M74FOc668gGb7MAZxtb1zJavtEI1PnALNGPNqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793366559;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=j2UAE94DwDtj5LC5+N6jjgw+UMIRPadcwNXB/HMtjzU=;
	b=1fuwAUKxkOXZvPOKUNjt6Nm2puHUBY/5SbxGndHMsp+h6a81nfZrxoKOT3qIk444ya3b
	 6cEUq5L4lLiGWi6wGZgpG022z0O+unaCWFZ81+6F8Mj+5E6LgVlxwDb+uom9a/5QJ6nus
	 ar07/IOeJsAPe7A1qsAA0H6zAG/8+8a9twDWMxEdr8TTDRNMhPiDluX7sPo+JMx2xw9lY
	 WaqcCCLAxjONzIh3KiZW2z0DUgJdMsjZTqebEB3hwYezsPGaXql1hwSxodb5FLTquTD4N
	 +qaYVHyiGBOKdMdLn2EkjfXZjGSOzDVXmVsCObAKbOpUI0zmNewjEa5zDQ9JIXGSNDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=XHGg+9JK;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=NM6HgPDW;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86839606A31A;
	Fri, 30 Oct 2026 13:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86839606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=XHGg+9JK;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=NM6HgPDW
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBI7k91436892;
	Fri, 30 Oct 2026 09:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=j2UAE94DwDtj5LC5+N6jjgw+UMIRPadcwNXB/HMtjzU=; b=XHGg+9J
	KDzSNB+JROdc4hcYks3nREF0z6Z0neuy+5uxM3t5IN1qIQI3n/8wW7rP7E3hSq8s
	g1ValLDLfKUx9690UPlgizlMWfvbMb3B+lJqZ+YsRvmUUow+sIf0wKyRGFMcO2Pt
	lK7sneWIj99uV9KX7rGT5JIfTJHbU5+O646cKFd7NeWJjhpVvvKZCHiT1V0DPT1e
	3svSc15Yh/x/OUQxm9D987o/L6kyfyVNs373fGRZlObw55tueEO1OogCQeangsIr
	eFnUT6jIShCnbHBOo7UqPz+lAI6125qKuG6aR6O38Iof1MUuRyyjry8vCvZU8Q/j
	oELl18GBlXq0Ppg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=j2UAE
	94DwDtj5LC5+N6jjgw+UMIRPadcwNXB/HMtjzU=; b=NM6HgPDWWduO9A+1lCEEl
	6ipgpN9QMWgjOOOK6QOPqhxH+e5GE5ZcWTkrpqMEBGiBSPbdlpOfOv00VrpYPBoc
	a9ZUIFIkaFlxcDZyGCSb++Z2sc9KtO8fj8S9QQcQS18TlXM0L3xkoR77dqZ++lLD
	YZg5ilyOxP6tt3FxbtMtPcabfIk3x7KYfR4NaP/M9d+bf74MDnxEVDH4P+maSMd7
	l3xKVNV/iPd+7aiFdgDMDTq/YU4mqITubdYwlZxtfIeGyJAOMm3RZ3e/HkWPt38p
	fwXHzRiFZJtpX2+Ro8jqHuYvUlUYiKv9FDlbuM94Djq+fUBF9VLhGott1VYzkAUM
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7acduy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 09:22:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69UDMXfx010514
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Oct 2026 09:22:33 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 30 Oct 2026 09:22:33 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 30 Oct 2026 09:22:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 30 Oct 2026 09:22:33 -0400
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69UDMKjm024982;
	Fri, 30 Oct 2026 09:22:23 -0400
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: <jic23@kernel.org>
CC: <sergiu.cuciurean@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <ukleinek@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: add ltc2387 driver
Date: Fri, 30 Oct 2026 15:22:14 +0200
Message-ID: <20261030132214.327546-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028023919.21834986@jic23-hlaptop>
References: <20261028023919.21834986@jic23-hlaptop>
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
X-Authority-Analysis: v=2.4 cv=bcX+w+PB c=1 sm=1 tr=0 ts=6ae49a1b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=YXEIlvhfyepGEwiY_-oA:9
X-Proofpoint-GUID: JN8he33VGWJsHSRbojmuxX0BypCuBSP7
X-Proofpoint-ORIG-GUID: JN8he33VGWJsHSRbojmuxX0BypCuBSP7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MyBTYWx0ZWRfX8k/N9fY+Y8jl
 RL8YPi8BtsCdcYRgKjSq8zq8J+qPUEN9z9QuVYF9rVBuaE766EfmWYFIm2GsNA77RPR1MPSyIgK
 R14OSPtCY4hkizovss/2mpFaey09U2CjZoO++uyypoXMpbSWSIYg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MyBTYWx0ZWRfX+HAtx+6NIOWw
 47/dqxtepKpLBCbMUuBFQC5HYhwLsjg/DX27NMxd4KPfaUOiCrptaCkPLIJJDEtCCS7ucNh0Ozr
 joj960KQoUw4JOJLGimiDEDOHxsTaWykURrfB+TsHRmrT5Rmc4iI1P52ryUSiAaBz8nEsKE7Zu/
 /VS4iGHmHGr0ZiVx+B1kdHGsP29SYN5wEy5wOSK4gzYIvQLZeRUSZPxUA/qg+h8IgjtHjEs/e/N
 FynUrsticJC/PED8n7kb3fWpBrLrLdBCpM/FNZ2SSl4SLCNdTx1Dvgx5eCh+Bvx+r/i+2+lJ4Cw
 X+C8CtuA1xhNtzsRNmuKdUYv/V/K+yYzFLg5c/oGVVBpJNlz/H9uRldQRp9WZo2mgsdfiVsntHB
 RhodziAiJ1XIKURzYj9xCI6QuelGZ9kV//VWt68K255g+fhVb0rzftUY3dHbMN8UuG3N6kt4+Mw
 35Q5N8JtdT1MEHlBH/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300053

On Wed, 28 Oct 2026 02:39:19 +0000, Jonathan Cameron wrote:
> > +	/* Gain * 1000 when adi,gain-milli is absent; unity for the bare parts. */
> Gain / 1000?  If its in units of milli.
> For the unity parts why 0?

The value is stored as gain * 1000, so a gain of 2 is 2000. I'll reword
the comment to say that.

The bare LTC2387-16 and -18 use 1000, which is unity. Only the ADAQ23876
and ADAQ23878 use 0: their gain is pin-strapped, so there is no default
and adi,gain-milli is required. In v2 the comment will say so, and probe
will fail if the property is missing.

Thanks,
Daniel
