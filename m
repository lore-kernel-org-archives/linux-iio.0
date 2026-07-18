Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863463254BD
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784415044; cv=none; b=l9dj5++zttbp0s/jedW4INUORbV2Ghmb/I/TfFgoZLoaKtOBadcgekcP9qDt1sYQ8TcVxVfwNtw5TdUv9sbCVKdxA2h6F7I6DRC94t3TXQs+MHttqaz7HZWKU4JVctf3UHeI7no2/P6TU9VnyT4JmktM0j9E5La0nZNucCELAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784415044; c=relaxed/simple;
	bh=obJQuYiFerRlAZsJd5YSFky/LorP6Nw6+tKO6ZSHaU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZevN2PU7gSC+WAxjcPcwl2yjc4Aj3uNl7XO6QX3miwtbXdko6FeYc/CXZS1JjqL62NbE3HQlNMFe90U8G2qW9Lc0MUYOLsvnnWQ7XXN1kPrKhotKq7fZCtiWV8xJJEqsu7C8SzVXeWMQD7SPF7a0a8Swq/Ty/SU1wx7c8hescZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d+x/8SfU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C6z6ZA/c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d+x/8SfU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C6z6ZA/c"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IJrJi41668683
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	obJQuYiFerRlAZsJd5YSFky/LorP6Nw6+tKO6ZSHaU0=; b=d+x/8SfUXQ949Mie
	5p+Km5Odggi+9kR7qHfYVDZyyO4O31GXNCQLKLtqFjhBhwFyILz8gBaVX01rdHub
	x4Z8C7OcY0kFwpxuBMRdK6W7DcXsLBd36L+7mTSj+IC5R8JKXLTAX+TyFkeHCX1D
	VNkAzHpjPsDG5I2jB3y3FFKyu5Dh0k81/XJBrcyod1ShmE46yQ8KzFiIUyEsd2zF
	PLkyx0l7eKQPhsLBU6Von7Fj+P2y4UJV8Yg3VWtSDz/ZcGk/5h9tOmah/ZTOi7pr
	KG7zSblYswtXpHhjR/UDSnZBrJ7OwapZZYrdVRmlTiHgSc8rhzEG0fgEOa0iVyan
	F7NtOg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2af1pea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:50:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-388b404eaa4so11832331a91.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784415041; x=1785019841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=obJQuYiFerRlAZsJd5YSFky/LorP6Nw6+tKO6ZSHaU0=;
        b=C6z6ZA/cr1Y6MsiHRwhWuXBC00n6WAE38BxDhpuonewP27md0VxdpDvg5sc4r6lPmG
         E7UxEmeeRsdxVaQKsmbcUyC384W8usHYWALuPL33DCKlX8kgip0x6uEIJc5yzOMDCF6j
         t2TI/95TVKmPU1MzqnbLYosOxbOK9LmqTF03dSd37g868L2sJSerzTvTyCkfHhe4tRWE
         Y66vmGuTwGxwc5++0unLO4w1U+H/suA5WXA6+Gav52kXAPWLuJNYjcqDvfAnBemDxUKi
         DEDiuX4M9hKbqha9j8JU8Ir4mgI+XJP4wdncjgewFtcLf8qsLAGUDhtLj5R9S+geBXIn
         5P7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784415041; x=1785019841;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=obJQuYiFerRlAZsJd5YSFky/LorP6Nw6+tKO6ZSHaU0=;
        b=HuxEYw8ph3VXLDjVH84U1oD2Me48+P4vIuR/dJzLLrcuoqbOh8h17FMXPJtgrFB+h6
         3PDI4bdQ/K99F2zR6hIxg5UoQ2qz5J1BNyejY4i/NjbULcstsjCwO8DLiVhw9V9BaR3k
         T/MoNWoKFbK57NgE/9gd57WpweSYLGsfpPlJyerDgoArfdV5BZPKEYI1hHmayre7QcuM
         jrUe1nCKMObZ68kb/4agVzygkZyP9DI+nsteGK0yObyTHPnUMe91zTVsGJXcSS/bOt45
         ZmnLCAjU2Xs8qr8Rk8RpUH/GwfLakqeW7lQ4gbqJQOLmiLYx2Xtx6Tv0mp2JiZ3jnHRM
         eEVg==
X-Forwarded-Encrypted: i=1; AHgh+RqS9+wZXtpUHMIeFryEuekCLuMB0VsuVCodGOsT/6drV5So8mDT7jYYuiKVZtDPHM+SPTUiy85XK6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5+HtRIajpaaRxFjHWLjl9jZW/SIZJT/+euptjCKSkLPzipVD9
	FCmhAb7IZXOFMJTKNI6Qh8mkGuvwzeNUZNPpz5Qu9o55v8YBR5qxHQl7LvujTbmOlmG3M2kiUSQ
	409ZRcoe+6+3s4BaV8CLHIaD9MXi0NJxqzjjzCvsuTIEyAinoyWFdyMV41dJ1qbU=
X-Gm-Gg: AfdE7cktgoh4CPaTDYoq0qPd/tU0mO7jFAzIs9e7oVmQYxKP+gRdsgqQqZDp6zGPq3M
	FyAzju1XBITVHiFPE0WcJ8nelPzW1xGTLVzUxmvZluV04uPxrPmwmcYYGLJbIMmhdT47ryHIhEH
	hvclxW72g/9fx5OvHafdea0Loyj3/skqQQF92pn1J5yxLNzSz7ZsdIcc5XPfS8oO85C46QopxjK
	itBPld8LdxAQ8Qm1JVARyu4T65OgbJcHQ1MunGoakg9dcf/6M6TIAcIS47F4wTSPNC3CSUEhEO2
	o5rDap40fgzucrvg6pR+ceMBsV1D8mR6myu33eMjfkobuAjcca5vcuZJiS5vmk9F3QdLxJ9ouLE
	OebIjhq/dOOvt5gRE
X-Received: by 2002:a17:90b:57c5:b0:38e:2860:253f with SMTP id 98e67ed59e1d1-38e4b447cd5mr8914173a91.12.1784415040876;
        Sat, 18 Jul 2026 15:50:40 -0700 (PDT)
X-Received: by 2002:a17:90b:57c5:b0:38e:2860:253f with SMTP id 98e67ed59e1d1-38e4b447cd5mr8914153a91.12.1784415040356;
        Sat, 18 Jul 2026 15:50:40 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e3a0d82d1sm5074615a91.10.2026.07.18.15.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 15:50:39 -0700 (PDT)
Date: Sat, 18 Jul 2026 23:50:36 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: =?UTF-8?B?Vm9qdMSbY2ggS3LDoXRrw70=?= <vo.kratky@seznam.cz>,
        nuno.sa@analog.com, Michael.Hennerich@analog.com,
        dlechner@baylibre.com, andy@kernel.org, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: resolver: ad2s1200: use dev_err_probe()
Message-ID: <20260718235036.6b71a337@jic23-huawei>
In-Reply-To: <alkg54Nc79f-bmha@ashevche-desk.local>
References: <20260716170306.166804-1-vo.kratky@seznam.cz>
	<alkg54Nc79f-bmha@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDIzOCBTYWx0ZWRfX1PVWep70vhWh
 +eGMOh8mJH74xVzFfpMcqW6f3F5R5YwDom00R6WXq/lyfYv4wiY0yD11P0N0jn32rtZ77yjiSKB
 ML78vO0eLigARXWe5vO7NQZKVUj4BU8=
X-Proofpoint-GUID: TVxTbu_S6maBTBwgZdlHW_455iwh7mHN
X-Proofpoint-ORIG-GUID: TVxTbu_S6maBTBwgZdlHW_455iwh7mHN
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a5c0341 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=QyXUC8HyAAAA:8 a=Wm_U45AI3mUzE4zcbAQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDIzOCBTYWx0ZWRfX9wLG6hcvVVL1
 UcLvOtcrAFhXkk6f1tkm0GfC4rzMCFxRFfMnnjruMYTA2p5DSMUJai6D9cr3s445LVO9sYqye4v
 F+jjnZWzkfLXkDDECvIkD5qzEuY6bbByCjTFusav8zMGgBScjyfpFu+cj3dVaDpDmcpHTHjrMao
 kssiJp1pv6cwELmirPswZ7tFA6GixUAqyj2YnIVfW7W2Fb+YtyZpHorzbF4GCROp3/SabLng1o/
 U7/7ocKFYYOt+2n+zx/4Y3yaaOKqLhTo2FiVKoegGaTnlwW+Ey97QQ6a0lRuyuu0KdDuNw65YCL
 HzZvYDoNE9BxC9PgoMOMgg6ZJ5MurDb/izzjtF0sYZp6+iM0nUspdAIus7x2Z3/EHDRaJJ+wX7l
 5yFgc5myA0iIJGjSbpllw1Ol4k3E+tYms7dm3FLLmzq+FDalwUWKZz8sP9v3L2XCwaKbuUv6x+M
 twNcB8GDuqMe2aZNoWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180238

On Thu, 16 Jul 2026 21:20:23 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jul 16, 2026 at 07:03:06PM +0200, Vojt=C4=9Bch Kr=C3=A1tk=C3=BD w=
rote:
> > Use dev_err_probe() instead of dev_err() to simplify the error path
> > and cleanly handle deferred probing. =20
>=20
> Wait at least 24h before sending a new version. Please, read the comments
> I gave against v1.
>=20
> ...
>=20
> No need to send a v3, now it's a good time to read comments, discuss, take
> other opinions. For example, if Jonathan is okay with v2, it maybe good to
> go.
I think Andy's suggestion was a good one, but given it would involve a coup=
le
of patches to add it and convert other places it can be used, probably foll=
owed
by an update of this patch, I'm going to take this now and suggest anyone w=
ho
is interested can revisit Andy's comments.


>=20

