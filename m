Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1921369D75
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142343; cv=none; b=T5OEHvrywzr+2aermMOkKIkiKCjskzIUyUBWtSP8535+dd2ZuuBkoB5oEtHVX9sVC553gcFha+kfCgcoC1gq3ZmE+AloZ/TRG7RcMXPELQxAzSyksbiGRdWeNTXGu1SdTZ9htdwHW2oSZRQ5VPM7QOOThtu9lgMVBtTmu0ayY40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142343; c=relaxed/simple;
	bh=Hpchx+TeVg+3320N2ZLza2s70qLylkvHKlXE793d4Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ED6A4ozEFkqpuX0je2QHW7VhxzpyScVBXisKRK3onPqkURHKuj0nMATyXWahk9b4FXbU0y2Hd9kSAdyxggK8OdjbHWzHI/v/mq0TgWqhuGDrCnY83488wjk2V/Ji1Rxyg9WbTO4HKD40HqNnQ8AiQsdLY+dgCHmC5B0Iqa87mFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=U36gbV3M; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="U36gbV3M"
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id 9DDIx4I09JFmF9FnYxmMwI; Wed, 23 Sep 2026 05:45:41 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 9FnXxVMlUvfbR9FnYxoYI9; Wed, 23 Sep 2026 05:45:40 +0000
X-Authority-Analysis: v=2.4 cv=X7FSKHTe c=1 sm=1 tr=0 ts=6ab36784
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=4ffO35K8LLM2FldQJH0A:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=/E5qcA3QzsXosiYS9VqPceYIRRHq3vwJ1GMOPH5S7j8=; b=U36gbV3Mix/x
	WIQjz6KImRom22m14NU17nkw2Fz9/BzozX7h8i445DOlqIky7qEU2Ko0uaWY72P3QKkAB2vwMh3DV
	z3GccUJyHkhSvmxM8MdZT9Dr2mByWNDmnsm5Uv64/k4mXHrwrZvUpQVro6qkg3CuafvSJ7ZyoARzF
	yWnVDH2AFHAjE/g7CftfEa2a4b4EyrC7MPNSj/S0d79W9lMYod2wX3hHhmBhoMngx5GcdWnpWx2h4
	UinxsBdLkVY0fMD6ot2o6xHlSzcgAS2BG3rxOUBLHbrlJPd0tB2IoWbjW+6/wCgzvMMDVTuNQ0Kym
	jfgitaiY82MPrUluK+MEqg==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:36818 helo=[10.203.100.34])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x9FnX-00000001zQT-0WFg;
	Wed, 23 Sep 2026 00:45:39 -0500
Message-ID: <8d82177e-5347-4e7e-898b-01cfe244e1af@embeddedor.com>
Date: Wed, 23 Sep 2026 14:45:34 +0900
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: qcom-adc5-gen3: Annotate struct
 adc5_device_data with __counted_by_ptr
To: Bill Wendling <morbo@google.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 codemender-patching+linux@google.com
References: <20260922220950.2267270-1-morbo@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260922220950.2267270-1-morbo@google.com>
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
X-Exim-ID: 1x9FnX-00000001zQT-0WFg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.34]) [125.195.69.90]:36818
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 41
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI/3Q5ZCbvO/YKE5YNyEm265SDUtw7A7jS6oA4Ao9uNDOuFDCoDO9lQ2n7cElSpP9XguHtYTdJaMInbHqWQgZBCQRzOROpIwlubDe3DoQ7u8tov+NukO
 bTS7gwhhh83TdG2MF3vmyWjRIDGMMZ2Pu1x3Q0zShb3A6vficu7Yzla/UnCV/3/KJi0NG2i9STardQ/BibyID0/vwO+xtbaBJtw=



On 9/23/26 07:09, Bill Wendling wrote:
> Under compiler-supported bounds checking (via KASAN or UBSAN), pointer
> fields inside structures can be annotated with the '__counted_by_ptr'
> attribute to specify which field in the same structure holds the element
> count. This enables the compiler to perform runtime bounds checking on
> the pointer.
> 
> Annotate the "base" pointer field in "struct adc5_device_data" with the
> "__counted_by_ptr" attribute pointing to "num_sdams". The number of
> SDAMs is determined from the device property and assigned to "num_sdams"
> which is then used to initialize "base" via "devm_kcalloc".
> 
> By ensuring "num_sdams" is set to the correct element count prior to
> the "base" pointer allocation, and since the size of "base" is never
> reallocated or changed, this annotation is safe and will not cause any
> false-positive runtime bounds check panics or KASAN issues.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   include/linux/iio/adc/qcom-adc5-gen3-common.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> index 39cbfcbdb101..b3e2c2f50e8f 100644
> --- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
> +++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> @@ -137,7 +137,7 @@ struct adc5_sdam_data {
>    */
>   struct adc5_device_data {
>   	struct regmap *regmap;
> -	struct adc5_sdam_data *base;
> +	struct adc5_sdam_data *base __counted_by_ptr(num_sdams);
>   	int num_sdams;
>   };
>   

