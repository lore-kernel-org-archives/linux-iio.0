Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340C2CCB9
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784509611; cv=none; b=lSBYrM6gOnG1I9hyUqAnEyJc4AF/X6K5yAfwyx/5w3gPNqtuturCEeRn6Hxp19vNF1xKq76+VMoh9JXUWS+8DTHmJhwiP2DsVjRmLbcMUBYC+HJrE7iAMPNym2ZxmT2MiTz2WWdh9wH6FwLMvScBZIcynCE0UTLAd5j9WoT10Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784509611; c=relaxed/simple;
	bh=5ioWFQY/G4/vblJm00YiFg7evmrUnCGZNlD4ypUrHAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qI2Wb1JrIuwAFvwagwpS/naoD1M62zzZUM7U5Ex1KQKcMcaiN3ylRKjgRhAjES5pH4Ojvh0DT2E6HSBScYjbEygNM1jU783d41Rr/UHuNzlmZ1lSqeQmM0xgymTbom9MGCojuhZoeTqEH6s7+vl7uG7hKmaIylnZhn2S7u100H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mDLhzvVc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F0KdFbK+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mDLhzvVc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F0KdFbK+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNt4TF757630
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qpJBWXqH8g7ugtMzbZKZ5iSHljf51mja60IrQ04xdeg=; b=mDLhzvVc8+gDd11v
	O/YeWkpO2KkGpLooXOSr02PE3mgn6/EqWToiWq8Eb+jfT18OLWKnilJ/1Dz6hbSb
	Q8xXsEqymSSzVJrPhjyB/x/JZpwk5/4yKDF20BOVpMotKfw749RRhpkCPQD3kstQ
	v5ZlW+p1jsmaIiNp10XqWw89PbVXv9AjJBrjILD0HwlTb+2OQ8HKjf+9ZF4yxuOl
	E4lgpYetMmMIh+1SfqiYs39ibo7HuHcJ4sMxq7ZfPJbfbkqmwLrIGRzzqf7QkX/8
	jG28bpyi2ShF7YM3F48wwKW3v83RddB8e6RilJorRUiJMPUIxERY4gMV8g1BN9DX
	kLIdEg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnkteq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:06:48 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so4837705a91.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 18:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784509608; x=1785114408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qpJBWXqH8g7ugtMzbZKZ5iSHljf51mja60IrQ04xdeg=;
        b=F0KdFbK+c/dHI89RVqKRlXgPZJB3MRAnTwGiriQhVHXO5M8Up5qxx9VrwYukptwl+4
         LF77L2cGncKc35eLfpZYZmuqj2L2XRtTPYu65W7N+gd4mPW63dL0WE/wWv9dRG1VR0yN
         THPfGYp39B/Y8+yQfAEeBJbMCgWZ5IqPVB6+3CJqU9mMVcI7lPFBkfzMmx3cv+1tyK8e
         GJw1v/pwuJONdI0kNZ1nmQzGvGbSmsl9rWm5VdqFX6NIAW74Ph1hKameLiVqln0z/eh0
         akwWphy8tYbUeqp2dVu/3lAv83yKypdb+C0O2ScBp8TCLnQLNIBfTeIETKIIinz4GxAW
         c44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784509608; x=1785114408;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qpJBWXqH8g7ugtMzbZKZ5iSHljf51mja60IrQ04xdeg=;
        b=BBya2VjtDO0cOf0wVijRvxaMTp9LfDeCvJ9KGER9mzIdJh42i6mOuxuqkUHh+xvvOV
         3DPZheNAXBEoXjbd0gLwMRw5KN1DT2Juilhu+kIvDKMHcgAqbH/vq5xwRLOVM8lbn87N
         hN5ZCQf+M6iorJ8AN1ZoEXHJQ4zcJd1GD0sqleqEdNXugNNF+qyG5Oc+gaS6qFPGaLRN
         EP9gKuPMU50DJmAbj1ygGoCrRYwsQEvxqK0flBVq3WpBEtTJ+TFPmMcJxMzryfMuj430
         A2i0VXrV5a01mn6b3t9KMtBUxmmhIumDVdckv+1KG1quHyjUx7jSIOPZ3IUFRBhknQN3
         oBkw==
X-Forwarded-Encrypted: i=1; AHgh+RqWmi4ZX5YsNPTfNJMMCy5kSYE1k0VPASuYYUfcWm+SwBJPfqMZEEZe6G0ZTzEjGt0Bl4nEvJnjUo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7dIWf+RDP1vKL4+juxF49EAus/d+RsgifuR+uoKYfZPGYld76
	NsGDgPnIfwqxGgGkF/Rrv4Ilq2oD2I/FoZhUao18RZ6KxVBSccjzSQ6/bUgVkSTojEChaqOcU/6
	ZHlsSIuRJSUcdG0AKPR2IAQDQdS7proWCy8F5sFvaYuPCZQBWCyJ7nw6SET6oX3Y=
X-Gm-Gg: AfdE7cmkxQ+JbWRqvrTYf7x9Clggg2QZQkWng6aLibeSg56t+3WQAoF9QMcPSorqVwh
	6jpE1UTj4Tp+Y7MG0DmBgcFm2ZgxERRvrkpkcRrJeWN9m01GB7O+o1Xxsy2rEbDxIJp2IqVP6Ae
	/+pUrAgGmgOsI7a2w/XLjVu+gPTuV1jgEiP1WuJlYyZgq2Q/vNAosqRQwRyQpwNtn5qqOoOXvdQ
	jb1Rs3R1Pn6LvOlvRgrito6yqj5e7coAP/n3o+udBX73/Y5RxDOBv5fa1BEPAof6XKGENh7t8ke
	eFZGcuJlxnx5ttheq3tvG76dHwdEnsaQjkwePivMLG+BF/ywoO3Q5IAQvjWps3mhRUb68Gl+8Nk
	uvi93gJWp+SzrHYUK
X-Received: by 2002:a17:90b:3b4d:b0:38e:7cb6:5c35 with SMTP id 98e67ed59e1d1-38e7cb65d63mr2352024a91.36.1784509607762;
        Sun, 19 Jul 2026 18:06:47 -0700 (PDT)
X-Received: by 2002:a17:90b:3b4d:b0:38e:7cb6:5c35 with SMTP id 98e67ed59e1d1-38e7cb65d63mr2351992a91.36.1784509607293;
        Sun, 19 Jul 2026 18:06:47 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39bc2c2esm6915493a91.0.2026.07.19.18.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 18:06:46 -0700 (PDT)
Date: Mon, 20 Jul 2026 02:06:40 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: "Siratul Islam" <siratul.islam@linux.dev>
Cc: "Jorijn van der Graaf" <jorijnvdgraaf@catcrafts.net>,
        "David Lechner"
 <dlechner@baylibre.com>,
        "Nuno =?UTF-8?B?U8Oh?=" <nuno.sa@analog.com>,
        "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Conor Dooley"
 <conor+dt@kernel.org>,
        "Luca Weiss" <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: add support for QST QMC6308
Message-ID: <20260720020640.4bdde14e@jic23-huawei>
In-Reply-To: <ea6f4eaeb0535d607d77920515e9cb1739266624@linux.dev>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net>
	<20260714202842.340293-3-jorijnvdgraaf@catcrafts.net>
	<d7fffbeacc77c3135564f902c41f19a219ddce75.camel@linux.dev>
	<20260716141837.83326-1-jorijnvdgraaf@catcrafts.net>
	<ea6f4eaeb0535d607d77920515e9cb1739266624@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: f-ijJfni5Z8TVDuoNcIwaJ0fPEFFNtin
X-Proofpoint-ORIG-GUID: f-ijJfni5Z8TVDuoNcIwaJ0fPEFFNtin
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAwOCBTYWx0ZWRfX2kaCkwTMt1Xe
 28sWx0WjpQqWWpiGsrkyGQjoygUBJbVnmwKfj/fmEaGqeU2g42hE15NF5QfCsZx3myrvzV+L0Pe
 0pYkikKVrBF0wEM/xSMqGuk3Hv63Yn7AzeRHlTsq3v+E2SOdsv6SeExvlyOStA1Slms+laSq3/e
 TLjGUcdeU5fA8glaYEEwQ2b/b8aHmG5IfwJjKuZJt2cbAKfuZSM5qKwCtwvVTyAKaY06ji5pPPv
 rVJBwSnkEyzVgWNY2IO6hpl+ZgJUlqpkh/iRsIUxBSDszYgwOJVMN3pC9YUnPl3WnnNFWjJ1U/+
 4OMEJ2GTCJ+BfSnX5+amJu9oSMsa1uaOGcPhV36G3ggMRwSQkbGtsm5YVJtrzMiZhQHSeoYd9R0
 zCChEyKfagTAdAqA0n34W3uIeplfRFfl9+5Ti6v1Z7jseZayTdNqT7C/bC7SkHkA/H8Xk6/J2yQ
 Z4WMNCiU18ABzUe5NmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAwOCBTYWx0ZWRfXxn16MIJbSwVi
 WY5eUp2hjnQjEjkITXwZM7UOiDqZqOxwI4dKFLmtOn5cNX3RlWDvbwesq5+yhhTVgc1zvMQb5zC
 ROvF9ZpotEfEv0xHbgktytPe+uXyQSQ=
X-Authority-Analysis: v=2.4 cv=YsQ/gYYX c=1 sm=1 tr=0 ts=6a5d74a8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=_Dw2flptXLMPG5FagmcA:9 a=CjuIK1q_8ugA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200008

On Thu, 16 Jul 2026 19:06:51 +0000
"Siratul Islam" <siratul.islam@linux.dev> wrote:

> July 16, 2026 at 8:18 PM, "Jorijn van der Graaf" wrote:
> 
> ...
> > > +#define QMC6308_AUTOSUSPEND_DELAY_MS 500
> > >  You can call it QMC6308_SLEEP_DELAY_MS to align with other values.
> > >   
> > I'd prefer to keep AUTOSUSPEND here: it names the mechanism the value
> > feeds (pm_runtime_set_autosuspend_delay()) and matches yamaha-yas530
> > and ak8974 in this directory.
> >  
> I can find atleast 10 drivers in IIO that uses *_SLEEP_DELAY_MS postfix
> for autosuspend delay value. So it's not a strong reason not to use it.

This sort of thing tends to be author preference as both show up.
AUTOSUSPEND is clearer in purpose so if anything would be my slight
preference

> >   
> ...
> > > 
> > > Why not use a switch here instead of depending on 'i'. In it's
> > >  current form, we would need to keep going back to check what the
> > >  scales, odr, osr arrays look like.
> > >  I would suggest following the same pattern as the QMC5883L driver.
> > > 
> > >  The arrays could also be flattened like this if you follow the
> > >  above suggestion.
> > >  +static const int qmc6308_odr_avail[] = { 10, 50, 100, 200 };
> > >   
> > The arrays are designated-initializer tables indexed by the register
> > field code, and the same tables back read_raw(), write_raw() and
> > read_avail() - so the value <-> field-code mapping lives in one place
> > and the accepted writes stay in lockstep with the advertised
> > _available values. Switches would duplicate that mapping per
> > direction, and the flattened form only works once the tables stop
> > being indexed by field code. I'd prefer to keep the tables, but if
> > Jonathan wants the qmc5883l shape for consistency across the two
> > drivers I'm fine changing it.
> >   
> I know what the code is doing here. But I'm emphasizing readability. You
> are using 'i' with double responsibility. You already have #define
> values that you are only ever using as array indecies. Using a switch
> here combining with the #define(s) would be more readable and explicit. 
> 
> But it is more about preferences and following existing conventions
> (i.e., the sibling driver). Jonathan, Andy, or David may have more idea
> about the "preferred" way to do this.

I'd prefer to keep them.  Makes a clear association between the defaults
set (via use of defined registered value) and the value in the userspace
interface.

Jonathan

> >   
> ...
> > 
> > Thanks,
> > Jorijn
> >  
> 
> --
> Best regards,
> Sirat

