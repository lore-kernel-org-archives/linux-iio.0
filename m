Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AE83B0AD4
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415271; cv=none; b=Upj/JQym307zTA0aDFTI18a71itYi6XCmD3elukhybobxPdU0QB9BTv5QyWvlIoJnIbC7uHpCA+u9MT0tAk4gPjaojFMQuoRE7yZsR/HJDJ0fC9JbJ2Z+7cnE37iHRtJUoptKg6U2vwz8cxgrb/kgG5cXe4tu/fO/XfoZ6Ps3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415271; c=relaxed/simple;
	bh=pUbRxLjqXtbtcASRC1l1F5ay4LPPg3RsgdFO6aP3c+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3Id3fYY+G/N/NwyRwmTr0be+O0Oeriy1QKNaEAvffbHxo28cAJlYN0H76xMFn6Scw7hGXFeKeWOEvQXOlLVA3mbSb2jnva1W36VJRvhIrIMPMWA7jZ9oMRUf6D7CUh/BeRAafkxj1KroAAtw3w5WYFndN733aDmVJvjic5FGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MPjgdPzH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L+J+rRLO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MPjgdPzH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L+J+rRLO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H6qHGW727586
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 08:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uib1biLl1Q+oOaTNTww0Svu6KOoR3zuEfTMpy5WpHrU=; b=MPjgdPzHbRSUSo5e
	JyVhP7d87oPghOTKhhLr9b55Cw+A29D8sO0B2c+DOGpKaX/Y8oW1iZpHC3sV/5aL
	wGDSZeBD0wQAJdjwUuH3nQ/WjQySqH7MF1zoW5V+25DVkLgZ5cUO41qlnSmZ2O2f
	23BjeBSSYCKfc5bBKhzQvw+jMslNSc7g6Pg9HAkHRvtVwmwVxs/SQGHzRh2/JjRk
	5+F/JtzLSaPUdR/15O2CxUx99Kax82DI7w86bPHTyuCl+tN4Imj+crRiwYdLZ6rV
	o09pbQbSnHqSCjViSViXDGvnBoQ7sBe7pFiOM4O3mJClef3Wva6/x5AsMkr2X4XQ
	hzwing==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkfyqrex1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 08:41:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d984c74a8so10793701cf.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776415265; x=1777020065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uib1biLl1Q+oOaTNTww0Svu6KOoR3zuEfTMpy5WpHrU=;
        b=L+J+rRLOB1Wv7os3lqYWSwq0bqVDwI8q8kAQ1J0r2S5g1OYBVYDvci807QxNuAAJnc
         TLSdGzw/J2YZp9tEK3ct5A6vb0t3WhZZGi/169ziskXkVtavoIo/EFvG5S5gsU7iDhQP
         hzajGX2TE9SkeV8zlwLMrVhDEuCcOtWSX/wPzraiwb2aKTiitL3nC8e2UInF6UglUPyF
         2RiAzba7EGzaOV/8xhnRXE705+lSImGaEPzr9kEhzf5b6gBzijb8WhdAzCSd0Xltoq8u
         IBYbI35aURJRjp2d0ACmri/t0ACHJyDAblEKLJc3W8MdvvSzQuU3KZyqkSa8oB3r+DaB
         290g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776415265; x=1777020065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uib1biLl1Q+oOaTNTww0Svu6KOoR3zuEfTMpy5WpHrU=;
        b=W+qd8xjSXVYiE4M2vT52HvOWcyOEbCSvPam30KbrWUUh6QlE9JZthKfYQ14TDlWZrk
         gzTtbehukUhMjTbHnXRhrI7ScjuHvyGd55iWRY+J7/c/Uj/je6mkgTYGuuSAvOIwkXCU
         yLNi1PgFfGOM3/nab6ihqGi0psMvQesAgdVG9FUtr/ZUWUyaDgaoqsSUet4ru68uRZdC
         fgTuKU64wR81tU4kNaextLDK+EBSgKli7lTXEQxGFz/z0q2b4CCc84K7e6HnOXM0LZVB
         fgzEbZbfbRxEpqTL5+UtnG9pyBkRwCv4jj03NhByUZHCC4ZuKZFUObISnExw/QRaXoeT
         eRPg==
X-Forwarded-Encrypted: i=1; AFNElJ/U2FrLsicXrXTK9fHRTlRY9UfTeB+6CdyiqEhD//eFvDdG1nqntoA+Y+xWcXMGgQuMrCAUHGYViQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/2UW6Uls0WZjD/0BTi+SqXevZmX/BnkE0xsc938vh9AsiRAH
	+pcA8C7RFw04l7iQGoZaKx93NNkGb6lN2lNEx6lJluMAXx0YfDSNtmcSFTNqXgvrmNCQHb96T0p
	t2LYa4lPyA0a8Jyz3gSa9YIL50bPowDByx9XjQDSQM4fxi0Xh71Ayekt9NfM0lrua3+IWbVM=
X-Gm-Gg: AeBDieseqzySSm8sxPSeLO3822qacnEN532UFTJRyvnmN7YStuthxaHg9HGSKDu9vzy
	yBsNviKjwjfFoT1xWKP1n7mu2doABE5SfTWy4GytTcdUYfCeHnHxK66PPWVXSR99L4+6dNhPqpN
	tgNuppNgLyatD0txZwAwyoyjc5lMC9LJnf+ekZbA7SraiJV3JaJZxAzYX5SsOaSzVDK45vm9dq3
	+uCV/sOrjzArhnPYFDZ0FNQcF7rbVN9TuWZ3wNWCEofn6K3G+NXGGeIWwbBxFNTgdzmdyCtjLlE
	KDmafESy94ksBDByBdVi3+CwQNXmH3Hr7jWaAUhMvBB0wZs+MBRmd0+PkXrl3hMlBzs6BnCxQwu
	YX5r/Bni3cP2iwlcd9B6gmEV4yVERK2TVph8ODD+xaAQIrkpKTW4/1qaGXwYGBaLIMqNUXdLJk3
	HeVtja7bf2auC/WCLGMtw=
X-Received: by 2002:a05:622a:1208:b0:509:44c3:5ffa with SMTP id d75a77b69052e-50e36c69265mr23549421cf.52.1776415265094;
        Fri, 17 Apr 2026 01:41:05 -0700 (PDT)
X-Received: by 2002:a05:622a:1208:b0:509:44c3:5ffa with SMTP id d75a77b69052e-50e36c69265mr23549101cf.52.1776415264583;
        Fri, 17 Apr 2026 01:41:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:cf08:980b:ccbc:54fd? ([2a05:6e02:1041:c10:cf08:980b:ccbc:54fd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm2662279f8f.4.2026.04.17.01.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 01:41:03 -0700 (PDT)
Message-ID: <79b02540-7981-4584-aca2-98e1b95cde79@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 10:41:02 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: adc: nxp-sar-adc: Avoid division by zero
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Felix Gu <ustc.gu@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, kernel test robot <lkp@intel.com>
References: <20260416090122.758990-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260416090122.758990-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA4NiBTYWx0ZWRfXx7C4yrJcb004
 MaNpsYQgfF+SdOqOxDRXiEWLBsieGoFGdcc6M+uQsDrMkDvEnDXBkazNyYu8rQDcaU4Ndj2kRJn
 MyAeiBhApMfVhYNRnwwjdALXmQW+UR9iu+AqHZZEDOaBC57gSBSGeCz77ckBdcoPfJv++mDqy03
 VLaxG2+XalQ8s725FsafXa4e8Z5QZ80z3BUJSOOqh47SMBFGygxtlvr9C3nHIeFQmG0dLMQlUb8
 jNILo54IU097Q4+0ZyHBdApDSTJ2zT/bhcIs+acjXQH/SqcnxYH5A4uwrl3lUQamEJfNzawfUxl
 GhqX24Rt+J50+2tPlQpkTZQLHEW4lc/JtZ743MDhuzzmDNWtKkV9Zej89SIHpFdTtV1aQvI6Pjt
 0IwEjfuq1+d5qm0TMsfFd4TayTOJZ0jUvUnXF1HGbxyKIwrN7PYIf5pTF5cjGZF9YvwM9b9L3TS
 f7R8/moTAMDOyA5AdQw==
X-Authority-Analysis: v=2.4 cv=BZPoFLt2 c=1 sm=1 tr=0 ts=69e1f222 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=FG_i2eBGQR0NSksuxDEA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: uNVUNVsvyLj3EwBiwGWJQPdc5eWbtgqg
X-Proofpoint-GUID: uNVUNVsvyLj3EwBiwGWJQPdc5eWbtgqg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170086


Hi Andy,

On 4/16/26 11:01, Andy Shevchenko wrote:
> When Common Clock Framework is disabled, clk_get_rate() returns 0.
> This is used as part of the divisor to perform nanosecond delays
> with help of ndelay(). When the above condition occurs the compiler,
> due to unspecified behaviour, is free to do what it wants to. Here
> it saturates the value, which is logical from mathematics point of
> view. However, the ndelay() implementation has set a reasonable
> upper threshold and refuses to provide anything for such a long
> delay. That's why code may not be linked under these circumstances.
> 
> To solve the issue, provide a wrapper that calls ndelay() when
> the value is known not to be zero.
> 
> Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603311958.ly6uROit-lkp@intel.com/
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

> ---
>   drivers/iio/adc/nxp-sar-adc.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> index 9d9f2c76bed4..705dd7da1bd2 100644
> --- a/drivers/iio/adc/nxp-sar-adc.c
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -198,6 +198,15 @@ static void nxp_sar_adc_irq_cfg(struct nxp_sar_adc *info, bool enable)
>   		writel(0, NXP_SAR_ADC_IMR(info->regs));
>   }
>   
> +static void nxp_sar_adc_wait_for(struct nxp_sar_adc *info, unsigned int cycles)
> +{
> +	u64 rate;
> +
> +	rate = clk_get_rate(info->clk);
> +	if (rate)
> +		ndelay(div64_u64(NSEC_PER_SEC, rate * cycles));
> +}
> +
>   static bool nxp_sar_adc_set_enabled(struct nxp_sar_adc *info, bool enable)
>   {
>   	u32 mcr;
> @@ -221,7 +230,7 @@ static bool nxp_sar_adc_set_enabled(struct nxp_sar_adc *info, bool enable)
>   	 * configuration of NCMR and the setting of NSTART.
>   	 */
>   	if (enable)
> -		ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk) * 3));
> +		nxp_sar_adc_wait_for(info, 3);
>   
>   	return pwdn;
>   }
> @@ -469,7 +478,7 @@ static void nxp_sar_adc_stop_conversion(struct nxp_sar_adc *info)
>   	 * only when the capture finishes. The delay will be very
>   	 * short, usec-ish, which is acceptable in the atomic context.
>   	 */
> -	ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk)) * 80);
> +	nxp_sar_adc_wait_for(info, 80);
>   }
>   
>   static int nxp_sar_adc_start_conversion(struct nxp_sar_adc *info, bool raw)

