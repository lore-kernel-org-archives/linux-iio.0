Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEBC363C63;
	Sun,  6 Sep 2026 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788718725; cv=none; b=uEPBTX64CL7nyzyUr2k8B3qnNZdAftpUimr2Ad9dxU78dUnPdk9DJs+AZOK/qRAGwJrLhw1ytma01HpF0T9poBip6h5pQtV1ouDkE3lFJ/45w2p6bYHJgw8ANY8HIBhEMp4apQZvW95tPvQgFLTyPy99XLU0/UFSAUX9fkfUKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788718725; c=relaxed/simple;
	bh=4688ZY2LQuS1QlFVb3KXW2GsD6ZmKhdBSui71c1Zhyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5zdmQz3YFSnC0DJXBx4TqT+n3evcCrE0NdEOz7BUryrYpOKiKu8aEPmql4Q0Sg2amf70mvFiW9XY4B7IkNvcn0Z/OzmUvWBM8+WGOh/OzSbRbbnV/Yyd1eyl6FjYsvsHRp7smMhgCKifjaHj4VAvH8Brog6Gvs1+/BvGtAiHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFK/9zRh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFK/9zRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC84B1F00A3A;
	Sun,  6 Sep 2026 18:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788718724;
	bh=uCbCEXb6Onzx38hdUFkKNVpVgkZEH2Fy0zkg4WvdrcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MFK/9zRhTVGukrJDNB4fDSeggbNmNfWIkujuYdDgpwVu0OjgJQxc70AI4FjjGMcKy
	 i2xqBS45Qql7iCp+TpoAXoQ+Uu7f3eMz8Qdx50xET/dSxSdwf2Q6qoaPYLUy48ImbV
	 0y/glk1L8eKHaf2LDk1p5vJYweGdlI5wwLmWbuXbQ5p+eqwo3gVyZmKFpLiwtD7Nhk
	 vG2kEk8yrjpjuCHhBaRfDGAbWQ2BvGrAieMAGVOJPBKRPqes1VcqlwB96p4rR1qfo2
	 RtXfKYlIs3L510Qh8wloCGswLrMi1nY5+yr5gIvLwn4khJEMOOzpMK0V/xbKKwfevJ
	 A/bKsGjQtC63w==
Date: Sun, 6 Sep 2026 19:18:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Tsz Shan Chan
 <tchan@jacques.com.au>
Subject: Re: [PATCH v3 2/5] iio: light: vcnl4000: clear DRDY interrupt when
 buffer disabled
Message-ID: <20260906191839.406f435c@jic23-huawei>
In-Reply-To: <20260903-vcnl4000-v3-2-5e69c2e715a8@jacques.com.au>
References: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
	<20260903-vcnl4000-v3-2-5e69c2e715a8@jacques.com.au>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Sep 2026 14:53:47 +1000
Tsz Shan Chan <tsz.chan.dev@gmail.com> wrote:

> on vcnl4010/4020, interrupt status bits are cleared by writing 1 to the
> corresponding bit in the ISR register. If data ready interrupt triggers
> when the iio buffer is disabled, the DRDY bit is never cleared and the
> interrupt line stays low.
> 
> Clear the DRDY bit in the interrupt handler when the buffer is disabled.

Add something on why we might actually see this. Are we looking at a race
condition or normal operation?  I.e. does this happen on sysfs reads?
I think it is just the race condition around the buffer going down
but good to have that called out in this description if that is
correct.

Thanks,

Jonathan


> 
> Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
> ---
>  drivers/iio/light/vcnl4000.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index cf55fe6afcba..c5f34e748e1a 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -1545,8 +1545,13 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
>  					  isr & VCNL4010_INT_THR);
>  	}
>  
> -	if (isr & VCNL4010_INT_DRDY && iio_buffer_enabled(indio_dev))
> -		iio_trigger_poll_nested(indio_dev->trig);
> +	if ((isr & VCNL4010_INT_DRDY)) {
> +		if (iio_buffer_enabled(indio_dev))
> +			iio_trigger_poll_nested(indio_dev->trig);
> +		else
> +			i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
> +						  isr & VCNL4010_INT_DRDY);
> +	}
>  
>  end:
>  	return IRQ_HANDLED;
> 

