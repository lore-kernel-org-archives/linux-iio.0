Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AEA355055;
	Sat, 16 May 2026 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778930430; cv=none; b=tUMXv5jKzXqKlQzSY83tewCT1TxaIxAk4KvreMuRGUej1AoSZevuvAJzbjBS7t68oIZeQSm+gUh3BDdmijXaPX4WylKS2uLMR73TSACX5uyke6TDrphm/imKBkjCRFR9t/zECDJKhVaV0ZPvMvpSHRd1/uu2cY1DwzdH4J3LDU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778930430; c=relaxed/simple;
	bh=1YVe191uXDA4Cm/Vqc7LR7GoDA8SIGQoMShtAvg1+5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fo+yX3WtH+ARTQX1mVW8D+RjHGm4PyZYv7qV7wR9zgT+FPJGLwCFllchP/HGdVbBFmFbFH/PAL99BbQLyjGaZPAdKcn7djjNFw+EEBNbHgsP3OPUvEV3DZsfy3sj9YvfnVTLrdS9w54oQMXxBgrZMR1JSJ+WQA2prMuxCEwPTlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBHchSPN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBHchSPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDF4C19425;
	Sat, 16 May 2026 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778930430;
	bh=1YVe191uXDA4Cm/Vqc7LR7GoDA8SIGQoMShtAvg1+5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LBHchSPN7W+KiB5Z+xX30H6D5cAAw6CqWpOkJv/pT0/nFEYiMRMraH5cSDT7q/qdu
	 Kzkpl6YrEBU3gES457hB+Z87sv0lzypJYgAZoJGQAqWvPg+jZzbOBuzHJM5QKDqoOq
	 DuR5PnI8wzcMy3qfvz6voh4XsZ56CfJ8Xdor3/YIgxj/DtWMzLZ/TaUN+e6c+7J3iu
	 Lwp49vFLxAf21Q9Ww18ihuw0p6/VSg4Klf+LPSp9qiOcF2TEiPrc6Q5JGwG4R8GpNe
	 yLFtaDYOh648mmkifsdTGMvJS2LlePd81Pogqp5HAwIrUd6H96Kv4QKkdB+pKsZsu6
	 XSTmc4nv8sG1w==
Date: Sat, 16 May 2026 12:20:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pramod Maurya <pramod.nexgen@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH v4 2/3] staging: axis-fifo: Fix alignment of
 wait_event_interruptible arguments
Message-ID: <20260516122022.1aa82a8a@jic23-huawei>
In-Reply-To: <20260515075736.172172-3-pramod.nexgen@gmail.com>
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
	<20260515075736.172172-1-pramod.nexgen@gmail.com>
	<20260515075736.172172-3-pramod.nexgen@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 03:57:35 -0400
Pramod Maurya <pramod.nexgen@gmail.com> wrote:

> The second argument to wait_event_interruptible() was indented with a
> single tab instead of being aligned to the opening parenthesis. Since
> the fully-aligned form exceeds 80 columns, break the condition at the
> comparison operator and align the continuation line to the opening
> parenthesis.
> 
> Fixes the following checkpatch.pl warning:
>   CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>

It's not a related cleanup as nothing to do with DT - so break it out of the series
and send it separately.

Jonathan

> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index 3aa2aa870ea9..1c34de020cf8 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -246,7 +246,8 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
>  		mutex_lock(&fifo->write_lock);
>  
>  		ret = wait_event_interruptible(fifo->write_queue,
> -			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET) >= words_to_write);
> +					       ioread32(fifo->base_addr + XLLF_TDFV_OFFSET) >=
> +					       words_to_write);
>  		if (ret)
>  			goto end_unlock;
>  	}

