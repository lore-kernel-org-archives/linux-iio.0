Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C633D6694
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383715; cv=none; b=RoqIBF9jSEdi2wCBDhcpov1/pRA8X/HctoSPGHuwDVNtyDZ/kvzEf1Pz1/9p4v26nKlnIsaOK4iNi2rMxhullS0yqqUzqAsu5GKrknWettRfzKWab3SO3H3ZYqnmZYEzI9Rdkt+8WGlNiVE5C6LOagRv4+P92VngTp0i3WnYe0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383715; c=relaxed/simple;
	bh=RIyiRZawDBMZO4eMZo4oUsl2dSffInOezDYUotVje8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=my2qeR095C80StUSzYhD0vqlDOnElekyj0SgGkBldlSN9KwJ68uOWHyvF4PN4+kZHLDIXEgGdOiUoe1M7pg0UjsKzaUcWID1/CoBXdPHwi/qNKLIVtpoYU74FEFuIP/eVDU3VH0uMrUq/M1mIZh5v063SRlhf44bb7L8Y3U3YaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ba8oWIyY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I+7zebJb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ba8oWIyY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I+7zebJb"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6168K9UV695761
	for <linux-iio@vger.kernel.org>; Fri, 6 Feb 2026 13:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jdJy6dnIbw7vFQgp+55aNrKfackYgSIKphN7g2jedYA=; b=ba8oWIyYktiVHo79
	WMr3mDm+/SS0nr3dRJuY1GOxpTDpgPRrsteCxa2gPL9yYNRG+RyyalF5on1nSR6y
	EYiMilFA1ScMnCLgncr23ZljFDdIMd/nbY0U46qmpwinVOuPZZ0P7PnZtCBhFZI3
	fJH28E0/JpAVYKrG0wC2sgLZv4O257DUM+E7nZBsaH1EaOoaWw9b2Q+/JRnIpj2U
	C5j1L+DLzQGJmIHxIWwwb887ujd1aaK71k1xrm0CTIl0HfunOUNO6A/6PIfnvTgh
	uzZU+AHwFk784Y6RKmXILclnTOnECfFlf+bE5+2VK0NiRYbiehMxSXyBCh93gG63
	AD69JA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c53qvakjk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 13:15:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6097ca315bso4315876a12.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 05:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770383713; x=1770988513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdJy6dnIbw7vFQgp+55aNrKfackYgSIKphN7g2jedYA=;
        b=I+7zebJbbNs2OT40jUXlI0sG1avuNZ9eZ2W8ToKa3hLYXGc8C8PLtJyPYvGoInLrmm
         ED0Sa5PK9QdIireApP+/o/JVAPVnHrhYLGp+3fAc/riPD8fgmtWv/MQHF72ml6ikC74P
         F0v+5zxLaaTSszAuADyMs0l+H/N2LHsz4DzS/Cz53VE2wX98AbT0DfJtXwONXcbtCgZN
         ZUAIByqnRLK0L33rwfjyhR5RzKx/NOjxGHZIpPiE6GR82v+epybDiK9r933iFMz5kaUG
         F4+l4vgeCcK+R+bBIYlCZ/OFkfiuhPiuW78vJ+E1hNt/6ehelNORvAjjNlrUK8vp3MQV
         sOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770383713; x=1770988513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdJy6dnIbw7vFQgp+55aNrKfackYgSIKphN7g2jedYA=;
        b=aC3t3gKZtpydKcQ5NKcP+K5e73Eirf3qoE3HAGsN5N0PrcWITaSdLRZkKRMov+GN1G
         60ZNCjvjbBg73da8vCcBEbd8Ze2NoKFKr/dIA9cBgxwbLCMCsdP2PR/+4kMkQrwY4n1c
         npigZ00Awh1B0mMLwLcxQ/WbD43tC/t5aMe4Pm6acman4AR7qTdSxq6CK9zypZeGv+E3
         5BRgrsmOlnr+DFT6eP/a/qRGWilR9JHzcQCswmlvwdsoYpqUZMdn7SgS+ehQGGDd4iIS
         sELzAfWSyltiviq4GMs1Y8CwR7mEUWMakIB+Rc90Pi993x7WAd3IShFy65x95orblszL
         gy8g==
X-Forwarded-Encrypted: i=1; AJvYcCUg5uT7J/yhbnh+HGn/W9iaeJs+fr8jQA/FONor9wX3RjFWUlxoEq56H7115sAjEvlPeO3tT0s7QvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1L5mJCHHBB5DxCs3WD604TWvSZvHfYX1URMpEpU1suK+eeP3
	WPZPOx4AadNnpZnIsiFwVgJ6DAIS3lBSHy6lpgVqj6Hh009gUnDhdwNTvJ3Os2loCDozduafFHW
	Pjp5C3wKHLg0MgS7Bo8PCmR3607SE6dp977xGKmNdDchf+3bW6gjQiQIKdjuGaz0=
X-Gm-Gg: AZuq6aLDOIJBNS1VWZ9DotJY5YCaSUJkq8HEom3D0OSb1ew59AVEJiqN9jLrZwe7ljl
	iKE46e3mIinum/+DF68pIPlgtDjgTystCDHkGnvIetui86pi8Jl4iXWO5Rv2NIGQO4f3wpyob5o
	mRfvxYuGDjf0up6vf3Bq42IeE1vJg0bZQ04R/b6vz5dBWxM8xoVro00pU9WCxXarOpeQPyl/76Q
	zqSG2ffzAiBv2BvpwudJQDHgus60Q6/am54u1HeawacL+5B19WUK9DnYEmI56O85LWCxIsQ1KEs
	wGtpYDVAp9nfkztApulYTXnuqo+v63sYUloqg2odZRL3574qBgy019gA7djotAgQdwlG2SqSnFX
	WrAWZ3updyORLMCk6LExs3USxrw1ZO0R3EQzarGOR8A==
X-Received: by 2002:a05:6a20:3954:b0:342:352c:77e5 with SMTP id adf61e73a8af0-393ad38c720mr2857941637.54.1770383713085;
        Fri, 06 Feb 2026 05:15:13 -0800 (PST)
X-Received: by 2002:a05:6a20:3954:b0:342:352c:77e5 with SMTP id adf61e73a8af0-393ad38c720mr2857888637.54.1770383712346;
        Fri, 06 Feb 2026 05:15:12 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9522128a5sm23484855ad.86.2026.02.06.05.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 05:15:11 -0800 (PST)
Message-ID: <6012ad64-3a10-4f05-9f37-f2d0c36df582@oss.qualcomm.com>
Date: Fri, 6 Feb 2026 18:45:02 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
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
 <20260130115421.2197892-4-jishnu.prakash@oss.qualcomm.com>
 <20260131173941.68b8116d@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260131173941.68b8116d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TsPrRTXh c=1 sm=1 tr=0 ts=6985e962 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=5130DEEzvUW_sqHk1DIA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: sZtoePUQOkwWbGpB6tB9ceUYvt3-dvBC
X-Proofpoint-GUID: sZtoePUQOkwWbGpB6tB9ceUYvt3-dvBC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA5MCBTYWx0ZWRfX5IY27ANQgEV+
 AheTbH2+yqs4mFHIW48yldtuVpKj7BDzWnmdlXNZ65d6IWxlnURWsw4iJdkwTU8myy69PcnWGyF
 il8L2HyUST515Yx/w5b6xpAIUutnJkfb/ISsDxVCMlpMMyIewcPfltjbVXGlGsrk5/TVoB8rzoW
 XNbJ0hTNGW3k9Om2PkwlA99CxcD3l9hawWk5Zb58kogwlfD8eKHbFVWft/lYQjTCM/8hbdpPXKS
 Pom3Hci7pZyzm7xleVZ8HcBYY74wEKpt4jwKB/k/Rv/GoOBuUiDwd/vkKJib3qNOhmvDlGDVSDB
 vQYfqVC2mHJ1muhcEzwFdhWGWDApkKWAKkWkiLINCYTc+7AL8Kb5WQx2bPJlng3BcRreFKNffT8
 Z1AdPemdLb3beBrW6PJUBakPidDLTd4CvXixPdynefHeOW0Tue08klFbQHSjM5N9y6fynXwVdNM
 5efXcWx/Led+JX5ifHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060090

Hi Jonathan,

On 1/31/2026 11:09 PM, Jonathan Cameron wrote:
> On Fri, 30 Jan 2026 17:24:20 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>> with all SW communication to ADC going through PMK8550 which
>> communicates with other PMICs through PBS.
>>
>> One major difference is that the register interface used here is that
>> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
>> There may be more than one SDAM used for ADC5 Gen3 and each has eight
>> channels, which may be used for either immediate reads (same functionality
>> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
>> (same as ADC_TM functionality).
>>
>> By convention, we reserve the first channel of the first SDAM for all
>> immediate reads and use the remaining channels across all SDAMs for
>> ADC_TM monitoring functionality.
>>
>> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
>> ADC_TM is implemented as an auxiliary thermal driver under this ADC
>> driver.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Hi Jishnu
> 
> Whilst there are a couple of comments below, I think this is ready to go.
> Unfortunately this is just a few days too late to merge for this coming
> cycle as I need to send the IIO pull request today or tomorrow (due to going
> through char-misc) so this would get no soak time in next.
> 
> Also, I'm not sure how we actually want to merge this given close coupling with
> the thermal driver.  Perhaps best bet is I do an immutable branch of next rc1
> once available that we pull into both trees. That would have the first 3 patches
> on it. 
> 
> Jonathan
> 
>> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>> new file mode 100644
>> index 000000000000..f8168a14b907
>> --- /dev/null
>> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>> @@ -0,0 +1,860 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/completion.h>
>> +#include <linux/container_of.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
> If you happen to be spinning again for some reason, I think you might be able to replace
> this device.h include with a forwards declaration of struct device;
> 
> If you can that would be good as we are trying to reduce includes of these
> mega headers.

I have a query about this. From what I understand, having a forwards
declaration of struct device may be valid if we only use the device struct
definition directly, but not if we try to dereference any of the struct's members.

I see that at some places in this file(qcom-spmi-adc5-gen3.c), we dereference
the device's parent:


One example:
void adc5_gen3_mutex_lock(struct device *dev)
{
    struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
    ....


Another example:
static int adc5_gen3_probe(struct platform_device *pdev)
{
    struct device *dev = &pdev->dev;
    regmap = dev_get_regmap(dev->parent, NULL);
    ....

We do not dereference the device's parent in the other new files
(qcom-adc5-gen3-common.h and qcom-spmi-adc-tm5-gen3.c), so
I can drop the device.h inclusion and use a forward declaration
of struct device in them.


In this file, what would you suggest I do, keep or drop the
device.h inclusion? 

I do see that device.h is included in auxiliary_bus.h,
iio.h and platform_device.h, so chances may be low that
it is somehow dropped later from all of those files and
will need to be explicitly included here.


Also, is it alright if I push the next series to address
your comments immediately? Would you be able to include patches 1-3
in the immutable branch you mentioned, once it's available?


> 
>> +#include <linux/device/devres.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/err.h>
>> +#include <linux/export.h>
>> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/property.h>
>> +#include <linux/regmap.h>
>> +#include <linux/types.h>
>> +#include <linux/unaligned.h>
> 
> 
>> +static int adc5_gen3_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct iio_dev *indio_dev;
>> +	struct adc5_chip *adc;
>> +	struct regmap *regmap;
>> +	int ret, i;
>> +	u32 *reg;
>> +
>> +	regmap = dev_get_regmap(dev->parent, NULL);
>> +	if (!regmap)
>> +		return -ENODEV;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	adc = iio_priv(indio_dev);
>> +	adc->dev_data.regmap = regmap;
>> +	adc->dev = dev;
>> +
>> +	ret = device_property_count_u32(dev, "reg");
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	adc->dev_data.num_sdams = ret;
>> +
>> +	reg = devm_kcalloc(dev, adc->dev_data.num_sdams, sizeof(u32),
>> +			   GFP_KERNEL);
>> +	if (!reg)
>> +		return -ENOMEM;
>> +
>> +	ret = device_property_read_u32_array(dev, "reg", reg,
>> +					     adc->dev_data.num_sdams);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "Failed to read reg property\n");
>> +
>> +	adc->dev_data.base = devm_kcalloc(dev, adc->dev_data.num_sdams,
>> +					  sizeof(*adc->dev_data.base),
>> +					  GFP_KERNEL);
>> +	if (!adc->dev_data.base)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, indio_dev);
>> +	init_completion(&adc->complete);
>> +	ret = devm_mutex_init(dev, &adc->lock);
> 
> I'd move this stuff up to before you get reg so you can keep all the stuff
> related to num_sdams together.
> 

Will address this in the next patch series.

Thanks,
Jishnu

>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < adc->dev_data.num_sdams; i++) {
>> +		adc->dev_data.base[i].base_addr = reg[i];
>>
> 

