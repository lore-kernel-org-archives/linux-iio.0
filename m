Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEAF3955E1
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714919; cv=none; b=XRfs+9d4hHqTC7TOsppfj3Lvxk6eXDn5ASJ/97gNhgE9nzuBNz460ye4NQz+O7XfPMu87la167XsO5XMN8QROjNWlaEs2kCnaNy5i9aSW1OZAPhegCKmg2Ac21vRqlspBoN1FQlF+dZdye9WQ0q71zZWGv9nPLSJRMCkP7s7TpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714919; c=relaxed/simple;
	bh=mwmcHxrVR+kz/WQi8iOjtcMfnkGRz+vLnMOAEhzR2Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HArtVvuXulx4agkjRpUf+PihEIxKfFZspRtFYjbmHIkM0PY0czdTeq4PNpeanOfyg+1nXWGRCaE41x41uer+1pItE54QI4lNW8k61THZU+HVX4mxiWvt017YefeLLv0iOwLRPA6Bc0oblImL6k+shpwK3JKEhPcb//bF86X+JVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RRaayQZ5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CeNYHzfd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RRaayQZ5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CeNYHzfd"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AKDc8q1811764
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 20:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f5MBPQjfTBEuM72l/dKsAgwUJbCHso/oUhnZImxy64I=; b=RRaayQZ5SX846iDI
	LV0P5ysidPkoDfl8AHncZ6zLIPkh8pIQNfFx5uEucad6t39P5//Q+Gk2+jHRaVbH
	vPJR716lgEY+dOIiWziGWqwrLNCK8L6hBC6ruKLTSK0AjI1Mv1Q1cuRK+pxqxEFN
	lWpt+iKZ9gCqiEFVaDNLPWFRBiF49NnLInuaOBZnYsRSaw7O1TA44y3kO3GoXYeX
	eL+OuWAEjjlYg7eIasHjLOLjoHXSJ/OK+hjSshOCEaBx8nWwMAeGP7mvjeTJ101X
	Yel0bA/vddguKGpWA2Gf+5yGiFeuWSZLmQwZUDgdlYivwuVxDIXErTQSnXpSr7x1
	5gRxIg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5faauw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 20:21:57 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8486c3411c8so1872377b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 13:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783714916; x=1784319716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=f5MBPQjfTBEuM72l/dKsAgwUJbCHso/oUhnZImxy64I=;
        b=CeNYHzfdzWxuUc4MPdpJOr/C+st3TfiYb+DNvAH4GAWewpJTyeypDAavZqt4bB5fvb
         HFCNENNJBa1Qh771iSBzRylkFeUyXMraUMUX8CBg/O0Lefwks8Vfn6SQzR45+6sz27XO
         rZHWpcpxOxtM4h0XHUmxoyFBalMiQta78MdNnu1eDLgMB+Hvzq63yucGKWokMxWLVMJQ
         irVX3bk5Gj6B64SM+eqc1s3M/4GKV1/DtUp7Dffy+U59mrrejbIBYqIzrNwwaDE6X6+b
         M7lS0Kasgfg4ihPAabuRTKeY54wyfy7VOToq/blYD/iz8JP05VkRnI+RyqfzQ6NFwuZ+
         LSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783714916; x=1784319716;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f5MBPQjfTBEuM72l/dKsAgwUJbCHso/oUhnZImxy64I=;
        b=LMALA5j0kh8+i0n3HT6SmCL5JtZx9Tj3ySD4tVQxjILtaVK3Z6f4Xp0quZpR/qYo4a
         WOZ5O+bvk4Z96sTGCXg22/Wd212lF5OxicgXp98ozJ5MeV/ecdX6Bz9mn6eJhDt+MGK3
         fyPIIr6nS9EGFFJe9k/sQQBQ0zTDk9q2lEIxlWhLX9F7ZMrBnsxDeVjsvawnSyMpdAzw
         F0AY0gfh7pEmTjA0yY7KaAANw6/OfClHqK0rnWswoG1ZzgU/45G3xOYoB573yJz9nGgC
         orwE2uTbOfPC21eOGLelWaxleg3c38JYj3Sxx7A8U9d8xMoZPT3rt7ky9hmeX5RaM9+1
         Gv0w==
X-Forwarded-Encrypted: i=1; AHgh+RroLtNmXUbcka68UHISvKbDifI8709GiwQ5BUyQOxkkFg6cgt4vcNF52L57G3lvJv2q2EBtDQCjX1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9K9gxj19EtmEjS2e2IKUZWoDA4bpFaX30rbfjjNcKzq+Q/1dr
	uDzTLwJfFvBrUhXN9Df32HIvdb8v/R9un/wmQP6V4HqXksm5ON0co164ld5sTwLgBK+f59GXLmM
	2wFaau9dfAPmpn7Jb5H9exXhzOFYrcqZMcVX4YlIjPd3ytNiaEEISGxYJGnnpVRQ=
X-Gm-Gg: AfdE7ckDVs8YrmX7AOaMu+0qwl4mRBRyfMUXE1p7Ebir2yhTJtF9QG6QgekKRWpXO3p
	VYpLqxTA1s23cv6jLIaQXa5HkgTMdHuSPyjfo9AGHEMZBTs/fqAa74+ys+8Bw0QEfVnBWvYIOSy
	4le6IeZI6L/93PDTN1wY1w9UTf2oUxKqnW/8tESN/EZb7baUansRA9G9+ALCOYsvPIzBFs08hJk
	hQmL7empPUaKk3r/rSBvmIpFD8f00yb+ovbwhMfI5DyOThq0uwJ33GKBXvb7+Iqf1CnCYTHsrxQ
	8E89IR1JaS2KQ4ZfwuDwJnUReAvv/bYqUz5T6AfcqnnudQKWWvPx/Q64G7pA62vSGmOdkF6UOjt
	bjrt9vqMPkTcqXLwdGCa7LDt5P4LBUNhyYfvI
X-Received: by 2002:a05:6a21:e083:b0:3bf:7fa5:8922 with SMTP id adf61e73a8af0-3c1100092dfmr545788637.2.1783714916052;
        Fri, 10 Jul 2026 13:21:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:e083:b0:3bf:7fa5:8922 with SMTP id adf61e73a8af0-3c1100092dfmr545761637.2.1783714915523;
        Fri, 10 Jul 2026 13:21:55 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b658a99afsm41399058c88.0.2026.07.10.13.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:21:55 -0700 (PDT)
Date: Fri, 10 Jul 2026 13:21:51 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Yasin Lee <yasin.lee.x@gmail.com>,
        Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: hx9023s: validate firmware size
Message-ID: <20260710132151.00000f37@oss.qualcomm.com>
In-Reply-To: <20260710152842.53659-1-acharyalaxman8848@gmail.com>
References: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
	<20260710152842.53659-1-acharyalaxman8848@gmail.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a515465 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=I__WuZVpHmGD6N4htagA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: CxPBYTOv8fKv-FmII6Z0AJZhnUcjbAUC
X-Proofpoint-GUID: CxPBYTOv8fKv-FmII6Z0AJZhnUcjbAUC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIwNCBTYWx0ZWRfX3jeKYtCc4YY8
 uH7tVHr3qXs0MuuAC+INBRzd7AzSQQMLpiwweLyHr52TZnFXnWEn3wyy6ynZM4e589UqGuWDgr4
 LAoFuP0/3YE1F8+MUYhGZe/RhO9cpP8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIwNCBTYWx0ZWRfX7N2f/yQQtBzU
 a/sEA5ueF81i6iBCoDwWFeMjIRAnIvH7LT8BN5ew5Dr9Ts/RMH45IGNWmgmaiEve/ep074fAMo9
 jvjJ+q2fOnyA7thk3eKZTaFg8233XH04qXz4XgH2+7SgAAYCbEvnXvzGhOkLts/mVoHvfu74MVK
 9EEStqZerMaeAJ1i6wUkIpwNzd/BBCQXmgLiPl6MEKJM47FxM25zzNO5W1k0yA9hK1xsmslLLuH
 IQRRMYhoPeXkKBQu5BKkqspuS2nst3bNL73JulpH5XPgb6e81mfweFs/v8jVwrbd5El5XBf8o1I
 kXqEacon+yXIWbknPJa8x0tskEJzJI3wQX40K5YvoRBTwu59xzd0LCw2RHjhn6VZfuD96QrABww
 AfhRzg/5UNOitrUI3Q87HOOwNotlSvQT79QlWOJNpso2ca5VUAHUqA1PuweA4m03VVUgmZC8V1y
 TnFumvVQZKYaoy5sLbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100204

On Fri, 10 Jul 2026 21:13:42 +0545
Laxman Acharya Padhya <acharyalaxman8848@gmail.com> wrote:

> hx9023s_send_cfg() copies the firmware into a counted flexible array and
> then reads fixed offsets from the copied data before walking register/value
> pairs starting at FW_DATA_OFFSET. A truncated firmware image can therefore
> make the driver read past the copied buffer during probe-time configuration
> loading.
> 
> Reject firmware images that cannot contain the fixed header, reject images
> too large for the u16 fw_size field, and validate that the advertised
> register count fits in the remaining payload.
> 
> Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing functionality")
> Cc: stable@vger.kernel.org
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
A few minor comments.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/hx9023s.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index a6ff7cbe9e6..9d91ce681ac 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -18,6 +18,7 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqreturn.h>
> +#include <linux/limits.h>
>  #include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -1031,8 +1032,11 @@ static int hx9023s_bin_load(struct hx9023s_data *data, struct hx9023s_bin *bin)
>  
>  static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data)
>  {
> +	if (fw->size < FW_DATA_OFFSET || fw->size > U16_MAX)

Add a comment on why you've picked that upper limit.

> +		return -EINVAL;
> +
>  	struct hx9023s_bin *bin __free(kfree) =
> -		kzalloc(fw->size + sizeof(*bin), GFP_KERNEL);
> +		kzalloc(sizeof(*bin) + fw->size, GFP_KERNEL);

This doesn't belong in the fix given it is just a reorder. Maybe it makes sense
but if it does, separate patch with an explanation of why.

>  	if (!bin)
>  		return -ENOMEM;
>  
> @@ -1041,7 +1045,8 @@ static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data
>  	bin->fw_ver = bin->data[FW_VER_OFFSET];
>  	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
>  
> -	release_firmware(fw);
> +	if (bin->reg_count > (bin->fw_size - FW_DATA_OFFSET) / 2)
> +		return -EINVAL;
>  
>  	return hx9023s_bin_load(data, bin);
>  }
> @@ -1058,6 +1063,7 @@ static void hx9023s_cfg_update(const struct firmware *fw, void *context)
>  	}
>  
>  	ret = hx9023s_send_cfg(fw, data);
> +	release_firmware(fw);
>  	if (ret) {
>  		dev_warn(dev, "Firmware update failed: %d\n", ret);
>  		goto no_fw;

