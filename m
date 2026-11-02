Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585142;
	b=oXnpwpc3e847fnh/7w54wkqKqQEJTAt6aoiZsyROjJo4Hjmsea+lTDAKrr7Hukdrfw9q
	 AHzPVFmRIKvio7jeE4KE7g2+VO9+9UOgco5+wh8dRbel1lGMb6Sm3xIPSHnAQuHxXnOg7
	 Fi1JjXatlt5I55exgbkvDH73YMaS/0zOQkorysEV97ZxAA9ekXdttqtwjjX+0dToTV9xs
	 QuxY/Lq7KZoIxdOLrvp/k6BwlmnOmIZA1FbLqM+E855AQRUoJeppZBA3PiJH+GPALGyBi
	 mL3WRVp67vBztoAu/5jeGjW8+fjPaorsM+4hyBh1NM150bEyNH5yIlXYh4GVmaeaBNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585142;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=saLjZrbieLhJB1tuozWjrnu5bEeBT6XlxMA2WYvE00k=;
	b=aqppj9Hb/Jji02DPvYe3JACS9ISuCd/+/aPewwPz03uWWqbvPmSnCJ/x14kjxJf/F9yG
	 CtYcsTepqufs93JUy9Sdhw+YDhiOVJ9+VjPMRfKVwPtE797874jQFr6LUjItNJDBt7G3a
	 2GX9d8Vn2J8rKhZk+JORb+aut5fdp44F/+389g21qQ61M98RE+o/v4Lx1UUTKoN0cP1ip
	 DbwDZtFU/3MXAlQcU8XdxKh9ZMCgAxVyW63K21eiypN4We401hqSjKZlXSqqsonjif5i+
	 ShYUMeeIIzJiouTzOqW4p5WShwVZkTWJULra8wTDTCPu1AsvgtOZNy90nGLHQqIJS+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l2+3H1Iw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KTumMwDy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A04606A324
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 02:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52A04606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l2+3H1Iw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KTumMwDy
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A20KEDl3310375
	for <linux-iio@vger.kernel.org>; Mon, 2 Nov 2026 02:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	saLjZrbieLhJB1tuozWjrnu5bEeBT6XlxMA2WYvE00k=; b=l2+3H1IwxzBegogB
	IaK2HeAW1sQjsQS6MA2XYIOMno5CHzbPO3a7uKJrLPMaGGGd8MtbeOU3D4ajhzXK
	yQeUmp18LBTqSgoZ3hGnbxLgqdHLB+ebVoCN/b7F+B0VzJilNMRaAG5IiyaTQP6V
	ikEAa7JYLVlF7Mt2I2DX5dqb28lUm368khY31jv2ZGvrD6TTozg5KgRhRaPwrtco
	WeiziBoAC7yWaL1JT2yLQqejkSIkJ/gz4YBQRDgJLrdY2TuxcbtLKq5lPO8m+e1t
	uY5mNnxSB2AjxTtfreBrwaXi/4ErN2K2TB9nN2aANhc6hMpP/2XWsXVseRT9vRCu
	IwLHzA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn79rvvx2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 02:05:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab67ff8ec3so1711894a91.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 18:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793585141; x=1794189941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=saLjZrbieLhJB1tuozWjrnu5bEeBT6XlxMA2WYvE00k=;
        b=KTumMwDy+GeIBsJoRa4pgcdwhL5wQUYi24+blPPQeo2/DT8dpdDT0TOeztsqjy/Sqh
         1eL0V8cgJZqPsJDsJf72KV6yGf3tYAJqzaw7d3hu4ceCOONfxeOEgh92ETOzgYp9DGoQ
         LvWmswcYXkJ+fLQBRNPguBrGr7yD2ccryn6WfnChxi1GoW+U2ylOzZ/16RuYI8uph8Wk
         9OjQ4f7xxP6PcA9UbM2dffl1+E0k5+wh6czZAz473tUr8ifMfqh9+p89n6TBp0Lsm1TE
         h0AC+z6v6BKp8BXXyNHhzgIXIzh8G6QVt4OyzBVKR2vhwMkqHd9eNGJFqjzqjEuIH+k4
         FTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793585141; x=1794189941;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=saLjZrbieLhJB1tuozWjrnu5bEeBT6XlxMA2WYvE00k=;
        b=JlidZtLI2YQEchScxLItQ3zJ4KOaDwYARpuBoGmWE4dR1C9CjbcAB6bGD6ravCJiml
         WYik/nQhX//qeiUKfSQ0PYW8pBQZvyyVn5G2gTZhEBOQTO+eDzX9lbmYq1aJ38F3SYvt
         upC11KwRXPu073KbmfyX1vVO8a4m4IrhnUHZuofm81mhN55x4KfaymbNUfGNavoxTdTO
         4VF9QWjYQXhOfdICnfQt4nZMLcLIj42gtfUM+4esfB82OrQsMy7aYEAfOZPMIgtW67GI
         Rp8eidnISHXAuNa3B7Qy9rkrG7ceM1wy6dlmnKjKdzQC90DrfyuvMBSICVR2sZ5xZfaL
         8tFw==
X-Gm-Message-State: APuU4Z/NpB8ewtLn1mVR+PcxFLgruKh5MFFLtL/+WpJrggrvbmsyEeea
	Nd58aAyEnUl8WZY1/rma1tXheGQXUc5UUWdv4s2tE6J7X8cpVA54LI09uemjUsp56V76cFhGKpX
	XqNGNEyKl3m7XOcavl2spqFRX7pe7gvQKn8N8t8EVuiTvvcDW3ZJk3gwgeZQvmqPAe92c0s4=
X-Gm-Gg: AYBFou30jPz2u+Ior4KgjJp2PLlhwSlr6vDaZO9PTs0oAsVXdX8UdLY1jJ6TbbJUf20
	B/pI2oLq+mSea8q1lprto/hEznqGAMUwEPg2/0ugAw6pLAZSDzI0sZhqxfFIHFlOjlc7ELqlZm3
	sx0irAGQiKaSA6/3sTROG5HBWNUela6EmXMpk8do2STkA1eWEN9rELZVHswRBUhI0I+0vGgwelA
	HDuSW7ctjYCn8mRYT3dcrVKdiL/8ZDcX55Fnl8mowSaSLAUYoLGKO5Z8pOipYse8FrBT0yESbDx
	AvYp695r3Gw/Qr0fl7+MBOEalKH4KExV/GK+X/nfJPYyxEZLLV5kiNuhVFkR8wiFhmc8yX8mHPn
	C61JyiQWlLoPlPT2bY2JdFCxYJm56HhKY8xDkbuftzp5rH82xQ9qJzZV1ibNZyJN5XA==
X-Received: by 2002:a17:90b:3c0d:b0:3aa:f4af:1e0b with SMTP id 98e67ed59e1d1-3ae8957d281mr6416172a91.8.1793585140454;
        Sun, 01 Nov 2026 18:05:40 -0800 (PST)
X-Received: by 2002:a17:90b:3c0d:b0:3aa:f4af:1e0b with SMTP id 98e67ed59e1d1-3ae8957d281mr6416157a91.8.1793585139987;
        Sun, 01 Nov 2026 18:05:39 -0800 (PST)
Received: from jic23-hlaptop ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm15900631a91.15.2026.11.01.18.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:05:39 -0800 (PST)
Date: Mon, 2 Nov 2026 02:05:35 +0000
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus
 <antoniu.miclaus@analog.com>
Subject: Re: [PATCH 04/39] iio: addac: ad74413r: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261102020535.288da60f@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-4-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-4-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 1cxOOFEi6QZq12AkwIasxpII3ZoGQJJL
X-Authority-Analysis: v=2.4 cv=Wtq+otfv c=1 sm=1 tr=0 ts=6ae7eff5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=gAnH3GRIAAAA:8 a=AGahgOuteS9-GZue9eYA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAwOCBTYWx0ZWRfX9N8RRQVcpQ9o
 jPuU6sfwckz7lx5JeeR1/m3PHr8lGbmJAEyvK0El/KXxXC8oKAL/ZUefvcqmxjxFUPYQ15SNOyo
 9z7ep5Lc/2CJqN5VXzCeROCD0PoxHK0=
X-Proofpoint-GUID: 1cxOOFEi6QZq12AkwIasxpII3ZoGQJJL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAwOCBTYWx0ZWRfX87W1k99WTQ4Y
 xlm2sUzJaJ64mU7OjZi65POwbLKE+5g8x7piaKggI3OgyK6D1kzDkZEowDxULbj4OAy3J/XOJHF
 WfaSVXD8UruyHfB1c5qj+v7yPLVBWIqxiWxPR04vXmPBJWNeqe8RR4vVtFde17R4ncyKaMw721S
 QyvEwO/Ii74qpJ9xkJbPmHA3XAEHi+Xo5e3lj0X+uK5TKaoTLSk3OO7uRv11M3MSfghwHgswgNz
 ewzb33OFLdCPbUswGcOmkRq7VXXcw/ybEr6M85YrByB+hFelq9AP1u5TKoyS8/YgmZV9wsbsFP4
 5WhBUPhXjtmByrALv9Rdf2OaWFud43HzJBcNlLbV7197a4IUgXwfr7aM/Y7LCq6GigC3cBXgD3s
 XmsS5SjkVGmUwBG7xaEr0C+LoS+WX2hJT3a+wY9QQSXLxv1tCBNGNlc06ZTXyDdHXNrTWX891zC
 qhm9hKBZJGvTm60tFvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020008

On Mon, 26 Oct 2026 16:05:22 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
In the interests of nibbling down at the outstanding list,
I've applied patches 1-4 as they are all on the trivial side.

Thanks,

Jonathan

> ---
> Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/addac/ad74413r.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index 2e5a58e48a89..8d9d3d5f09c6 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -798,8 +798,9 @@ static irqreturn_t ad74413r_trigger_handler(int irq, void *p)
>  	for (i = 0; i < st->adc_active_channels; i++)
>  		ad74413r_crc_check(st, &rx_buf[i * AD74413R_FRAME_SIZE]);
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &st->adc_samples_buf,
> -					   iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, &st->adc_samples_buf,
> +				    sizeof(st->adc_samples_buf),
> +				    iio_get_time_ns(indio_dev));
>  
>  out:
>  	iio_trigger_notify_done(indio_dev->trig);
> 

