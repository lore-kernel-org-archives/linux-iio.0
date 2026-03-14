Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031011632DD;
	Sat, 14 Mar 2026 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489644; cv=none; b=KKchtBOHvG5VbNNIxOFNUw+zts6r8d+l0+JbVeTcUuLSYYW4TQQbQBaVDBXXtfqNcuGrt9XXtxgM0NvppZUbFYO56YyQrx/rIjrVBA+RXuMX0T496IREz6aX/fIMbBRAKTIlG5eVjt0HZKk2664dRsCXawKEbB3tIyLCAk/6KBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489644; c=relaxed/simple;
	bh=dfoEFNpfg3RpymXb8lJoxY3QW2VfROktVwWXNaI9UhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psLIVOqp52/hVp3iF5v1CI28ZIwJXHbODMWmVk9GQi7IPHKYEQiKwpyzNX8N5SAkUMbWuP9DdbVaQZ437DOFRqEpCYiCcBKgUZd7aec1Uy1RUEfMu6uCOYA08RZMOCqEoDI24GS6soL4YfHCyM9kWVxjhR3zCzau0EFQTh6qqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgpqFMp1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgpqFMp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBFDC2BCAF;
	Sat, 14 Mar 2026 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773489643;
	bh=dfoEFNpfg3RpymXb8lJoxY3QW2VfROktVwWXNaI9UhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qgpqFMp1Ka4Cq/C/lDOUwnR1rdzqQHdUgsvMHclwmw/bVVjIs9mAC/biEyLKoSdvo
	 AgdfAm7acS7I6dTzen6q4EYYEjj3YMZxl8hXOi5TMr+UurSVtvhvTHZQOKmH9OLRUN
	 WxBLJ7kk4sg3gsguPaUXg/o943/majwlQ2keBIs8ECIPMbTrttLtYST6fn6HQ0Zxbt
	 LrT7soN97bEH+jfEO4KXaHLMc9XGKrODfJKe/xrJftJM3iVjLpusso2D8Mv7/zXmby
	 aQzsQz2jc7NVT9VeoY/YkYgrMZ2V56YIHZX5wjRD/4zxVCEXOpK8Ctu+n1NDZflOfZ
	 TvRc2tp/0+G5w==
Date: Sat, 14 Mar 2026 12:00:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260314120022.56265de3@jic23-huawei>
In-Reply-To: <abQdvXq9MtIZ0EpZ@ashevche-desk.local>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
	<20260313115856.87763-5-antoniu.miclaus@analog.com>
	<abQdvXq9MtIZ0EpZ@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 16:22:53 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Mar 13, 2026 at 01:58:53PM +0200, Antoniu Miclaus wrote:
> > Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> > integrated fully differential amplifiers (FDA).
> > 
> > The AD4880 has two independent ADC channels, each with its own SPI
> > configuration interface. The driver uses spi_new_ancillary_device() to
> > create an additional SPI device for the second channel, allowing both
> > channels to share the same SPI bus with different chip selects.  
> 
> I am still not sure this is the best approach we can have.
> In any case, I have immediate questions here about regmap usage.

I think we have a fairly fundamental misalignment on what this is.

To my understanding (diagram on first page of the datasheet)
+ the functional block diagram on page 3 it's effectively two almost
entirely separate devices in one package (sharing of power etc) and
a few common wires for clocks references etc.  Pretty close to some
of the multi die devices we get for IMUs etc but with tighter coupling
that forces one driver (for the IMUs we just register separate drivers).

It 'might' use one SPI bus, or 2 or even 4 (if using separate data
interfaces).

Just to speed things up let me have a go at answering the questions.

> 
> - Why do we need to have a separate regmap per channel?

Propose an alternative? It's two independent interfaces, so you
could spin a special regmap to handle that, but it's much simpler
to just use standard stuff and keep them separate. Not to mention it
would either have to do external locking or falsely imply
there was any restriction on using both interfaces at once
(there isn't)

> - What is special about channel 0?

Nothing.

> - Is it okay to communicate with different channels simultaneously?

Yes. They are entirely parallel bits of silicon. Own state machines
and everything.
The configuration registers section of the datasheet says:
"Each channel has it's own independent configuration memory
accessible through it's separate configuration SPI interface."

>   Wouldn't be a nasty race with HW IO?

Nope. You are talking to different devices (more or less).

Jonathan


