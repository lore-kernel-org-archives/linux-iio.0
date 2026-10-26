Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036534;
	b=fU+szB/AblOuZwrdv0iGzoNFI2lg7KmGgpEmLblMWrX5UTXoKZhZxCMTapAd7XOMJpYL
	 kqOQKcHTTICLsojFY6iqKOCgQk9BgtXb+ct+p6jUdCUplOSEOJyZ2QLI7C1BRvigXYzeq
	 /ELSVJjkj88delBf8+v+EIrptJ8fwZ7JT9EbWkrOpTCGzoSKyL1LdU1HqbQyOMRfw7B18
	 76NHEULmxuBFyA9sl1MweUgoOsVwmS8OZ8ZnAHlHnIuPmF+r6fTDFbrybh8grRf/+rXQj
	 kakqXhuOyIzqpyRRBIvr4UCC5ixA+6jiR1gjZbYXC4mXee5jVIDT8uregTAaRBlqTrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=WAoMtkHfCWv+6BXicfU1j7E0e7dZp4DhcCvc99gABTo=;
	b=o2+OIE9oeEnTCXit81v6wMXPcq8N//CnSZQACpMa/HwTuTt0TYb7d93bg1peoiRwGfR/
	 1Ai2TjZZIs9ur2SZ1IsXeOVV/F6o/Rk2DCwTZvOXiqmUbxVDe3tcM7gE28DbVcsQg9bNZ
	 IJl4XS5mqWvLPKbNJLfdmF6NpGMxcudXnILj3D3XWapgMkBMTvsBOC9nSw1HpTfg94Z9p
	 nYsx++41cFRfMOW5dA+GE6c6YwzbctRJ9skX/e5fk6eX9qmNWfivbPrZQQV1/Ui3BqR0M
	 S9zbKAQwB02YaJOjQibw/Uf23brD1ZrWbX93O+yuubb1l0mZ+W0u50WTmcoPGYC92eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=M7d3W9ve;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D69606A32E
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 17:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96D69606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=M7d3W9ve
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36661f953e4so6132334eec.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793036533; x=1793641333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WAoMtkHfCWv+6BXicfU1j7E0e7dZp4DhcCvc99gABTo=;
        b=M7d3W9veJ9vjDTmNS8rtt9D+2mCqDD2Te5uWPu1k9rIWMTzto5Jct+DObEeqFlrhwD
         Irzx1/kmVtJ7SSQKdVZAWql4rBVqROykMdjeBFTck9xbPBHgibH9g25Dcf5QAP5+hZD7
         AYTuIgsruAIwuQISy4kkcXS6fn6K2LGnIC/J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036533; x=1793641333;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WAoMtkHfCWv+6BXicfU1j7E0e7dZp4DhcCvc99gABTo=;
        b=a+mMNcNANUhjlcJZEQwXMSobBELJzCXy0oxqCLWE7OMxE3myKdtLXacnmYJ9CNHxuS
         KVQJegE8xdNFhUHWiMNlZnYqImscaH1PQbXNEZKFHrja+C4iUKsP8115wjasYKZiRBmM
         iwC+YxWqmQrk9SNYvH5nNL9RQqX/8OKe7oso/hiUFBZcgqas1yPGyUtGwXwg6Y94ZwFB
         FTrmTw7VqMNBNggVBhGORBEQRlkglAxysjOPbgDNduh+priPR8Lyw2or8LLl/igNsLfB
         G7DEBoqEiNNtcF79ieMNf+KEW5lw5DZasZ3H1W6LA5ZtoK6Xk7V2/v3aB5mO/jQvF7Ps
         eFdQ==
X-Gm-Message-State: AFq9FYLFU1eHXD8A98QzyvfJlUbflGr8ZFoPk9z1QgT3uMZJggGHvBhF
	4z+yfCbjDP/PdgkbB1GQ6BbJylS1Xw+iZy0J945o1HWhQ2A8SCMzi6xqJxciuQqCEA==
X-Gm-Gg: AYBFou32QJ+sZLCd6j8PALJRGHUsDFMt+E9evmEiwT69LmTo5DjyY3e5jt7sKV5fuqv
	+b3s3aHX7wX5rhwVKV/24DHP0sdssruAOcQBo7xeKIMO+1UqqRborBNGBYMOl1xYJUQME9lJXW2
	IZNzuG2cg9jVMxDJo4okkx8jSln3xHpGPbsV9yZ8kMDCRo29uJZbS6OwN0TqV/ZTTLS/JhRP920
	LJ5bHFHU9OK4Y2HBt/m0hBX5yxCr95sAc2tTfggqT+GUuk2+v/jxXXGjvCpZPtJNnmVJPieTgPO
	lhTxKNO2afMxFU5WpPfNjtz2uOIi9BoKzpoA+MaaEQDR73hgv2kmEsfyO1Kc6YIVmUCUQ025tRH
	uTSPLlDmE9zj7Sx6NOAmOxiEKo/Trr0CHZl9nJdwz9xEpAMF2BHs79Jumc3nCD1H4kYExiQRYRu
	3PS1Vn02fZrcdKQ76L7NpuLQJ5O2w2mQyZzpoRCPFYgZW1zot/3+ewEDjc1lOWW3lR1ukl9p9MG
	FvDkXVL6jIFUp/jB82pvcFE1ALmCmIc9RGCKSpgmD3t0dScEvC8YcnQXBLiKe9hXv5Y96xwYvxH
	jvizH5zHCxepAlEI27w=
X-Received: by 2002:a05:693c:8811:20b0:36a:1f8:a56e with SMTP id 5a478bee46e88-36a01f8b810mr4586888eec.23.1793036532444;
        Mon, 26 Oct 2026 10:42:12 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79c5:9cd3:db14:7468])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-369e8daf444sm25871383eec.18.2026.10.26.10.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 10:42:11 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:42:09 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] iio: gyro: fxas21002c: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <at-Q8f-BKoExUH0e@google.com>
References: <20261026032051.1004536-1-jic23@kernel.org>
 <20261026032051.1004536-2-jic23@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026032051.1004536-2-jic23@kernel.org>

On Mon, Oct 26, 2026 at 03:20:50AM +0000, Jonathan Cameron wrote:
> From: Brian Norris <briannorris@chromium.org>
> 
> This driver propagates the return value of pm_runtime_put_autosuspend(),
> which is not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> With the driver modified to discard the pm_runtime_put_autosuspend()
> return value, it becomes simple to use PM_RUNTIME_ACQUIRE() and
> guard(mutex)() to simpify two locations. At the remaining location
> simply dicusard the return value.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> ---
> 
> Brian, given this tweaked your patch a fair bit, please let me know
> if you are fine with this. Hopefully I didn't mess anything up!

Fine with me. Not sure if it's appropriate for "my own" patch, but:

Reviewed-by: Brian Norris <briannorris@chromium.org>
