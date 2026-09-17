Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95A4E9C1B;
	Thu, 17 Sep 2026 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668601; cv=none; b=ACFW39c78eXwEnjkcUjGVr0bATdk6N8+rD+tAQoWmqbtmama2tRSb+x9x2gxzZinTcSVuC8S+RmbFpDr/pSVsRGpt8TleA1TuGPbA55o4Y1DItUkWhToZyV9UZPZxrR0kiR3pZP+0ZlpPhXLfNnCMGLhha9HhHFWeya/9KFOydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668601; c=relaxed/simple;
	bh=oai6U0JbCD4GjPdMag8AoSuR0BOXNS/qIxk4AQoBcA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDAwNo/w3nFWMZ+WT2I2KwjKODb6FGtVeW0ERsepTvbTUPKCXpmtcGE01jlTTE8rGvVIEOu/SzHrEr4QcL+gj7I33c/Aex+xk5SrACNUBfVdm7KqW74r+o5uKJqUvIEf2HSZkxp8CGMhQHG1jYOKwAM1PDdXagQ/nTmEGYzwVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbPi5HkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbPi5HkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0B51F00893;
	Thu, 17 Sep 2026 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789668599;
	bh=4pYu5PJMwDbiD3YaUZzHgB4wN8SoNcJfUzk9qPUH13c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WbPi5HkVF8DSz0T2SCNJanVPF1hO+VUVNvlf7dZN/M+QGQZdaZZ++HiKXIdGawI0K
	 HoNSeXerN+3x7/q2GZx9A1BCMFtT6htdqJZ48oJSZe5prgnajMVxTbrsV37XDsodIL
	 nFgOSCtk9xLUnNo9T5jIw7b+hxZrEP2SI7saVA+3Tfuw89Qv7f66r2lozXtG1mM9N5
	 /wB/fpo4qFySqnM6qYJ3bWJdhbhNrCwJd0ZXHgk1bBgE76Dt0bo4BxnnXXZCXNiwB4
	 5I+uWXcHsxWWx3DRSbK05yRnPAhe00NkpmwlmO7L2NzHBqZ/zl4oPzq6bUmJ7fh5bU
	 LcQRf0alicsEw==
Date: Thu, 17 Sep 2026 23:39:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	=?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 01/10] dmaengine: Move enum dma_slave_buswidth to a
 new header
Message-ID: <aqws8pN2rfS9-dCC@parshuram>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlpoBJJXfZgsMxT@parshuram>
 <aqlwRkNcs_UqKjWs@parshuram>
 <aql6u3T0nnSVr-FC@SMW015318>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aql6u3T0nnSVr-FC@SMW015318>

On 15-09-26, 12:04, Frank Li wrote:
> On Tue, Sep 15, 2026 at 09:50:22PM +0530, Vinod Koul wrote:
> > On 15-09-26, 21:22, Vinod Koul wrote:

> > > > Traditional naming would be
> > > > dma/engine/provider.h
> > > > dma/engine/consumer.h
> > >
> > > consumer and provider and good names.. I would retain the full dmaengine
> > > everywhere please. dma causes confusion already!
> >
> > Thinking about it again, drivers/dma/dmaengine.h should be the provider
> 
> There some dmaengine code outside drivers/dma directory, like
> drivers/crypto/ccp/ccp-dmaengine.c

They chose to be outside, their choice... They need to be updated as
well to point to ../../dma/dmaengine.h :-)

-- 
~Vinod
