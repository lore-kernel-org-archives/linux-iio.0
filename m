Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466784A35;
	Sat, 14 Feb 2026 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771085343; cv=none; b=izy2NmkNALHLYfbfvAygbusR4NCP5gSK8SjdFqDCtE13IooMtKZcHdochhsR4i/6uI5/mUddXn4s46deQcLr8kXQAHSah2S+C7OZtMgH/gg8rhEHWK+WxrcXYNn7gFkUcXYAYtcc0O733KD9G9D8QgxhujKYOCD+bxHG3VRUzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771085343; c=relaxed/simple;
	bh=PXeuJmFfzmVGFuU0kyAuHLlIbJdvY3YParL864C3sAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oudVMEdPDzKeVjB5WFaHUkd+eqLENP/0qtXgCHIW35tyUz85l4kICNThJFF/v6fxQ2NGVzSSEt14O/b+AN52iKZq82F0svIGtsuviIgkOcNXe7fFgfU2QIWKbrGdlZWZ7wmjdtWMmYS62+AUf9eXP5YVnliP+fwxQzODz9mLYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbqCRZOE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbqCRZOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD81C19422;
	Sat, 14 Feb 2026 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771085343;
	bh=PXeuJmFfzmVGFuU0kyAuHLlIbJdvY3YParL864C3sAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qbqCRZOE36kpGNi91Em6wSsrGarSpSbuzzzAL3R8/sCT4LZ649dGmvAXH+8QOAZis
	 gfnt9wlJ0GITcwrJPG1E/y4z37M7QC2U0jPTKObv3GBqYQNsNXHBvAdT3toRs/yFR3
	 XHNgcbDmBjx3G2H5wjhX9PCAPc0nKvrWCRiDNW9RoZ7iz4QDucOMRmqlVnrADf4zL2
	 ei0qsFmcaLUIGc7LVFxFIGRE0Q0Lhes9uzphFoolJt1BFE099MKSHpihN/uBBjsSiB
	 2Cw7upgp3fmDvXNOaxFqsrUV9Y8D/1bOqvX60mrTF+qMHhg+bMWH5DBaibdEUxTOB3
	 cYY6PweA0cHCQ==
Date: Sat, 14 Feb 2026 16:08:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Mark
 Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260214160852.6862b58d@jic23-huawei>
In-Reply-To: <aYiGj_TYelvJdVaR@smile.fi.intel.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
	<aYiGj_TYelvJdVaR@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 8 Feb 2026 14:50:23 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Feb 06, 2026 at 06:07:12PM +0200, Antoniu Miclaus wrote:
> > Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC from
> > the same family as AD4080.
> > 
> > The AD4880 has two independent ADC channels, each with its own SPI
> > configuration interface and LVDS data output. The driver uses
> > spi_new_ancillary_device() for the second channel's SPI and requires
> > two io-backend instances for the data interfaces.  
> 
> I believe there is a better approach, what you need is rather a flag
> to SPI core to tell that this is the device with shared CS.
> 

Antoniu, this comment from Andy needs addressing before we move
on. It seems fairly fundamental and I'm not seeing a reply to it on list.

I'm not entirely sure what Andy is suggesting will work but this
is perhaps a mismatch in really understanding what is going on here.
Andy, how would a flag work given they seem to be separately addressable
SPI buses. I think this isn't a shared SPI CS, but rather a device
with two entirely separate SPI buses. I think the only reason
we are bothering to implement it as a single device at all is the
shared backend.

There is an argument that maybe we should be looking at how
to do data muxing backends to support the more general case of two
separate chips feeding into a single buffer, but that's a complex
beast and I'm not sure if it is something we actually need.

Jonathan
