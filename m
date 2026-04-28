Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CBB3BA25B;
	Tue, 28 Apr 2026 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395849; cv=none; b=iRkryeMD2HMH2Wfy4mOYhD9I5KRQuaze2APk4g+KD8RrjULJiE36Qs5qQi3fc9+L/HG3e1Xzdy3cnIoXcHA4Tc/q1fSRVzJlFRYfb/YZxgQqfxuf9AzN1OiUEKC0ZsnoDnPJlRm3rkLZYR3K9uuZO7g2aBZ5HLnAvrzLmLMqyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395849; c=relaxed/simple;
	bh=3mMPg4rozx+x50ubX57DDRfKp0ZrXvZtJZnoMdHRKXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0YnUQV2/TWorUK2HnEwExqFhnRdioc0JY7f5PY49/Qir8/yuwrnezQ2RWjlLwo4y9nbF7s4jP8WnD+RwpAE94P35KUNt7CKQLtw6AxvBvdSzFTtic74Ax5+rd8vVoLTmDLFlbAjaGuQDrGbVcqAfTPjPbKkPxwjRvzBRchNuc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB71i+xE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB71i+xE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E129C2BCAF;
	Tue, 28 Apr 2026 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777395849;
	bh=3mMPg4rozx+x50ubX57DDRfKp0ZrXvZtJZnoMdHRKXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fB71i+xEGFDQivvILLdx1ENTQfK0IvXk6t0r3Yy5RyzInBTivZP4xbY/hNJLTDiV8
	 F9C7vQh6nezTUFquqZDo+L0pphmuZPZIjlOgJUt38N9lT7TyC4p0eubNyBohCgig7G
	 U4w6lIf8O5Sm7hc/e9xhhScuL5jrTgBH8MVjwuV0WfS7CId+JTxcOH9cL1NnNEdleu
	 Jhddw7Zk2UwU+Tl3qV+dS07EngkD4Yd7wd+q+wZqS3Aji9Mx3OT6xySWA5jb4q1xiv
	 8AxRPkzhD9nkUUgosl43S8Vzafm0o4SMIHZ+dnYh7cCAkiw/r5jf42tuN+uGD6Gezo
	 uqUG8byDXFaRQ==
Date: Tue, 28 Apr 2026 18:03:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Giorgi Tchankvetadze
 <giorgitchankvetadze1997@gmail.com>, antoniu.miclaus@analog.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads7138: replace kmalloc() with stack
 allocation in i2c_write_block
Message-ID: <20260428180356.62801c75@jic23-huawei>
In-Reply-To: <20260428103617.148027c1@pumpkin>
References: <20260427112705.71138-3-giorgitchankvetadze1997@gmail.com>
	<20260427143137.27bc4552@pumpkin>
	<3512cce0-6660-42a9-91bb-07e78a002205@baylibre.com>
	<20260428103617.148027c1@pumpkin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 10:36:17 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> On Mon, 27 Apr 2026 10:21:37 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 4/27/26 8:31 AM, David Laight wrote:  
> > > On Mon, 27 Apr 2026 15:27:07 +0400
> > > Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:
> > >     
> > >> The ads7138_i2c_write_block() function currently utilizes kmalloc()
> > >> to allocate a buffer for I2C transfers. However, the length
> > >> parameter passed to this function is strictly 2 bytes across all
> > >> driver invocations, making the total payload buffer size exactly 4 bytes.
> > >> Invoking the heap allocator for a 4-byte buffer introduces
> > >> unnecessary SLUB overhead.     
> > > 
> > > Have you confirmed that the buffer is never used for DMA?
> > > 
> > > Provided the lock that blocks concurrent access from two threads
> > > is actually outside this code, a buffer for short transfers could
> > > be allocated within 'struct i2c_client'.
> > > 
> > > 	David
> > >     
> > Giorgi,
> > 
> > This is why it is important to include a changelog and a link to the
> > previous discussion [1] in the cover letter or after --- in a single patch
> > when you submit a new revision. I think that would have answered David's
> > question.
> > 
> > [1]: https://lore.kernel.org/linux-iio/20260424081809.61841-2-giorgitchankvetadze1997@gmail.com/
> > 
> >   
> 
> The thing is I remember issues with on-stack buffers being used for
> dma - which worked before kernel stacks were allocated using vmalloc().

That is a problem for some buses that define their basic bus access functions
to require DMA (and regmap on top of those).  E.g. SPI where your comment
would have been absolutely correct.

I2C does the opposite. Everything is bounced through DMA safe buffers unless
you explicitly opt in to say you are providing a DMA safe buffer.
That is only worth doing if the buffers are large and the bounce therefore
expensive.

Whilst we are here - something that has me doubting myself so I'll just
lay it out.

There is a fun corner where Sashiko is giving a false positive (I think
anyway!) in that a pair of rx/tx buffers can sit in the same cacheline
as long as no one modifies either whilst a bus transaction is in flight
and so the DMA hasn't yet occurred in both directions. This has the fun
side effect of part of the cacheline in the non coherent DMA management
code being marked for each direction. However, the mechanism for corruption
doesn't apply so it should be fine.  A common situation is where rx and
tx are the same buffer which is an extreme case of this and absolutely fine.

If I have this wrong we have a lot of broken drivers - so hopefully not!

> One of the solutions to that is to use kmalloc() for buffers that
> could be on stack.

Correct, just not needed here.

Jonathan

> 
> I think I found exactly 1 call to this function.
> Indeed, just inlining the logic would make everything clearer.
> 
> 	David

