Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FBD2F6910
	for <linux-iio@vger.kernel.org>; Fri,  3 Apr 2026 21:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775252879; cv=none; b=VibusoIpOzfNG8H3Ll2W1+quBrUncAhS1CE8NPvSoRVzIXt3Xke1w3QKVAC1snMuSKuQ6jpk6604GJQeGMG23WTKkGVXlZi2MaSG9IHPybUGJBxx2oSlrD+kiQdlc/LhbSF6+LlH8YAAPEAPASUc9DBEymOkzDLKzBvyqxpNlR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775252879; c=relaxed/simple;
	bh=obSRFqphICqgwu5mGB5dOzzmoDIay7Ygz+pA+RIw0tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7nhMxYXEHqlYyyxnLCyhHEaAaoNNOwrm3bihTCejqXQSGGqOb5lCPp62K+ln9bedZQ02nqC90kwMT0QIFgHuZ16MS3KTFXAVfcUzLmjhn8w0rvuywBT5ymPbmllYI2keDX7IOC22084K8n1pnB5PBBygE08ZD8BYxjTtf2OVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NNkJiBdU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EYcI7FYR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NNkJiBdU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EYcI7FYR"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633DVrpt2359561
	for <linux-iio@vger.kernel.org>; Fri, 3 Apr 2026 21:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EmZwj5MaWSd913J5s1DiIbj1
	ZJYGAjg3Ytgz19+VIvo=; b=NNkJiBdUr9k04CqPptP+mgzxkXXxEYBFuZS2c751
	dZ3gHcMzXVdD5udjq/jQbvVgNtwBpDUiUaFZt/zvIdGerjdIz64aoK0GJS5NprEd
	+Q8TJXY4ZWrpIrOIFgDtGMOecVP/0pEdo/oSbpT0FouqdWZp8nGQa/E7Xoipapw3
	MRMeLbbiFr/SnQVbJcPE0NaQmZnHh0SZGKQAJssRtMPBxp7J6sBSElGXMaDSFCgL
	GfGPcJ+KZIzvX1hs2rrAIQwCyb5z490yo6W0H+4bQ4Kim4lQp7TowmPAwd95BRSl
	aIsPDO8kxE9djO49WzfmbgG0mWuVkx0JUz1sIfg3BnbqoQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daeh1h7xp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 03 Apr 2026 21:47:57 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d58bed44aso63274641cf.3
        for <linux-iio@vger.kernel.org>; Fri, 03 Apr 2026 14:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775252877; x=1775857677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EmZwj5MaWSd913J5s1DiIbj1ZJYGAjg3Ytgz19+VIvo=;
        b=EYcI7FYRVnJJMY74rEZB14rWAg3gip3DhiJb6U/BJV1a8s7lvAHdtrQYGfMc7WpeS8
         qVpOkn8xsG4Q+QpRbm9bYOIB1gWayJJenclAZ78cqmzgH6lCWCiaoqOZ7Wfi1Co2yxoA
         hlfOttKM44kwIM8T0H14hOqPwrWT09+WDdNLNBKdx+QE6w5NUDBAfYLkUAo7a1O3cDHh
         dYUh/syEpiRKnjduh4QLoKmzsTyvNFymdFXQ28YU0x50kgfGQ7b3qzmNiXMXcPuAuA4D
         a7EX2dkg8gg3Us+T+2lQuyJFwzff894zTuhPNNfkUX+nZcOmLN4iEAGIG0iyDa2uiQFd
         lkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775252877; x=1775857677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmZwj5MaWSd913J5s1DiIbj1ZJYGAjg3Ytgz19+VIvo=;
        b=ci8FJLgudjcaAbhC2Be9nM4zycX0P6jadUFn4pi3LUsgyXYzkHv5dJbgCaIQ/RRi+B
         IrlCtM96OfP6QeauRodIO/MPA0OZKwfo7/z21gWj1aAvfZZT3KpmQvn2rzlikY1wB+yf
         rBh6AZh0K/qhYe5JdLuMzmIpp2Xx8Fmug/0QKfso7eTNSjGmweoAT3MnZRw2SfpjdyIZ
         LVGl4jteGC2SRzL3Q74mJU0UV1xlHnvP7P1muK1XhIittaqG0gachMLzhAyUBKGoS185
         1C9E7HiCvqcq5+RiHtkEQi/XXHPcQscP99lO5i1o0AJeFGUmIVLFr8tnJmyTNER99OXw
         CT5g==
X-Forwarded-Encrypted: i=1; AJvYcCXC0ax9LjaRR1WFSQoZmXdEbmTyWLvXNbRY7ML8igp7afsYGx8efTlAA/sbOwZE1akBKjbqt61Ok0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtm23Nr68wk9IZW6d465RJDuaMzfdrHeJkl7UozakBCd92HH1Y
	I5srndGzgl8SfFhYDIZ6O+Z34Yd+Kqh4bxUZMCZHKGsVtMEcPhuP42cjdVleHscI0Fu5A/KOs7v
	95py/sanvvd2f8Wu2bIyeQ/YEMawfEJ3wt+ipGU9M9k88BV7SdRM0WsB1gGO/MQ0=
X-Gm-Gg: ATEYQzxRIt216cZW744PAXgSefRvjngKqN2YuCNiIBRH+Rog3c+pL2EoDhc8g+qKCoj
	DhOayfFLac9V8QnAY4A6+sKwJigPelGtM22lFCWxrPIc6peUHm0jm8DyRYfTF3KPVPx906PIBjm
	GM9TSL3AwvDpMjXEyc6jVBKn9c2FRGqTfmAN/Kx+6v63UbcSU9QGIiVPeo84xFrtcLUccZ9ip6c
	WKLnJkWFvuM7ZpKzm5yge7Cjlc4yvtbsLDzwqx+Z8W8eCLr5rFkpT5gdyXwByJbMw1u1uL9Z3GA
	aLhNJIZn4Z2I7J8HlUe8DUWqB5EHVQUJaNNbkoATkuZ4sjqGw5aKPw3FRALveqBC7ev1i9CMufp
	07G+jZQYNTckXvG4sBgC8kbaiqtyZrvNvCoRjeapzSKd7irCD8SEXeSY7jbo2zs39kiAHwLMVjl
	tvYebI3RjG+e1uxNUkUk331rEonyOatUadCUw=
X-Received: by 2002:a05:622a:11c4:b0:50b:1adf:89ba with SMTP id d75a77b69052e-50d62a7f2bamr66782671cf.40.1775252876674;
        Fri, 03 Apr 2026 14:47:56 -0700 (PDT)
X-Received: by 2002:a05:622a:11c4:b0:50b:1adf:89ba with SMTP id d75a77b69052e-50d62a7f2bamr66782381cf.40.1775252876146;
        Fri, 03 Apr 2026 14:47:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38cd2187070sm14998261fa.42.2026.04.03.14.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 14:47:55 -0700 (PDT)
Date: Sat, 4 Apr 2026 00:47:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: qcom: pm8921: add labels for ADC
 channels
Message-ID: <43agfdcud77ifh5oxkrzkxb5dcybja6bw5f4bxd3ebdjjrni4v@xc7rhornw4fh>
References: <20260403-pm8xxx-xoadc-label-v2-0-29b50bf821e6@smankusors.com>
 <20260403-pm8xxx-xoadc-label-v2-1-29b50bf821e6@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-pm8xxx-xoadc-label-v2-1-29b50bf821e6@smankusors.com>
X-Proofpoint-GUID: fwBdTwvuMh8PQYqY2GKeBfwh-w50hLxU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE5NSBTYWx0ZWRfX2QVl/DKsXXRh
 QMEevXDiM/3T6s+BsGO2aOaNMmDp4e5NJ8d7kfN4WKc6LAlgyDT2b26/Oe0z5Zux9Jm74m6BCbn
 SlTQCz8qVMYRJL0yFn8vCxsqClpEsRs/G+8zUsVUWkz81xic3UetcnVQbLVC77dRbImnE6mqq7B
 8sgrAs4dmhSTUA8rFwb5UK5zzg3/sJnIQwmGdPncwVpSYHsz22F81mEhJo0H85/ezU24cDHKt3h
 E2SFa8M76T97NvmFg6zGixViOgK9qcmbZD4QsA870zEtyLi7bbLjbl+v3NECuUcaa/I2ZKaO/Sc
 CSb6W1QZb/NJZh25GjfvJ7aajp3EqL0j0ol4sQpGr0xrptC2DSzsVMueL9ywAnw+a6UMn83M6o0
 j5MXPmtfB0wAnhACPmcFFYg7iHS1wz7gd5bdsIiLspZifQ+onPNqUJPoN0fjAHgTOm95eVuf6LV
 qVNPhg6KKItYq0lva4Q==
X-Proofpoint-ORIG-GUID: fwBdTwvuMh8PQYqY2GKeBfwh-w50hLxU
X-Authority-Analysis: v=2.4 cv=JoT8bc4C c=1 sm=1 tr=0 ts=69d0358d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=wxLWbCv9AAAA:8 a=Ke7W15zrM9QGlUBYRRsA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604030195

On Fri, Apr 03, 2026 at 09:23:14AM +0000, Antony Kurniawan Soemardi wrote:
> Add label properties to all XOADC ADC channel nodes in the PM8921 PMIC
> device tree. This allows userspace and drivers to identify channels by
> name rather than relying on datasheet name.
> 
> Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
>  arch/arm/boot/dts/qcom/pm8921.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
