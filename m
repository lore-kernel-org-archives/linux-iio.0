Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94543DE44D;
	Wed, 27 May 2026 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898313; cv=none; b=mmx4T42g2R+nwwcSEiJHWyQ1YgGlULSIl+w0G32AxYGPQB32hBAa7Z9S4XL8RDruvDiL331P8lUuLm5cF1710AkEpEdgcZ9CTyEP0CDXhAPPtPZs9nonIAIMzMihp/8qn7WYDL1ChefSh4TDrXqz2zbqyyM0B/qC9Ix6lwT577c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898313; c=relaxed/simple;
	bh=IEi2shFjoEiFermnRY3KLvjwu8/2T2MG3LyZuL1bOiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBkzKt6PZMzyRrgAY+oIndcCSXbBd9P8Z0Re5kZlvapALV2r74qa4z/j+xCCeTeEflCnV6+qeJajL7p1vNHIUHMeUGc5f4xRMTvr/4W5Y5x5rgtDqs68xzbIp0tvrqzgX3vQ+ijh9nYpiEsfXvVvLk4B/XQ7vUvi42DKuJDi93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YC19PHA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YC19PHA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F4B1F000E9;
	Wed, 27 May 2026 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779898311;
	bh=Kp7s9WM17SS31vKf8MgDLGBDlPsLsQUGl5Zi38xsNjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YC19PHA6Kg32/+IxEe7WbkCbUdRcW6UWkFy08Y2jvOX/2wY4gJn4EDm+UzOckIpgr
	 x1cVwsbM3BHFFBJY1Pu0XxAsjzRZxFWSmjHfLOkoO6FYZHLHvnngP9vXOempPs2BNF
	 gdUTPoPyc6p0f8QwhqtOA43PxTMnr1vKDTsj8Ysh/PlANx8+w89C6i+iTSna122Hgz
	 bA6ACjbKGSTRSJM/Ui09JTF+SBeZSBGv/aqDWjt/fQG4DihZINEv2THBztStkn5czt
	 +dMjG/T8Aha7BNGFowkusWBRo+kbu6j6rQMNwckPSv2lVpWmKjAHbC3abjvJeTJ0s5
	 MMYx+Ctf6FYKw==
Date: Wed, 27 May 2026 17:11:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/9] iio: temperature: ltc2983: Fix n_wires default
 bypassing rotation check
Message-ID: <20260527171141.3f256a62@jic23-huawei>
In-Reply-To: <20260525164013.118614-2-liviu.stan@analog.com>
References: <20260525164013.118614-1-liviu.stan@analog.com>
	<20260525164013.118614-2-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 19:39:28 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> When adi,number-of-wires is absent, n_wires is left at 0. The binding
> documents a default of 2 wires, matching the hardware default. However
> the current-rotate validation checks n_wires == 2 || n_wires == 3, so
> with n_wires = 0 the guard is bypassed and adi,current-rotate is accepted
> for a 2-wire RTD.
> 
> Initialize n_wires = 2 to match the binding default and ensure the
> rotation check fires correctly when the property is absent.
> 
> Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
Applied and marked for stable.  I vaguely wondered if the stable
marking was worthwhile given this is a driver validating dt failure
so shouldn't happen with valid dt.  Ah well, it's simple and obviously
correct so I'll mark it, but will take it via the slow path so we don't
stop the rest of the series moving forwards.

Hence applied to the testing branch of iio.git.
Thanks,

Jonathan

> ---
> Changes in v4:
> - Moved to the front of the series
> 
>  drivers/iio/temperature/ltc2983.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index 38e6f8dfd3b8..1f835e326b93 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -741,7 +741,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
>  	struct ltc2983_rtd *rtd;
>  	int ret = 0;
>  	struct device *dev = &st->spi->dev;
> -	u32 excitation_current = 0, n_wires = 0;
> +	u32 excitation_current = 0, n_wires = 2;
>  
>  	rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
>  	if (!rtd)

