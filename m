Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A549B5BC
	for <linux-iio@vger.kernel.org>; Thu,  8 Oct 2026 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463129; cv=none; b=Vyadpjf6pgZIq7NamjIjEGgOEqY7Vc8gzmzUjrZC/npl8s+Os1OazWutavhygGgEGwCQTSJEKxiKLQKcQvZNXjI1BosREqTuMTDLBbNTsltbasPb4zWBdCzZjHL05BRR90U+NUX+NpdO70tdSjeqkTppp7pH0cDRL1tICzH9VpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463129; c=relaxed/simple;
	bh=zMqRuzzgdFJ1fm/eDvxR9LsZgHUvQ/RSkYZbPH5r4qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3tjFOiXNBkwutxAD/Q6jKJQyqvc9KPLSXR2VHXHKcjqSw+w7fGzaiqw/jjD/Kl+4MWjmRvzqhBrufWKVqmHfilXTafhKrj5OffduT7frq9DQfD8gUFI5UEu8hnbVPf4JrC15qzftWC7xXuGIGM/a6iR2VEUdkM7+SE3mmulqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NTF6loD9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VxCLNWJx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NTF6loD9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VxCLNWJx"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698BJwha1881908
	for <linux-iio@vger.kernel.org>; Thu, 8 Oct 2026 12:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w39yKARDa1FO8OXgrwzakXgdnRwrZUAfxXED9nTH6Gs=; b=NTF6loD9JAkSxy1R
	zytdg1aU5L1MCUs7qngI973BOMNsmKbzjPWA4w7KqlKD1Fku6AHuuafbsB3v7/5N
	0AnOjjg6ZUs0OQovTwuTeC0BDj3hO5V4CjM+X4EngcwDQLAEx9cFtGekGv5nBfu9
	q5L+/LtWydsq4N8rwBGDzj9GzzabsCzkPt9ZomfDPaxUeStPZKI7pvZpZVWp0tH7
	To30l0CPhCB25eyBBgYn07dWUvQQnnUu4wGKCS0fZVrhVha5fN/1I/L7btDp5aWz
	kMRV8Qi7ccZ27SKAkpYRSw7KoN2NWJ3BhxdYInDSGtlKDLzrGxcjgQoJGVgRxzPg
	JQVqpQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2tvub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 08 Oct 2026 12:38:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9179a2035a4so16515226d6.1
        for <linux-iio@vger.kernel.org>; Thu, 08 Oct 2026 05:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791463127; x=1792067927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w39yKARDa1FO8OXgrwzakXgdnRwrZUAfxXED9nTH6Gs=;
        b=VxCLNWJxdYyrtIySfwTwGhUImewwCIyuBGgJf/uuFA3iQ2ciiLvdH5KJwXTS2V2iO6
         rR1vvokkcj3p/T0gFgO4/oskaZkY4oVPFCMNgNkojv0GccK/GM2CXCAxswH4bnSLlqAM
         t/lewuoozDTBDeuuwaVgR9oiMfTcZKQS2jcvrEjCMVAI4jGgr34QSA9nXfLdMTNUpFcl
         pxPcnRsAq41BZanE0FrX4jVv1/qJQ2DMJoVlBqKXM2zGhdtSLWhOIz+eysDiWvgoML/4
         hV5374xWKzgElb1BII91y9d+utY0MmKiOc5MDm/l4Pi41mpeeMPC593AmrRVCrb528ra
         pk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463127; x=1792067927;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w39yKARDa1FO8OXgrwzakXgdnRwrZUAfxXED9nTH6Gs=;
        b=np572yKsOusvPmLYjjPJj/a4ARItR+Kn2tquw7OkX4a7QiLEh8wVcjaT4AXM6UlXn2
         z2VMI0lVTKDNewWiI6u4Q501bIC/LYbmWBupj92I28YbDUihlLWhTKP1wI/rrmRtiKVu
         S3LqHTYutpJ5bHwdzwMboWKQMyMGfCfV53+Zg0GSZY62W5SojJU30kFclFYzc9gSTIuW
         drtyA+tkd/JLkZneBp/IRcNHl557jOFGT4UuWBsbQqIVwF+3DFBb8EWQTWh8jBBT026k
         DGJI7PbLQsYC3vBl1OU8NMXcgZ2NvXzFDGOE4X7T8GTo8UFp/pWueiXJkIBOGmw1N6Uv
         QAKA==
X-Forwarded-Encrypted: i=1; AKwUvBy2rs6Gb46TO/IHyDPBq2FYj/eq2c3xoe91h9MSjhyAqbLkv6+VryJwvhKCGKGhd+/PmHWtflLPjhE=@vger.kernel.org
X-Gm-Message-State: AFuF++nf2dZ7TrDPcQqPU+FBsyZTk6RHHIAb1efW0/FVKJbFiF11pNFS
	DJvoo0CfFd7JuYE7PhBBayrkvnB5EHFOHTDgQDEzEoqv+DGNIHiUFAz+o7iN1FvSbM/1OjixcoC
	pp2YcPkRNBk+VcxiIQkoUUH0fr5+fUjCug+H5gi06oQZ/5YiM+x8DphrHffu/JN53Cu1YlP4=
X-Gm-Gg: AYBFou3lqVgkMAYHBwSBjegjg+tzoc6sEpZBTnMakYjuxXBNTc8grwlEa9wzOnCfjyf
	fUg82ZMZTOMmPyn3NE5n65gXaSHjlA/y6BeRR7rq/y20J4YIyiiqEj2hHTRzWnjlBYvPJIbUcu6
	foiQw2sOPNaXog2i8bCsWzUzTErEBN6cq7BY52s9Indm3ZwwHsIikmtfZng+i9S7aKcQz1KrWJI
	qDpdXQ8o50UUDpBxqUzARs1MqmkSieqqcgfwM0/7IoU7fGoV6VKk2k79k5ndHWpn2x/pZpul6eY
	mWiHZ1d67ATPm0eEdiOfplC39XCrZeY/ogTW2pfGrViFU3Pa8h9+SyhDVKl2MOv3isJk8BWk8Ky
	cOpgCPuKwjQ6m2WSLjRNWg4eEVHEt
X-Received: by 2002:a05:620a:3712:b0:93e:9808:2e17 with SMTP id af79cd13be357-93eab16feedmr408125785a.36.1791463126333;
        Thu, 08 Oct 2026 05:38:46 -0700 (PDT)
X-Received: by 2002:a05:620a:3712:b0:93e:9808:2e17 with SMTP id af79cd13be357-93eab16feedmr408120385a.36.1791463125801;
        Thu, 08 Oct 2026 05:38:45 -0700 (PDT)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e991fe1a1sm466011285a.43.2026.10.08.05.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 05:38:45 -0700 (PDT)
Message-ID: <02307f67-7767-4bc2-a701-f97e7343ee82@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 18:08:38 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Allocate unique ADC_TM aux
 device IDs
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Dan Carpenter <error27@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Dhruvin Rajpura <dhruvin.rajpura@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1MCBTYWx0ZWRfX3l7RnpRMTb99
 88pX07V5yAG3HyJcdTQLbDE9g3jmBoWpwKY78uz8jPRro/2ddlo2RRMAfR4UXwwfFyuv2qZKZPQ
 3by+D2UNCZ2VRhLHNtf0OYMga+FwRHY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1MCBTYWx0ZWRfXzl8f3rv/Wqvb
 xdA1WqQxfoCEcmMDssCURNWJVLcQ2h2iuV4DmbD7k6jDfU2NqEQOx0lYiJcsI73TJobe3E02uwx
 N7vY5nxzEvqffdBpvtPRjJ41BfdA10qRxTR54pY77x5zhdgrX7vVNxpxAbkb9agG25rM4sDFNyS
 TnPN7o7S5MG9rzM7j1H0GabJuTuR2+JOi/wUB/62aW2stEIhJFAiD6zQRcMWB9MykyEi+mDIvyy
 zUai9JCj+l6TSUm3/0YbYYShsxoR5ZZEv+SXIN3aosCpOWjeU+6CoSDeptqG7RinDeCxn9OCqaD
 aqEJaIbEjnF6sBdBrvv9ZxpuofcVTqupncK87TC3khmoa73rGHPco/CpbfdCn0w++IHjzmn4eU9
 q1u/lrpVGaSTglum3B5e4XVa5gnrz5WkDTy8vI4mb/GdooJmnZDJxREvCqmr4iM/EJ7Ha5eUoyJ
 Dvhm8iulkAYfh3Ed4kQ==
X-Proofpoint-ORIG-GUID: __6Jhft8EAmEcXrkX56zXjqgLR8I7nin
X-Proofpoint-GUID: __6Jhft8EAmEcXrkX56zXjqgLR8I7nin
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac78ed7 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=P0qyw1g9NGlai0uqiZsA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080050

On 10/8/2026 8:41 AM, Shawn Guo wrote:
> adc5_gen3_add_aux_tm_device() never sets the auxiliary device id, so
> every ADC5 Gen3 instance with at least one qcom,adc-tm channel tries
> to register the same device name. With ADC_TM channels on more than
> one PMIC, the second instance to probe fails:
> 
>   sysfs: cannot create duplicate filename '/bus/auxiliary/devices/qcom_spmi_adc5_gen3.adc5_tm_gen3.0'
>   ...
>   auxiliary qcom_spmi_adc5_gen3.adc5_tm_gen3.0: adding auxiliary device failed!: -17
>   qcom-spmi-adc5-gen3 c400000.spmi:pmic@8:adc@7200: error -EEXIST: Failed to add auxiliary TM device
> 
> The ADC probe then fails as a whole, so that PMIC loses both its IIO
> channels and its thermal zones. This shows up on Nord, which has
> thermistor channels on two PMAU0102 PMICs.
> 
> Allocate the id from a driver-wide IDA and release it from the
> auxiliary device release callback. The ADC_TM driver matches on the
> device name only, so the instance number does not affect binding.
> 
> Assisted-by: LLM
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> index c68c6c5f6aca..f0b2544c1632 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -15,6 +15,7 @@
>  #include <linux/dev_printk.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> +#include <linux/idr.h>
>  #include <linux/iio/adc/qcom-adc5-gen3-common.h>
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
> @@ -608,7 +609,14 @@ static void adc5_gen3_delete_aux(void *data)
>  	auxiliary_device_delete(data);
>  }
>  
> -static void adc5_gen3_aux_device_release(struct device *dev) {}
> +static DEFINE_IDA(adc5_gen3_aux_ida);
> +
> +static void adc5_gen3_aux_device_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +
> +	ida_free(&adc5_gen3_aux_ida, adev->id);
> +}
>  
>  static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
>  {
> @@ -642,9 +650,16 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
>  
>  	aux_device->n_tm_channels = adc->n_tm_channels;
>  
> -	ret = auxiliary_device_init(&aux_device->aux_dev);
> -	if (ret)
> +	ret = ida_alloc(&adc5_gen3_aux_ida, GFP_KERNEL);
> +	if (ret < 0)
>  		return ret;
> +	aux_device->aux_dev.id = ret;
> +
> +	ret = auxiliary_device_init(&aux_device->aux_dev);
> +	if (ret) {
> +		ida_free(&adc5_gen3_aux_ida, aux_device->aux_dev.id);
> +		return ret;
> +	}

Thanks, this looks right.

Reviewed-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

>  
>  	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux,
>  				       &aux_device->aux_dev);

