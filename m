Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FDA382299
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425438; cv=none; b=cvhPUhpyR/f0IRl/eJU6ZvWSQy/E48xI6fUPO1A5Gc35aGRb/p8PsmHYT8atrSIa675LigZRMptnkEoifr7kOun13HmQJbIzyp4dMKUHovCIsAy7GSI1d0haQrrhn0D0r+FTmujG4xUBobwnvLf05CSNViBHeI7JvsiDLfGkZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425438; c=relaxed/simple;
	bh=yvRA6+RhpqKbBpG7vuhCaw8flA1Rlh5NgzfC5O25f+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1Pfb5HGnEjZQTywEnYnYY1WQanQ28Q2wCcur9KmNkpGgizFO9K8UE9WmGwZhUELqB3cUV+zHAoj01LGYH5bOepRXTuKBbzFNmo0iAzQ9slN7ln34ETgjqEs5GFdrTnr+RbwcBYvVT1Sl0eFbl0L5Xs5hSqIzTZaYmKfmAAVlQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nx9e6pA5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QE5w1MOR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nx9e6pA5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QE5w1MOR"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835lh5b079934
	for <linux-iio@vger.kernel.org>; Thu, 3 Sep 2026 08:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	61ALK7PnCM34Vxnk/ZtnoDcsbGV97BxWP36hX11Z9IM=; b=Nx9e6pA5Lf9U0cjf
	02ESwiiizuR3tzGVYi1FxMJ3vSW7c95Z32Wk5jvxhM++h2xlKT8MciY8HqsDQS4D
	uMvbyvB5+dw1G2bDYO5w+q4u9cQL1tBh9muvPJV1WX2aGWL4MsyzIZqpnXKIvAFb
	Pd982xeucypNlYMW5fzturDSj5SAMzxPQbdUOch989M4XSuDqG8BMfaeVSqDIzOf
	VdVBldJvfPSPCexq77YCE/sNsIwh27y+SSM2xkoiNMN99287XZdekqgyRCMS/0ev
	ozxqPFgKmomtMxFp0q4vrGeby7S0pwLI4ST/IK/d7MkeJKCGq/iSubyOXWP4S+KX
	o3NvVA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1j4h1kp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 03 Sep 2026 08:50:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92eebb130dcso51373485a.1
        for <linux-iio@vger.kernel.org>; Thu, 03 Sep 2026 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788425436; x=1789030236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=61ALK7PnCM34Vxnk/ZtnoDcsbGV97BxWP36hX11Z9IM=;
        b=QE5w1MOR0OF+mWTGiooj81jasZtrTv8KbV+QSGZaK2Jw6hbyG2Ys/9qr4fV1z24ujr
         9Wo6z1FTdgG/w5KJJLLsh6PFNxxcdQUSDvptuBf9ZCFvQry5dKRHv/M47VrD3I3Z4el8
         AljNMtPzQyY7rHm2fyPn7xe/YmdJy/UPPPDfjZ0m0WCZiF45Ld/IlsZC+Hcy9JsvsxXT
         BdW71z5+H7mvAL0izYaw0V2SHV0lHuMyEskqa6jnpearRpC+D0GeGP5/kEn/2X9PqQPo
         VtnvnwFaHqSfOL0uhqfAejUspmGCHobxKmA2SfcmtA36cz4VfoO1MOD3po2UIeAkFu5X
         SzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788425436; x=1789030236;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=61ALK7PnCM34Vxnk/ZtnoDcsbGV97BxWP36hX11Z9IM=;
        b=qvIJ7nr1KpfbsM+0CnjwpP2rlIb16GYsRlpWgxqm9V2FhMyjYUTgWBiLNe87IytdWA
         RShhGl/nqxHR6i3qenC9oJ/D4mPvtu361iRDkecR1dEkpcNHJimlFncZ57bOzeDQC6Za
         xFDskhkMcG0zMBddCanNZQepP3hhLqndFtYWKBwUKTmFs0SBnFcOXa+sybNIi7wQ3+No
         EnnoJvEaGSOVxD1zWTIp8yHWb52F7rlLDZbSMmKhzsbjgrlpHR2vPX/9gDIz4Ztzrawf
         KhynbcLClYOWEf+WdbVLiuEKo1hrFSGwcMPDcA8h/lIb87gVMesZNkV/jBceTqJcL7t4
         Fe5g==
X-Gm-Message-State: AFuF++nNkTuQoW38iD6u5PIOk9ePU/l6Hk0G/bd8332hXmsWkI9AEMus
	fGKm7vzi+y5nHCfbmWBgGp+i3DzVw4PBKMA+kLlkWXSxGh1L6QkdXGuwexEzFHrjqvoDKOo7AVO
	+PLqPafQxwVLHUGDm8j332SJ+TSZhHZNUPI9E9unMQRTpKAyoC2anZpXmeZAbMi4=
X-Gm-Gg: AYBFou0mA3SLyMdx7jehvrIHzYVUGdm+N1Bs1Tar/D0URNjOVrZfrX/y3b0Bj9sTBDF
	8j75Ice+iTvLrFBum6YErS5ynJ2EiJQxGJcIDuQ8CKt+W2ooo9Daj80e5d1faMX3ycSAHvsytL3
	inw6RWDLTjZ2p8HUfTuFUHRI214HJEkYjPLOukUq2/cgGZzlR7y7heqDCfAjVRlMXs2o97eA/NL
	LxQXHX6cqVZldCfufEWUC6KePUkyzyeQeULW2SyzxuA8GBaGFAFr8MveQCw+ryAoZ1TNqeHcRhy
	gtiwgO3qH57ah7kghDt+FP07UKXkk3fwXbVtf21nyrB5XU6MYN+ISqgYO3tEcOdpcSccblM6H7G
	XSLK86YfEkNtb2dMOp14epg==
X-Received: by 2002:a05:620a:2704:b0:939:288a:8a0c with SMTP id af79cd13be357-939610b5598mr738046285a.6.1788425435813;
        Thu, 03 Sep 2026 01:50:35 -0700 (PDT)
X-Received: by 2002:a05:620a:2704:b0:939:288a:8a0c with SMTP id af79cd13be357-939610b5598mr738043485a.6.1788425435305;
        Thu, 03 Sep 2026 01:50:35 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f41733b2sm67614866b.17.2026.09.03.01.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 01:50:34 -0700 (PDT)
Message-ID: <6ffd13db-1ca0-4497-9ad6-fdb65b001dbf@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 10:50:29 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: qcom: kaanapali: Add ADC support for
 Kaanapali boards
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-7-9c49b2eea6f9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260731-pmic5_gen4_adc-v1-7-9c49b2eea6f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dufrzVg4 c=1 sm=1 tr=0 ts=6a9934dc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=T6yAfy7FHkEd-x0P2_YA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 4WHe9MMqha9yw8Yh-e12XL3rHKAR2HV2
X-Proofpoint-ORIG-GUID: 4WHe9MMqha9yw8Yh-e12XL3rHKAR2HV2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3NSBTYWx0ZWRfXw+R23AriwXMO
 CEbBzqlg4YGhbrxh8UXUstBfACJlZ1ralmtyM16sJk7x1syOpzt1gNj82H7TUk/lujhDAhGgIb6
 IH0C2NQfZzS4psZM/u9CUAHa2E13FDg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3NSBTYWx0ZWRfX2APWeO8nMk3D
 k5s/91ZhkykKZ1+MqmMdwIOzUWlBCzX0uHlHyLB8ir71/SIQUIVlZCZ0PU+ngBd6jQ9aKcm9uAB
 MZRIqQCXTIMPUpDNOFGuTOVQOSl1in484RWXvHt0paNMHKunxYuu5cAh6QGPYUAeDw533JKdpme
 aCBG8N/rQtXbe2p8YqfEAof3bETmXurw4IDiCIPkd2g5eswkG3OI8vsC3BGT7y1DllxRc0nrsB8
 cg9EmO6oc8rfZXLK5g06gVv+SjqzT8iudOy0yCLAd9WWEo1UZM+nqtk19DPCX/3vwwcowUZfDF0
 rHkEsUukjvYoreerZswqL9Bhz7dgYTEzvTIDTDNwPXO2xuEzv6wzft1jVOTZtljm8AjV+pIIVCV
 5nC2IAmd3G1hfcpXsmW05YhVvJeqiNsDuHTDTCHSJ3eggxCF/08uxGoxmcjbfDBuXEutgX+veZK
 MOMCBJOsVICfmnkz3Ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030075

On 7/31/26 8:06 PM, Jishnu Prakash wrote:
> Add the ADC channels under the PMK8850 ADC node for the
> other PMICS on the board with ADC peripherals. This includes
> die temperature and VPH power channels per PMIC and channels
> for available system thermistors.

[...]

> +		sys-0-thermal {

likewise - sys-n-thermal is unnecessarily cryptic

Konrad
