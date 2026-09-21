Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1812F7EF3;
	Mon, 21 Sep 2026 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956808; cv=none; b=dj7wICGJOAq3kwXrA84EEMGk+AyQKLr78zOEMvdXfsh8F3gt8IShZH1F0hbycpYlJVj/xoae7QkBgHwYqGweJ/nthGQBrgqEWpStb9fA+sqmRdlHECZNooGgwTt2SbBc8ssYyzJICByhvQNyzS2G0xMs0YFxVLrOgIUAtkutA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956808; c=relaxed/simple;
	bh=wW9q3xxSv+EdD0YDTdtWWpzKrVloxopLFNPJM6TxMvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iafJxxPLWbgB/sC6uS0OzvzxLeqw6SO692PLvt3okEXLJs2dj2mNSOMmBuyHsBynxgPrDhqBmGL0OqFDtLXc3roeQSjT0vAH8m5eLv3dPeHL/NsAFp2HWthjnnrmDwIX5kBi7WVA5rBE+L8PT4+YHuUmZe9Qkv1Z/hRE91ZVDqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIi5MDSN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIi5MDSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462FD1F000FF;
	Mon, 21 Sep 2026 02:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789956806;
	bh=DPTi7N5qsYEdFhSbNOboj1eNrq7d+EjudYJT3x6S26A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QIi5MDSNuDOE2E59yM+3fBosxl77HtcBUnz6Jnrp3o92ZFqQ5Eqx/I/dJlWeGkyyq
	 Tbra22LYGSbVmeK3k+VnXQCa/IP3lnl+N2+xSeCFTTdqynmN7MdeXvq8sjO3rxUWwP
	 wI+68FXx5G9uSe2oPvF5DnrB+F6CIbOv8XnLPlb0NcrOtMGq5vE+SgIqbbzlTTX3Hr
	 yUI7yTA4notVohgHAA7JtFPTScat6N4NCVhDiQ239i8yrQ5f9u5iStm/yIEDIG7ZCQ
	 msirpVpASzIAHyjkQOsjSzJjn5mpjqJQJPni53HfuPPFEyvtvKNtDu7wKuEDrvh5bp
	 UA7JYjbknJyuw==
Date: Mon, 21 Sep 2026 03:13:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux@analog.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ad4080: add support for AD4885
Message-ID: <20260921031321.45893860@jic23-hlaptop>
In-Reply-To: <20260913232155.5b8d226f@jic23-hlaptop>
References: <20260907101944.9748-1-antoniu.miclaus@analog.com>
	<20260907101944.9748-3-antoniu.miclaus@analog.com>
	<20260913232155.5b8d226f@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Sep 2026 23:21:55 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 7 Sep 2026 13:19:44 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 
> > Add support for the AD4885, a dual-channel, 16-bit, 10 MSPS SAR ADC.
> > 
> > The AD4885 is the dual-channel variant of the AD4085, sharing the same
> > register map and SPI interface as the rest of the AD4080 family. Like
> > the AD4884, it uses two independent ADC channels, each with its own SPI
> > configuration interface, but it runs at a lower maximum throughput and
> > therefore uses the same maximum LVDS conversion clock count as the
> > AD4085.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>  
> LGTM. I'll leave it on list a few days though as we still
> need a DT ack.
I'm not entirely sure why but it jumped directly to handled
elsewhere in the dt-binding patchwork.

Works for me ;)
Applied,

Thanks,

Jonathan

> 
> Jonathan
> 

