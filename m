Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86AE3290D9
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961776; cv=none; b=L9LOLn6iBUn8a9UdBG6UMT8Og1/3LY9G13R2hDhjsv1pf7YDyNXj3rQ25o0e3fuQcrQxzx2r224opW8RO+s0RufuJW/hrR8rorsS796FGJ8EMBJ3EFJ+3+AsyXpoyuA1dy7uhqMGsEFQ3DrU7CLhW6poejvcuFdlUnNQJv+kl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961776; c=relaxed/simple;
	bh=oVvyHkwRLo36ybY/LmG8sSxJU9a9lzLKNbwUsPqQIbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceWO5cQxSGzQ6zXbjlFit19bQfvnL+z6o8gjuzfLKZUdHoE4De4XJg+CmZTyKGr92H9xWxiL2uHur2BUA9Wn4WCThhIqUMWDgJDcdiye/LVg7+7E7VaR4HuOBrbfTMX6mKc7QB7H5wKJ/7gfNGkxdqym61LjkASw2F+a/155/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rjrgq0W5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W6ESEjIS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rjrgq0W5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W6ESEjIS"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF88ZD1887847
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 16:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Ecs5tH+zZY2MRhB2RadmuAKPiV+99oz9UwWFOi6ZgM=; b=Rjrgq0W5NzrMQVqz
	gcBwMVMItVSJXxllv5/eHXXHBC6PKw/BLlL6SpG1uUXIUoGfsFBP24+RQY93ZUyY
	ODUBJoHz9zVenkYOu3Z7SFU3BZ+RiyfEuRtz/C2iyi8scHnSksF7tj3OCY2uu6Pz
	66jFAXCguty+C6+SG41IVYYVMiZ9qZWADDPqVB7vRYRtNktnf7MtVA3tRKtE8lDe
	W+q8F3lsITrYAqzSROjhuSepC8jknealT1aZDfI5la5H9yuCAs91S2PzN8tjNQaa
	1xmGyl5sPVURYB5dowtn3ZeFOvNZvBwfAp3iXUizNvJzFNGpkJgfO7Mq4k1BKYJl
	2vX7Dw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavsu8x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 16:56:13 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8895156101so2433826a12.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783961773; x=1784566573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Ecs5tH+zZY2MRhB2RadmuAKPiV+99oz9UwWFOi6ZgM=;
        b=W6ESEjISflrkKH5lE48X08d7GrgZEzGleopjXbhyx3zlGdh3P5Lle3IUDYaIG9rrhe
         UAyDiKApi8re0Jn+mwwhmmV9BYdaIBOQuq5B6np/OnloFsdH1gmHOjtIBQyylABKjJDm
         DU4Fss9qOhP0qQ+8vIyzffNL1LEpuI8cKHR/EERd3Op7DLQ9NhGzESDpvjJr59hCvDYL
         yl9Pg+DbBz5Vl/cBPqT+BiEMnmgLYdfmujCyyKShbksEvHEEEVLAOp8eq7NmXkE1knpd
         rnRg3FqH693inonL6qHqpCczq+CB3owyDndDXRrfS3mQGjt5jima3Kl9AM1mdpM7kjaI
         +VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961773; x=1784566573;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Ecs5tH+zZY2MRhB2RadmuAKPiV+99oz9UwWFOi6ZgM=;
        b=U9zsemqIwegdAIm7ahU9zpVMjF3J/bbHv/MexWjNdJzMldtZhJFkLvnkpCzffG9Lct
         01h0UpHXVb36xBWXcOuLJSYxT1jlCQfDk8HpPI6mTwhDKe2Y+nmJmO24dYfaDBBIw61Q
         YxckDjkbHW4LanywE74OQtpMgPY1fCZo7OAEXIJ8ZPATkZ0m25K45IG4JUGNl8oQl15f
         i/Oxhgr0s6hpwJzXgcCcYnLHMkDgCSF63ExviRMCT/tYLhCtMtLO1gZWgFFqwDyE5Fml
         IFC9h6sXJ+Z0KjmdSAH0PFiBduyNgR5NMRETuZJsV3O/cidGEhpxkFuCFDRIZ5pZerrR
         l8og==
X-Forwarded-Encrypted: i=1; AHgh+RpL5CN9RYdf1Sd6s7LlJdyFIn7fho+v5a8X8r5g9Ar7zGAXOwk2U00W9Vf1bt1LWY26JdxtlXlBfQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI260nBNTGX85eFlh9o+yWKgufa+NtOsUEegdCUVJzSvaJEdiU
	PF6nrmEYnb0N5g8NeV7dO+YA62FY7XSRJvXkMZXz542UJDfYoxgacJQEdJ1H6D84r7DMT1Ym3Kc
	zWjSpRSDnYXG5JDepT/xLFNrZOXEfKX09gHdbXQGHGz6ZUfiqurKf4/0AEVYiA94=
X-Gm-Gg: AfdE7clKt1kXnbN85ZB7UAd910ZRnetY8j69lGwCuj1KLIvMqIyFOCA6u5VUZ4nBFWe
	zOIk2jlL9e4bFkehq17gse+63X+mBx00D4A8pq2/O/LrrIyIzmfCbX2mJVugtNhRJ6bgLo5dNE5
	8hrUYnnhvFKC5bwNTPL6xwR8Pxnt9BThof7gc5mId/45sBYT2nS/nlocY/rjmq76jsfpRoVBirg
	7RgnLLq800qq3ta+Mi+YyvnXPGPRZ+nuSrRwUC369Dht21ts5VcdXIoyE8QpQzqIi4Kc8tFi3QR
	u93ikQZjfcPiF4stxRB7BYXvh//iQmEFIqzpuJVOBCd7j7uTVP7OUBupEvlLRCsj+oTNGWVX9Jj
	QabTlmSNjmnmhBy1KNpnSFKLwu28XGVZSwXwxs8SljGLQYQ==
X-Received: by 2002:a05:6a21:3992:b0:3b3:23a2:edff with SMTP id adf61e73a8af0-3c1102a15c4mr10772667637.28.1783961773426;
        Mon, 13 Jul 2026 09:56:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:3992:b0:3b3:23a2:edff with SMTP id adf61e73a8af0-3c1102a15c4mr10772622637.28.1783961772810;
        Mon, 13 Jul 2026 09:56:12 -0700 (PDT)
Received: from [192.168.1.100] ([157.48.180.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313cb804197sm23242316eec.13.2026.07.13.09.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:56:12 -0700 (PDT)
Message-ID: <f384adce-8954-4667-9e3b-0fc0eb223439@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 22:26:03 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
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
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
 <20260705-gen3_adc_tm-v3-3-ac62f387dbce@oss.qualcomm.com>
 <20260706005134.7add6bbe@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260706005134.7add6bbe@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TY7bvAtd-VWRrKgTbzICWJx3csGklgxU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfX3br5aqo97zes
 ByFl6RQe9F4WXo9x/Mjc+4+SC+w7tRv6gJQ664LAWD9pZ6zcfzf6qpMr1XC8y4A6qNslG4zCQxk
 8qfyeGkwLY254RFghy8JZCQaAEdzWoF4cVG46rrEfEEUuPDBaecCZsqOYAXKn2lLb3PwxJjnosM
 1v2jCR10y/3A2ygf8WT/qAN3sc9bI7HS5eepDV8s8+Tb4oB73uFkpqbgWFidn4PE29SaVgE9Znx
 LsTcnj7W7+tBuS03UdmpIuzs4eKg/WMJv/kTQ/IFUSYkai5/Zh4EtkRoPsEDxsIdrRTCNzF3yPQ
 1K2yP/avjZ3vB4N2Gtksf8z3oEpkenpCZRYN5TrgoZpBPEVvHDvWlAFDLUEiZshZZwMWBlUoR4/
 SjlqNLbHmEpLDmvt/XcLwNR/JNNrNrx0gloD5R41bmH8UaQM2+cFYoV01adWV4KwTKOgmAXfWb8
 zQbiVkSWQnN2HKUMipg==
X-Proofpoint-ORIG-GUID: TY7bvAtd-VWRrKgTbzICWJx3csGklgxU
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a5518ae cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=62VzjLAzdHZQ3L95IMgkXw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Q30daxf-3pjc-4xqwVQA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfXzCZyh667nANE
 rXMSysY56gZqmUXOhffsll8lt3Hz3yvkKsU+jSi184hRwxUA9xphmPgfvzdltQmar0f2YLU2IHs
 u7iVE9CPsZ4Fso6Coe2eHx3liC3zp3E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130175

Hi Jonathan,

On 7/6/2026 5:21 AM, Jonathan Cameron wrote:
> On Sun, 05 Jul 2026 22:23:35 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>> drivers, used to support thermal trip points.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Hi Jishnu,
> 
> I took a quick look at this. A few really minor suggestions inline.
> 
>> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
>> new file mode 100644
>> index 000000000000..5a82c4d8a37e
>> --- /dev/null
>> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> 
> 
>> +static int adc_tm5_register_tzd(struct adc_tm5_gen3_chip *adc_tm5)
>> +{
>> +	struct thermal_zone_device *tzd;
>> +	unsigned int channel;
>> +	int ret;
>> +
>> +	for (int i = 0; i < adc_tm5->nchannels; i++) {
>> +		channel = ADC5_GEN3_V_CHAN(adc_tm5->chan_props[i].common_props);
>> +		tzd = devm_thermal_of_zone_register(adc_tm5->dev, channel,
>> +						    &adc_tm5->chan_props[i],
>> +						    &adc_tm_ops);
>> +		if (IS_ERR(tzd)) {
>> +			if (PTR_ERR(tzd) == -ENODEV) {
>> +				dev_info(adc_tm5->dev,
>> +					 "thermal sensor on channel %d is not used\n",
> 
> That seems noisy.  Maybe dev_dbg() appropriate if this is an expected
> board dependent condition?
> 
>> +					 channel);
>> +				continue;
>> +			}
>> +			return dev_err_probe(adc_tm5->dev, PTR_ERR(tzd),
>> +					     "Error registering TZ zone:%ld for channel:%d\n",
>> +					     PTR_ERR(tzd), channel);
>> +		}
>> +		adc_tm5->chan_props[i].tzd = tzd;
>> +		ret = devm_thermal_add_hwmon_sysfs(adc_tm5->dev, tzd);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	return 0;
>> +}
> 
> 
>> +static int adc_tm5_probe(struct auxiliary_device *aux_dev,
>> +			 const struct auxiliary_device_id *id)
>> +{
>> +	struct adc_tm5_gen3_chip *adc_tm5;
>> +	struct tm5_aux_dev_wrapper *aux_dev_wrapper;
>> +	struct device *dev = &aux_dev->dev;
>> +	u32 irq_flags;
>> +	int ret;
>> +
>> +	adc_tm5 = devm_kzalloc(dev, sizeof(*adc_tm5), GFP_KERNEL);
>> +	if (!adc_tm5)
>> +		return -ENOMEM;
>> +
>> +	aux_dev_wrapper = container_of(aux_dev, struct tm5_aux_dev_wrapper, aux_dev);
>> +
>> +	adc_tm5->dev = dev;
>> +	adc_tm5->dev_data = aux_dev_wrapper->dev_data;
>> +	adc_tm5->nchannels = aux_dev_wrapper->n_tm_channels;
>> +	adc_tm5->chan_props = devm_kcalloc(dev, aux_dev_wrapper->n_tm_channels,
>> +					   sizeof(*adc_tm5->chan_props), GFP_KERNEL);
>> +	if (!adc_tm5->chan_props)
>> +		return -ENOMEM;
>> +
>> +	for (int i = 0; i < adc_tm5->nchannels; i++) {
>> +		adc_tm5->chan_props[i].common_props = aux_dev_wrapper->tm_props[i];
>> +		adc_tm5->chan_props[i].timer = MEAS_INT_1S;
>> +		adc_tm5->chan_props[i].sdam_index = (i + 1) / 8;
>> +		adc_tm5->chan_props[i].tm_chan_index = (i + 1) % 8;
>> +		adc_tm5->chan_props[i].chip = adc_tm5;
>> +	}
>> +
>> +	/* This is to disable all ADC_TM channels in case of probe failure. */
> 
> Perhaps indicate who turned them on?  On from reset or something hidden
> somewhere else?

In the probe, ADC_TM channels are only enabled in the loop in adc_tm5_register_tzd(),
when they have the set_trips API called during thermal zone registration. I'll
update the comment to mention this.

> 
>> +	ret = devm_add_action(dev, adc5_gen3_disable, adc_tm5);
>> +	if (ret)
>> +		return ret;
> 
> ...
> 
>> +	/*
>> +	 * First SDAM's interrupt is shared between main ADC driver
>> +	 * and auxiliary TM driver, so its flags must include
>> +	 * IRQF_SHARED. This is not needed for other SDAMs as they
>> +	 * will be used only for TM functionality.
> 
> If indent of this doesn't change, rewrap to 80 chars.
> 
>> +	 */
>> +	irq_flags = IRQF_ONESHOT | IRQF_SHARED;
>> +	for (int i = 0; i < adc_tm5->dev_data->num_sdams; i++) {
>> +		ret = devm_request_threaded_irq(dev,
>> +						adc_tm5->dev_data->base[i].irq,
>> +						adctm5_gen3_isr, adctm5_gen3_isr_thread,
>> +						irq_flags, adc_tm5->dev_data->base[i].irq_name,
>> +						adc_tm5);
>> +		if (ret < 0)
>> +			return ret;
>> +		irq_flags = IRQF_ONESHOT;
> Whilst this code works, I'd be tempted to make it less ordering dependent.  E.g.
> 	for (int i = 0; i < adc_tm5->dev_data->num_sdams; i++) {
> 		u32 irq_flags = IRQF_ONESHOT;
> 
> 		/*
> 		 * First SDAM's interrupt is shared between main ADC driver
> 		 * and auxiliary TM driver, so its flags must include
> 		 * IRQF_SHARED. This is not needed for other SDAMs as they
> 		 * will be used only for TM functionality.
> 		 */
> 		if (i == 0)
> 			irq_flags |= IRQF_SHARED;

Sure, I'll update the function this way and also address your other comments.

Thanks,
Jishnu

> 
> 		ret = devm_request_threaded_irq(dev,
>> +						adc_tm5->dev_data->base[i].irq,
>> +						adctm5_gen3_isr, adctm5_gen3_isr_thread,
>> +						irq_flags, adc_tm5->dev_data->base[i].irq_name,
>> +						adc_tm5);
>> +	}
>> +
>> +	return 0;
>> +}
> 
> 

