Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C0C62809;
	Sat, 30 May 2026 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155138; cv=none; b=c5yaPoWJZfxxOiO/f7ERSsFE/4Js99Ij2F8OWB+OMEpvkGY9m9sdt65P4t5XLrVxqONMZ876+bb2tdqVz+491Lf9FR4+hNXRMtZqPwq9KvvhrgCPOXhLgwA85cOpPCgPml8C/L9WJY95YBQ51YqfNyVkMh0tYX3D91WOA0WwKo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155138; c=relaxed/simple;
	bh=QvN9XbMCu2FLQNy3scTDDAT2C2nWIv5LjbaO1kNvIMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Inc8/EDGYuLsyeJZHxNrdvrQVhrNk7rFEdrpglmAsDhZ9s2FPG9DatpRtswr4OzZk83aiLuW4NPrRh1BIQVlRZokQLrbhlyur6kUD/P7U+5oRRGnx/9hhW8573pQUDDrMgDRijsoYwCVlO1JqxR2XbrGCtLHxhU0LXIpx6Qppa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApHEjtBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApHEjtBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5271F00893;
	Sat, 30 May 2026 15:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780155137;
	bh=ZXwHjHi0J7muy4GndYQi74GrM1L924H1NMrU5zTg2fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ApHEjtBqvKpMDGfbSbxd1lsDZ/855PlifvAwYd0vU76uLmpQYK+1mA0VDeMgeCVRW
	 noCdnA6pq5Y9V4ih/s3wyYK7uatsuOE6SmDYnhfZCWgu0nziNRmP+GtgM1Hlrd223S
	 +e4GRcxu7eB+k0ZJHq8+0RK+TVp9TueG0g855Gtp3Vv6kpBvb085WFEVm5uCAvAoi4
	 6acvaLmAptbbJ0aciJbKKh/SVsYZC+SWW5+hwJw0m+7e1HPtMzs90sgKB/cYWorjOp
	 Tcp3K0zTLq83GGEtB+X25C0OiIrIFRa5+6mS/TyKc4NRfrpPDLsWIAkavgIqHXP11z
	 v5TqlaB1p6Fwg==
Date: Sat, 30 May 2026 16:32:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, apokusinski01@gmail.com, me@brighamcampbell.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 3/4] iio: pressure: mpl3115: generalize interrupt pin
 routing
Message-ID: <20260530163208.698e9b31@jic23-huawei>
In-Reply-To: <20260530113938.171540-4-suunj1331@gmail.com>
References: <20260530113938.171540-1-suunj1331@gmail.com>
	<20260530113938.171540-4-suunj1331@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 May 2026 20:39:37 +0900
SeungJu Cheon <suunj1331@gmail.com> wrote:

> Write CTRL_REG5 explicitly for both INT1 and INT2 rather than
> relying on power-on defaults when INT2 is selected.
> 
> This avoids incorrect interrupt routing after a suspend/resume
> cycle where the register may not return to its default state.

Need more information on this.  What do you actually mean by not return
to it's default state?  There are a lot of registers in this device
that affect config - are all the others restored after resume?

I suspect you are actually talking about a soft reboot where the
driver is reloading. Given there is a reset call just above this
that should never be an issue.

> 
> Route both DRDY and FIFO interrupts to the selected pin. The
> FIFO routing is not yet used but is required by the hardware
> FIFO support added in the following patch.
Do it in that patch then, not now.  By all means introduce a
local variable that you change in that patch, but don't set
the fifo bit.
> 
> Consolidate polarity configuration into a single code path
> that handles both interrupt pins uniformly.
> 
> No functional change intended.
> 
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> ---
>  drivers/iio/pressure/mpl3115.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index 52a3d0d59769..90e83e34ec43 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -67,6 +67,7 @@
>  #define MPL3115_CTRL4_INT_EN_TTH BIT(2)
>  
>  #define MPL3115_CTRL5_INT_CFG_DRDY BIT(7)
> +#define MPL3115_CTRL5_INT_CFG_FIFO BIT(6)

Not in this patch.  

>  
>  static const unsigned int mpl3115_samp_freq_table[][2] = {
>  	{ 1,      0 },
> @@ -624,6 +625,7 @@ static int mpl3115_trigger_probe(struct mpl3115_data *data,
>  {
>  	struct fwnode_handle *fwnode = dev_fwnode(&data->client->dev);
>  	int ret, irq, irq_type, irq_pin = MPL3115_IRQ_INT1;
> +	u8 ctrl_reg5;
>  
>  	irq = fwnode_irq_get_byname(fwnode, "INT1");
>  	if (irq < 0) {
> @@ -634,6 +636,9 @@ static int mpl3115_trigger_probe(struct mpl3115_data *data,
>  		irq_pin = MPL3115_IRQ_INT2;
>  	}
>  
> +	ctrl_reg5 = irq_pin == MPL3115_IRQ_INT1 ?
> +	    MPL3115_CTRL5_INT_CFG_DRDY | MPL3115_CTRL5_INT_CFG_FIFO : 0;

That's complex enough that I'd prefer it as a simple if / else
as will be easier to read.  Also you are enabling the fifo interrupt.
That should be in the next patch, not here.

> +
>  	irq_type = irq_get_trigger_type(irq);
>  	if (irq_type != IRQF_TRIGGER_RISING && irq_type != IRQF_TRIGGER_FALLING)
>  		return -EINVAL;
> @@ -643,23 +648,19 @@ static int mpl3115_trigger_probe(struct mpl3115_data *data,
>  	if (ret < 0)
>  		return ret;
>  
> -	if (irq_pin == MPL3115_IRQ_INT1) {
> -		ret = i2c_smbus_write_byte_data(data->client,
> -						MPL3115_CTRL_REG5,
> -						MPL3115_CTRL5_INT_CFG_DRDY);
> -		if (ret)
> -			return ret;
> +	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG5,
> +					ctrl_reg5);
> +	if (ret)
> +		return ret;
>  
> -		if (irq_type == IRQF_TRIGGER_RISING) {
> -			ret = i2c_smbus_write_byte_data(data->client,
> -							MPL3115_CTRL_REG3,
> -							MPL3115_CTRL3_IPOL1);
> -			if (ret)
> -				return ret;
> -		}
> -	} else if (irq_type == IRQF_TRIGGER_RISING) {
> -		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG3,
> -						MPL3115_CTRL3_IPOL2);
> +	if (irq_type == IRQF_TRIGGER_RISING) {
> +		u8 ipol = irq_pin == MPL3115_IRQ_INT1 ?
> +			  MPL3115_CTRL3_IPOL1 :
> +			  MPL3115_CTRL3_IPOL2;

Oh that's fun. The data sheet has bit 1 as IPOL2 in the compact
table 49, but PP_OD2 as bits 0 and bit 1 in table 50.  If you are bored,
might be wroth pointing that typo out to them!

> +
> +		ret = i2c_smbus_write_byte_data(data->client,
> +						MPL3115_CTRL_REG3,
> +						ipol);
		ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG3, ipol);

Fine to go a bit long where it helps readability (stay under 100 chars though!)



>  		if (ret)
>  			return ret;
>  	}

