Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF801A0BF1;
	Wed,  3 Jun 2026 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491339; cv=none; b=Na5lBb5X9baCi38tsTJFUAfaMKzIAO7MI+UIQ8TenRDlC8tI5GmetMj1xvDSn9QS/FD2i5X/KBch6peUTgEO0cSGpV4NBHfZbIzElYyERd0IpXa1+OhquwWtbS8Cy5WLB+pV4P6I8PB01AvqCdmgCQ65hZg8A/Am9CFVeduleRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491339; c=relaxed/simple;
	bh=3rYEvm8guTOUqyzyTHOnG+63cFjmQM0v9FHTN0tbDrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2cS5jfYOwc2pB1jJKgORudE9RkrNWOXvzS0qfh2AoIaoc8zrGvx5nZQnSH0qmM7smQ7UPvYXZ9lj6785HIngXa0RY+nnoskQbdQQYlTVgvqVegJIsAadPAkp0l+rzAq77S2dziM8Qp8Y4MfSOrgfX2C27fg71jN1/RLHhGBzhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZITy+Jvh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZITy+Jvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7AE1F00893;
	Wed,  3 Jun 2026 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780491337;
	bh=iE4jRMPbhQH0PvIv57gmqF1YPc/vbiAJUSleWIT0u7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZITy+Jvh5I+g+3hrZx+k88KdQNY2wDBZvjYq5TlCVs6UOrTHgIbH/YZzL5wyApxI5
	 T8kh9Z0F3pzk7z0/5uMDstcXeElYJZkuJdnfRbNDbSZ9oOXfYYTyp6yPcGQlgjM9Sl
	 LYsmf0FUI3VywLT+pxbDyTuV3CSCiHxrQlezYtrBKcFmIEwE7GD0x2rTarTqQBBhX3
	 mwtqpeOLNsAy7ojhOFI4EkjhqqVJzMLyzxtPWqdQwMftMe04eRlMjKKDe5Zs4A4fPP
	 UTIlY+oTwQYp6aNsMR2yK8/y6svyelZhqYupSyDj9yguWMx9Lb/aeqClamgTAk3qan
	 kWQkG9hLXMHdw==
Date: Wed, 3 Jun 2026 13:55:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 09/12] iio: dac: ad5686: implement new sync() op for the
 spi bus
Message-ID: <20260603135525.41331916@jic23-huawei>
In-Reply-To: <ylp2jf3wbojbwoozhow433vcvnz24ahvqlr35hhdoctm42rqqn@irrv3f76gr7k>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
	<20260602-ad5686-new-features-v1-9-691e01883d27@analog.com>
	<ah8roqGqZ_VhAPaa@ashevche-desk.local>
	<ylp2jf3wbojbwoozhow433vcvnz24ahvqlr35hhdoctm42rqqn@irrv3f76gr7k>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 13:26:43 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/06/02 10:14PM, Andy Shevchenko wrote:
> > On Tue, Jun 02, 2026 at 05:33:56PM +0100, Rodrigo Alencar via B4 Relay wrote:
> >   
> > > Use of local SPI bus data to manage a collection of SPI transfers and
> > > flush them to the SPI platform driver with the sync() operation. This
> > > allows for faster handling of multiple channel DAC writes, avoiding kernel
> > > overhead per spi_sync() call, which will be helpful when enabling
> > > triggered buffer support.  
> > 
> > Why spi_message_alloc() can't be used instead of manual handling?
> > (Seems no current users, so you even can modify it for your needs.)  
> 
> I need to manually call spi_message_add_tail() to append messages.
> I suppose that such function is a bit weird and no wonder why it
> is not being used. struct spi_message_with_transfers might need
> to be properly declared so that users can populate the transfer
> array without manually moving pointers or having to redefine the type.
>  
Agreed it would be significant surgery. Perhaps worth it as a follow up
if you can find a couple of drivers open coding the equivalent.

Otherwise perhaps send a patch removing spi_message_alloc()

J

