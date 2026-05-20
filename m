Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8E03F4DDA
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290431; cv=none; b=pcRI32oBVrk3z3A1mXHHjbv1mbVxhIUq09kiuAvo6SnltsT3wj+OPjdrV+BQyqFKF9+HrX2gHAhTHQ4Y42/pHE95xO+R7Rd07i6lcGzTUvECtkADm8rVzA3bNuLmU44s27Hr9P+lTlEaFb9roZg55FeVL1pBAo0289FWX6HqqYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290431; c=relaxed/simple;
	bh=w/o8ALu3JhTui62UkO3C0AbOHfMtZJQPDhlfOzkGK7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X90W4uTEyq8nspwcG1DyrrPPxw0SgnBiVMq9t4k+/EkLk9XDbYZOx25+KeiC5UBpzZcge9/AT3wKlrYv/yqzeB9T0Fi+jZwJnzIPrUsVqQS1SaAs7gUKdhOSOMXG4iARh7c2oLkM7aq/ZLWXi7XjpQY+RUEibu5z4CPc4kep7xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gTcRUO9W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZLhPebip; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gTcRUO9W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZLhPebip"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDuT5A3680300
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 15:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mT+rMK4/HIfny/f0nd19A06TzmRHuaqZ9n+4gyyLAbs=; b=gTcRUO9WY7w9IHBq
	auVNP/PWNdAhI1JDrkGv+puTAs9PpXorZN5RUNjQianQ+YdeNO9TPyIYz3MJOgFV
	BJZxcKBPEFEP8pV4XQBpE7ekshDVFiMq2IS64bgxSKRWTKfIoS9o0tcTVAfLiLgr
	JaKdxj66r0t9f3rq3IRi0qxDJdvsXgQMCUmEUMxG207XAp0YNIi1NXUwif7nY/lL
	YAXoqYIdamdvViB08Xcsym8Xirj+eU2qHCV4tLlzn6/1fOHqY9jxFtEObzv4lID2
	VyFkjXCFJfZXGof0gXW8NdQvny8aKTr03A5j7WPxsmKfVLKyLoEpeHSbPilHoA4V
	lbMoBg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j0cp9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 15:20:29 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-482884a9ddaso12414618b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779290428; x=1779895228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mT+rMK4/HIfny/f0nd19A06TzmRHuaqZ9n+4gyyLAbs=;
        b=ZLhPebipYPdVlkuDc3nYuv3uxf1Wni2t9WWXfxybT0KjbIEC57xO9KWc3TPLvDPEqZ
         qCCpI1DJO7edlMFhtNORdxBmBRwhDlqgm1bsp7A7Lf1pfZzptICgI4S3QeucLIyYd3FY
         XV/oMJjIPKiY6wEIxk4qC2imyQB7lEdwAYWScFEy4Z+930MZV93uJWa+jX4nr7ORduHl
         WSP1QagFejztilRtRYcKIRhS9EVybfXSwevYInIYyyJoJasKi40wo4lNgjWyTsKWALAC
         Ju/0Yfrh4CuZ9xg3ERqWO8DuIUH3bFPZELcsiZGtSNvQvEsa4d/RvbJTvQyqxWP+HVWr
         ZPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290428; x=1779895228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mT+rMK4/HIfny/f0nd19A06TzmRHuaqZ9n+4gyyLAbs=;
        b=suW5duv3bnZh8bEwjT4Up2gcj9rpqySN8rrYBFQtYaeBzVyreNOT30jbA0ibIi4LGz
         bq4Yi41v0dT+nuhQXe++PFss7D3hBFzoT1kKjOID/fkyTtfYZ3xdagUGxZAIxQshDrL0
         pB2iCPhDn8PMy8obpTH/wtAnzN41bS5qD7zOtpY/yccWIDoHa6XXXukPsUhlOmCcqhnI
         ngOmcaymi67RqqQTBWGpDL4GCBHcGpfloUoUhAvn4D2C6xrJ68q8zpl+JFg3+T+ZtM6o
         3UrGYUcF/9KTc6gwdAqmTTrAEw1tKXQnFNVa2wdz8YjppK0da1FdF+QZj0dV6u7J+opw
         m1uQ==
X-Forwarded-Encrypted: i=1; AFNElJ+56vveBt8UmyosQAUVV/zYeEeg5Mk4wQEnDKzCR9AsEPCPiwx430LK4bUOOIaOTnPJJpk3PwULqQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOM9y9OpDSqK7/Q9Cmx/9ng2cdTP2ZuCHptvu4otDzi4Yi80ut
	/Ll03FaeRuNd7PhV/N7ZQH2H7u/o5vaOAfhpY7i5dEV+9ejJYIuxndzl87GzRoi8l4JeMGAfIj0
	nIhQqrxZzmgRMQtYrp1cOcQ2NOAaiAkYJ6aVRpy9c6W2jK6xQdJqr8B8rE6nXSgM=
X-Gm-Gg: Acq92OG65rDu5LAsPAXrKV6hZyYcCQsT7a2Ex6yvqcE9gOGDArw+843TJGp4GBph8yN
	FWuzR6KW6X/jqIfDLL80tCFPcvkE21BMaxP3QTLs6mvJDdsWqF2tqkkC2inm83MWz1VS7I76q88
	ZVmdxLVf2AzRdnXzn6oUPYc/5zdsPRsGYKLYhpoL0kh9csyV3751X5K0pTQsSTNzahGk/SLtc67
	wkbZfmglgnnaUOOmcFmVX/S7RknEoVET63rbmtETANoUusJ/PJnkslthtJTdvvXDVCcx91PWTlo
	EdyyTPleE5OPyiC2qoHnVHDyo3HW475+cbXQ1xjS5PeP/x8awykr1uq7KWoRW1JGR3gwtrwgPoh
	Ir7zhhmkyQwcqSY/3n+9zPpUg/dISgo0EwzZbCQnBWkD5ZIMEbfSGBDBFkNqPAjEO5/2V3HP/IT
	iMSiCg+s/Q0ncx5aypm9o=
X-Received: by 2002:a05:6808:2388:b0:479:d779:353e with SMTP id 5614622812f47-482e57c9a13mr17237435b6e.24.1779290428308;
        Wed, 20 May 2026 08:20:28 -0700 (PDT)
X-Received: by 2002:a05:6808:2388:b0:479:d779:353e with SMTP id 5614622812f47-482e57c9a13mr17237386b6e.24.1779290427794;
        Wed, 20 May 2026 08:20:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ed59:2b99:54ea:b713? ([2a05:6e02:1041:c10:ed59:2b99:54ea:b713])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c62dsm230047695e9.11.2026.05.20.08.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 08:20:26 -0700 (PDT)
Message-ID: <4d2cba0c-6418-4bb6-91e9-9730ad4d692f@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:20:25 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ with
 ADC_TM auxiliary driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260515-gen3_adc_tm-v1-0-39ba29f9b4ab@oss.qualcomm.com>
 <20260515-gen3_adc_tm-v1-1-39ba29f9b4ab@oss.qualcomm.com>
 <aglpVX2NeQ8jxN6Y@ashevche-desk.local>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <aglpVX2NeQ8jxN6Y@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0dd13d cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=-F_JFAN9hT3LZsc5xrMA:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: DoEHkqzRTqs7U8ujCMyKGGmFZY8ZCtJQ
X-Proofpoint-ORIG-GUID: DoEHkqzRTqs7U8ujCMyKGGmFZY8ZCtJQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0OCBTYWx0ZWRfX4+hrzJfK+bjh
 ycavfOtAwn6RMKjT3i4rrZ2Xvpdc8FiwLHm7mj9cj+bKILCpttpfxHEgYALLJzMlWIuTmppkVVZ
 nukvM9Y4ysbxa3fnlXSJs1nrFnDEDHWRVXdnjEGXrMTfk0EBoF6W7WRF9opUCremCiGIJujFeC4
 UEd10wGPLP9iOmK1gd4hCMPo2zGAVQhJZOgXVbcwyFtHWqp4p5B185Ecw8tiQ5PJAzzz0rbPFoT
 59/Y51Z6IG1U1Rxmo27LENj87kiCBwMZRemQWMD/JxrigYpDleZQQZu14dQPepey/UVqsAqrCxK
 Y82zxEehDZo656Lw6+Y8lvTPiclLTa7MoPSp672tzG5tva+5WjH+39bR8iPfJVtFhU4labXeKTm
 yYx2cYsjXYhqmEj0MS9D4spfxAD+H/8twxMXAeLh3NAyUl/9Hiyt9Ah+an67nybhImShNNOyWXi
 et16k+S1ZnjZ8YYtktg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200148

Hi Andy,

On 5/17/26 09:08, Andy Shevchenko wrote:
> On Fri, May 15, 2026 at 02:23:44PM +0530, Jishnu Prakash wrote:
>> The SDAM0 IRQ can be triggered for both EOC (end of conversion) events for
>> immediate ADC reads done in this driver and for threshold violation events,
>> based on ADC_TM thresholds configured from the auxiliary ADC_TM driver on
>> TM channels on the first SDAM.
>>
>> At present, this interrupt is handled only in the ISR in the main ADC driver.
>> When the ISR is triggered for an ADC_TM event, this driver notifies the ADC_TM
>> driver by calling a notifier callback exposed from it for this purpose.
>>
>> To simplify the interrupt handling in both drivers, share the interrupt between
>> the drivers. With this, ADC_TM interrupts on SDAM0 will be handled directly in
> 
> "will"?! Do you mean this patch deliberately breaks the working setups?

No, the interrupt is definitively shared between the iio and the thermal 
sensor. So when submitting the previous series, all IIO patches were 
picked up but I asked Jishnu to revisit the interrupt handling in order 
to make it shared. That is what he did here by reworking the ISR in the 
IIO and resending the thermal sensor I did not pick for this reason before.

This patch does not break working setups.
