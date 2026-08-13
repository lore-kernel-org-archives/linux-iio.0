Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736A320A14;
	Thu, 13 Aug 2026 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786584445; cv=none; b=fpmwQ4i1F0y31eICSaHjbyoCrunmWB5GxTYESA3edRkM48QPEfhGbcLusgXjjMVidXLJo8cVP/Y4NzxLAEFg+cgjj/UPBJvp2fAU590f9yLG49AhmV2dNVNvucMuwfLLjd9DxK/UGZVQYopsPaajzrbRpVRKMY5f8RYeHD3KJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786584445; c=relaxed/simple;
	bh=ywUp05vOGtWhiW0UfTTG+cVumkQATcDiGz4J7IaFrjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOGi1HrjKdB7wMBHV+uvKc/pzpmY9sRuFv+58RM7PluKQnkJ+950KviTBnlKSzI8FemDAaBgNfsjWn9ijA2sVY+m+QQSiUPL4CZ13Tn8bjIREqHtMb2dkUJJXe1dV+U8ztFcuaINDxp0qyPyo1MAzLI/2Ts3yV6Qe/Kgz2WVNDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi4bGFtE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi4bGFtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E931F000E9;
	Thu, 13 Aug 2026 01:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786584444;
	bh=Aqbweh3qR16SRlhkAu0LVmHiQSVT9HCMG+hkondEi34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gi4bGFtExDC+HZseL4rhaNwr1WlUJMxdma3/bXarJ6Moe5GdLJngjJyrUDsCKfTCh
	 JBgIcvqUJHtXXLg51BnRBHSk3ibRvlpzOnj3EbGxcRY9hxLDhiUyN49sXoDfRDNDNO
	 rXMgCqgO47A2NukfZLV7fzdxN7q7HoDiNUP1GDTxhwQ9RvHoTudpWx7tf/2vxdLyys
	 Vac3tdSGImKFP5y8mU/MuY1y71LU62ssGo9ERIM2KQWAHO6V0W234E94pLrRG5NV98
	 w/6bNGbJYgje3wGrB3kBdhbzv1HCBrzqEA6OTCf+oeKFJEefLKdEvqGLC9ILG7cQ9c
	 nU7QOXKHEyIWA==
Date: Thu, 13 Aug 2026 02:27:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] iio: light: add support for veml6031x00 ALS
 series
Message-ID: <20260813022715.19d15cbf@jic23-huawei>
In-Reply-To: <20260813020429.54031688@jic23-huawei>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
	<20260812-veml6031x00-v6-2-7eef6e4ce290@gmail.com>
	<20260813020429.54031688@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 02:04:29 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 12 Aug 2026 22:27:41 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
> > These sensors provide two light channels (ALS and IR), I2C communication
> > and a multiplexed interrupt line to signal data ready and configurable
> > threshold alarms.
> > 
> > This first implementation provides basic functionality (measurement
> > configuration, raw reads and ID validation) and defines the different
> > register regions in preparation for extended features in the subsequent
> > patches of the series.
> > 
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> Hi Javier,
> 
> A few minor things inline
> 
> Thanks,
> 
> Jonathan
> 
> > diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> > new file mode 100644
> > index 000000000000..021bf726c60b
> > --- /dev/null
> > +++ b/drivers/iio/light/veml6031x00.c  
> 
> > +
> > +static const struct iio_chan_spec veml6031x00_channels[] = {
> > +	{
> > +		.type = IIO_LIGHT,
> > +		.address = VEML6031X00_REG_ALS_L,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_INT_TIME) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> > +						BIT(IIO_CHAN_INFO_SCALE),
> > +	},
> > +	{
> > +		.type = IIO_INTENSITY,
> > +		.address = VEML6031X00_REG_IR_L,
> > +		.modified = 1,
> > +		.channel2 = IIO_MOD_LIGHT_IR,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +	}  
> 
> Trailing comma.  Maybe we'll add more after this and they will fit on one line.
> Yeah it's a stretch but generally always add comma unless it is a specific
> terminating entry.

Ah. Not such a stretch. I'd forgotten timestamp channels.  This creates
unnecessary noise in the very next patch!
> 
> > +};  
>
