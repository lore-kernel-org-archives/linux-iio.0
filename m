Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B333D566C
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749151; cv=none; b=Xh7DYZlf25kQ4IpnOX824gawp2LQore5PnLmH6H7c6HeLwtphmudErzO3ENx+vWrWJbCmSNuBaXMFanGWcIOo07QmnvAbAqLmuCsVw/aSzqyvGVJKessqJ+lXk11B9IM4m+VpP8fwSd3B/V7lJjtBzKieJxWJvyA8emZoe2Aeyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749151; c=relaxed/simple;
	bh=9VhZJJo1ygdNZ7TCtZth8WrDphwJqDTJXg2P9t77FzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggpHxY2E/DBVe2RQUAx5fzYnO4tA1LungfASADl1PMz8bYRbPgoGWUjyYnWThuv3xgmAQvlliF/et3cCcSPfIkN1QA2xqK90ms+Kle91qWv+3pqqZbAs5O/MkXk3m1ia3PfONgjvxv1yC5LpPJdPNTGWagH0h0MrrMTRlG3D1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Vmr4K6UU; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Vmr4K6UU"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d556c1a79eso1447165a34.3
        for <linux-iio@vger.kernel.org>; Thu, 09 Apr 2026 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775749149; x=1776353949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3W63L8sSL/cmlr8dk45RzNHMgaS33g+6/2V8j5M410k=;
        b=Vmr4K6UUzPUu7EzP4TLLS2F9x6U6q4uPQuk6SnhERS9PcR+h7YS0STdimjvodB1DX3
         kOBKiRLFNfTuDnNxmAg3MdQtX7+WUtJP0KvsqSdjATF/21E+QSceqXDBuxKcMuMRaJZo
         cARUqgAh9FGThsHscdmQL/ioCBfqdZCemdTmywyM5MLot/Nw5hmCapSft4GO9ZZHFKXH
         9vrOZjKB24hoVVzoKthIOgHMEkX8av7J3B7aOCNJsSLRU2sS0UGZOTgWHJO93Uf1P+t1
         nS2YbY+YD3FkYHklnfwN0OcQtKPp5HyI0qDrutoumhM83h36wEgogl0kt5uJNVpLO4lE
         ZLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775749149; x=1776353949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3W63L8sSL/cmlr8dk45RzNHMgaS33g+6/2V8j5M410k=;
        b=eq0bIapEQuQCGqFoRCOSe5anW9eqfLCJgGgGEdg4/nSlb8QxXtT2r+0oWRPoKhy/yH
         3lfrADiKdgVNV6WWJMg6JM/zke8rZGNIpWU5e5OCnyT/HLatesyP+nGi6/TRNOIXlE0R
         wryFRH+NAgFZ1o48uCSjq1WAzgIutTHwNfOmErKtbbnCiyuRRmQPDR2q7T7snnw8JcHO
         UyVf19rt1f4MXJA1QVhS9JbUNREKiKcuFwvBQp3FLB1YKKUhq6eSe2n9cxYPVi8GQhl7
         eg+KHMOIyN2Z8/ulhMwZlJE2o5tX8vDFx0s9FBpFvhyl9IBbVW/3pVJxBSCRLbjD8sYQ
         Go4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/wvMpuVHKroguvJtSm9RwwDuS3omh/TH03PYiL3wzhx5i8UQoAtvyyXdiZhKTQvR0BDB43RYgAsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVpE0iZEDSoI1/4AF7hy6gjjUeajvA3Gz+DuR7cdZU0OD5j6/
	yMHRdkq9wHPtMX+lzFrets2oqPOwLjHOaKcpOmnZFbzH1udloRxDNrvb7suHfOclCRg=
X-Gm-Gg: AeBDieuLnddVHwy2/yw9ps2yMe4Bi+jULXd/iDCY3JMiSm6XX0HB1s+NZQTai/1I0Gl
	6ywtgpecz3ItjuTSryxyY0khlBFwal57a0GqXzUDuOHLksiJCbnARBVm/I8Gc90RALdML+kwGHy
	DEnek3PDgdo2omLDWI9hBVpT8eZwy1Xb0Qp3rrsdJSQJ4Va55HXQ1OqN3CAwrWNmoMULEUigyqN
	wq1PL98/bKS12dKV++og/TPx5RzphvKXgM3Ch1w41gx1lnlXm5PXOwIKGry6U0StR9aAKeOijpR
	ViG33+lcgd98GV5bNFKVseiap91Nik/lWTTlvf9mKDovo8Pw24fd2bmWbj8v7ZdPB9VeAgDUizh
	BkQKMH3GbJ9fCNkCA/4DBbSGyVksF0MXFNAhQ0Z7BYQz1Y1OmgDvAdHGldKwPVJGyp/x/SRYKNW
	rkhQL91ZiIhihRUtznsMtN4m2v23WJ9CbqIZM/fFynF+LXbYVKPGc6NzWVtqOx1E52svhyjIDY2
	A==
X-Received: by 2002:a4a:e90d:0:b0:67e:aa1:8821 with SMTP id 006d021491bc7-6822123db74mr14009511eaf.64.1775749148827;
        Thu, 09 Apr 2026 08:39:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a548:cf0c:d054:fd01? ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bc4d03ea1sm15573eaf.0.2026.04.09.08.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:39:07 -0700 (PDT)
Message-ID: <b37516b6-da77-4496-8514-b14ed0ad76d1@baylibre.com>
Date: Thu, 9 Apr 2026 10:39:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: frequency: ad983x: replace do_div() with
 div64_ul().
To: Joshua Crofts <joshua.crofts1@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, gregkh@linuxfoundation.org
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <2026040913-spherical-slacks-bc5b@gregkh>
 <20260409150157.1300-1-joshua.crofts1@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260409150157.1300-1-joshua.crofts1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/26 10:01 AM, Joshua Crofts wrote:
> Coccinelle reported the following in both ad983x drivers:
> do_div() does a 64-by-32 division, please consider using
> div64_ul instead.
> 
> Fix this by replacing do_div() with div64_ul(), which
> safely handles 64-bit dividends and unsigned long
> divisors across all architectures.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
> v2:

Please don't send v2 or later revisions in reply to v1. It breaks
some workflows. Start a new thread instead.

>  - resent email with corrected addresses

Instead of a v2, you can just add a RESEND prefix to the subject line
in cases like this. But do include an explanation like this when you
do that.

> 
>  drivers/staging/iio/frequency/ad9832.c | 3 ++-
>  drivers/staging/iio/frequency/ad9834.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index b87ea1781b..61ee93263a 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -13,6 +13,7 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> @@ -115,7 +116,7 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout *
>  				     (u64)((u64)1L << AD9832_FREQ_BITS);

I would expect checkpatch to complain that there is no blank line
between variable declarations and the rest of the code here.

> -	do_div(freqreg, mclk);
> +	freqreg = div64_ul(freqreg, mclk);
>  	return freqreg;

We can just return directly now.

	return div64_ul(freqreg, mclk);

>  }
>  
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index d339d5e8e0..83d0e1360c 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -10,6 +10,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> +#include <linux/math64.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/list.h>
> @@ -101,7 +102,7 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
>  
> -	do_div(freqreg, mclk);
> +	freqreg = div64_ul(freqreg, mclk);
>  	return freqreg;

ditto.

>  }
>  

