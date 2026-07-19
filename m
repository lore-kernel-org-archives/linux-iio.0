Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090A27280A
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 01:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784425928; cv=none; b=D8CIe9WcJ1F8kyc1iYCvHkZ+UzrCYEO6IpxLIJbscT+TiWQzZukWWXJk3FF2OVNAdjjxMAtjbNPnacDCz2h2tDZSBqE/BuLTsAXqHf2/YC6wqmzMmlx6zG6xtNsRjrutEXdn1TeCcnEExRi0zHxm9cy/VxWTpACApKycXjPuyCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784425928; c=relaxed/simple;
	bh=nQ0dx7z7VhqUX/xVZcJ7Oi8onwuylpkvTqsDeOO4N6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2/QADq2RkzAHoAVfu8W3yLZRaWQZVqFVUPrb4IYm/iVrD78BbYvA0BJ2tH8ApaAHVcgXlUp1P8RRAXNFsDo6z/og28BH9Ai2+ud0Ip3kK2vdgTvr6DmevKsOxQ7nmNI8hTaBdaoquEgZxUwCN7m3IU8AVlh9MRA8yeSbvwVsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dwVJvnaJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kZBG3u1W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dwVJvnaJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kZBG3u1W"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IN3LH51944575
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 01:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m2ykhDO9D2xyYesZwOG2ikM2DWqpI4oz9KN9zr7iQ/k=; b=dwVJvnaJi4OO7626
	2dYrzPGBK7itoc6C+wAYB24hxf3vT7T6971WKpFKZJP8112gqrPxvmZp8k56qIpb
	ZNKURJ5uE2HdUBj6bFNnXd0vALGw3Xz+JVkVHL6236pNPhjSTBMeYusTDSZdOKVH
	vEgoyM+CUXT4JW/ZeyoYYOblx0YgyFsRe0dsNT/FHVHVI1vcoj2dWqxJEJa0CDev
	mLAPd43RANQ/LxWHFEYOBMW83q4zNG9KRCtgAkaMEZis/ujeldvcO49ljbyO6jUj
	WOBzaa7Q9hWnF+naUeHDQyhLi9oZvobOuhOnakzhOtj93PeU3F3K9HIrazKDY0x8
	6y2lUA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04rudf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 01:52:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e5a616d07so1059645a91.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 18:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784425925; x=1785030725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m2ykhDO9D2xyYesZwOG2ikM2DWqpI4oz9KN9zr7iQ/k=;
        b=kZBG3u1WEbrE9AvIPgfCoVCBTPq208bxe7EiemxsNvPwStfnwvjjAwmxihFvxaMxlx
         /rpH7ibM95z/c0lq7389HA2mpFehhQEkiciM3cSMalhSnZ8tcub+l3QLtd1llNgXGs/E
         AozTO4/n/lt4zozvm4xC3Jv99kbNk9ps1TwaZCrs0AydsvxTWeV8/6uJri4eoIfz8nrP
         SXYzs9w9CP4iuTEhvaXy3lMcS8+49gTbm7p8WQ5WbjlH8WQLTtdpYyB6bshIJ/VUc52M
         8vK16j3zCvQB085dk2Ro4/GW2PVnHj3kt+Mw4l6A+dx1vSZwSWLgHESoBzwnGrhVVraN
         laZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784425925; x=1785030725;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2ykhDO9D2xyYesZwOG2ikM2DWqpI4oz9KN9zr7iQ/k=;
        b=QH0ITZi9W7yuLQeuK8K7a/NjtLHm0VXngfqUGpOZTb3qKcyvA2kZTVsVFHDOqF/lGP
         nVnSlkxk48Q475Hgk/4MkyBQAxXy4KH2PqO5yR8rD2LAA2Va+rxpYDO4KYzMq14rJUZH
         h8lV8seGURi4NJfe3nJa8EBMaiAKRCoJ6iFtKVCvgmfF9ltsfSomCmfSVJcbjLWvJvhq
         VNjLI+k/CNoxEktSEEoYY8A91DaE81y4XpVV+67yYzPwdlw2UhegimfQwP7MKgq9sd7w
         PwoDFLhGcM/rFVs68Mc5d1bRuRkiNGWhoKwibQRiCpbIE0UOSfvTV+B7CXODNOHhcmUP
         YvEw==
X-Forwarded-Encrypted: i=1; AHgh+RpxhRfA5M7yoLO+aymYvniqAjtuxOt9Wv5guX/2gTyYgyQds9ws9piUPMyVpZfEaxe7/gRD6G8HI/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyebWj8eE1ZaHZsX0aeGBjPOsLPEiG+VSTkQR/2IFOwqUL1P0Q
	LT1xOzCAqYghdluo2GCwFd2CfvXpM6ib3EFYpd4O6dq6+jj/izauKh2PUlN9NlyMk6uDp5wTtSL
	wrzexKGa/QCmUiO8CdFGY8m6OoqYDq1aaxe9N4SCWcm6WCoqve1xeJzH9KM80vRw=
X-Gm-Gg: AfdE7cnuzWvwNaeN9snw5p3KFAmz6U2tmdrSASkynzv0x9V4S31QguD6xS9nfOgovXc
	nKfH7XKBSzkh5hmI3drRzNovnF7pEZcNrrt1ErBKQ7XL59FUX4SrHCyDkpMhaJuHtS+HE21VHGr
	ba1TrqtpCuSegxsRyDEZ4SWwDykxLAjBLErosse616nerURWDOjPejSef9a7SA12YGLZC0U6hUD
	Zg3Z30gMAUFJouQB7mq7Yi8EyGKuCW31Id9q6TSXEHnbVLgsbfF3w+APxengLJYAnandusUURBt
	Ux4HP/elohErFHmy/6AfXX9ZFaqswGIXJ6jakG5/AVNfDGcELIX0AIYym+W1x4qBB/m1zMFWsft
	Y+rPJn4/zhi+Vxvqz
X-Received: by 2002:a17:90b:17cf:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-38e4b4113d6mr8983424a91.11.1784425924602;
        Sat, 18 Jul 2026 18:52:04 -0700 (PDT)
X-Received: by 2002:a17:90b:17cf:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-38e4b4113d6mr8983409a91.11.1784425924150;
        Sat, 18 Jul 2026 18:52:04 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e3a119c56sm5544147a91.16.2026.07.18.18.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 18:52:03 -0700 (PDT)
Date: Sun, 19 Jul 2026 02:51:58 +0100
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
Subject: Re: [PATCH v2 4/4] iio: light: ltr501: Power down chip if request
 irq fails
Message-ID: <20260719025158.1e4246c6@jic23-huawei>
In-Reply-To: <20260715-liteon-ltr329-v2-4-d18af55edab5@geanix.com>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715-liteon-ltr329-v2-4-d18af55edab5@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5c2dc5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=ilKATfAMAAAA:8 a=K3nnHmk2jewTcsKXIS4A:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=73awMTU50e6eLoBjGbzZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDAxNiBTYWx0ZWRfXw/qGqWLQA4E5
 z5tzkM/HXH+nlwILQmyVFxT7EvF30tTwI9S/IrZlBb4wH+z1VB6OhYbNNbFXV6BwDU3t74V2ysb
 WO1RR0ShQLR/bRkJ9gzYa0ykHqRaC0S1MwIvbhfu0aPwwFCwW7Hch/fouivrHKD1bHgX4WgvsyT
 OaLjYBmbkSop62yfpvJVLGTUOjIsq89+dnLprAr/XYu8NqPkV5jx0kSUmh2nu42KgdOJK9XHH9H
 0y6GY77ZmO8RmmvuyVllzMsYWtC+HiK2NU+MvUhgeYLGzEpy8tnORSAUCYThKa34I4m7C9Z/YlC
 Kab7Hn+ZNd8qFsVytjPwHA/CPd9oR14onr8U7DOLWKpCG4kc3iwTH4XuQ1ff+7WoeBbBy7L8a9O
 8MbVcuwUePbjgoMWfyVI4exV14iF2TlINILx1gkqiFFQ3ZcHQUtf5efZEqR7W9IWExSz5YBAa28
 0QFQtcLGqnlMRD8W/lQ==
X-Proofpoint-ORIG-GUID: J2zMpJyQtXJfzeBT7jmhlHIctkqDa5Ff
X-Proofpoint-GUID: J2zMpJyQtXJfzeBT7jmhlHIctkqDa5Ff
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDAxNiBTYWx0ZWRfX8q5EKXy8IPnV
 gSretPrqATMwV8nq4PIV6lD6UidNsSQkSjdApmifdKF3ScIzuTHxuSiHagTKzzMITEbkY0Dd9MB
 v4PcxPUwdob8Ave7zfQK0I0xheYPcnU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190016

On Wed, 15 Jul 2026 14:27:26 +0200
Esben Haabendal <esben@geanix.com> wrote:

> In case request irq failed, we were leaving the chip powered instead of
> powering it down again.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/iio/light/ltr501.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 379e57ac5f5b..9d4de798e5ab 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1571,7 +1571,7 @@ static int ltr501_probe(struct i2c_client *client)
>  		if (ret) {
>  			dev_err(&client->dev, "request irq (%d) failed\n",
>  				client->irq);
> -			return ret;
> +			goto powerdown_on_error;

A goto after a devm call rings ordering alarm bells.  The two calls will
be reverse of expected order (error handling generally reverse order of
setup).

Instead of doing this, register an extra callback with devm_add_action_or_reset()
for the power down.  That will do for the fix, then if you have time
convert remaining two calls to devm as well in a follow up patch.

Jonathan

>  		}
>  	} else {
>  		indio_dev->info = data->chip_info->info_no_irq;
> 

