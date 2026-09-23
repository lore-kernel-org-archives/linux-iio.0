Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3E38E8AC
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141911; cv=none; b=N3FfBpAF9cbCfbTweHKCfiB5Vfqc/scsCV1MLeL88NY9uPUbPy4r5Cekc9pTiADlTvOqBTNG/Na3lOBRcVXqiIRCy7sNYlvVVoS7WP0cfctbJr4i/4+16niiGra8KV/VcEwTE5lDFVNlGY1ry8xzzmv29k4WmaJrM2c9PY8Trk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141911; c=relaxed/simple;
	bh=CHf7YR2P1zfqC8/qUYW8PpUaHXWITc/4OJW3WX30+6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+Kznb4bhSwkZR0eyf4h0K6RkNo34jXkSLAaF9fgqH/L7pZnwZQ5yBk8wnB3k2zsx2hnkRo+bDYkzY2fqn+782xzVbGcfYaF31VTAkz8Xw7gPxwPgp5/Q440haBfqXPiydNJfTGh7jxmLIw3X3+XxanvQSCxxCGosFMC3s5wp3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=wcavxlZ1; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="wcavxlZ1"
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id 9AP7x3rxgJFmF9FgUxmKqM; Wed, 23 Sep 2026 05:38:22 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 9FgTxgEGiCZwg9FgTxOSSX; Wed, 23 Sep 2026 05:38:21 +0000
X-Authority-Analysis: v=2.4 cv=f4JIBPyM c=1 sm=1 tr=0 ts=6ab365cd
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=uNDWqsvZ2givMv5jDzEA:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=9nKFyigc1frVZS9CIQh1jg/E4/ykOvn8MgO5qeg9drw=; b=wcavxlZ1EV72
	KhTCSyaArt7b0uBYHi1VUzqkhgnSKazZlRWTo7Ge0PMh0ZM9c+58vANvfPu1F+SQM4wRBJ+QEvt+C
	WX47oewvI/760U4RB8BSmchKsE0TMxyja8sZxb5aKH6NiCV02EysGyYmxazcNgoJoKkfwkbvuhn+a
	pSYBDx2Cvj/u00eNS6Drk4f+jCKVpZd1FtnN0v8pW+tFffO5xNkTY6cJV+KojtKwq/W4/W8m2L2O+
	2Xil3PpKFMAWS5uJqqiA6FhIgKqnqs4zVe0HuLwY/ZN3lXna2K+RRyPGRpufMEHAMbua5+Jkk+7hB
	5iPQjEo2FzKcXZ8hKBxn6g==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:37820 helo=[10.203.100.34])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x9FgS-00000001tuW-1rCn;
	Wed, 23 Sep 2026 00:38:20 -0500
Message-ID: <00310b7b-7367-4546-90f3-4c0bc23f36d7@embeddedor.com>
Date: Wed, 23 Sep 2026 14:37:45 +0900
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gts-helper: add __counted_by_ptr to struct iio_gts
To: Bill Wendling <morbo@google.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, codemender-patching+linux@google.com
References: <20260923041630.2553973-1-morbo@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260923041630.2553973-1-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 125.195.69.90
X-Source-L: No
X-Exim-ID: 1x9FgS-00000001tuW-1rCn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.34]) [125.195.69.90]:37820
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEf9yDeGUjdm5YiH+khsRFsd8ISAm9rOPPdvk+4ndEEGFrCHZcrwsUDhhtPV7Gk+WA2tEKCyMyPUozLVaX4cEuDD7I2yqgBTdLShUjVCoA/kEi04X1Pe
 u8PNQRqbL3V4WMipNcqNPnR4Bxogyr2YK8+i9FSK1zIhaxwoWtlWW5wO//Mu0/a6XD/w96TuH3yrVLCr9owx6Iz5KYfWoagwf3o=



On 9/23/26 13:16, Bill Wendling wrote:
> The compiler attribute __counted_by_ptr can be used by KASAN and UBSAN
> to detect out-of-bounds accesses to pointer fields in structs where a
> corresponding element count field is available.
> 
> In "struct iio_gts", there are multiple pointer fields associated with
> an element count. This patch annotates these pointer fields with
> "__counted_by_ptr" to improve runtime safety:
> 
> - 'hwgain_table': counted by 'num_hwgain'
> - 'itime_table': counted by 'num_itime'
> - 'per_time_avail_scale_tables': counted by 'num_itime'
> - 'avail_all_scales_table': counted by 'num_avail_all_scales'
> - 'avail_time_tables': counted by 'num_avail_time_tables'
> 
> To ensure that the count is set correctly before any pointer is
> accessed or assigned, we update "iio_init_iio_gts()" to set the counts
> prior to assigning the pointers.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   drivers/iio/industrialio-gts-helper.c |  4 ++--
>   include/linux/iio/iio-gts-helper.h    | 10 +++++-----
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 4f52dc373abf..4de6324fd923 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -652,10 +652,10 @@ static int iio_init_iio_gts(int max_scale_int, int max_scale_nano,
>   	if (ret)
>   		return ret;
>   
> -	gts->hwgain_table = gain_tbl;
>   	gts->num_hwgain = num_gain;
> -	gts->itime_table = tim_tbl;
> +	gts->hwgain_table = gain_tbl;
>   	gts->num_itime = num_times;
> +	gts->itime_table = tim_tbl;
>   
>   	return iio_gts_sanity_check(gts);
>   }
> diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
> index 66f830ab9b49..7e7d3396ff1a 100644
> --- a/include/linux/iio/iio-gts-helper.h
> +++ b/include/linux/iio/iio-gts-helper.h
> @@ -58,14 +58,14 @@ struct iio_itime_sel_mul {
>   
>   struct iio_gts {
>   	u64 max_scale;
> -	const struct iio_gain_sel_pair *hwgain_table;
> +	const struct iio_gain_sel_pair *hwgain_table __counted_by_ptr(num_hwgain);
>   	int num_hwgain;
> -	const struct iio_itime_sel_mul *itime_table;
> +	const struct iio_itime_sel_mul *itime_table __counted_by_ptr(num_itime);
>   	int num_itime;
> -	int **per_time_avail_scale_tables;
> -	int *avail_all_scales_table;
> +	int **per_time_avail_scale_tables __counted_by_ptr(num_itime);
> +	int *avail_all_scales_table __counted_by_ptr(num_avail_all_scales);
>   	int num_avail_all_scales;
> -	int *avail_time_tables;
> +	int *avail_time_tables __counted_by_ptr(num_avail_time_tables);
>   	int num_avail_time_tables;
>   };
>   

