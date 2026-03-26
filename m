Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D02382F3A
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522891; cv=none; b=iH4zCC5yWmNww3hnanJfmScKH7/sIxRHJLke8ADUf26oJS9I1cXPgsOPylpZsDbg6uZ5yxuq9kT4nscLY7PgrgrbIu1a/OANhVScb4LBu2nnL7OXkul+ttdPLVbHAD1mY++F/PTunRW7d9kMVzIPhbt2LZqBi7B68KHXtamVpCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522891; c=relaxed/simple;
	bh=cDaY57qKIm9pIDy7cQO/mh31CNZBhQYkCGOhhBSUbv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7FkIH2cwSHPzOSfDacl7rgLDyAADRHRzDNL5OEHEfKeAAZdrALT9F1qQ/THiedlm1bVjGl6CIH1Unp+NnZ3Xr3GQD4Nb59SiCW7o5jiYRUPQ/5XXS++z0Ug8wivQW/QpeVpTNnIC89LSEwbCr+CIzgnlx+oW/O+mP4M03jZw5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F6YyJQzE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zy9yhvzs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F6YyJQzE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zy9yhvzs"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q7ciMF2887117
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 11:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l/Y8amr0VtrBzPYxQ+o9DK37io1izH8toJT61N372kc=; b=F6YyJQzE7+q02wN6
	KXupMiSQh26bfdKkPgK6VlpzarxoN6W7akyix8e5j7ewXh0kbC9LUdEZuc+XETzE
	LLvBHfWVrbw1wlmVyyOIGCbi07lfvJaax+10AcFXultOMhx6F4l7RxhAKmWAWoDi
	FFfeplXtUbPEJ3QqyacEIVzyuG0TT4VELuHxlC6wIkycQ9nLxRR06Gth5EDH54dM
	rNtFeF4to6Oj7XiAYQI0/Po+7ZsvLbKvwOdmBf/9+P7l4z8AQ+mdrI3yKKoGCiWE
	0/T9AE09gQKnrpnvJuUaCYIrABav1zSX6kSTOS0zKZOC0MTHzwCtFJdYtdxCQ2Q/
	GjshFA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d50kg8pv6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 11:01:28 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6000a7ab3e5so32335137.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 04:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774522887; x=1775127687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l/Y8amr0VtrBzPYxQ+o9DK37io1izH8toJT61N372kc=;
        b=Zy9yhvzsCRpbQI6ym/seJn4MsQfdXD05bHRpzL96bhT3VpuBU7rUaxrrFdB0/AGzKH
         K8pFPUuaYnWAuZga7/C93kOoVNhJ85EfgFCra+JalIt4xnEm5UoctyDYjzy9ZL8ozzdG
         q0iIO7275oWeGHU+XR1sByGg8XxYglScCZ7rZorF12SQEkoF4PX1tT4uBwG2nGvIEV9z
         mG5f3is/g3V1BSCkX1hfhWXc7u3YFw9DOkv1IZsRJVrJLJKYodI6A/9lgoc7KofeeioC
         jjlFuT5UgZke1d72aXryumEVlQeHRvLyVjI9ZAZcAtgP1xycfPzye2jYyuzzE/AX/oQp
         gu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774522887; x=1775127687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/Y8amr0VtrBzPYxQ+o9DK37io1izH8toJT61N372kc=;
        b=Rop/bYENupmCBA+nWQ/fkmvgeXGXI/n2Uke6X+YAaMSmajFXHapJ+YH/R7UIx3sC6D
         /+90uYwSF3qnx9TaoXbbuGhvBZL8V1sQ80b7eF142eWbQA271nS0U5cttt5MLEFNo1g6
         EBLxE+LBKZIcKuPyPIbrdXSVw+aal8GExao5+wd9XzCn60d0qVH9kHR+aKG303Dipz6s
         QkpLptfsr4KKTvhXxJlwDWzMNXimF/v1voORk/jvlqjUe3JZx2M1/AKuoeOwv5uU9IlI
         4VUQcTHS4y7Ky2IN5G5h5SUQ4xL3LkFdgyL/vXQmnXGZTZ27zJ47ETpb7gDNYH+vzWs3
         nOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVosh7UWmBMchASCYT39WQ7ermgwd5c/lF4lCSuUdn4QgJvPDXJgix39uOx5PegRWv6WOOUyM7hpys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhpZpyqFvaRm8S6Feb5yFGozYLw+l7u7t8tqmS+6lHJGR3l46+
	ap6wZMgrWkcex8y3ROnudGFdsfhgZfLeVCbRmvzm0cT2PE3FJKz3KwVYqH8+Y/7SHmIppueY9YO
	41pWAaA2F7e9iISeD4it/q5L7ufb/sGwml/oaPYiUeqqzoM5eDbMrBGk/3GWStqzwFEbDMZc=
X-Gm-Gg: ATEYQzx3hgvndmHVzlryzkRtZL4NRu0We/+aZqQoZe/DGPE6DbxnOXvUl0JYBaAnrzC
	jyXCZ7DMQRomQosoRAf4Pv2MqqHJTXaN7/DedIJsq8gyfl3oDSwU+5yPvRm9QsGacJ02+vf1m4Z
	Sfxog3Hg3x02LT/iAKSFA0a95Tpb87mpeK5d7BpUN63Fn10FPPx6WMhw8x6Hi53ZuAvDmSWRF7Q
	j1oSxGKwtmbooZ2T2q2Za+SB7tyv46Dzwx0V9Kf1hZzD0K8Upqfk+1by0RaaT9Dpg0Kzi9WyFPM
	QFOIhf5DwjCus7KZRhWFRDI2tnNK/J74/HSclYxcyEQ6f8tS3/unc75Nagw3KdoIzDcvUA1bwiE
	tG3Nc27qRlhz6WMmsS9Oy/MU4CMW3P3C4bMg/UqQaov3kATE7rx48dGedL9Ln09ZvEKtM9XsnlJ
	uo038=
X-Received: by 2002:a05:6102:2910:b0:604:e850:92cf with SMTP id ada2fe7eead31-604e850937fmr121280137.3.1774522887231;
        Thu, 26 Mar 2026 04:01:27 -0700 (PDT)
X-Received: by 2002:a05:6102:2910:b0:604:e850:92cf with SMTP id ada2fe7eead31-604e850937fmr121241137.3.1774522886657;
        Thu, 26 Mar 2026 04:01:26 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b203c0cffsm103374766b.35.2026.03.26.04.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 04:01:25 -0700 (PDT)
Message-ID: <ed0c8b2f-57c9-49d3-963e-a6d4b6d242fd@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 12:01:22 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: dts: qcom: pm8921: add labels for ADC channels
To: Antony Kurniawan Soemardi <linux@smankusors.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20260326-pm8xxx-xoadc-label-v1-0-027805dad4db@smankusors.com>
 <20260326-pm8xxx-xoadc-label-v1-1-027805dad4db@smankusors.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260326-pm8xxx-xoadc-label-v1-1-027805dad4db@smankusors.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SMZPlevH c=1 sm=1 tr=0 ts=69c51208 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=wxLWbCv9AAAA:8 a=EUspDBNiAAAA:8 a=Ke7W15zrM9QGlUBYRRsA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA3NiBTYWx0ZWRfXwGV5T8TGPAB4
 y7Nr2rN2By7XY4HXY67UKPABcym705cT9cIY1VR6yinpfTUrqAEQ6seMpfyPplyH1FKgOJr7kax
 y8zVHZvKS/FZlr6t3R7+ucci8cSR3hleN86RfZnww9NeD3FdolG6F2+75D7POQrh12ibUx7irLr
 762xc16xM1lrFzuzgmEY0UxuyrVTyOt1EIxaKMHVjnJMqb3ZS2GQiWo8WUC3i7lIJrk3ZFmyDf0
 +09R0Pxrcs8gfZT5NUk4wWU9xJ6E9G8Fh6l+lR38nXFldAD60mm0BFRYE+BZCpbOJj8ehteAfRG
 gGZsMSu9l/zUavSdampTYEsjfbK3CDkGp9C6xtJbJABCwkDFE1Fl+EjsG8tJl6Vu7mfOFpwO+tO
 OPQOd4+lG2Sh9rWb8jzTtY0GPEI1uPUpNt6WZbI58OirJrT7oxNopUpWF9kvWvWAssZIRHQqYob
 /pw8mY6+tHVW5h2IZaA==
X-Proofpoint-GUID: 8SNS5bRqKxpqr65t_YWshEL74vZhIQd_
X-Proofpoint-ORIG-GUID: 8SNS5bRqKxpqr65t_YWshEL74vZhIQd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260076

On 3/25/26 10:02 PM, Antony Kurniawan Soemardi wrote:
> Add label properties to all XOADC ADC channel nodes in the PM8921 PMIC
> device tree. This allows userspace and drivers to identify channels by
> name rather than relying on datasheet name.
> 
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---

I can't find a reference but these look reasonable

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
