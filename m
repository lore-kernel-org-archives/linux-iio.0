Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8F2BEFFE;
	Sat, 21 Mar 2026 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124527; cv=none; b=kzs1kg/7D3snIhob+oK1xJv+3oLE//TaEcOll6eOsDVjgdYil54CoPi3d9fQIyhwoHJJ9cgHdMPHq1cA4Yiwf+mXQAhsKjzRlN2eWI/Jzb0tNaSUBuyflHQ376A1JWE5N2IRtmwUKNvSd7LtqxPNb64XHcaHW4kMKPnHf9ZCfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124527; c=relaxed/simple;
	bh=tvtXNyV+XEq2Roj/K/cw3M4/AwrRBklyM7EEgHiKUgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSRK5MAHTRdUWAZayTKpEtxo7NdcNImaimdrj5wrlnOJwWPfW4sW8UlxEiSKjgHgqBXuYGjZdbwyRJQAZvnnnKltUi9N/FwSU2YYxhN8rcBqleWt6dB3eDz7y5+LufsWR/c3qwoR5ai6Ch/zMLEDL/HiCljYuu1FkdA6+lRwDhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bL+Znspu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL+Znspu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EA4C19421;
	Sat, 21 Mar 2026 20:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774124527;
	bh=tvtXNyV+XEq2Roj/K/cw3M4/AwrRBklyM7EEgHiKUgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bL+ZnspujXYbxKjvlQKSe0v9z8hdZCmn7b4MITZjRdFeUvv8BF6hFXeAJLRSHgcu6
	 afMFJdPyOeNlTi+fqSNcTsPzHkT3DU4zidS76RKoDjz5YID32VLALzoxqrXkW3q9FO
	 ItowOnueQ27MXYHcjeDdjFcnR88HrI+XD8j4MqE/HcoRVwagjjckTRMGHroD0TMGb0
	 tKjq67fdvRyf0KZBBH5t5EvrKbsijZesT4YLofdf81VnXpR2G668xcGT8A/GjrSPpY
	 pv9dV/p2lT7Eom6O7ASja9tMoP7Ms5lw/Y9FcaayOXKApffG2iYOKe36nm2+gP/ioN
	 1wMty+Ipk7PEg==
Date: Sat, 21 Mar 2026 20:21:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Matt Ranostay <mranostay@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-adc161s626: use DMA-safe memory for
 spi_read()
Message-ID: <20260321202159.048dbf2f@jic23-huawei>
In-Reply-To: <0269d645-633e-4ad0-8326-ecdd5f4f47fd@baylibre.com>
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
	<20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
	<20260316183117.4dde7386@jic23-huawei>
	<0269d645-633e-4ad0-8326-ecdd5f4f47fd@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 14:27:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/16/26 1:31 PM, Jonathan Cameron wrote:
> > On Sat, 14 Mar 2026 18:13:32 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> Add a DMA-safe buffer and use it for spi_read() instead of a stack
> >> memory. All SPI buffers must be DMA-safe.
> >>  
> 
> ...
> 
> >> diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
> >> index 1d427548e0b3..6416d6a7ada0 100644
> >> --- a/drivers/iio/adc/ti-adc161s626.c
> >> +++ b/drivers/iio/adc/ti-adc161s626.c
> >> @@ -70,6 +70,7 @@ struct ti_adc_data {
> >>  
> >>  	u8 read_size;
> >>  	u8 shift;
> >> +	u8 buf[3] __aligned(IIO_DMA_MINALIGN);  
> > On this. There is new generic infrastructure for marking these.
> > https://elixir.bootlin.com/linux/v7.0-rc3/source/include/linux/dma-mapping.h#L720
> > https://lore.kernel.org/all/01ea88055ded4d70cac70ba557680fd5fa7d9ff5.1767601130.git.mst@redhat.com/
> > 
> > Would look like
> > 	__dma_from_device_group_begin();
> > 	u8 buf[3];
> > 	__dma_from_device_group_end();
> > 
> > Do you think we should adopt them rather than doing our own thing?  
> 
> I have mixed thoughts on this.
> 
> Pros:
> * This would make it more obvious it should be at the end of the struct
>   but doesn't hurt if it isn't.
> Cons:
> * It is more verbose.
> * There doesn't seem to be __dma_to_device_group_begin(), so it isn't
>   clear what we should do for tx buffers.

Agreed. Should add that.  Though it would then imply that we should
treat them differently. Hopefully my understanding that we don't need
tx and rx to live in their own cachelines isn't wrong (at least
for all the stuff we care about)!

Let's let this sit for a cycle or two and see how adoption of those
new toys goes.  Longer term I'd generally like to get rid of as 
much that makes us special as possible.

> 
> > Slowly though I don't want the noise of a mass conversion.
> > 
> > As normal, advantage of standard infrastructure is cutting down
> > in subsystem specific magic.
> > 
> > I 'think' result is the same (though it also forces the trailing padding if anything
> > comes after this and needs it).  
> 

