Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316C49738E;
	Fri,  9 Oct 2026 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537307; cv=none; b=L80NUKe4/Yh5Qvi9oksNvV1Qbf1cacNr+RyTOZrJEZ5mJ8NnwQJeDpd+xudoCyBOzSMIV5g+bFXWdkjLdXsX0DQpr2pKA9T1u/OlCtDQ4ao1CIYAtCzODBtS5F+08UghwR8kgmwrY9/bcwVmioOmJahUAaXunsCf4dBV52zT0Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537307; c=relaxed/simple;
	bh=rkWOojI+ebnA3Fv4IWTizk0VlXUsQPN3hEzpRvmmX8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGkQ1VG9UaLaLYqSwZ6ZPz5ZAScrneLhEzPs6DYnRFV0Yvmo65pQm6pzvAnN7sRj7irVrNl2VD7R+ZZTbfYj/QfyQ0qXfX52DKd0qgUhvAxpkDDNdfLIXUseq8R0gEIbGC2L5R7VZvt6St/2pQ0+NjnSr6OmZpZstio1gF9pNX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1iSR24M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1iSR24M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A801F00893;
	Fri,  9 Oct 2026 09:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791537304;
	bh=3NN/hoihGlgYOQ3g+HiDIFNp0hvlK2XY1wVVhjZreZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d1iSR24MZdZWLG3gs/fGUx1COZO0uDBytxmc7byfdGwfxukLFU1e7EbY2cNKo7da9
	 wJV/BYTBVVqPrNK1dqQtr1aMOkEfw+0EXwnbCUht7gHZfOzKGGdvcujEsZ5wzeT1FO
	 hMkI0NSd3ktIUnGjTbD4HS1Uua/oS52qIxUy5U3Dx9I7NVAvFOonQ1BC8vwyucZmr5
	 TPIszck4cljr0ATfW6EYHdNQmEl6iHJOOTRFJfGpObmA4aevizSLnjzW//xNXnnBE+
	 oGa21Vz071e6QkRUnWX9iWa1v3xnR5qTFgN5OBBGLIPKaqi3fIsGYN4pCorq7+szF9
	 kUKFO6ON9BRag==
Date: Fri, 9 Oct 2026 11:15:00 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Frank Li <Frank.li@oss.nxp.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
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
Message-ID: <asiwlNB2GMhmBlk8@parshuram>
References: <aq18_TMNs4EJzgZO@parshuram>
 <arDtEB0na9DxDWAS@nsa>
 <arFXc0LqEpgWSS6m@SMW015318>
 <ar-Il2qP_Qms3Qw1@nsa>
 <ar-13p3a7ENGfMOF@SMW015318>
 <asEWwIfO0LB27wj9@ashevche-desk.local>
 <asGk4fj_HQ5HupB4@SMW015318>
 <6f5dd1c1622adbaf0174a949ca91cb11872087ff.camel@gmail.com>
 <asSqVEHe8EjkbcwW@SMW015318>
 <asTDTxneqrpFlZi-@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asTDTxneqrpFlZi-@nsa>

On 06-10-26, 10:47, Nuno Sá wrote:
> On Tue, Oct 06, 2026 at 02:59:16AM -0500, Frank Li wrote:
> > On Tue, Oct 06, 2026 at 07:36:06AM +0100, Nuno Sá wrote:
> > > On Sat, 2026-10-03 at 19:59 -0500, Frank Li wrote:
> > ...
> > > >
> > > > There are already include bitmap.h, and use
> > > >
> > > > typedef struct { DECLARE_BITMAP(bits, DMA_TX_TYPE_END); } dma_cap_mask_t;
> > > >
> > > > Suppose all DMA Engine consumer will use it to do some check. So I think
> > > > needn't split it as indivial version.
> > >
> > > Are we sure all consumers are making use of dma_cap_mask?
> > 
> > Some legacy user check it. Supposed needn't check it after get channel.
> > I am working new API to check it to avoid direct access it.
> > 
> > > In fact the only function
> > > depending on bitmap.h is the one clearing the cap_mask. But stepping a bit back,
> > > bitmap.h was the original proposal from Andy so the idea was to have the new
> > > widthmask (this one indeed heavily uses bitmaps) already as a split. And with it,
> > > came types.h given that the DMA enum needs to be used from both consumers and
> > > providers.
> > 
> > Supposed provider is super set, which can include consume part.
> 
> Yes but also look the below note on the consumers.
> 
> > 
> > > And note that consumers might want the header without actually needing the
> > > bus width API so the separation kind of made sense to me.
> > > Then, as a follow up the idea was to also split the cap_mask API into it's own header
> > > with a backing include in the main consumer header.
> > >
> > > So if we all agree with the above, I guess the current series does not really has to
> > > change. I see 3 ways:
> > >
> > > * Just go back some versions before and have all of it in dmaengine.h
> > > * The current form
> > > * s/engine/consumer on the current proposal include/linux/dma/engine/*
> > 
> > I think we can put include/linux/dmaengine.h now. The split/move need more
> > work. I already sent some patches.
> > 
> 
> Ok, to be sure we're 100% on the same side, plan for now is to add the
> bus width API directly in include/linux/dmaengine.h?

Agreed, we have two headers one global: include/linux/dmaengine.h which
will be moved as a consumer API Header and local header
drivers/dma/dmaengine.h which will be provider header (i am okay to
rename as such as well).

So this one is used by both so lets keep in global header.

Thanks
-- 
~Vinod
