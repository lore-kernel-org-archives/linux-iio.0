Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E53F3D6493
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383734; cv=none; b=muidILKWvPt+OM2S0m+xcYcix3iqWVDlptQuY94XEn2LMUSfD0FEFq81NlEe7MWzaTyWsZ5m3a5tZm8EqcibH3SC2oupKBN62crMXL/hNj56r/UC/5NF8WlwtlAwkf3b3FIjiYAVK5efLlQ7TXC1rb/J99PjlIqmuSHS6nWBV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383734; c=relaxed/simple;
	bh=OP8/OArL2cMmvjrS2BcXJQ+YVC6QxtE/6FgIyIpyXfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njfuMFGavrp1R/SLRr63rmvWuAiqsD/CktGSHiX6qPywiISjLbuEphDwqPuQeIVn3QWSRB6CJJu2kTqpKmECEmcsKN0bFLHcBGtLtBK1qQE4R2IWdhUIW8UFrN9TaLzFgjwSYIgWboOjcp56v1TtKbWeGnkE8+jo0s2mEV3q+5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M65YF92D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GutH41bn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M65YF92D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GutH41bn"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616B2v5T2939295
	for <linux-iio@vger.kernel.org>; Fri, 6 Feb 2026 13:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HmNmeyWa+J7dZZyEeSg9GnKnpszfkH8n3cTwO4E6RzI=; b=M65YF92DxN324jlJ
	W7osZxwxct4DPC6cKtRVM6kQS8dSFdHbySHsE5Xn0MOQoVcmeSMdyI1oeE02vCxR
	6JmADaxuUkK/uESgT0AqQ/Zthyzagr1LJvH9yiQXMmgBThDRiB/X8BjM1bOblo/B
	ZNSgXWVwE3AqQdJM8DAIBo1jBAQGLiROvIYdCcNG64uTSJpns6hOnA9/iCa/4GTu
	svURhO7ODgvTRuw7LGhSIaTmQi4O/g+lThjWlDwCHTu88ZPCa57qXUtmI04I74IK
	8E8QVm94ZHqMh5GvbGddgtpr+gB8CNfZrpwHwBhY55PB11Hfia5FJ8jjCJ/DhxK9
	3qXOvQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5f35rbnq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 13:15:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a92a3f5de9so13722285ad.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 05:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770383733; x=1770988533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmNmeyWa+J7dZZyEeSg9GnKnpszfkH8n3cTwO4E6RzI=;
        b=GutH41bn89hK79mQ9R+vWJOwHsRzWVeBG8eXccqsXuryRZSjMCysTbVS3YI8r+nf9Z
         ISQJ+VnhRcWIyXh4KWDr/vvIOqn2z5YJzJFTwDKqGo3x6R7InF/P6g6M3ZiW2zEp7ydK
         S6+v8xpprfGORRsXXKudJUPqXqkIam+lE1MZwU5xt9zQZRnEEkYhsd9q8Lno3AH8BVld
         NZJyNscRBKlCL5Y9fEEhgm/9ujaBRrkuAuee6d44Xl9bTybnbxdu2trOTHHol7Cbfh7q
         fUp249arXJRJhcEV8t771RPSMNuRJiuhdsjwd8vGtBrIxe3FuRpHHY6jFejCke8Ez+F6
         mlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770383733; x=1770988533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmNmeyWa+J7dZZyEeSg9GnKnpszfkH8n3cTwO4E6RzI=;
        b=SWlzbEGY2/wG2y1YTrrjaMA6rVjCtts1HUXntOgyDTq4GZWVq7NSa0gNQMwgyu0tau
         9H6MM/WWUglEFQFu8GIl6iMV6l6Xt0IdhkOOOFlFz0BCqlpcduLzYJaLqz/RDYf1bdmf
         ZFLU49G0HCcEhUyJgtihVQb6W2ak7UBQdWr2hvunCz20zHNQDBlqhvRqMd1Ue6HBob9q
         7eaYak4Cz0qc4SVx9qwf8g63bJb6wovV/ImZFEZeCz3B8XBeMCxFrvcxNCQ2kKUf+US/
         /o2RhKThPbyZygFfOq3C0jEHV7ydWaxQkIKHDi1c6i2PpmkXEx/p75KZFrj0oqkGqOY7
         o97Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyHESk3nuCAMAJlq2P1pZaetNiSbehMYS6WtU7SCPeiNexPOZmmsBitvNcjjbFE63fds1Z29txS50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHmUL1VpwzimAdxNRsXPOmiyB7rzE58z8Olf25KLQ4kLYEoSEl
	QdDM1jVMPHfB44wneit3uxEz+ZatshH1z1raeZE8LQWVkl/woE3ux1Fx/KBXGxOTIbNy3EIt7nU
	syZrFPzHEohxW1oABFKVEeY1q2uirxGi6kcFDBqQOKLWDuvMdT2qBXMm47vAmClE=
X-Gm-Gg: AZuq6aKntxNB7HNnK5MWcNWZ2EJyzijkI2uQxxnuUPUSxv9+C8I93QDiuL2FcT6HYiL
	UgUxEMELQhJxbk9lz9WxJimEOqsg8O3jz7dPRAZg3oZpDaypwLfYQkka1PqZ4NWqsx4zu3whVn6
	tQiyUI9RnUrHyImLcAiHXCmNj9Gke2eXXz3J+v1d/QLF3Dk8vGqHQrIRJt+wUNIxZJRdO2ahghq
	jTlllfex4i33N2FJS6A8gdV8YyojzmettcAKOfJvUHODQkynj6/MlplFXXgG60O4NzjKMUuHnfS
	i+1sBZ0Hd6eBAZAA4RCMzInsJKtV/zoAgNp8ScgWayhbXoM03vBB9FB+SZSiKDcsRZ51e7dpM73
	vXdkbmJOOp8zMzXyiIMOtscp35qzV8//ORt16GEb/2w==
X-Received: by 2002:a17:903:3d0f:b0:2a2:d2e7:1601 with SMTP id d9443c01a7336-2a9519428c7mr28925095ad.48.1770383732475;
        Fri, 06 Feb 2026 05:15:32 -0800 (PST)
X-Received: by 2002:a17:903:3d0f:b0:2a2:d2e7:1601 with SMTP id d9443c01a7336-2a9519428c7mr28924715ad.48.1770383731980;
        Fri, 06 Feb 2026 05:15:31 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521f8cb6sm24970545ad.79.2026.02.06.05.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 05:15:31 -0800 (PST)
Message-ID: <def530e3-3a5d-41cd-9f1a-1dc3f98747f9@oss.qualcomm.com>
Date: Fri, 6 Feb 2026 18:45:22 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
References: <20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com>
 <20260130115421.2197892-5-jishnu.prakash@oss.qualcomm.com>
 <20260131175412.0ded39d4@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260131175412.0ded39d4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WCFGpwxENFmkfxPT488YxZhg38t_DPy8
X-Proofpoint-ORIG-GUID: WCFGpwxENFmkfxPT488YxZhg38t_DPy8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA5MCBTYWx0ZWRfXxpSBGqkGR2OA
 R8I6KsQbqN+eyWbbYwdM0WFSLF19LF+Koknvq3H7zeYMEaEVn3V8oFZXCIMVhktr+LP5HD9ekHN
 MZxdw5wnLaJy/7b4e85T5edusqVy7a9NosuHXG9CkjaA2S4TeKxuzEspLNO+ibZMgb0vpg/Ivvx
 vucvqKnMrqbO9W2EeiNc+qXX8BZGsCRo9k3cgkiI4Y9vcRGY3QjOon4IP5Fjee3AJkLAZCkxmH4
 BM0MzZ9VxEJzGhvI5xuXM1BSeacxS005PtbEoue7ZN7kV1ku54ghOiwWbqLJs8TuzwmU+9dC9Dq
 gy6nE5sMvsbSxPOP1XcqChCFAD+6P+6St0fv7YCHMMkqMs9OInN4FiZtmTL/O3JY90vqtC/qR4g
 e3sVKVSDDygiFR0REYddvqw3IE6PBgxSOkKHoN2a7do8PhlcLImYhz266XC+9JMQde+xfrhHIHu
 8QaVzMw3rgco3jfJnDA==
X-Authority-Analysis: v=2.4 cv=ApnjHe9P c=1 sm=1 tr=0 ts=6985e975 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=i0EeH86SAAAA:8 a=yfIZU4QQ0lc7Zzv-pR8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060090

Hi Jonathan,

On 1/31/2026 11:24 PM, Jonathan Cameron wrote:
> On Fri, 30 Jan 2026 17:24:21 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>> drivers, used to support thermal trip points.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> 
> Hi Jishnu.
> 
> Some minor editorial style stuff below if you are spinning again.
> Otherwise this looks good to me
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Given I expect this patch will go through the thermal tree and not IIO.

Just to confirm, would it be fine to keep your Reviewed-by tag in place
if I only make changes in this patch to address your comments, in the
next patch series?

> As mentioned in previous patch review, we've missed this cycle for IIO where
> I'd expect to spin an immutable branch for 1-3 so we can do this early
> next cycle.
> 
> Thanks,
> 
> Jonathan
> 
> 
>> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
>> new file mode 100644
>> index 000000000000..882355d6606d
>> --- /dev/null
>> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
>> @@ -0,0 +1,512 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/container_of.h>
>> +#include <linux/device.h>
> 
> Similar comment to previous.  It's rare we need device.h
> and if a forwards definition of struct device is enough it
> is better to just do that.

I can do that in this file.

> 
>> +#include <linux/device/devres.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/err.h>
>> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/thermal.h>
>> +#include <linux/types.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/unaligned.h>
>> +
>> +#include "../thermal_hwmon.h"
> 
>> +
>> +static void tm_handler_work(struct work_struct *work)
>> +{
>> +	struct adc_tm5_gen3_chip *adc_tm5 = container_of(work, struct adc_tm5_gen3_chip,
>> +							 tm_handler_work);
>> +	int sdam_index = -1;
>> +	u8 tm_status[2] = { };
>> +	u8 buf[16] = { };
>> +
>> +	for (int i = 0; i < adc_tm5->nchannels; i++) {
> 
> Not that important but you've been a bit inconsistent on this style
> of putting the loop iterator declaration in the for loop or not.
> You could definitely do it in a few more places.  I didn't comment on those
> because it's a style choice, but consistency is a good idea - hence I'm
> commenting here.

I'll update this everywhere in both driver files and also address your
other comments in the next patch series.

Thanks,
Jishnu

> 
>> +		struct adc_tm5_gen3_channel_props *chan_prop = &adc_tm5->chan_props[i];

