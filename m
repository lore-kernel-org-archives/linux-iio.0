Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C832442FBD;
	Fri, 18 Sep 2026 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754468; cv=none; b=NojBQ2KJ37AXfM1FsiIF7BWS6KkRrBhw8fuFLdC0lsASYKp3Ytm8b0ecrOd++qf1lB6x5b9jq9gtxz+hd7oM414FGK5NODSsChX+ssiWW9A9RXjuO+1jJAbhrXZzJ8Wbr1IxAkbSGHvKEmPD0Kosp6aUi0I/eEcwPWQaPqYqqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754468; c=relaxed/simple;
	bh=+ymAg0bLWbEQ5+aud73uKePSpfUImuqoJEb1bGtxU88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bedgqxc+iaklmcexfy6xdyB2d3W+YqnOz7KINBfoLVpRxCu5lx8yvxdVOxAYrtw5BEhjYYvBi2uKo8pmktcskcmeY6PZ+61tAnTHIk1bqK/I8kcCpbRQQGgVe/56WajPXrXAOdm8Tuzkf8jApyOP9ZeY+i4HbdWXNGen+VT+ids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui0WeFB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui0WeFB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C811F000FF;
	Fri, 18 Sep 2026 18:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789754466;
	bh=JFGUmsZtJrd4ua8ceUYxUso1QIbX+17a+Wb/M6n30Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ui0WeFB36ooFsNAEOXhsf78kjdmkzW+qCWLnTsOVTo/7Lle+ToNp5ogBFrd15KsUH
	 1KJzCcvfw/m/CtJpdEuV1w9W3Vx4Ep2yJehXTAMvI2jpoIPfLotaZ32NDZjwg6wlmh
	 c7+ziURsMqN99wXtwbSG2bSe2RvnL+08zofACb0uxTXK7IcZ3a4/hRcZahVlD76Mi2
	 05D4EMn1ZxgJoZmsWKvOYNEGVKWEQd2RP/HexrPM1hUVYOkTIf605EFZ6WPBxR5Xlb
	 igtvUyx56jKeKgY3ddt/D8LQuStKmYBoGiDWfWuwkBBnndQACkJwhS6Jf5sJf+zVFj
	 vFomtcK1ON37Q==
Date: Fri, 18 Sep 2026 23:31:02 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Frank Li <Frank.li@oss.nxp.com>,
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
Message-ID: <aq18XoWmys6RmRGj@parshuram>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlpoBJJXfZgsMxT@parshuram>
 <aqlwRkNcs_UqKjWs@parshuram>
 <aql6u3T0nnSVr-FC@SMW015318>
 <aqws8pN2rfS9-dCC@parshuram>
 <aqzZOZ2ovBc6affP@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqzZOZ2ovBc6affP@ashevche-desk.local>

On 18-09-26, 09:24, Andy Shevchenko wrote:
> On Thu, Sep 17, 2026 at 11:39:54PM +0530, Vinod Koul wrote:
> > On 15-09-26, 12:04, Frank Li wrote:
> > > On Tue, Sep 15, 2026 at 09:50:22PM +0530, Vinod Koul wrote:
> > > > On 15-09-26, 21:22, Vinod Koul wrote:
> 
> ...
> 
> > > > > > Traditional naming would be
> > > > > > dma/engine/provider.h
> 
> (Actually majority of the subsystems use driver.h.)
> 
> > > > > > dma/engine/consumer.h
> > > > >
> > > > > consumer and provider and good names.. I would retain the full dmaengine
> > > > > everywhere please. dma causes confusion already!
> > > >
> > > > Thinking about it again, drivers/dma/dmaengine.h should be the provider
> > > 
> > > There some dmaengine code outside drivers/dma directory, like
> > > drivers/crypto/ccp/ccp-dmaengine.c
> > 
> > They chose to be outside, their choice... They need to be updated as
> > well to point to ../../dma/dmaengine.h :-)
> 
> Hmm... It's rare to make such a requirement in the kernel for the resources
> like this. All I know about (GPIO, regulator, pwrseq, IIO), they split and
> provide the interfaces to the whole kernel.

Resources for kernel are in include/ no debate on that
If there is a valid justification on why driver need to live outside
subsystem we can provide. Unless I see that, I am inclined to not agree

-- 
~Vinod
