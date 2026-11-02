Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585330;
	b=4zPk8XFCImuNZcU78+DCM+FWtxhx3lW9OTcWQ6upeu/2FCDC+7nZDNBbrExROxKLhhx3
	 YP9W07URBt3SMwf+Q0bGWpWKwGAq8/l+fnMs5NBY2Iw6MwkZfXmQQBRfo56BVl21l7FB5
	 wX0vsyblzJqXW8QdDC6RbclyFDs+KeMPvlwmMotPFZE46G+2MWQ9kMYS9HQPDqGX0aV1J
	 b0Y1cbI5XOrs2Ea5je+jkwZq27jwfUTG+bNTL0RCTGc09TZlkrQZZw+XaWnPwcNeZ+T6f
	 +h34UcHu+6rKTStkavRIL4YSUbvnGhayauWWLrehxksd0A9Kf1oRpXVAFoaK/eWlgDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585330;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xFjIvuiYlG/Mx/wRRuLLr0Y3+5vITw+SZEkAoai3pSQ=;
	b=F7PLyGBpMXSPagR4LKcaMj3UEJ8OgyXGZlOAAgmQbO5qBkgeicLDLBxFbQdMWQ2VhRJQ
	 RrVejedOuvLU3KZb46lWqPhr5UA75oOxNoMuM3I87xT3cYlRefCQtQKSEzW1QqtJ3Co8I
	 cv2reQ2yQjmcK/LG+96pNpChB8Kk9U3t9HJNfOhZUvvPXPhWCiIDdTAxBk7UCw/YoJai7
	 f2ozZK77Iwrr6+9rwzGJp4CHE0KuLSnV5TZAXt5+nHduuoxJjkXKnz8CZNQNaOj6Sy61g
	 JsvV1xr6AfWl56Rx2RHbJj2qyVdu4AROf5z3qX8mZu7FbyBCUsy1BAAJM9HYE8tKRkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N6gv+Egt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YNiHmKq4;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3515606A324
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 02:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3515606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N6gv+Egt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YNiHmKq4
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A20VAmJ2317475
	for <linux-iio@vger.kernel.org>; Mon, 2 Nov 2026 02:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xFjIvuiYlG/Mx/wRRuLLr0Y3+5vITw+SZEkAoai3pSQ=; b=N6gv+EgtFRFBfYzO
	+De3RPcoyjzNxj+ZjE2gMxvwmm9os7V4e+UALhLtavhgV8FeCKW50zth/PdcUw9o
	JvpdUiE78px08Q9FQCbkBNUbaNPkUUf9jSoJpxju9P8VzIUo9d3SSzONtA7jFauG
	ImDGmIphausqXu23ttNKTg5ES6YcbqFDfODkLJYZo/UdmvJKUQN0A1Vail8hsMsy
	RCOE+B4f3yXEW4CDpTdN9RyF1WxWh1Jld0CDqXTnXpcjXMSyH1r1or3R79owBaoU
	DNr24yFBfBB7m4yVXSWx9aUcx+HiHhcvOV0/NDW9gARqnRcKs1kQ//OOM7GxRW3T
	Ynn7hQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpg2006yu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 02:08:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac8f449d1bso2012946a91.3
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 18:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793585327; x=1794190127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xFjIvuiYlG/Mx/wRRuLLr0Y3+5vITw+SZEkAoai3pSQ=;
        b=YNiHmKq4tlfDIUAg8KU68shauv45HpHZtgOEKlMsYOnVC9z4wdpncy5/TwD0RaaOG9
         XIQbfEwpwcw8/4m2Bqu0PAYGfmGVJks2ZFlJeEwkEkH+3iu48+TE4I7jKs4MGu/n2mRf
         mLXdI0J93j/6BMRKYe/aiUUjzoOYDNp7R2XxNuN22nWn6BBXHgNSyymPWDwFnd0zu4NK
         fP4KmLpdvbcdIwfj7vtDVya/hgCNQCjRnGFQB0wDluQw+ox/tj1erBvHEp5kNt11hmjU
         xqKPuW0Cxj47PrLhNrICRi1UIbqDcqLugnSqceaOXzpSyx9FMiA2XwDVIcjJudxBdOR3
         b/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793585327; x=1794190127;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFjIvuiYlG/Mx/wRRuLLr0Y3+5vITw+SZEkAoai3pSQ=;
        b=k5YlsL0EEjFEn1n2TNYGDLl/fJMvVR9WxIowPaY+ep8tIkZ4KxO86OT0ieNKu53l/f
         buhdoEOj6+WAorLqy6rt+a72pxY3Z8e4xB3Tgyh2m+FqGqpXIJd5HhrbvXF5bD8fRHUE
         onPvw3x1kHLSbGrxP0Dk31RpHGdGTsZK5BNzIreWnZm0HB0PSXiGYAHLSzRmuNaCTo4t
         g744U/Q/IKg+K0kfnUjFHRwKFdXWv9Yg/Srdhj7tu8P2HPn8RYKqeeFaoQsbE/wGR5So
         uFCbQ2Lrp6h/fk3AhG/ln04mDGCacgQgHKZdmilTj0bBIq2yqCoeVkc2kbIuoZX82c7o
         Yvaw==
X-Gm-Message-State: APuU4Z8dPi3XmcyGDw9bfIk0C/NlzJxSdkABYMTe7q3F2gQy3O1iE5tM
	I9b/0r+pCE7wsrY8aTOJu0cVde2ONaNsbO1laOspHB7aDu7i/ldn6MOhE2cSvRfMp9lQtoy3xMo
	uinvqG/qoWo2fyLrdNLdmlWZwNhFVfenOn/bEBKlsL/Z6n0IeWXoLO8KasH9s7nXtgMh0yHc=
X-Gm-Gg: AYBFou3rXMryN+lvSpRiQDEQAflhLN5pGvkurE1GXX6AS1BRJfAN2KehFWf/n5gl4Vb
	fWMVf2EfwHlKZuy/pwD9LviHIhaLqudONtMk+ecUrTApGh8qAxL8iIIrAxcOwRGaRnPCB/x+AuP
	iTroQBPnpkBuk+TOynxY0vHw8l6U1bP+PJrWa6aLGh0XiX0ZYCF0g1cqwhjmXMZ7skd5YupSMRZ
	abtbWe1OTWRU8vxyUlBQLtwjv4xcERnZ5CnVWX/waGpq1b7AhFkhs5Mz/JAAyb4qmP5zGawjmID
	lxK0zvqkiG7QcGiR7jZZrFmc41mf/VUuR4rJM9ILpRmMRX8xXylEKRK9lu/PJIphrkDrXxKnt+p
	g4QwcWTIX/JmbAy2QMh5/J0nSpfJEs7t9XuEPmwTw7uxVFD0OEqmtHoA6lZ9t9Cx97w==
X-Received: by 2002:a17:90b:2686:b0:39e:6a7e:ee18 with SMTP id 98e67ed59e1d1-3ae8974fc92mr6851658a91.36.1793585326921;
        Sun, 01 Nov 2026 18:08:46 -0800 (PST)
X-Received: by 2002:a17:90b:2686:b0:39e:6a7e:ee18 with SMTP id 98e67ed59e1d1-3ae8974fc92mr6851637a91.36.1793585326468;
        Sun, 01 Nov 2026 18:08:46 -0800 (PST)
Received: from jic23-hlaptop ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096b7483sm2436248a12.9.2026.11.01.18.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:08:46 -0800 (PST)
Date: Mon, 2 Nov 2026 02:08:41 +0000
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 07/39] iio: imu: bno055: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261102020841.009afe07@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-7-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-7-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-GUID: 0skKbXb3ONvh0dV9KWXcvERul_aetnCt
X-Authority-Analysis: v=2.4 cv=fZY4WEQF c=1 sm=1 tr=0 ts=6ae7f0af cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=DAgZRNeLhTXUDa-BYH8A:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 0skKbXb3ONvh0dV9KWXcvERul_aetnCt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAwOCBTYWx0ZWRfX0kZl6uOGubMm
 GEnaytQL6GAojtL/bPu8g5TEZAORRI2C24uI7xafpGfBpDvxh95Y7Fy2k85GASJutMuToQ5o7zO
 yCybE3U3WYYPnNBFbqRAv4626GmoR/Hx8CBl1sXRVVQFSouM9fxdExST8w+PoDgTrdVeYuBDOVy
 4nHVBZiUVXKL80A6TKKUu9xIr4/+pxvRQcjGbMQ/PqBLEjps7U9BFqoCN2fak+uG53p0YVUAXVq
 Wfj15h+idZSWV4xnlW++lVhHyC0Lo71cka7l9i9s1hX5pB6JJerxoMUQK9MKlvuB2PcggZkgwWz
 oFTPnntVgWz0y1jzEaBqQQ5j0XaWtxuuKcbNRPAptPmWcgxaoqowzfONJTsh5C31a58nJrzUcbQ
 tdz6nKFPmG2dIpl8cd8wt6XEr6tE05nKGhkr+/LshfqWoKTdIMRAfXWgydSKpTZ94C5rT/pTV6p
 K/SGelIQpAQYseuZl5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAwOCBTYWx0ZWRfXy0NSRT7yJB2b
 LVxD0XgK4xs9MSs0CrYsSxbbsO5wFIpDS8X3hJXuUezCNFmPduA7pnWKIGMTLy+750R9XouDmpl
 2CTc6+YHUHzHltWVxKlOqaLiq+YNns8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020008

On Mon, 26 Oct 2026 16:05:25 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
More nibbling.  Applied 6 and 7.

I should have moved that hid one.  Initially I had it incorrectly
not using a fixed sized buffer for all cases and so it looked
trivial. When I fixed that I failed to shuffle it to later in the
series where the more 'interesting' cases lie.

Note there are still a few 'really interesting' cases that I haven't
figure out how to deal with at all yet.

Jonathan

> ---
>  drivers/iio/imu/bno055/bno055.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
> index d0101607a9b3..b1c7b4f88bf1 100644
> --- a/drivers/iio/imu/bno055/bno055.c
> +++ b/drivers/iio/imu/bno055/bno055.c
> @@ -1543,8 +1543,8 @@ static irqreturn_t bno055_trigger_handler(int irq, void *p)
>  			       mask, priv->buf.chans, &buf_idx);
>  
>  	if (!ret)
> -		iio_push_to_buffers_with_timestamp(iio_dev,
> -						   &priv->buf, pf->timestamp);
> +		iio_push_to_buffers_with_ts(iio_dev, &priv->buf,
> +					    sizeof(priv->buf), pf->timestamp);
>  done:
>  	mutex_unlock(&priv->lock);
>  	iio_trigger_notify_done(iio_dev->trig);
> 

