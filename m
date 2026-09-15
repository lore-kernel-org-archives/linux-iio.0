Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6AF4A3F0F;
	Tue, 15 Sep 2026 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487526; cv=none; b=TH5bKtr3pYTdVG/srDPlc8wCJZKV3suAehd30QUC3xo6/vbGcPJuCD7Yj/08XSPHqsZQ6FE57Oa79jnyIfQlFV9KKTZg7qEOB5iZUW7SpfHuG62+QfwHp5E+gt4fSojAhWqbSyVw449jsOhoE0WCj2SaYqiRaaaVaMhZAO691Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487526; c=relaxed/simple;
	bh=8j3HX5YHFLFaNpm2LrEXwI/2J4uiSIPLvY+ZmAEzRaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM4moQGM2fnFeyG20y/P6lCOskSyZvXA3XuW7o+H3qI/dgrjRS3dYrtvJl8+fPh5r4WvkxPyjAcKQbT/6uW0J03cO7urTgcY1wwbc9d5Lyfc7vQYdTOFYa3FYfTQUSxR90+713WW0JcwaVTMS4l9lWbJVdJd2JY6q/whYnG895U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAQ04ieK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAQ04ieK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E704D1F00893;
	Tue, 15 Sep 2026 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789487524;
	bh=o/1G+SKQdNCp7/TEN2iwmfHVFh9Mpgi3hXXpjOWL2nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VAQ04ieKIx8qzu2N0TjEFTUlNC0rVBiIK1ljVsXU60NzK4UnF7PAaJQNkLlulOZTo
	 omuP8Ticljoh3dg54JBRvb7nk6q6gs3nUVm6+aW/JtrwpZx2FmtHgIlBVS9WbTnYmQ
	 9IL/U7kFNGRj6d69sGEZP68+DZdGrZEIuN/AcXFr4ZjoDpXED6Uz6qe6FDhV+IHZNg
	 Ft3hSm8dddhRpnu/+tOX1o0XRzjk+9VyaiygBwpD4d3CSWeJUD1duhlXwjHyfcTlI6
	 HLMoeu36XnYqaC8cytIuSasSpS0ilAn5spVfnkGj2w4CzWEnwygDoZ464QxWitZoa6
	 OSV0xAP81qs0w==
Date: Tue, 15 Sep 2026 21:22:00 +0530
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
Message-ID: <aqlpoBJJXfZgsMxT@parshuram>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqjzvxI4ecoFvRLT@ashevche-desk.local>

On 15-09-26, 10:29, Andy Shevchenko wrote:
> On Mon, Sep 14, 2026 at 09:18:42AM -0500, Frank Li wrote:
> > On Fri, Sep 11, 2026 at 06:25:36PM +0100, Nuno Sá wrote:
> > > In preparation for the bitmap based bus width capabilities, move
> > > enum dma_slave_buswidth out of linux/dmaengine.h into a new
> > > include/linux/dma/engine/types.h.
> > >
> > > linux/dmaengine.h is included nearly everywhere, so growing it with the
> > > new interface would make every one of its users pay for it. Keeping the
> > > basic types in a separate header lets the new interface live next to it
> > > without that cost. linux/dmaengine.h includes the new header, so its
> > > users are unaffected.
> > >
> > > While at it, add the missing kernel-doc for the enum members. The block
> > > already opened with /**, so kernel-doc expected every member to be
> > > described and warned about each one of them. Describe the UNDEFINED case
> > > in particular, as its meaning depends on where the value is used.
> 
> ...
> 
> > >  include/linux/dmaengine.h        | 20 +++-----------------
> > 
> > I think it is good to split dmengine consumer and provider header files to
> > hidden dmaengine's detail.
> 
> It's indeed desirable change. but isn't it a bit out of scope of the series?
> I suggest to do one step at a time. Would it work for you?
> 
> > suggest name
> > 	dma/engine.h
> > 
> > so we can start move more API to this files.
> > 
> > after all user include this consumer header file,  old
> > include/linux/dmaengine.h rename to include/linux/dmaengine-provider.h,
> > which only include by dmaengine drivers.
> 
> Traditional naming would be
> dma/engine/provider.h
> dma/engine/consumer.h

consumer and provider and good names.. I would retain the full dmaengine
everywhere please. dma causes confusion already!

-- 
~Vinod
