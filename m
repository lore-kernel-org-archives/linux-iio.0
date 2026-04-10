Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E83F3859E6
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851416; cv=none; b=RDEq+rxtM9XW1lAf5vTVdLqmEqJ0c7KO9RlPyuY2tWpqDJrpBdxw8+GJd+tSDZyGngMQ88SISQkPGZBfs1BVlvsI1EM4FsufI+3J/uOoewbWCW5wRFGR4W3Ewjwb0nbj3EMi+sm5V7b1lVByjKCbel+zhnBEIjFKBLw9xvZWUdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851416; c=relaxed/simple;
	bh=dQEI+RAv8fDiB4XvA4CkEXutIegdIJLC2Yo+K1odV0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5qr00L84DzVE4WVRrK9obHFfrtIT12TU74PESfSz4iVXrfKKe/Xou1ATgBuqEpUoZ1SyiCU6sNmeCD9KB+ZVIN//iCxnodv65bmaIFTsmKou9HGiKvXUkGfffFnxjJS//ZFho7KvAxswUXf/rjgUDJkAb4eaMuYjFLLtF2VIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=BC+mSSuC; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="BC+mSSuC"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7ebe11bffso2167065a34.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775851414; x=1776456214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DgoYNG0L10EMMFDzlIpM8gfugVP9vew7olPcN4uvRsM=;
        b=BC+mSSuCEaUFuRGZGC/6NqJsRwmBsn/FlEskYf1S0y2BYbCj1iqPngFhLy9o3zVkY9
         YCeS8CGUVhMf22l05oSm+IYHRrohkgSYLgvQivCRzXeS64lbX49zWfrcOV8QGM9DXoe7
         Z7PFW9gZB6JsYaeWBRA5yIgbDWMKYXq2olUky0TSpjUTXE0sr1EM52DkcAeN+39JdM1C
         yMxPy3k/ZVen9FqZi1QNkSGKnwLew/DYkkgKU5heAmW6Qp80vOVjE7i27ogGovF8HDFP
         vOaUAhAjEc5DyamIv/rBrS8XLYWESTIbLKamRqF+r6EI2yd2qFuHPQi9GIsMTCGMWaVH
         Vjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775851414; x=1776456214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgoYNG0L10EMMFDzlIpM8gfugVP9vew7olPcN4uvRsM=;
        b=BsxsqLGsaludOSjTJFtVMNOKCnO63fbdTbsogNHmDE1ZuPE68CAjajbtFjwAn/z9T1
         jx4IGNvkbUBG5JlAqIXtXHbgMI8O+IURgM9u1ZsIQyHAbONGyBub776gbKvhEMfuSViV
         hBM+kgSuiiUAgRIOiQkXYRSYysXN0Hf7cN0vnz5+uI1Q2wHFsjJBcqi1vgRb+tWewoUV
         u20LKVgu5UnLr+zlOSRzpj8r1g5wnTDgdwfF/46B5n7AwnAlxSIu9kxYSyDj+9s67aps
         M1WitJPi+vhTsulBWZQKBf/SStxwusNRYzt0EJnoQgu85C8tKZIaYyzcyYq19KRcPoMA
         NLLA==
X-Forwarded-Encrypted: i=1; AJvYcCUTrTrpCaf1+9zFaIjDMtdahk0CmFUjTpIjV5yCBuMCbyh75e2IpaNhvmrwUXkXAUGtmRuX7ew8DIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPrA2if5pNSJGeeAx3+q71SwCiL5DKi13/ekYN530b2nwtEeeb
	q6KVJPSyoCXC8j/P1i6qtLSjM+L6S1LSUSJbboiy7xFpKwt81c78LboAXMj+7HM31ZE=
X-Gm-Gg: AeBDiesIsAgK0/XqSG9VfNay/S6Us0+mRATCZTZyx1U2rcGDFcwuge8lDr8cUI7w+oF
	Ivv5hTpTzcx3atb/yFRc6boeMFZ4tYV+VJY2spiX9zpNURKfrLSCTZsuGWUZO7qTWheVHYDZhZA
	TN9nczMk4uVo9Ekf7dSZoIJxh5uaKNrcOBOAJjIRp9b9sQouvAzOgAD9Ltqg399opx7KkMpvNP5
	yraCCeqMyCxCltlZpBxTqMiq9F8ep95JyDyv9iQXtGexu6/smLT4rJe4NC7+1HwyNC607IwRvwx
	xF4irpbNmPi3OaHThY9/EEGgMW0HFQcBCPXv5ArKeAfmsM5S+5XoAYli/6qrSReZmu5TXWN+b57
	qp1xiVMmwg9N2dYw95wc0yIGEIF3HB9dFkRP67wvXv0w2ZDCLO6fpeWCHUM5Ns8m5qrQxvTrBPP
	T+KJ3gW4n2T6c41ub8J9in+tOJruEpgWTytYAFa2jc7xYWHDoA64poD9+IgzAt2TZOA9yzXHKc5
	g==
X-Received: by 2002:a05:6830:3e07:b0:7d9:ad90:5670 with SMTP id 46e09a7af769-7dc27f114c3mr3045127a34.18.1775851414308;
        Fri, 10 Apr 2026 13:03:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b? ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc26905041sm2647106a34.14.2026.04.10.13.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 13:03:33 -0700 (PDT)
Message-ID: <60c2cdbc-2ee3-49ce-8a94-590230899cbc@baylibre.com>
Date: Fri, 10 Apr 2026 15:03:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] iio: dac: Convert several drivers to
 devm_mutex_init()
To: David Carlier <devnexen@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Kim Seer Paller <kimseer.paller@analog.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, linux-kernel@vger.kernel.org
References: <20260410193737.35905-1-devnexen@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260410193737.35905-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/26 2:37 PM, David Carlier wrote:
> 
> This series converts seven iio DAC/ADDAC drivers to use devm_mutex_init()
> instead of mutex_init(). These drivers currently call mutex_init() in
> probe but have no .remove() callback, so mutex_destroy() is never called
> on device unbind.
> 
> Same pattern already accepted in iio for other drivers (e.g. ad5446,
> ltc2688, ad7124, ad7606, vcnl4000, etc.).
> 
> David Carlier (7):
>   iio: dac: ad3552r: Use devm_mutex_init()
>   iio: dac: ad7303: Use devm_mutex_init()
>   iio: dac: ad5758: Use devm_mutex_init()
>   iio: dac: ad5755: Use devm_mutex_init()
>   iio: dac: ad5686: Use devm_mutex_init()
>   iio: dac: ltc2664: Use devm_mutex_init()
>   iio: addac: ad74115: Use devm_mutex_init()
> 

Jonathan has mentioned before that he doesn't care to take patches like this
unless we are making other cleanups to the driver too. So we'll see what he
says this time.

