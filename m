Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84E22689C
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784337264; cv=none; b=V/WPDWFgfMXvWf2v8U2GwgL0BVxv0/H7tEIq/gnajjKpJbPcI/rqOqGqWTworyeX+QGemAww954G60mmF2CskNhCOdINOeAfVemgO2Vd3LddyZiYeUtM50m1Bw76LhdCLMQETRgTvBrGKaE37VvSr9BMZgJA5+gXu69QD+ZC/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784337264; c=relaxed/simple;
	bh=0NH+un9zhISExEhIXrYUH9GQX5QJuIQSCrpSHBL7Lj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXCAZPGPR7Y7YJB7yHRZ1x+QTWrtFbSUVxQcioRMvyOKQe9dRDykLnEwhk8JhMMPLiTmBTmzKCayopRg+ULnF8t9SsndPNWgmYoMD1Frb+K6mI1BthIIhjivvgMC6gb7PBN35Envc1wGWODAHQzzqGlX4KSIAOkFaE6EiW1QAGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lywFv6ZX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jBhJTVwL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lywFv6ZX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jBhJTVwL"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HNELq33312517
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wL2nUpOxP+eB4nzmaV30SUD1ssY2RAbB+Ras+/QA9yo=; b=lywFv6ZXg91Z9uqK
	weL4ZnKB4zTgCL5ziOo0NLo1YXX2iloYOIC0CZHnlJumi9S4Ld3jEvfT8FModJtz
	mVggqYXkJEBrA0BGKBdISdk0hOZwCrYWx2ZQItfCO/wJJ5Y92lRipu8Gm2UqNXr/
	8NXUKz3YnZCVjh9nB5IKkt8KBKBrN8X5HcN6k3iw4Z3NhUwK8SGqKEBqAUNm8x5P
	qjifYqI5kn8cq/TEfrLpkh/blrUkGSZnzQHr43/PaaJFUfC5v0kYWGST5/FOvtVj
	3ifkfMyRex6u1v3qHClVFQvx63akUiXlyTxsY2hcDmEqRevAospbCoxLZeCSf/Dp
	ytQJ8A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffhpfk91x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:14:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cacd6d37edso112828645ad.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 18:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784337261; x=1784942061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wL2nUpOxP+eB4nzmaV30SUD1ssY2RAbB+Ras+/QA9yo=;
        b=jBhJTVwLxmp1z2ZMrjeCXBHuy07xYB1O2w7F0MfiGkHa9fOQw45S4LjK1i6gDUxSso
         e14dIaLGoPyEXwmO5dQHw6J4k8Y6N/xl9CuxsykKaKBSSZY4tJVCekA9W8SCdpk70x83
         9Xhvlot+lUyXlP28Jy9es9k56LHxrVMBoRs+pnqTnvHFnFKXWNCaTbTojz9+Z8deTwxH
         Livt9ArVtvNLMmueUD6RWUjIj+ZiLAeFcf8I2n5V/YMh+0jOhG3dUCgke5eYcae7ukYU
         lsRPjgMWKdHE+Lph3wb7aLefgjJEFCOZk+YQfXHMczLSOka3ufN8FVd3G6xdDvmSBe3V
         nDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784337261; x=1784942061;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wL2nUpOxP+eB4nzmaV30SUD1ssY2RAbB+Ras+/QA9yo=;
        b=ftkLYezxk3xoHO5QZY9EuZIn8S9itBQJNy7fGrL+Xb77wnMT0ttLiVq7XAC90DSmbo
         MqY3M47lI3YsoKGXkUasPtU365FCVFBOkFnN91GoJDsjkOzdzOec523r0F/v9sj9LvlF
         WUVVBrfihcN//dbyXlFlDae3SEipzLVeK70kX+BbKqsE6QnZSuKQYK8CalkYTGrYbaYZ
         eBlsHrdTOluTgAA0OyCfcxRVsxVN+PHtJgsHwlhbgWREJwptB8ddnkfu3boyHqcmBLxx
         ldJvvd+YFgPqFYcpG8xkqvpuZxVHVvrqr/cJSyXWcg9+kBlkBQJ7rTQkosn8mCz28W/S
         Ua7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr9ubZRbQurTNtudHTzQmV5u7QQsxNzj6POStcak3IXeBCrQQIBQnXyH57ErQQ2pqeBwl4ce4GcZJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNQ9c3RVvY4arMcVWxtRiB+BzFmBV88jYrU4/7NwjOUkaEq78d
	dSql+6+AQ4knZPnRBiCmClFEb1r7kW5vpVXsYBz5XCLndBSwEhTilyjUr6g7c81hhD8pX+q/bal
	cC2YKhDFqmyEGHMFeur7nE7B/qa+cgnRX4DIR9hqx0YMphtOAOzXySUgLH1g2ZHRIvGRvXdw=
X-Gm-Gg: AfdE7ck1msTwlZ0KJo6NydVTQ5UpbkPHMSudul9amTvYXGtXTq8ID+5avz24PnskaOK
	IdYwNZ2HImpFutj1szwzKWoJEG6fipzSc2fYtcL8WPhEVonKm/B9cKpl7dwDc7tXvKy5X82Giqf
	ViUCRZA/MMZVa+Gw4K6TFpQDOiaczFFy2gBYjrtA3BhYQIEjVyOHQ8ZkQMBKhzZz91V8S24E64Y
	okGiMhpsYukHPvCocnldDdgXxnp2G5TDhhXkvcH9WQk7xEjfbeXVSbQcRBhrfyXYAHxI9/ev3Gj
	eaULwLwXXVdC0Sx8lTVI5+UrnJpsdHuo+FZH0DND7Kb6YFODk+DTN5xZJND11Dh4omuV0u8HgBP
	1SrLse0vUOROHh+MU
X-Received: by 2002:a17:902:ccc8:b0:2c9:ae0b:61e3 with SMTP id d9443c01a7336-2cf3484b193mr47502505ad.2.1784337260634;
        Fri, 17 Jul 2026 18:14:20 -0700 (PDT)
X-Received: by 2002:a17:902:ccc8:b0:2c9:ae0b:61e3 with SMTP id d9443c01a7336-2cf3484b193mr47502205ad.2.1784337260111;
        Fri, 17 Jul 2026 18:14:20 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344f12e0sm19364325ad.31.2026.07.17.18.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 18:14:19 -0700 (PDT)
Date: Sat, 18 Jul 2026 02:14:14 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: invensense: better timestamp alignment when
 using watermark
Message-ID: <20260718021401.7e5f54d3@jic23-huawei>
In-Reply-To: <20260717-iio-common-inv-sensors-timestamp-rework-v1-1-d1afee2805cd@tdk.com>
References: <20260717-iio-common-inv-sensors-timestamp-rework-v1-0-d1afee2805cd@tdk.com>
	<20260717-iio-common-inv-sensors-timestamp-rework-v1-1-d1afee2805cd@tdk.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDAwOSBTYWx0ZWRfX6g8pZ48bMHPw
 HocGjxyw/EfP+du5KS9Enm4/4WkFrYE/M+pLl/TyDgrjRTfktgkkIg5ztGrIpofOtXrhjh8kg+C
 DX66xwEns/fSdvuE+ZE/zQLw5Rl97bEeUfVxVQQ0g5sat0VjCpNs+DsMdb0uDkBLakCwEaA+vN4
 5VhYa9R4RDmr5sZ2jr1MjXQw9V8t9UCDtHzOHao2cEM3iH6Vnxu9OQe/C1hPGbA3Ug4I+TWWygY
 LyCKH+uq76ca3nEe56oQ7eJOjlNFn2A/598E6GOgO6npVvWRHB/JYbGvhf6gw/q/SDbpqD8JzkU
 iTOGADeO08iMqKKOpT3JNy6IsUPnT+lcsqAZ0qLUhgHU65sHT3f3VTl0S+JoOc+lqGnb42ZR/fu
 1gzNBvYVDX0bqZwXOTyriK/QR6gxkySk5QrBAgxX4v7srsVVEebPVgmbQ3ctW170FPiO0IvNjOE
 WefHbewBXb4Wkrb+yLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDAwOSBTYWx0ZWRfXxnicw8jnCdFW
 BuEButsz/Opyi0g7sH9dELqkYxjceKjHDz/sjpi01neinNsG3wkcmCvq59bCEs4mhtyBGZZ9mOb
 CDWGKaRpI83HhtoNA4XiFfuZIqb4CPA=
X-Authority-Analysis: v=2.4 cv=YeWNIQRf c=1 sm=1 tr=0 ts=6a5ad36d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=ZZqDz5lU3Qu-RT7MuEQA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: oGxtvABVtqe5tZ3bfS4ALf8_YBJbdSGF
X-Proofpoint-ORIG-GUID: oGxtvABVtqe5tZ3bfS4ALf8_YBJbdSGF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180009

On Fri, 17 Jul 2026 14:39:40 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Current interrupt timestamp alignment only change the next coming
> timestamp. For watermark where we have a batch of samples per
> interrupt, it doesn't manage to align timestamp since modification
> is limited because of jitter.
I've read this a few times and I'm not entirely following the meaning.
Please rewrite. Intent might be something close to:

"Current interrupt timestamp alignment only changes the final timestamp.
When the watermark is in use, we have a batch of samples for each interrupt.
The current code doesn't manage to align the timestamp because the
jitter is too high.

Instead modify the estimated inter interrupt period and use that
to  adjust the timestamp alignment over the batch in a linear fashion.
"

I'm not entirely sure however!


> 
> Implement a better version that instead modify the period to align
> to interrupt timestamp. Period is now computed by align timestamp
> if interrupt interval is valid, or we use the computed estimation.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>  .../iio/common/inv_sensors/inv_sensors_timestamp.c | 55 ++++++++--------------
>  1 file changed, 20 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> index e0b10366ed2b..2c89e0edc87d 100644
> --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> @@ -10,9 +10,7 @@
>  
>  #include <linux/iio/common/inv_sensors_timestamp.h>
>  
> -/* compute jitter, min and max following jitter in per mille */
> -#define INV_SENSORS_TIMESTAMP_JITTER(_val, _jitter)		\
> -	(div_s64((_val) * (_jitter), 1000))
> +/* compute min and max following jitter in per mille */
>  #define INV_SENSORS_TIMESTAMP_MIN(_val, _jitter)		\
>  	(((_val) * (1000 - (_jitter))) / 1000)
>  #define INV_SENSORS_TIMESTAMP_MAX(_val, _jitter)		\
> @@ -102,34 +100,22 @@ static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
>  	/* update chip internal period estimation */
>  	new_chip_period = period / ts->mult;
>  	inv_update_acc(&ts->chip_period, new_chip_period);
> -	ts->period = ts->mult * ts->chip_period.val;
>  
>  	return true;
>  }
>  
> -static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
> +static uint32_t inv_align_timestamp_it(struct inv_sensors_timestamp *ts,
> +				       unsigned int sample_nb)
>  {
> -	const int64_t period_min = (int64_t)ts->min_period * ts->mult;
> -	const int64_t period_max = (int64_t)ts->max_period * ts->mult;
> -	int64_t add_max, sub_max;
> -	int64_t delta, jitter;
> -	int64_t adjust;
> -
> -	/* delta time between last sample and last interrupt */
> -	delta = ts->it.lo - ts->timestamp;
> -
> -	/* adjust timestamp while respecting jitter */
> -	add_max = period_max - (int64_t)ts->period;
> -	sub_max = period_min - (int64_t)ts->period;
> -	jitter = INV_SENSORS_TIMESTAMP_JITTER((int64_t)ts->period, ts->chip.jitter);
> -	if (delta > jitter)
> -		adjust = add_max;
> -	else if (delta < -jitter)
> -		adjust = sub_max;
> -	else
> -		adjust = 0;
> +	const uint64_t period_min = (uint64_t)ts->min_period * ts->mult;
> +	const uint64_t period_max = (uint64_t)ts->max_period * ts->mult;
> +	uint32_t new_period;
>  
> -	ts->timestamp += adjust;
> +	/* compute new period aligning last timestamp with interrupt timestamp */
> +	new_period = div_s64(ts->it.up - ts->timestamp, sample_nb);
> +
> +	/* ensure that period never overflows the jitter */
> +	return clamp(new_period, period_min, period_max);
>  }
>  
>  void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
> @@ -143,6 +129,13 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
>  	if (sample_nb == 0)
>  		return;
>  
> +	/* no previous data, compute theoretical value from interrupt */
> +	if (ts->timestamp == 0) {
> +		/* elapsed time: sensor period * sensor samples number */
> +		interval = (int64_t)ts->period * (int64_t)sample_nb;
> +		ts->timestamp = timestamp - interval;
> +	}
> +
>  	/* update interrupt timestamp and compute chip and sensor periods */
>  	it = &ts->it;
>  	it->lo = it->up;
> @@ -154,17 +147,9 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
>  		valid = inv_update_chip_period(ts, period);
>  	}
>  
> -	/* no previous data, compute theoretical value from interrupt */
> -	if (ts->timestamp == 0) {
> -		/* elapsed time: sensor period * sensor samples number */
> -		interval = (int64_t)ts->period * (int64_t)sample_nb;
> -		ts->timestamp = it->up - interval;
> -		return;
> -	}
> -
>  	/* if interrupt interval is valid, sync with interrupt timestamp */
> -	if (valid)
> -		inv_align_timestamp_it(ts);
> +	ts->period = valid ? inv_align_timestamp_it(ts, sample_nb) :
> +			     ts->mult * ts->chip_period.val;
>  }
>  EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_interrupt, "IIO_INV_SENSORS_TIMESTAMP");
>  
> 

