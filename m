Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168444;
	b=tk+0JKQ0dKbRzsVxFqk2z9CDYdKEcS2yGzI+2+yBVTJ2h4Op0cM639TCy+J6gp67eFq1
	 ZtXKSAME3lXcoEULtFDQ3X0iroDJOejwcyhh8/3qKmbTcnNjEJ44lh9gjDIvjnLXj8DKK
	 NJNPaLB4bAlE5Unr1jvrO9r59qlTm/jjJjccJqjGzp/kQQN/zcegUNMG/3mPxfHfat4fA
	 0Hbm915+dwwWhzOpQ++obrkr3qAgJKbH+e7V/L+W0KiZP7ibxSifROaY/raUT2Ro2tQRH
	 xswEwuHwNAWYueF3taP4ebWHSwh7XxXcBpt1UsadLeY2QnWFh0vpxGEZ9GNa4Vua4EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168444;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Cz2EpUz8VJk4YNhwisNVU1y2MaWcW/CYmStQwQqpq30=;
	b=tTu056SERZEktpos1mipFw2JEncWpexaFsxIl+nCcs9iTup/zoIbnKHdzsVT1B/+sp7s
	 sm2QVd5OZkH+a3PQwFbtxLzl38sjjGtw2x6S05jDLab7RdxkFednRzOh6+TVvnc0d8ktL
	 guMVyvUenKn0T4DPblg5xWil9WKDPALx4Y/uUWQ+aoYCI7TsMAm11nZMrS0aXoK+AuxWC
	 BbMkUxoGQNeCzpEvhGa5zGRdSWqTpmyEoxjlYSmlCjtL6itKpPoOIwfSP/1rrV4qb7wMq
	 qQNU87bqmiJf9+MhHogSIAT0wSjpbPqdeHN5xt4F7xPPp2cYjJgmubkv//NbhrSQ5bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NxYagxm6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GhbLl7vw;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71872606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71872606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NxYagxm6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GhbLl7vw
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A8HppY01771971
	for <linux-iio@vger.kernel.org>; Sun, 8 Nov 2026 20:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cz2EpUz8VJk4YNhwisNVU1y2MaWcW/CYmStQwQqpq30=; b=NxYagxm68Y9Bh/Fo
	uO0fuyrIIp7AiYUb7YRHyvm/1kBbitBqbcEli8nujapD7bL+5W7QVigx5ypf3EAp
	2F/+VoDMf+Y3D3OYdPexE2EPf1tML6DJkDvD6/lhUfZ/l14TMr0cXTmAl9ICSUWj
	WtvxPxC7KAlO3HjcPPC6KxTqJg2YCgEGzyhdNqowZE5TGjFn/IpC7ITfhnxlvBWp
	ClnRu4y0qsbXhJEEtYdQpfvQFJTtka8mMiH1ajPBX8u3M+aOkbwGBl3UMfd4Uf4F
	Fi4TJz2xn8mkXsd8z6keDgnmvW9347hPxt90DwsRxWVUkdxb0vnIgZ+MN4SqO7QZ
	fNl/4g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsuagupwh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 20:07:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdd4dafdcf3so186949a12.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 12:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794168441; x=1794773241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Cz2EpUz8VJk4YNhwisNVU1y2MaWcW/CYmStQwQqpq30=;
        b=GhbLl7vwIKkZBebQMCUU/7vGphOemwBmQW8KL4Blu0tzeNdgwN2EFV2w2JB7MwwlQk
         dSQMI5tXwqX3M/dAbYqpT0YY0jUeCjX0uk+zLJY67K8d8ETDCT2KSYO1pAZ/P9JCnP4Y
         BAkSSmyvMmczRW/bTi6xHYIwOMF/9gvbZkwYqtOhOq2g7EAi6iy6DDLJ8jm6RLJQ0yl8
         x3uti6bTvD9jibK01idUKAcwdv7xqfyebgqaENdNiQvP6I86qxmjsNpQs0rjm3dCT0y1
         GzZtxKFZxATMyBbklBz6QRRuTQFq6UhRgHK4jA0mPKDEGtHXUSAFgCsBttpr+mpHpfbt
         sCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794168441; x=1794773241;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cz2EpUz8VJk4YNhwisNVU1y2MaWcW/CYmStQwQqpq30=;
        b=VhWy3UdCum9bZdjyPbtCwTd+HVN41PS+x6oZqD/WIqXtYA6P/3f48fIMRNdvQsFrXs
         1xPZMSGRH/mpr0TVpFWsR5U5uJfnfimq5Xe/O+3dNkYUQcOVrS+lLefmtEny62PS8dRB
         wV3Hvk4u2ME1dUgvI1KiskPRYjP3YMAiZ900VbBcIRF8oYzmRGCOGCZGMokwLIpM7On9
         sUIV+WgyGVObK0f4FA5RSDfTOOTxIWAVl/7zzTXQJ40o4eJ+6XMhAGbuc+3jZbJ4Gl9k
         vpJoUwS/+SPNI8Tv/TTbPBiSjgGa6nZliCO5KaWR2/na5S7riVpH+xzk3hk8ToRNjD0z
         5mhQ==
X-Gm-Message-State: APuU4Z+zDGQ+eW6255ZtI4ATIhLAibDJByVXLc4JgeZydsoGp4cXa+y4
	jEOq5FDXLE5gts4fv1hOaPwL+JtPfpB5OzWWv/vBC8tOjwvPXCIMyrjr7NM2ayhLlQunkr8xrH8
	zfiA+ldMqnSEg9viYSubpVTjWUAPu10SQqteGs67Tg4rzlSrBlaRWG4aBsT22u1mxOffrCrU=
X-Gm-Gg: AYBFou3jc02796g2g7jRGNxtIToyfivscNz291mAqi5KTHGpSgfqE/fvHN/5qDP6whA
	xHmMWtE/L0Lolp76HtgjRaC5tTg+3WZ3c3rS9YGol9PfohUcRJg+sZD6j30cMf7zEAza1h+HCu6
	8TKXM3rzMoLJBCkf7BpqWqHin/3HehbHNtGNNXnAtk1MC5UNBRS+APeRlIMv+UR+bogsaRp36nP
	LsXZR7qVNj8BADFBEAEFXbUace0/sVuFBHt/TuKEVQBN2OP1z4ImqmPEFLx946mnRlWMN75bLQV
	xR2BtzbAQom6n1kpuLMq18/gO7SxmOmtGgba8rlA+FNVWht+FOH44UYjZuWfIJ/zezCRoVNdD9l
	18QCXYHe0uvHboyPAqdNFBjGFhxX0BL5RusdjwITSVLIp+jJ5SWynqbK8RAxS7t2y4w==
X-Received: by 2002:a17:90b:4b01:b0:3a8:211b:6c8c with SMTP id 98e67ed59e1d1-3b12d3c0f05mr2152880a91.22.1794168441162;
        Sun, 08 Nov 2026 12:07:21 -0800 (PST)
X-Received: by 2002:a17:90b:4b01:b0:3a8:211b:6c8c with SMTP id 98e67ed59e1d1-3b12d3c0f05mr2152866a91.22.1794168440760;
        Sun, 08 Nov 2026 12:07:20 -0800 (PST)
Received: from jic23-hlaptop ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057b1fa8sm8150022a91.2.2026.11.08.12.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:07:19 -0800 (PST)
Date: Sun, 8 Nov 2026 20:07:12 +0000
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 25/39] iio: potentiostat: lmp91000: use
 iio_push_to_buffers_with_ts() with a scan struct on stack
Message-ID: <20261108200712.226d098e@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-25-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-25-8b136778eedf@oss.qualcomm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA4MCBTYWx0ZWRfX6dqoKA3cmISQ
 zc4NnW/pl0j+fUDq2HSTBKzriTmxwKQTT5Lw3sjAyE4IgGxUAcwgHJ343Jn8DCHGszxWZ+kDAsf
 QV0MecwjTvQF7qTxXG1gUhuw2jYJsasw2y0a5I9zE1AAULckOnwi1ZVKVj6mTeAAesYYgSMnstY
 AHLUz8pNqV/Q2mWSU0C+7JcRxNQeWhQdFLmHyQVFLcDtcn1xz5o+Svm/p+8dUUA8vs9Nty8Mx4e
 PUwZhnj+ynlEiqfD2NhaBl7/hjqo3JlG5LwfQvaJOOSNaXhnThhyUx9Ipa3qWmdgfCSTG0jU9u8
 H7PxWYJYzDvBrgb3YSJtKfMddqgG3hQd1HduCG5fMolSD3gt1bgTpnmXc4zmVOaR0UrG1FIppqs
 ube2jc1q09tJcM5L/4+knveYK/T68LWmCiXeBIuQMszs/bIYqw7kO23kCM0KVB+qD9SqAv/51Rk
 KAm+04IPObnX2oc3NDA==
X-Proofpoint-ORIG-GUID: bjTV4Iif5QUdK26_fw97mjbko9vq9AVc
X-Proofpoint-GUID: bjTV4Iif5QUdK26_fw97mjbko9vq9AVc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA4MCBTYWx0ZWRfXw/hCQH9ocaNF
 7ViyGPC/jmJnix0cTCoyuo67jLrLGmMgF6PW7QHgDa4Y8JUNB2wfMABd8olGkzjhHyGxqUN2DQS
 nL3befLYy5OI5x8rZrIiDoP4HphMe08=
X-Authority-Analysis: v=2.4 cv=V8LoQuni c=1 sm=1 tr=0 ts=6af0d67a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_Wwkgj7EPQ2OklP9ipkA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080080

On Mon, 26 Oct 2026 16:05:43 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Move the scan buffer out of struct lmp91000_data and make it local to
> lmp91000_buffer_handler(), as it has no need to persist between calls.
> 
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Applied.
> ---
>  drivers/iio/potentiostat/lmp91000.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index 00cb3fea97ca..53f181cbc0b8 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -70,8 +70,7 @@ struct lmp91000_data {
>  
>  	struct completion completion;
>  	u8 chan_select;
> -	/* 64-bit data + 64-bit naturally aligned timestamp */
> -	u32 buffer[4] __aligned(8);
> +	u32 buffer[2];
>  };
>  
>  static const struct iio_chan_spec lmp91000_channels[] = {
> @@ -135,15 +134,17 @@ static irqreturn_t lmp91000_buffer_handler(int irq, void *private)
>  	struct iio_poll_func *pf = private;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct lmp91000_data *data = iio_priv(indio_dev);
> +	struct {
> +		s32 chan;
> +		aligned_s64 ts;
> +	} scan = { };
>  	int ret, val;
>  
> -	memset(data->buffer, 0, sizeof(data->buffer));
> -
>  	ret = lmp91000_read(data, LMP91000_REG_MODECN_3LEAD, &val);
>  	if (!ret) {
> -		data->buffer[0] = val;
> -		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -						   iio_get_time_ns(indio_dev));
> +		scan.chan = val;
> +		iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +					    iio_get_time_ns(indio_dev));
>  	}
>  
>  	iio_trigger_notify_done(indio_dev->trig);
> 

