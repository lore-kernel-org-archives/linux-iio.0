Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5940E32FA1B
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784418039; cv=none; b=tarzOFvKWGMUkNF4m0lEcANbBX6TNJMkmJKqdwNFqVK1pFXwrGWN79u/YXjfT5EKGNLFpXO7tT6rLujj5XKkNV3Y93fPa8KynLwbn5oIwYVbfIeoSiD14rBEkiVcn87l/60wzHq0WBfHg8bIfNLGNnUg5Zij+yAJniVR3V3O/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784418039; c=relaxed/simple;
	bh=XWCs4fUBo6gGQ1M2CVgFrj56MJznDKoZZ3l/K7qUBiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzxWzOC/847Zk7mHODci8g5XUKgkNrMh1PUoLtMORykv8jikNSF+1LNsdU3YDXYiYa4B/Wo9ij4/5rLQFlGlcp+p3CdtSUqJeT0Mvs7vEBL3YENzyC/zUPMaSyC3zXzBF5HNj6p62fbaI2nNrPjcjuPE5TtEgMiXo372mphfYT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eqeFNGzO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Djgrl4pZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eqeFNGzO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Djgrl4pZ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IN212q1780693
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 23:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z3Q9taMjWV9GchlGB3+zBzhpobDtgh7Q1RKR4fp9cao=; b=eqeFNGzOzq/LuXAC
	rrVczsovsIm/nfjblLpCpc22YiURUUBI5y3tPn0mnzSpcy/r89538s+VpcWdvE04
	7Wv9HcU1dXRknHJfqImE6MUJN2i0YMQS7BU/eiILFbzjrvbq2fG2n/qge8+FEYwF
	ikOaOgM9Fpm2rDPqAba2fqWRj5eYnBRUf0hmyYKPHkX2t3UA2GGfeX+jywd9VFZW
	rpgj0SVXtFpxWz4KDSJaxvl/WfJJcMjTXWxVkbsqhCteLvSaHVrX1IWz3Fkd2S8h
	2DmnC4+ukJrdShJ26quDe3/iIbn0aMVWsN2DciWAHIErj3HQZ7A7RWkiN43WIK7N
	yNMb3g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvsr7j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 23:40:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cee1ec30f2so78229845ad.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 16:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784418037; x=1785022837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z3Q9taMjWV9GchlGB3+zBzhpobDtgh7Q1RKR4fp9cao=;
        b=Djgrl4pZ6NnU040txIyuUrBcR9LZGGKh8f59IwgUYnOX7N+oAbnbTI3OOq8FHsEqEO
         Ijqe2/MtpQBeJWbOQ23Cwd1YlJYhBctKupnkGI9xUcp73FtpCAUfuSkizAKcjYIa/ayR
         TBwdSLj2RFCX8Y6Kvt9GyMLfQjQ2Rp4g7EMr+VbbsENqdCePqRNdQBEFTlB/DZ2rVCAL
         RpQeet8EprQ7oOA6MSAKFjYHdsFum4/MjO+1MiC3evTYtgEf/MgP7vLgPSFshQZZsuUm
         qPsUnkyt0/58X5sIx+Vql9cuNmSMsfJ3V4UPbnBPW5jpnu8KgR8PA6gAnvLX92HA6Lj4
         oW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784418037; x=1785022837;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3Q9taMjWV9GchlGB3+zBzhpobDtgh7Q1RKR4fp9cao=;
        b=L6neTsVlWJIToMTgAon3Y7lyNZp+JuBvUsTTETRvJKIUk9+mw3+zbmB7+BztBeUQts
         eDBBwNYUG2yqu8S0LA5Hp+fEpbgjt9ZFGYA2AFa5Q+gCr7fCW+EZKJX97wCCne7wvTGc
         U+oKXfgZxg88mswC63XFOQAKtpSke4qrqfhIeRJzcOdNzYvdXtNDVL1wev32ISu7l1nk
         oIOQbbjkbfgiJk2kZP6+Uf/Neyt3VsN7EMJmxVnstMbGamrd9E2NTZjJjGOoBBbcd77t
         cC5lnm5fJeemvpy/txZRkKMHObvlV3E1ERy+TpegyRnvOvF4CRQ/278nnHoXp1P972lI
         7AhA==
X-Forwarded-Encrypted: i=1; AHgh+RpT47QO9jVag6FAACgVmk+90AnplypbHg0arlaJXdk83hBhj185QHJEMaKtohWZlCiYoFa2TMoGLKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxy4NxRrD8OYfCzyn3oXLxUDUeZilrWZYW80RTk/Kec33bhzZ2
	WUyp1qKde+Vm8NvQ98XjnRQxbbydz33W2v9P0UF0WUGA4EEErN2lM82khsGCAf94647Nq8iyEt+
	vHT78ekLLfA6Ecs3QIkT3cjaAsuaV+o+Z0bc9SV8scXorVCzhyyawbkrhjwYoSjY=
X-Gm-Gg: AfdE7ckqk/VDlJHkJh20HvSDPTTq2YqSwR9i22PBEECpz1NM9+reqx5CVxKiTgGEdSS
	kT6l7l1d9xzKlmxZ15DAzk6v2t+CnamWG7+Si/1HgTrVxr7YsmjEri+JTIVpyDRigoUDhzsedls
	eaBr58aOn5SRzeuIsPTUwIeA6Y3AAtI3/K3XCW5qmkS+Kkhq/02ZIOvtpq8qkdcOjzV12WsWPX6
	TLHIkFDliZ+Yy/fmUm2hdYBk0doQGqZwoT0RLQN5C6uZfdTfEayzOiG+MZwIr8yQTVG43LJWka7
	kMKC7Qdno1LK0sJGSlbAYpciw4giKQdJpZRSRyBbNQaAEKdRxnRFVv5tsZ0Xntl5JgUdVH4ulyb
	/mWQdvp+dGe3A1Fjj
X-Received: by 2002:a17:903:324e:b0:2ca:6514:9201 with SMTP id d9443c01a7336-2cf3486f1ffmr93265195ad.15.1784418036759;
        Sat, 18 Jul 2026 16:40:36 -0700 (PDT)
X-Received: by 2002:a17:903:324e:b0:2ca:6514:9201 with SMTP id d9443c01a7336-2cf3486f1ffmr93264825ad.15.1784418036323;
        Sat, 18 Jul 2026 16:40:36 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448d9b0sm33136325ad.13.2026.07.18.16.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:40:35 -0700 (PDT)
Date: Sun, 19 Jul 2026 00:40:29 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
        linux@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Michael
 Hennerich <Michael.Hennerich@analog.com>,
        David Lechner
 <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/8] iio: dac: ad5696: properly check i2c_transfer()
 return value
Message-ID: <20260719002355.4a818026@jic23-huawei>
In-Reply-To: <20260716-ad5686-new-features-v8-1-ebb0051af5e5@analog.com>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
	<20260716-ad5686-new-features-v8-1-ebb0051af5e5@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EqZCtAEiVHJ3GPeHLI4e-Wym2YrDG458
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5c0ef5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=eCasKaYD3dZQZqGzH0wA:9
 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDI0OCBTYWx0ZWRfX9NVdvrR60Jcw
 UISdrs9Dzmw7gywLv8c0ZShFRbg58NcD/b29e0sPibduBX5jR/gD//GNQj9SVbUq1IW8pgNGHTV
 WGmlAbTaOqgh7jqZes9xdd1xL8LLg4+3fxFv5XxTjTe4dlcpp2deBFGLELLAJjmWF7YvdQev/BZ
 A0LAqRw+xaK5/ThWpu/7WAUEdAPWieShQXCugeoevEwUEvhQJ96b2lPxHGwnAuRYyFCIBB+jjnY
 ljmfLncVp9f2mbBhUsQvnpqgWOqLRgxWRE/KPp5MBfbBqiuSkeT/HyOA7Kz0wP6ORjpZPAMHVuf
 D5qtNkyfgm1MdQfMxAz4x9/zE1q1IfeGv4fBJ/moPpCbp767GyaA6wq3p6GZAo2GWNIIhRdAEIu
 tz8C0HX8lSdWCKIqZWO20A/RLjyUMjlFkig5kN7vpynq44I9YyktF2rDy1qoSvOLU/HUccFkg46
 J8iDN0DkiKf9qzuLiKQ==
X-Proofpoint-ORIG-GUID: EqZCtAEiVHJ3GPeHLI4e-Wym2YrDG458
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDI0OCBTYWx0ZWRfX3fX7J8Hq267K
 Myk/nonOsg6XSs/o//xVlTc1C+a8kWkiFpuKd3VzwKX1NvK/m1SO3CE4+6aw4/fhxaJhIEdDtaU
 bz8RC7z3VvBd6OBR5/rw/9YaD0JP2/w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180248

On Thu, 16 Jul 2026 13:14:17 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Verify that the expected number of i2c messages were transferred when
> ad5686_i2c_read() is called. This issue exists since the support for I2C
> devices was first introduced.
> 
> Fixes: 4177381b4401 ("iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R support")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260705114746.1485F1F000E9@smtp.kernel.org/
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

Let's hold off on this for now.  Whilst it is technically correct today I'm
looking into ensuring that we never need this.  The only error case
today is actually returning 0 which in practice is an error.

> ---
>  drivers/iio/dac/ad5696-i2c.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index 279309329b64..551b200bfe14 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -7,6 +7,7 @@
>   * Copyright 2018 Analog Devices Inc.
>   */
>  
> +#include <linux/array_size.h>
>  #include <linux/errno.h>
>  #include <linux/i2c.h>
>  #include <linux/mod_devicetable.h>
> @@ -39,9 +40,11 @@ static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
>  				      AD5686_ADDR(addr) |
>  				      0x00);
>  
> -	ret = i2c_transfer(i2c->adapter, msg, 2);
> +	ret = i2c_transfer(i2c->adapter, msg, ARRAY_SIZE(msg));
>  	if (ret < 0)
>  		return ret;
> +	if (ret != ARRAY_SIZE(msg))
> +		return -EIO;
>  
>  	return be16_to_cpu(st->data[0].d16);
>  }
> 

