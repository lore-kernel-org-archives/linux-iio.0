Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B69C284B2F;
	Sat, 22 Aug 2026 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787362806; cv=none; b=FqLM5G80DCh2y3cHuXux4Pqim8r8VcydlI+b9lpXMbFfMh0DRz9z+ErbmwLx5LBtXJ8uACbdfH1s73Vg1qjsHmamVQv7Xz8Ply+S1BFKdbQqcJmIXmxKhVbf/Oux/sVVyNsU6fswyLTGLZ1LpPUgMwmGTVT0Fu0vk3/BgmNpomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787362806; c=relaxed/simple;
	bh=KTgpU9/8zh8wApa/SPdOT4w3OESsMoV7DtdiPjQbrXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPBcRK4rs0l8oLLHso/Lca6q8xE4pAY5sQFmME83yAtvR6cJT1H1FW3Tf9cU5aQSDBUfZXQu+zgq1r4bj6DKzMDRHU8/CPph2WN1lNqq2wEn7dCOgLhb2e5qWYMie4Cmh4aCMY26oc5gs3hmSLHznyfBsN0VwhuGr658ddmcfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kaw98fmm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kaw98fmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064421F000E9;
	Sat, 22 Aug 2026 01:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787362804;
	bh=5GTMKh9J6oce0GKOv9wCZNoicYsfUpE1mImuA2CZKBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Kaw98fmmXekhLrjzv/RNlHoWF8NgZvXdzQhdtNikJB5rd70RQX7ibCw26EZtpWvVV
	 yxBuv6is02ixN4JmPE3MFUjdKg4rYiBzCfdavYrtrwV/O1vQcbIY2YPucm7pIKSQn2
	 CUfmniAR1GCPfBfRF98EZwzQFufAz6TgGQMa9v8fnNSyqXJmSK0cHvm6sszXPFHzuA
	 HXPx1Ph3gBP9PIQ+GCgiO9m9DOMa/+t4qY1abGuNmALzjWUrQ6SM7tqrZlEeZUTDpQ
	 ABeLXaY6CfH3BZXkvVWzccARRmdKoPHdKY3yFIBF7INSHGKeu3eICCTz8HLzyqW7F8
	 issEFEaXgb8mA==
Date: Sat, 22 Aug 2026 02:39:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: phucduc.bui@gmail.com
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, Chen Wang
 <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, Takashi
 Sakamoto <o-takashi@sakamocchi.jp>, u.kleine-koenig@baylibre.com, Danilo
 Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-iio@vger.kernel.org, sophgo@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: sophgo-saradc: Handle errors from optional
 IRQ lookup
Message-ID: <20260822023959.4319f0c3@jic23-huawei>
In-Reply-To: <20260813074810.27574-1-phucduc.bui@gmail.com>
References: <20260813074810.27574-1-phucduc.bui@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 14:48:10 +0700
phucduc.bui@gmail.com wrote:

> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no optional IRQ is available. Other errors, such as -EPROBE_DEFER
> and -EINVAL, should be propagated so that the caller can handle them
> appropriately.

That function is very much undocumented other than not printing a
message when it returns an error.  However I think you analysis is
correct.

I'm not going to rush this is because it is not known to have
been a problem in the wild (only odd loading orders should have
caused deferal).


> 
> Propagate negative errors other than -ENXIO.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  drivers/iio/adc/sophgo-cv1800b-adc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/sophgo-cv1800b-adc.c b/drivers/iio/adc/sophgo-cv1800b-adc.c
> index bdc3e1326a9a..c6eed09acfcd 100644
> --- a/drivers/iio/adc/sophgo-cv1800b-adc.c
> +++ b/drivers/iio/adc/sophgo-cv1800b-adc.c
> @@ -182,6 +182,8 @@ static int cv1800b_adc_probe(struct platform_device *pdev)
>  		return PTR_ERR(saradc->regs);
>  
>  	saradc->irq = platform_get_irq_optional(pdev, 0);
> +	if (saradc->irq < 0 && saradc->irq != -ENXIO)
> +		return saradc->irq;
>  	if (saradc->irq > 0) {
>  		init_completion(&saradc->completion);
>  		ret = devm_request_irq(dev, saradc->irq,

