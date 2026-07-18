Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA7E1D798E
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784337954; cv=none; b=mBtYGMz4kSuvmEcCT7TsxAyE8pxUXeYo2HnjczLSmdc6k3TH7tShfaJrHKLGw6keJAt49qcMk2k1xC3x9/BXcWJpWAKXsPaxJcMzVIZ3v1+onRNYqACYH190KMJ62+1ttrbXSCBZtuSQEPtCx4RWqHd5sM8ky1ZsGgcCzL2vTZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784337954; c=relaxed/simple;
	bh=mq80V3txfMXMrCkJPr4Mb6+fv+nV4KF/2puhgZAS/Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMHgqxE4IG3BlT10p2+deXqp81MldUA7AZnMpFkqLn7mmG1F6PUNk6Ow+0pDA03gBMWyB/0dFjP7UCkRK992nw1FsK/NElr4lcXocaKB5xyDfymUJyX4REYDua2wad9mIugX/Ig9MoSCJ4pDMbKHRauTGW+hgNJwj9t+EMnhrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FtYBk04Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XOMaQAe1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FtYBk04Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XOMaQAe1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66I1HOPf3340949
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zRvVor+vPAyIjKQugxrudK5zr1kiGbEWiE9ngLXi0ug=; b=FtYBk04QyMvm8+qD
	RE+E6kQtmLne4jBIv5UHGBnsYuPoFxDJhE68Yjqt9hTZqx0NdWWzFxxad3ssLhdb
	3zx4bjHCE/g9BXiDTMAZz/8Gdee+WwUW++9BWDV1j/GiaL3S/WGc/ILMnIkvIGv3
	9vkW46PP+7Hdcd6PcFSP9iuO3FFeVrYNyXt9jwRMBdTLCpNQe8WlMs9p/sNF00Dp
	WyCBjy6DtvnS4Z4B1GLpao5xfuWZltJyyrPVbTIQbwhn2NCbJcbkRIk3Cv3FfEsZ
	iTdB3jFZv7cKBnKu6rvCzCf5ayFNY62CJvtUr6G/IdhIBqlznEOAiO4d9BB9xR5T
	rVB1Sw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffypqr0gh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 01:25:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848544a8496so5955294b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 18:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784337951; x=1784942751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zRvVor+vPAyIjKQugxrudK5zr1kiGbEWiE9ngLXi0ug=;
        b=XOMaQAe19mkW7JrDkYg5TR8V8Q3d7oWTg2NsGaFBHEoh2/+P1JVJUFhiQM1o+/hJP+
         ewqFTPniEDfob6zX7UFpsDNrMXiOFck2Kcbwgg6OQhbrxnjwRZszc1Fmend4MqZacFeV
         Z0aDsm4hcGiLH3lg37fV/CfWkozCySP8LmykTLzYktrUjhpOxiDe0f+I8Y8+FDlefS1d
         1eA5WGhxWtNfmb+Thv2DlpZPp7jX4tMpqclW1HTB+X8nK15fiY6pN4s27OxYq8bCD4Cd
         YQ8Pl5lklEXkz7oNZkHvp1Mf2SySsEZ9XbPehqzFwHdRDTX/esE4cu/t5fjLaNAYlXMo
         bKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784337951; x=1784942751;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zRvVor+vPAyIjKQugxrudK5zr1kiGbEWiE9ngLXi0ug=;
        b=C7fw7bjoGUwVn477sMG1BWVVqHFW0bi+lm89Nsf9jm+qqnGJ7CM4c8/B15zozB0Rr4
         1ODiknfDsTTqwC5r+E/rJCUoeLfo4mj5ApmgAquASkwJilbvWND0GRkiIrObgCIrxNg0
         /xbZnAJ+WIJHBppeL5LSDvENZP9rwxnbGO2d7s/6+AnA2/5Ah65d2XSWYFWyLkInQEOz
         dCydePbcBmjzzyVIqJpJi+I5NJM1Mat7KkQa2ORjBr2lhiqvJ48vN99KJdNg8nfELwo3
         eDeuviRjgBtSTgUqwocJD4GJG4SYGhlHnLf+F3G90VxJe2vKB+09iyv2hoNvGN5L75+/
         lBlA==
X-Forwarded-Encrypted: i=1; AHgh+RrfUoLU6u/yflbtFBz4K3OIZ3lRJemF+ibLIAjiP9SMt2e/KcZ6MhDDvHO+i9+TK/h2RnLBNb+rVqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLqiC9ZbD7rjSN3EVo05kwc/6cPzfCFqT7WpEbRxnFKTTNBeeh
	80qARYGwF1J/Dqo3oUlHj+r64BtXA9ZpFWpp2fRiQ9OttmdKHjAz1f9eOUZ90Z972aDvgkMR+j8
	CqZhj+T0Dz+fHQZJdiOWFI8b1/xXXWQNuKq5e1PNN+xbzsGs1SPgfMShARRqr4ls=
X-Gm-Gg: AfdE7ckDtrYTV1LuAh3SC+xYDLPa/1uOd81jcjY8/JmJmv7ssHfcpRawbiCI0+bNe6U
	GTfOCsWhPj64GXJGVaWF0zt1vPu6m2VpLi5cKDbsalSpQ9j3Bk3eKPSGyeUIBk6WTRZ/90jmfQW
	LSIxVeOqxVBbTTDsxXni+plmrGjepkIcLWCAGAj0uwPPQ/g36vrOpqFiolHmq7TdnkuwJA081z+
	JylxDz2Nw5ooWuW3DVPa6JMHyvew5aF1/XCLzMqeiaxsIWqjNviXkLY6doNIf1hcGwmXaPceZ8z
	o5DJxuPqBQn/thgck9jIkg+O9jxEKLPoxx+Ar4b5YLJKN4/eelmr8QhmZ77lp7Z8w60bK1v4Mvm
	U7pKLauJk7Qpi1OTL
X-Received: by 2002:a05:6a00:228f:b0:845:3fe5:cddd with SMTP id d2e1a72fcca58-84c29501125mr5422860b3a.36.1784337950607;
        Fri, 17 Jul 2026 18:25:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:228f:b0:845:3fe5:cddd with SMTP id d2e1a72fcca58-84c29501125mr5422834b3a.36.1784337950116;
        Fri, 17 Jul 2026 18:25:50 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af31790sm1975291b3a.37.2026.07.17.18.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 18:25:49 -0700 (PDT)
Date: Sat, 18 Jul 2026 02:25:42 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: invensense: improve period measurement by
 using a longer delay
Message-ID: <20260718022529.1b339061@jic23-huawei>
In-Reply-To: <20260717-iio-common-inv-sensors-timestamp-rework-v1-2-d1afee2805cd@tdk.com>
References: <20260717-iio-common-inv-sensors-timestamp-rework-v1-0-d1afee2805cd@tdk.com>
	<20260717-iio-common-inv-sensors-timestamp-rework-v1-2-d1afee2805cd@tdk.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDAxMSBTYWx0ZWRfX02cgODvoKY/D
 Jb/GuAnNEUlLcO9bP6u821vL2B8EGxe2a+0m5e7uvkzhDwBzJ6hFyRo3AMsNFOEUuGexGQaZcZs
 q0xs+useBbaXNAB05Nr2FSLC7Ma+u68=
X-Authority-Analysis: v=2.4 cv=bst8wkai c=1 sm=1 tr=0 ts=6a5ad61f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=c92rfblmAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=JO-11u2bgJaDzugZ4VEA:9
 a=CjuIK1q_8ugA:10 a=IoOABgeZipijB_acs4fv:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: LBl5qsfh0NrDLJREylOe1eL0j2o6Iuu9
X-Proofpoint-ORIG-GUID: LBl5qsfh0NrDLJREylOe1eL0j2o6Iuu9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDAxMSBTYWx0ZWRfX44Gk4/Re5HXA
 3s0BoTUULhFP+2E/vKl2QIuBhtchROXZ3UUl1IwFzHzdG+9sPmbfnsfx0dAc6WHc5LJE+mi4K7D
 HNHdvGqKV/+RnhqjjyZC6ErjVoDO19kgSBvlZWDSFXQ49FWnqHJMOhcjXCHxhA2Y5f+WOUVWy4x
 kSA0T4sHLcQ/Vpg+ksYGYnMHlMvzUmthsvT9baMcfEhxyz7hKlj9HC9DBDt10+3I5Guvm1RMoaD
 cRXIOS8D9MRbOUTQptRxp5pxlt/A1TU/X38kCrNIqA2B1YDGtR2Y6V+oj+KvvgdE2R19qTgYXoC
 0SpdL428iu49MxLuMaTnLwdPOxQK2eIv/aU3skjC52Vw4x2r2VW7Ql7R4yr3/hxinvQ9vdxQkNR
 UBqAkiq+/462tE16AFf/hVBCA6ng5Atfk3FySdgpYGn2RrF29VY5UVEEh2Licb8PJj2mhCMB/Oq
 4oTFIVLYqw9Q7F0xR4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180011

On Fri, 17 Jul 2026 14:39:41 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Period measurement can be difficult when using high sampling
> frequency where the jitter criteria is hard to meet because of the
> system jitter.
> 
> This new version is using the delta time between 2 distant interrupts
> to measure an interval of at least 20ms. 20ms is a good compromise
> between the mitigation of system jitter and the delay to update
> period. This way we decorrelate the period measurement from the
> interrupt timestamps syncing using only the 2 last interrupts.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
https://sashiko.dev/#/patchset/20260717-iio-common-inv-sensors-timestamp-rework-v1-0-d1afee2805cd%40tdk.com

Some comments. To me looks like a mixed bag. Please take a look.

> ---
>  .../iio/common/inv_sensors/inv_sensors_timestamp.c | 31 +++++++++++++++++-----
>  include/linux/iio/common/inv_sensors_timestamp.h   |  6 +++++
>  2 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> index 2c89e0edc87d..63c1d8a2e19a 100644
> --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> @@ -16,6 +16,9 @@
>  #define INV_SENSORS_TIMESTAMP_MAX(_val, _jitter)		\
>  	(((_val) * (1000 + (_jitter))) / 1000)
>  
> +/* minimum timestamp delta between 2 interrupts for measuring period (20ms) */
> +#define INV_SENSORS_MIN_IT_DELTA	(20 * NSEC_PER_MSEC)
> +
>  /* Add a new value inside an accumulator and update the estimate value */
>  static void inv_update_acc(struct inv_sensors_timestamp_acc *acc, uint32_t val)
>  {
> @@ -121,10 +124,13 @@ static uint32_t inv_align_timestamp_it(struct inv_sensors_timestamp *ts,
>  void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
>  				     size_t sample_nb, int64_t timestamp)
>  {
> +	const int64_t delta_threshold =
> +			INV_SENSORS_TIMESTAMP_MIN(INV_SENSORS_MIN_IT_DELTA,
> +						  ts->chip.jitter);
>  	struct inv_sensors_timestamp_interval *it;
>  	int64_t delta, interval;
>  	uint32_t period;
> -	bool valid = false;
> +	bool valid;
>  
>  	if (sample_nb == 0)
>  		return;
> @@ -136,16 +142,29 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
>  		ts->timestamp = timestamp - interval;
>  	}
>  
> +	/* update delta timestamps and estimated period */
> +	it = &ts->delta;
> +	ts->delta_counter += sample_nb;
> +	delta = timestamp - it->up;
> +	if (delta >= delta_threshold) {
> +		it->lo = it->up;
> +		it->up = timestamp;
> +		if (it->lo != 0) {
> +			/* compute period: delta time divided by number of samples */
> +			delta = it->up - it->lo;
> +			period = div_s64(delta, sample_nb);

Sashiko asks if that should be delta_counter on the bottom.  Seems plausible
to me.


> +			inv_update_chip_period(ts, period);
> +		}
> +		ts->delta_counter = 0;
> +	}
> +
>  	/* update interrupt timestamp and compute chip and sensor periods */
>  	it = &ts->it;
>  	it->lo = it->up;
>  	it->up = timestamp;
>  	delta = it->up - it->lo;
> -	if (it->lo != 0) {
> -		/* compute period: delta time divided by number of samples */
> -		period = div_s64(delta, sample_nb);
> -		valid = inv_update_chip_period(ts, period);
> -	}
> +	period = div_s64(delta, sample_nb);
> +	valid = inv_validate_period(ts, period);
>  
>  	/* if interrupt interval is valid, sync with interrupt timestamp */
>  	ts->period = valid ? inv_align_timestamp_it(ts, sample_nb) :
> diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include/linux/iio/common/inv_sensors_timestamp.h
> index 8d506f1e9df2..bc04831f54c4 100644
> --- a/include/linux/iio/common/inv_sensors_timestamp.h
> +++ b/include/linux/iio/common/inv_sensors_timestamp.h
> @@ -46,6 +46,8 @@ struct inv_sensors_timestamp_acc {
>   * @min_period:		minimal acceptable clock period
>   * @max_period:		maximal acceptable clock period
>   * @it:			interrupts interval timestamps
> + * @delta:		interval timestamps between several interrupts
> + * @delta_counter:	number of data samples in the delta interval
>   * @timestamp:		store last timestamp for computing next data timestamp
>   * @mult:		current internal period multiplier
>   * @new_mult:		new set internal period multiplier (not yet effective)
> @@ -57,6 +59,8 @@ struct inv_sensors_timestamp {
>  	uint32_t min_period;
>  	uint32_t max_period;
>  	struct inv_sensors_timestamp_interval it;
> +	struct inv_sensors_timestamp_interval delta;
> +	uint32_t delta_counter;
>  	int64_t timestamp;
>  	uint32_t mult;
>  	uint32_t new_mult;
> @@ -88,6 +92,8 @@ static inline void inv_sensors_timestamp_reset(struct inv_sensors_timestamp *ts)
>  	const struct inv_sensors_timestamp_interval interval_init = {0LL, 0LL};
>  
>  	ts->it = interval_init;
> +	ts->delta = interval_init;
> +	ts->delta_counter = 0;
>  	ts->timestamp = 0;
>  }
>  
> 

