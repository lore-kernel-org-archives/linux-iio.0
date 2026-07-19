Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C90135A53
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784425679; cv=none; b=qQo/9E7WoxhBbB05+ow8KpjQJb7ecBNzAZwABdFtnehAStSeL9M7dWOGEhEF1j9/JsHEMwi5/x8qkApzPlL5EVoiKWL8be6+AXiHsAwnIGHF1G/pMiiIpO72YKyHpQEysIl/4KcGcoGbQXZxbvokvRZPJuVYZwEGsKZEF1eNBJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784425679; c=relaxed/simple;
	bh=1LNACsyTWmq77CrpYJChISfgs/clrZPFgDZB6uyMV5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIrSBHPAjHcVXBXIQtbnkPaDsgzl0wQudOUMJr3TGWDQr/yxKiJXDswOg4lH+qqyNJNYC8sueDP+DjRKBOx7P3IRBR/eZE78dHIsYt6Nnofbi4JQ0ui9o/547OHN+LvHPqjuqX2APCpdGyTX0BRS6pRzsIM+aqbDJfFTl1GYhj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ksiFmZXO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VD+bo0/C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ksiFmZXO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VD+bo0/C"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66INZEVE1847779
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 01:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LEAsi3V738n9AGAW8Zy/c/volgRfd1AzGto8nsOt6Jw=; b=ksiFmZXO0+wrseZp
	weiHsuS4OFpE2JRviZKWyvQr+J4Jzpg0+m64lB8lA3/ATgtPYrDzFO84WA9KZJvw
	QAurTGglOFC52UeM4o2ku8M0msdXZ90sBi1csoaIjjIg91J1+toS+88r7AWhEvdq
	Hynl+oBulAIH1Px5hqv1i6ev/rfAtPg96omUZSiS8K5xJQJWDPhKBoNqsM7lSLbq
	bjBeBiz3uvjHRMW6VkS3oqjlQAVoGTAmHPLKXYZdtN5lX1ePXqw7yZ3MC2wy/pxF
	z/7GAVLIAEaku8Da676NDIf94R9CdnBxhncZw9qWWIMs/ugvJKD731fMblIIVkYF
	0FLdrQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvsw66-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 01:47:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb6823efcso81115555ad.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 18:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784425676; x=1785030476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LEAsi3V738n9AGAW8Zy/c/volgRfd1AzGto8nsOt6Jw=;
        b=VD+bo0/C9EZTs1IWobPy9eyFTCaILNIeKjosirBt1Rvsv+MLf28sa4D1Y3A+CY5PRq
         QOy9dcSkXGANa026xdCQ3tRJKFwgpM8j+DimCXN+Y4/kjGCMBhqsepPtzpqsiNScMzCc
         KSy86HhDzeNcR2lQf8w7sN2AepQXcJPvOlgGbyeEolKapVuAPtbFB3kZYG5Cd/Z8nNHp
         d4bwkcv1cs6do8pBgpiEYLZRa9GmB+7pQJOCw9xe1p9wCon5ung645+F/LyZxSwIiFxS
         t7aOxkeUIOrOKZGsaqrpgZqYBDUbZOwpMzYbqZC4YcFgc4BwCGD24K+ckd0so6Zk9dND
         8Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784425676; x=1785030476;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LEAsi3V738n9AGAW8Zy/c/volgRfd1AzGto8nsOt6Jw=;
        b=QlNtpsu5u8R+7qCtfCBN9QvG/D6PJiXHu/+tYwL0SjK+wRKG+h9pJ+tC5m17m6/6Lc
         dCxzqvADSEx/ZNFCfFQcJBMDWlF9g1gB9KIkh8D3JeZTnIsS4I1CG0IMqyz9jwIyjgFO
         sVUOgcyK9f1u6tRAUUYLMmRh0TOJ8oi8foCQWUPQoUpw7rTERl1YDhuBqX0hLSaTCtP/
         Df2k6oQrlricvnUTonPn/qXaddTDVZpwnFz9suIsRv1awYRG1o4OPl8agyLTGGN3k14N
         vcvfvrZubhSCHYSa4GoOiA6VCLMr4aBycjL0+X6zU1wqLZHJeKY3ZvEz0j84YZ/vhZJA
         E17w==
X-Forwarded-Encrypted: i=1; AHgh+Rprst8/Dyzmc7vppXVBOSxSUgPNqaPCnBhJ43q2oF0P2zmQYFWuhiVUVbTrq8FfdMLlK9lu13S7w5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoC/GGZmy7h7DNYxOPJroRE7DIuPo9oZ8qLJ6I87969Q0JUFpy
	2tkt4fVM0WMt2ySGVYuEs7lj6Y/zPyz9XdphlIe+8jNkh7lJAneHlLcPbFSy9Iz7p21aoFXJJ2F
	wPSVJqE8TInmMsQNZu+UVdNXlJkmQMhczAdELvOKvpNglhTvETeN6QHdYqcp2EYY=
X-Gm-Gg: AfdE7ckJNM+i+61+yaYx+5RQzeMBBlLON7x5Myp63W62Sc0WbUBmXoiVcdl1b9+JwK2
	hc245iuq24MjfZU4Xc9TBPjcM+3e04MweBlR9+wSACYx3VQ3kRVaubdOuvDFhqLIPVKx7Vno60z
	oTlWGmzVnJ7pxzank8ZVAmbYGLtK1KDcrH7wtGgv4kj+IYfNTLmg7HtFUtPzvEPbv/L0USBfjK7
	nAisaoMZUTfrOKLI96owcJ1RSODfmX/7MpbcGqfQghJiEdFnyehazoAV4QAXM30IIYFKLbfRie/
	CjLhKgnHxc/AqW9gxlQIT2yKaSQs2IMf4iaX83bm8KtBcuZ+wVyQVqDB1Csh0G04EqfxH2His7o
	f5emOT1BpJ13TiNxE
X-Received: by 2002:a17:90b:3c4f:b0:38d:c50a:714 with SMTP id 98e67ed59e1d1-38e4b56dd7amr9951567a91.27.1784425676322;
        Sat, 18 Jul 2026 18:47:56 -0700 (PDT)
X-Received: by 2002:a17:90b:3c4f:b0:38d:c50a:714 with SMTP id 98e67ed59e1d1-38e4b56dd7amr9951543a91.27.1784425675691;
        Sat, 18 Jul 2026 18:47:55 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e3a0d7a5bsm5478408a91.9.2026.07.18.18.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 18:47:55 -0700 (PDT)
Date: Sun, 19 Jul 2026 02:47:50 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Esben Haabendal <esben@geanix.com>
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>,
        Maslov Dmitry
 <maslovdmitry@seeed.cc>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: light: ltr501: Add ltr329 driver support
Message-ID: <20260719024750.2a1b535b@jic23-huawei>
In-Reply-To: <20260715-liteon-ltr329-v2-3-d18af55edab5@geanix.com>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715-liteon-ltr329-v2-3-d18af55edab5@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Cn1iFsyJfrbO8X3vnTL72WgdKWcEt-O-
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5c2ccd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=ilKATfAMAAAA:8 a=Gh6hzXj28-FDc_ewjUUA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=73awMTU50e6eLoBjGbzZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDAxNSBTYWx0ZWRfX8EmVO1X6yI1T
 c3VF6J+23hNmi1H/nJCf3JHogJ1AMvV7dAXcpIbEFbBUk27xaBljzQygH2+3xKFADyrLzaMVET1
 1qy5/872mNEAqrYDnP+KyBx9WMXG14tJ56vEn/KUaONrj3Iog19j0zlmol33/4wWZo8pOvhwj+J
 Ddccc945kelR2PvWEIwCXpzlwfyZhvaAzw5Z7wqrIt2dd+JWHCZZsyoS+INkaglecPWswlgM8Ro
 ZRq6IG4SrN5njeYtdtcHpZEiHDgfD10ssNj9zJ7QwQDt7cnaOV2tXbYPDlY1M1f07VAuhqnSNMb
 srtr19t9Gv+n5nePW6zQI7bYomFoYUpyGHcStgqJk2iR9dSsugC7pNTi1sV6je4Gvv+Nr2AVFuu
 6bJrg0FUOBAesvXGgXj9eFwt23FqekAVzLrxdL4VvKwka3hP10Fm2AL6iG1xuLlZaaf+eUIJVhO
 okbpqhPtzBDXnlcsicw==
X-Proofpoint-ORIG-GUID: Cn1iFsyJfrbO8X3vnTL72WgdKWcEt-O-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDAxNSBTYWx0ZWRfXz77XANXSrsAR
 HbstSvgY9zIFR0jTSrI/eXh38NZOtFFQ6qyEBOr2W/2n1pMaa/nizspLhpd3/TJiNBnW2MYhxf0
 0saUrXl7KcR1+nxtVK29Ulb3Ezvwins=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190015

On Wed, 15 Jul 2026 14:27:25 +0200
Esben Haabendal <esben@geanix.com> wrote:

> This adds support for the LTR-329ALS-01 chip, which is similar to
> LTR-303ALS-01, except for interrupt, which LTR-329ALS-01 chip does not
> have.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
Hi Esben

A few comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/light/ltr501.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 7d045be78c6d..379e57ac5f5b 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -15,6 +15,7 @@
>  #include <linux/delay.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/array_size.h> // for ARRAY_SIZE
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/events.h>
> @@ -94,6 +95,7 @@ enum {
>  	ltr559,
>  	ltr301,
>  	ltr303,
> +	ltr329,
>  };
>  
>  struct ltr501_gain {
> @@ -178,6 +180,11 @@ static const struct ltr501_samp_table ltr501_ps_samp_table[] = {
>  			{500000, 2000000}
>  };
>  
> +static bool ltr501_has_irq_support(const struct ltr501_chip_info *chip_info)
> +{
> +	return chip_info->info != chip_info->info_no_irq;
> +}
> +
>  static int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
>  					   int len, int val, int val2)
>  {
> @@ -428,6 +435,9 @@ static int ltr501_read_intr_prst(const struct ltr501_data *data,
>  {
>  	int ret, samp_period, prst;
>  
> +	if (!ltr501_has_irq_support(data->chip_info))
> +		return 0;

This is only called in two places. One of those is events infrastructure
that I would assume is not registered.   For the other in _init I'd
push the check to the caller.  Would avoid oddity that we seem to read
this and get an 'all good' return when there is no such thing to read.

> +
>  	switch (type) {
>  	case IIO_INTENSITY:
>  		ret = regmap_field_read(data->reg_als_prst, &prst);
> @@ -466,6 +476,9 @@ static int ltr501_write_intr_prst(struct ltr501_data *data,
>  	int ret, samp_period, new_val;
>  	unsigned long period;
>  
> +	if (!ltr501_has_irq_support(data->chip_info))

This one is called when setting sampling frequency. I'd gate whether
it is called in __ltr501_write_raw() rather than down here for same reason
as the read side.

> +		return 0;
> +
>  	if (val < 0 || val2 < 0)
>  		return -EINVAL;
>  
> @@ -1257,6 +1270,18 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
>  		.channels = ltr301_channels,
>  		.no_channels = ARRAY_SIZE(ltr301_channels),
>  	},
> +	[ltr329] = {
> +		.partid = 0x0A,
> +		.als_gain = ltr559_als_gain_tbl,
> +		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
> +		.als_mode_active = BIT(0),
> +		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
> +		.als_gain_shift = 2,
> +		.info = &ltr301_info_no_irq,
> +		.info_no_irq = &ltr301_info_no_irq,

The suggestion about a flag in your discussion with Nuno makes sense to me.

> +		.channels = ltr301_channels,
> +		.no_channels = ARRAY_SIZE(ltr301_channels),
> +	},
>  };
>  
>  static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
> @@ -1531,6 +1556,12 @@ static int ltr501_probe(struct i2c_client *client)
>  		return ret;
>  
>  	if (client->irq > 0) {
> +		if (!ltr501_has_irq_support(data->chip_info)) {
> +			dev_err(&client->dev, "chip does not support irq\n");
> +			ret = -EINVAL;
> +			goto powerdown_on_error;
> +		}
> +
>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
>  						NULL, ltr501_interrupt_handler,
>  						IRQF_TRIGGER_FALLING |
> @@ -1604,6 +1635,7 @@ static const struct i2c_device_id ltr501_id[] = {
>  	{ .name = "ltr559", .driver_data = ltr559 },
>  	{ .name = "ltr301", .driver_data = ltr301 },
>  	{ .name = "ltr303", .driver_data = ltr303 },
> +	{ .name = "ltr329", .driver_data = ltr329 },

Please put these in numeric order in a precursor patch.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltr501_id);
> @@ -1613,6 +1645,7 @@ static const struct of_device_id ltr501_of_match[] = {
>  	{ .compatible = "liteon,ltr559", },
>  	{ .compatible = "liteon,ltr301", },
>  	{ .compatible = "liteon,ltr303", },
> +	{ .compatible = "liteon,ltr329", },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ltr501_of_match);
> 

