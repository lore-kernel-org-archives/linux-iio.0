Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9B549362C;
	Sun, 23 Aug 2026 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787521819; cv=none; b=Ze+jrvv13kPBhG1GmhevI3aNvknjEgxYpq7yiopKJnebJnAmHWfSNHZ0Sl7ks3oUlAPgaJvrKvXA2hLlM6e9HXYqFqJXZjMnVl/4WCY0Nuzl3cQZbtw8OQUm1xlkWdfY/NeV+mtTS/Zy/qhlPwnUX4/4qJe8VEtTNf68DOUV0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787521819; c=relaxed/simple;
	bh=ns0WGZ2IWJS/pJd8z5B4GKKTlh26jjXhg5i00APm4k4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBvB7rIP/vhCODVoXiepJBtNh/E4Qv1/xpvUjvJr5rvhw8iW/Jk7/qz1F/SbaNPXSEWySUR53PaKmgHlmUgjV3P70++3CfDsSVaVhjouYzD1okVtSNNvid4SAoCrAF6cjEt642S2fFk57k2QIUXji1kp/ohIGfgwOyQlV7NKb2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8bw1wcY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8bw1wcY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA8F1F000E9;
	Sun, 23 Aug 2026 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787521817;
	bh=2C+UjKiXAaD4LDqNB6KPNtEDEb1ftgsZ1xVmhjLHJvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i8bw1wcYUt3j35EOvSxHkdZ8a8unKK+JJcNEWXk95JboUG+KWEiFMExa7LiTIlnS/
	 8urD45QTXtOXyK9ReI539Kdu1xGpG/6gdYveI4R1y5VkhaCZa8Uj1gueXzJO6rEKV4
	 cv6dvxO8pS9vVfRZkICZgQaBUxJpo2ywvIHT+lp4G20duBHXVi7NjQcwMmhIXLc3dj
	 uxqe6ziVspHc0iPoK/oilFOvQ1Cp+nB+ZGO4Sq/wojMYUocin6e+jH4ICIT1AuohGv
	 +SAOxeNAW8IK/AC6tl602Wd8zFNTRJ6yGCLRki8EY5ebkcW+BK3EkaOfUlYtEk75xe
	 3NEnNLlS8Il+g==
Date: Sun, 23 Aug 2026 22:50:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: vcnl3020: fix ISR bitmask check in IRQ
 handler
Message-ID: <20260823225013.4e6fea11@jic23-huawei>
In-Reply-To: <20260819203733.12730-1-salah.triki@gmail.com>
References: <20260819203733.12730-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 21:37:33 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> In vcnl3020_handle_irq_thread(), the status register (VCNL_ISR) was
> incorrectly checked against VCNL_ICR_THRES_EN (BIT(1)), which is a bit
> mask intended for the Interrupt Control Register (VCNL_PS_ICR).
> 
> Because BIT(1) in the ISR register corresponds only to VCNL_INT_TH_LOW,
> any high-threshold interrupt (VCNL_INT_TH_HI, BIT(0)) occurring on its own
> resulted in the handler returning IRQ_NONE and ignoring the event.
> 
> Fix this by checking the ISR value against both valid status bits:
> VCNL_INT_TH_HI and VCNL_INT_TH_LOW.
> 
> Fixes: 3363fbbe19e5 ("iio: proximity: vcnl3020: add periodic mode")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/iio/proximity/vcnl3020.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
> index 7f417372566a..d4ad06f8f366 100644
> --- a/drivers/iio/proximity/vcnl3020.c
> +++ b/drivers/iio/proximity/vcnl3020.c
> @@ -584,7 +584,7 @@ static irqreturn_t vcnl3020_handle_irq_thread(int irq, void *p)
>  		return IRQ_HANDLED;
>  	}
>  
> -	if (!(isr & VCNL_ICR_THRES_EN))
> +	if (!(isr & (VCNL_INT_TH_HI | VCNL_INT_TH_LOW)))

Whilst I fully agree this looks suspect it needs to be looked at with some
more context.

The event pushed is rising, which will be incorrect if we see an interrupt
indicating the other direction.  Also, definitions of high and low get vague
for proximity so check the ABI docs.

What:		/sys/.../iio:deviceX/in_proximity_raw
What:		/sys/.../iio:deviceX/in_proximity_input
What:		/sys/.../iio:deviceX/in_proximityY_raw
KernelVersion:	3.4
Contact:	linux-iio@vger.kernel.org
Description:
		Proximity measurement indicating that some
		object is near the sensor, usually by observing
		reflectivity of infrared or ultrasound emitted.

		Often these sensors are unit less and as such conversion
		to SI units is not possible. Higher proximity measurements
		indicate closer objects, and vice versa. Units after
		application of scale and offset are meters.

So rising proximity means getting nearer... 

Now what does it mean for this sensor - complicated. Figure 3 shows
that the when nearer than 1mm the value measured goes up. After that it goes
down with distance.

So I think that means that for most distances of interest this is the
same way around as the IIO definition.  So you are right about the
missmatch between the rising interrupt and bit checked.

So I think to fix this we need
- What you have here
- To chose which event to emit based which status bit is set (potentially both
  in some corner cases
- Clear up the ISR clear that follows which suffers from same problem you have here.

Jonathan


>  		return IRQ_NONE;
>  
>  	iio_push_event(indio_dev,

