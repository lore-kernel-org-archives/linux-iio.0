Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792610183;
	b=4J6l1cS2rr6gGY7YYCcXv90jsS2csbiuf7J79mWAaVxOT6Ky3+5lYVIMT6ysaCuI7cqk
	 aP22bL0B/eYcSDcJbeP2SSQA+XTV8LxjlekZNT4OGSlqCHlyZO784mwibG86atIjjICe+
	 BUxf2oAMGT432kRM5eFupcB2TJynmQlwrJsTcv26Kk/wR7uFYJzhe9f6PeOVJu+OCHOp5
	 5xD2tras+UMzbm+vy/blbhKQuUGpY0Fb6Y7CRlw15FaESpSwJWV9/e8zisMT9JC4H7gmO
	 y5OFvP5rrc7m6nkBPzl7JYUjKMidOTrzo2b36WWgGHxEDOf/rwt2ZshCLiP9wrZwRRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610183;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PX/0kvs4QlobqWwGN9vKI9fN7pNc+mhXK9E4ocGS1q0=;
	b=xcupYZSh9/sTm/hGk24a9C7M58j0DUh9wnpFLtHxy0c7A9Hx4xl/Igg6WY/YJOQRck2g
	 AqEzH98yW5KJY9wWDMHo49VmfeLAcrtFZAPOY7sk4llCwGlYsRH1LUEdrGxlNVQGwlx6+
	 7rK8TOheg9xv8pLIbbSXwVikA5JiS7IaNGwvNKIwriF3RZ3Stkr0i1xQPh2fk26w4CI5j
	 g9ZLrsrfT/8vp0FDZh/1eneCkEtQ06NP0D55DKTaTK3OPAcGsH3lat15GE9dEB5x7gpsy
	 Blosr7XBxTSOkKXOE+/xwPDqiJqjC3b0ujJ4ZJz0cIl+yF0xhPxUU66zeWoUYw7SGTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hAqwIth7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A9606A31A;
	Wed, 21 Oct 2026 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hAqwIth7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47581F000C1;
	Wed, 21 Oct 2026 19:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792610182;
	bh=PX/0kvs4QlobqWwGN9vKI9fN7pNc+mhXK9E4ocGS1q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hAqwIth7FlP2IQIuXHwRpR8bQ6SELcmEvAlU0D2KJSjl39mZ376WVRxBZwnXnNew/
	 Ro4wI3JUHgbD5N1ZdA6jpw7lrZQsQ9Sb7rE79yndBUmfKmaqpLoWEhGrzB2hN/Y0PD
	 xqkg5Sv8oGnYQdGmmP4O3e21PdQYMrjsQbbL/6SPFV3CsjRMu1hcc7hsEil7WUuyXM
	 DECziwzlmk8PjvT2JNd9/4VXjOm4lI23cTJesPOInOuTNRizPG4u50r6zHfvdyTiNG
	 r+uIzaJ0dHb8vLu3qrLVQfG+QLBl9TVIvbo/jVVKRqIEufow4w1vEKbmAloxs9CU5m
	 onFVPffYBm0xA==
Date: Wed, 21 Oct 2026 20:16:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
 nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
Subject: Re: [PATCH v5 06/15] iio: adc: ad4134: Protect conventional device
 access from debug accesses
Message-ID: <20261021201613.3d7833b5@jic23-hlaptop>
In-Reply-To: <ataF3Bpop9cAYuXW@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
	<b05978468abb537f7fe5b1d0ed2753df9a69decb.1792200021.git.marcelo.schmitt@analog.com>
	<20261017194707.48f6f242@jic23-hlaptop>
	<ataF3Bpop9cAYuXW@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 18:04:28 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 10/17, Jonathan Cameron wrote:
> > On Fri, 16 Oct 2026 22:58:05 -0300
> > Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> >   
> > > Require debug access to acquire device synchronization locks before
> > > allowing any transfer from the debug interface so to avoid disrupting
> > > operations issued from usual (non-debug) interfaces.  
> > 
> > These needs more.  What sort of disruption are we talking?
> > 
> > A deliberate write to change state that breaks normal operation
> > is a debug mess up that we don't guard against, but if a read
> > is enough to break things, or there is an inherent disruption
> > of other operations by using the bus at all then state that.  
> 
> A read is enough to break any ongoing buffered read because register reads will
> cause the bus configuration to change to a state that invalidates any sample read
> that happens afterwards. 

 Capture that in the commit message.

> 
> > 
> > What isn't regmap locking covering?    
> 
> regmap doens't cover IIO device direct/buffered modes.
> 
> > 
> > If this is all about the mux stuff and backend usage,
> > then move it to nearer that in the series and refer to that.  
> 
> We also need the mux usage to be synchronized which is why debugfs_reg_access
> now also locks on device state sync_lock.
> 
> In practice, because every device access will select then deselect the mux state,
> we are not able to have two operations going on simultaneously (not even two
> register read can run concurrently due to the needed mux state care).
> 
> On v3, there was a dedicated mutex for mux access synchronization. In an atempt
> to make things more simple, that second mutex was removed and sync_lock is now
> also utilized to prevent multiple threads from changing the mux state simultaneously. 
> It shall work properly as long as any device access first
> claims IIO direct + get sync_lock or claims IIO buffered mode.
> Is it okay to have it like that?

That seems fine.  Just add some documentation on the requirements in
appropriate places.

Jonathan

