Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791183F9284
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926858; cv=none; b=u5X7f/3BhEKDIQNtljIJX9sT/+hcp3PoyCzx5iOXtaiETRr0qks+HxZgsmPu37N5EukOe9SeZjmkisdwaXqcMH69lhOWCDKI/dyEVfbjlPY3Gj6ZHWAuRmkNxjFExlfWCdLAm5fVfDGQ1tR7KuYdZFrIoqHu0k/ravnJnutfhF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926858; c=relaxed/simple;
	bh=/PWgap84eb3PT1vleRSyOWs+iiOmgUCOw0Xq2cxMshQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uF+1ZvmNHgs8xLiKDfI8gNvjLZ3mB4xrh02ZmFWTiNkoV4hZeoIVuOoGKva0LUQy7xZwBbitVSY7a1fU4DQ6yNSwuSjyFOu6BWICCOA/B54xxpkg3XmP1EXWei67WRFYpC7wR1OKvB72dmuLL8OS9lUxfezILVkHkKf7qBGR+8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UmftY71P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QyL1iTdB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UmftY71P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QyL1iTdB"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758dZVx1713207
	for <linux-iio@vger.kernel.org>; Wed, 5 Aug 2026 10:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ss/eK8cGELilAVeOlfILSBb56cf4qKwKczaCfskWD/I=; b=UmftY71PWWRdkCSl
	QPyRRH/qp7st/mTNnUr8FAnvF3jXeE1cbfAEyoeOwmecjSMEmNWB7TK5WgAsxk0+
	096stGNpyiNK3eOUjpudoCBrEuxdBiNmz0zUICEhAUBtPjjWSuLjXhgddh2NyUvs
	rhQ2u86OQHBuic9PqdmWJ5QcH/afH4/fipUTui0+g0KvGWzM4dpvwtePQTc4msQ8
	xYNYXkpfyMo8B6K5VMwZhP1X9czdI64dcY+AdNkG7q6/zWZYX7I8UEkpUZ7UhSyV
	KBH/nyUHEccPOVu/Ku3hU+T4jJVcIUFddxqeE0s/Y1/r3kLu9BCoFFFvttcgBQuq
	tL4JHQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuwbqsqrx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 10:47:36 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb4bd11ddf8so889234a12.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785926856; x=1786531656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ss/eK8cGELilAVeOlfILSBb56cf4qKwKczaCfskWD/I=;
        b=QyL1iTdB03C/3h5X/Og84we0DVfqVtmeHajEnzLNy2DfBUtg6D/t3AJYTYPCHg7ZKc
         usEhxnNl54A0MhdNRkJC5UsiPM2ABoF4XPQgNeOm+9cmP3HzLIScl9xLqzMiOFS3zUXB
         kLlW1fwZSHjK45Jr5B7y5oiyxJIJWcn2BByn8B136hnnI7ln0zoYoHqCZXooFeGOEB3f
         09mt9LrZo28wwOgum25inoIpp199MMZTS/W57LFBtJ57J7hRmvai3ljFzFnbTkL1Lrnv
         HmbMY2pIzC+TdIU3e5CHsYIxLb4dhMtjiwSL+PItKy7z/0haL196dnEHuDIWOr+g3efy
         5t3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785926856; x=1786531656;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ss/eK8cGELilAVeOlfILSBb56cf4qKwKczaCfskWD/I=;
        b=cCodS5UJPbPS0Yi57qoEHl1oPDhfgjJf+hHGwAJbaHUC088QTmlCAHtFq/XL5PVsvV
         IHWjX0UGaZlyAHhzvS2spE5ICAVfZQdKyaQi7eXYQgx6b8XCwnXf625D0iTYxiu1wRAr
         QDnyQOHRjJkYQlxwAC7xru8KGOZKlwlEfgR1xak5a9vVVamvmXMgHdkw4IUIvIbKkKf2
         2mPIdU05tkDDX2jUZpEEhtSUPIHmIc1qLJJCrdwmvhevGio2RFrW3MGFBBsWY/6BcZiW
         sQZyC7fTJzJnN4+c/JbhKeKPOlD5o6hP1dl1deQYBJYqwKQLdIk+72Sf6CXGybLU/2pF
         OFkA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9FjM0UO/gpGopHwmtB60tJqQlj4ztHBywY0iFinNQhTLngM4z55yZiwc8Gh/JlNU/XDpi4KZtImU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwmzMBKNYanW7WdTyXLSRfVMkniCJ4u1+CzgrKcN97Uzo4JeH
	bUYLqEhtS3NN9l3MV1i7ldhczYb3yAglPA3YOz2BdY3/V5EEGTNQGcuUYzvLX0JcZ5He3xZSGVD
	qsC1VQE8ukTrt5Y3fA+jTtkUDT+obVEaw0g2nfAyY36IUPdV1Dw48NyyAjWeJfjM=
X-Gm-Gg: AR+sD10FC7PpRvpYzqghHnuBlvlG/5CY0BcPlac9dy+Elfp8zt0RDqjsxj3QsfVTW8k
	uZJcYvygcRgH4OAEVDZHIwXv2R3+mI62j19KRdFXe8ozUoLfnd62OmI/qppMUA+qLMB0GQOMM66
	F8h+AIIT0sZTg/V7JFI+T8hJNinmxkFxlFS5FxuW4lsIcNR40F6ITOVrNYJwfGzsW0w1XL8a+C9
	ENo9ieVBkNKd4njKTicspH2XF/icyAK4cbGyJqNClvgdDFot1DzSyVkmyFtvytXNb0ZHhyBDlY3
	yLm9u95kWVaeimZ/C9zKGAYiXWYqJQrYCGKI5KYihRuXuklNu+3Olix/TmwedQViV+vCKDBVa2I
	17goPfax6LGq80LYc3HANtAGelaiDquH1
X-Received: by 2002:a05:6a21:4685:b0:3c0:b766:74f4 with SMTP id adf61e73a8af0-3cb85f4a279mr6962689637.31.1785926855967;
        Wed, 05 Aug 2026 03:47:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:4685:b0:3c0:b766:74f4 with SMTP id adf61e73a8af0-3cb85f4a279mr6961166637.31.1785926842212;
        Wed, 05 Aug 2026 03:47:22 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe707c9970sm1315488a12.6.2026.08.05.03.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 03:47:21 -0700 (PDT)
Message-ID: <06c37244-d589-4867-a189-efdb300bbce1@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 16:17:14 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
 <20260722-gen3_adc_tm-v4-3-011981f756c8@oss.qualcomm.com>
 <a68078d9-9b80-48af-808c-af24d97268c0@oss.qualcomm.com>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <a68078d9-9b80-48af-808c-af24d97268c0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: I3i_8-kpMkbR3XpE5SQXuDdkTebGRIh0
X-Authority-Analysis: v=2.4 cv=B+uJFutM c=1 sm=1 tr=0 ts=6a7314c8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=y6G8bwdjvvgfd2dEMfwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: I3i_8-kpMkbR3XpE5SQXuDdkTebGRIh0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX7/D5AjJIMs+b
 TrnFbJXBNSO4N2IUwgzo5Dlgm5o0FPt68DPsfkh27+vhxh97tXIxxeON3a+PagGGiJfxJKhtDxI
 8BhNIDKNiSXwBhIBDhEAE7g7csdvyt0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX4OrqHwovu9Bw
 rNnyfL01pD3CiXa8Z/OLEqnaFwaYqJxrGfXTrxmL8uDGUll/1s/o/hzbRViEuXoOtJmwar0300G
 BCMa9LLGSAykcyIKYaYnAQljmrQ5O9K3YlqiyxvlTtiQCrJwVoxVwy2+Fs9uAqB0nZRQLb3U2wP
 c2TIxG+/LzIVu9OU+fMGPEgloEO4nlTPClIC+uaG4hCNqQ3SYtzrC/eZUv0E3v+fwrp0mkpTnmE
 teG8R9ujXtqLN7odkLSx4SL96eJeEFjVKkbHk5mSyyA7ufp8fGNsGQW+Xt2R3IVlfma7cleagbM
 F2fpmxeSCUc9iD0PdfLXQWkG/e3nRVcq7iyD3QQMe3eu1o0afo9MK/P2BbzIKQkRjNEU6k7Cosb
 WNn0Au5k2c5GshsHlG5yGfYAN8OM8qGXgTllZjpN4/Q2hva282QTbkcD7Yy16wu/IuTt+HBxPSP
 6j4E4WKOoC+g2eoivWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

On 7/27/2026 9:13 PM, Daniel Lezcano wrote:
> 
> Hi,
> 
> Andy ? Are fine with these changes ?
> 

Hi Andy,

I have addressed all your V3 comments in this V4 patch.
Can you please check and confirm if it looks fine to you ?

Thanks,
Jishnu

> 
> 
> On 7/22/26 13:26, Jishnu Prakash wrote:
>> Add support for ADC_TM part of PMIC5 Gen3 in an auxiliary driver
>> under the Gen3 ADC driver. Its functionality is similar to that of
>> PMIC5 Gen2 ADC_TM, which implements the threshold setting and
>> interrupt generating functions, used to support thermal trip points.
>>
>> In Gen3 ADC, the register interface is implemented on one or more SDAM
>> (Shared Direct Access Memory) peripherals instead of dedicated ADC
>> peripherals. Each ADC SDAM has eight channels which can be configured
>> for either immediate reads (main ADC driver's functionality) or ADC_TM
>> reads. By convention, the first channel of the first ADC SDAM is reserved
>> for all immediate reads and remaining channels across all SDAMs are used
>> for ADC_TM functionality.
>>
>> On the first SDAM, the interrupt line and configuration registers are
>> shared between the main ADC and auxiliary ADC_TM drivers. Access to the
>> registers is protected through a mutex shared between the drivers. The
>> ADC_TM driver accesses this mutex and some other functions shared from
>> the main driver (like adc5_gen3_get_scaled_reading() for immediate channel
>> reads in the .get_temp() callback) through APIs exported into a shared
>> namespace.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---
>>   drivers/thermal/qcom/Kconfig                  |   9 +
>>   drivers/thermal/qcom/Makefile                 |   1 +
>>   drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 434 ++++++++++++++++++++++++++
>>   3 files changed, 444 insertions(+)
>>
