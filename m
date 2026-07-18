Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8E3E47B
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784336536; cv=none; b=ttBiCblLXifAeHsVLSF+1syVFf/+6Pr22eLwTD4kzDxEOHlqOcVeTTYw/kSIWy5CtVyhVzy7hE3FcYmYZkvXK8MBMXt++d52UIQwG5m32a8GV7E+3nXnLYfMntoLEsvibpiKStHT3+sxXjyQE5UFCRwCKRLDm+iViGa5mZ9eTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784336536; c=relaxed/simple;
	bh=LB8WmO6Xt/8YrB/XsflzPn3mb+khWBvgDJxKZshSPec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/2Sw92Da3D5GZcK/6mQP/tHvjt5OTHIQWvzhNQlHVnxozM8q4HWE6gwKC/FDEWokFUhUOdCxKqApwjzNL8PghSnLeoJHStIiI320slp4bdZw7yWbOfS5l9Bme3qXqjIqucytllRvHmxzbJ0aYK5OQu1Nf+EByDVBBChJ9TAxJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KvQCMRDN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KQEZ3tFG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KvQCMRDN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KQEZ3tFG"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HNESg93207869
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ndVLBGOaRkTIeL6UHZEk0Jhyj0fG2C+GgrAhet6ouvA=; b=KvQCMRDNFCLHIu5Y
	BAVpFBuw1FXrhE7ZwgIXY6AG+O5LEgEozjBHrLTeubn9+H8E3MlVmR72i4oI8+4U
	VSrQsbMqMI9b696vWMgHCMhHp8R/mV3NWDxR5Hz2e/UGekK3nr5k1uDSulfh9oMi
	8BrIzm3vjpygWjFMGPeVysUCi9ijcJd8I3x+f/uyJ9N4/gjFgS/bSsLxOrgUMzIC
	n023cDu53Srm5jIOTP1nuVTHXU+mGxhqCpf/kJ/yW7aZu1N/54DghWdu8q2nkE9x
	r5bcCGI8b3ZN0fng4vq6be9mImQN5+Ds2L43eYQC0/3+Ydn+DU3r2m9N0zzabwHn
	TCh9ew==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9guxnf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:02:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc88e22f92so173129055ad.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 18:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784336531; x=1784941331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ndVLBGOaRkTIeL6UHZEk0Jhyj0fG2C+GgrAhet6ouvA=;
        b=KQEZ3tFGQAOssuW40hgFXLHfyq7sikjpUdPD4nsocBe6XvKvkmp6FaYAu2zSKiLE7q
         nFJVImxPv8bOqzDJSuP0HU/p1AK40pkYEwgE+y48/Skc/RYd6pXhlRp3ffbZnOXRL0Uk
         UQ6zoumRmNjkadN5rblAHu8h+3babDgj1dHYHgxAGKE58yanjx4k+Hexol6QYpVUkExD
         LKl1BHCKv2uB3+IOU3zM8gDCIpAuwTfgsXUGsmYepBcLWoHMKlNZ87mFYqnnoRTn6rOU
         7NTpR1i3GPJ3DQ8miMu/xs5bNOtVK8VtrEzOAT6eFCUx/DT2RjGm9AKgHJ8G3BTr0M4O
         PyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784336531; x=1784941331;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndVLBGOaRkTIeL6UHZEk0Jhyj0fG2C+GgrAhet6ouvA=;
        b=KzDiCAq17uWc9LdXrLwXfFXiey9p9fXMFmKRlpk9KFtKGzCIFayY2gHd/0YX3BqazE
         0ZX9Bpc2LD02PZykDa88K+1vk5TOlAjbPztLYmUYxgmBiR/QRRLz4ZngzkW0Afn04my0
         QdCcZ78GU8q5ShbjWNfu8VpRW2qZRTJXR44YU4Ua2TuTjUVQCzIe5VLH3DrczH3pwEPs
         P+0EAHVGgdxahsJdJ2jGKz2z5Z3EkclfppaZ+KPBTKAWOejEfMYz2d9aFaOjfaKf6a6e
         09tmGnhMc/CeB/LGtIxcDVsG2SslNcsWftF/k/8bMSVE3AXWlGTJank84fdYr6SklJNX
         lTew==
X-Gm-Message-State: AOJu0YwX5O1FH/EcJRqHXM+jsuacp+23vgy67j4rS2ktAicwvotOZ6Fb
	ELYKPnycuZ94JXlsj59KQo6B0sW7pH78TmUMvzWndM6kO957c9RZTEp5rViZV+BnORW8acVIiDx
	WY5Zy2Fv5AY61mF4S90RYyz4RnCwdRz+k9FH3JYRg8mQ+YGtw7lg/oPAYBRqKRIA=
X-Gm-Gg: AfdE7cl8MtVcu6CekzV5if1RXNlrEnquNJ4lB9BbbMC91o5uYQvbwHpdr9yixuJDL+X
	k0LKjWQANqydsFuKq35J4TJslYyzLuS/c9FczgPpABREUulJpe8eRA9govCi8y+HF15IlIPVJpp
	ZM/3nphTOrFWJumx+sl1ELJPUG2jsLdNusavm977YAVM3mELscA8jrH0SgO6QAXuyAuirgob6vr
	x0mnawrtaVrILUhVkqNUPvN/0BPEHyT9yv6l8X6jbpB6bu1D6qFcV5hCduNj58IfzktQGVYS+H+
	wDtES3dR0/MdWAosNGPApcGsbEE7sbuTirpcSZOmOtR3NnQ75tNrKjpLDtv3UfI+4e2d97aocHE
	truDlSUrvYS/K7HYn
X-Received: by 2002:a17:903:458d:b0:2ca:17e2:2acc with SMTP id d9443c01a7336-2cf348bbeeamr53782835ad.21.1784336531047;
        Fri, 17 Jul 2026 18:02:11 -0700 (PDT)
X-Received: by 2002:a17:903:458d:b0:2ca:17e2:2acc with SMTP id d9443c01a7336-2cf348bbeeamr53782445ad.21.1784336530589;
        Fri, 17 Jul 2026 18:02:10 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf342e3a8esm19632685ad.0.2026.07.17.18.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 18:02:09 -0700 (PDT)
Date: Sat, 18 Jul 2026 02:02:03 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
        andy@kernel.org, marcelo.schmitt@analog.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jorge.marques@analog.com, antoniu.miclaus@analog.com,
        mazziesaccount@gmail.com, jishnu.prakash@oss.qualcomm.com,
        duje@dujemihanovic.xyz, wens@kernel.org, sakari.ailus@linux.intel.com,
        linusw@kernel.org
Subject: Re: [PATCH v8 3/3] iio: adc: ti-ads1100: Add ti-ads1110 support to
  ti-ads1100 driver
Message-ID: <20260718020145.72762d9d@jic23-huawei>
In-Reply-To: <20260717185033.246580-4-jakubszczudlo40@gmail.com>
References: <20260717185033.246580-1-jakubszczudlo40@gmail.com>
	<20260717185033.246580-4-jakubszczudlo40@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDAwNiBTYWx0ZWRfXxun+6DzsTlyy
 gHfJh9qockptVX6J9ND7eIDt/Yucq2gcKWpYGT2apAT0so92gPeEMn+45kAKLUKFAkLM7rGNUQJ
 V3eI/pLKIc5BbzcyRbJPyp/BvF3S7OE=
X-Proofpoint-ORIG-GUID: jCKnk4shDxuL8kkeM8GIpugH_2xnNmTA
X-Proofpoint-GUID: jCKnk4shDxuL8kkeM8GIpugH_2xnNmTA
X-Authority-Analysis: v=2.4 cv=TaumcxQh c=1 sm=1 tr=0 ts=6a5ad094 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=mcsFP2XhKlOFKfFfNWQA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDAwNiBTYWx0ZWRfX4YWU3AmAmlpK
 4RZa+aZ97oG+hteFGrQpJ7zfAQjJ2BD9GdDdeLTRXEhi4I8m8h60XUgqWoXD8qL7ic+fetR60ij
 6IMrDhr2sXD1qM3aC/rweYU6TSzFdpEhCFMVWjrfhTH3Y1Op0fStJo/zejsoO2GvkD7MyI1vuTV
 vsDPmD781QvTmHI4PTyQSf9JTB9mF+3vJhGS0reNwx3jNPZOLOKdD60afDaRCYOhYWpIXoJG8IS
 p1AC1SkkQqyBhFaY4ZT5NDWMGbXAnBPZzMJWDtPN45CHdy66H1M4ZcIH2Je+hp6ZXHZeHmczyxK
 vC4J3f7cT+eZ2jhm6v9gZiq/lfysjWSYmgmUA8UjSLtTtuJZm0JymkiNy7g1uWinMyYM8wofzwy
 grbjDIwd/2Ij8iDgnW+8/9fCBDWs+F9d/izmEf/KSO+nr64+6gfssQTJQkPUVXklBW8PzkGqcKt
 haPXuli1CEMxsu68gag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180006

On Fri, 17 Jul 2026 20:50:33 +0200
Jakub Szczudlo <jakubszczudlo40@gmail.com> wrote:

> Add ADS1110 support that have faster datarate than ADS1100, it also uses
> internal voltage reference of 2.048V for measurement.
> 
> Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Hi Jakub,

Seems some stuff in here should be in patch 1.

Thanks

Jonathan


> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> index 363f790ca5d5..19533667e6cd 100644
> --- a/drivers/iio/adc/ti-ads1100.c
> +++ b/drivers/iio/adc/ti-ads1100.c

...


> @@ -139,14 +177,16 @@ static int ads1100_new_data_is_ready(struct ads1100_data *data)
>  		return ret;
>  	}
>  
> -	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]) ? 0 : 1;
> +	return FIELD_GET(ADS1100_CFG_ST_BSY, buffer[2]);

This change and the use below seem odd to be in this patch. I guess
they should be back in patch 1.

>  }
>  
>  static int ads1100_poll_data_ready(struct ads1100_data *data)
>  {
> -	int data_rate_Hz = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK, data->config)];
> +	int data_rate_index = FIELD_GET(ADS1100_DR_MASK, data->config);
> +	int data_rate_Hz = data->chip_info->available_data_rate_hz[data_rate_index];
>  	/* To be sure we wait 5 times more than data rate */
> -	unsigned long wait_time_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, 2 * data_rate_Hz);
> +	unsigned long period_us = DIV_ROUND_CLOSEST(USEC_PER_SEC, data_rate_Hz);
> +	unsigned long wait_time_us = 5UL * period_us;
>  	int data_ready;
>  	u8 buffer[3];
>  	int ret;
> @@ -159,7 +199,7 @@ static int ads1100_poll_data_ready(struct ads1100_data *data)
>  	}
>  
>  	ret = readx_poll_timeout(ads1100_new_data_is_ready, data,
> -				 data_ready, data_ready != 0,
> +				 data_ready, data_ready == 0,
see above. Seems to be in wrong patch.
>  				 wait_time_us, ADS1100_MAX_DRDY_TIMEOUT_US);

Sashiko points out that the polling period is very long.  Was this meant to be period_us?

>  	if (data_ready < 0)
>  		return data_ready;

