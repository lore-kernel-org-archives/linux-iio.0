Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792809570;
	b=P3MM7Fn73cf7G0dbmy4SHDkua9voKGMuBwMxzGrdqEPC24rW4e4zfQ0N5SW2ZbzJytry
	 HkEi5ikYX41wwGx2CMf7gmPMPCEyShKPZ7qYl0rkqRDVnNmu6/MuV0AaEXXgJgCI2TXDO
	 o+k9R8cojE80GnKuuNjCx7f9fZMbYAO9mqwikoOrhYDJ8hE9rFC2jRunKcAl0a9yLrLQO
	 JXoWm4m/batFGOG6lf7Wxy7oLDFB27j3cCPXD1FjXP16GCt2iCTBpRsRunXjHrRGANL8D
	 sipucrOtbQQgoE8bPxDmRwU8i4ZOyuoiuvfHjdBP1F/FGzABAzmQ1oJ2sL/qUcTdcJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809570;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rAvEBbxAiiozil7JXucCOwvBF/yNHw8qmjRc24tUjiI=;
	b=Xo5pUkpf3ccwKc/mvHSPCze3DDQ/xysJxtJXQ1K3LbPX+pn9PQTQFasmjEPqp5O7qZhw
	 BAeBsrKS2gpIypZc5F67ARWCS/TT94IHAMldohzGfLxKAxocBa+TYoxw8sa2PyMI3MpKS
	 0A7gxBW2cnEwINYhx1We8nl1/aM5LfK3HPrVAZ0HR5EFDysFjwvm+DS7NeY7Q2gcJeFaN
	 wbkYAdL554L5HqbcGYOq5dDN/hBoFjRQZn1t+t4iHwIA5qs4ll4OrWJnUcG8S/jfwR9M7
	 co5ASYCyp5fLqH+9STJHjjJdGte6NbEo1rspS8zsj+VV3juJiiDZ75E5J3nw24R9TpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JG21U+k+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37B3606A31A;
	Sat, 24 Oct 2026 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JG21U+k+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E111F01825;
	Sat, 24 Oct 2026 02:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792809569;
	bh=rAvEBbxAiiozil7JXucCOwvBF/yNHw8qmjRc24tUjiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JG21U+k+4thCFVkwD0ssK1USjZ7OGrNmoJRSN1jymFK5U/g1qJQTXgVoOD9CuZ+yV
	 qYKgkZ7pw442CYUFGxkyZOHPLhTkH2Lc48Z0XYs3tE7NV/mC0Tpis2XYCiqm6VpdNb
	 OX/19f+iHHR7IgrOlWrrv4umCmjeM4eWqhxOGf9Jr+x8GN+MdU/KLccL2xJgqNnfUU
	 cA1efYPoaf3iXRHziot3fbDj6c5HREL0rYvcHpKHHCCq5KkQe1u0wRvqlqN1NUFG8u
	 B7JQpqW7V6jH2fuHJhLPXYRZylTeKEx+Wlnl8DD8PMWAaxbe+WhKTUgiPqakglqsA4
	 AWNLboJMveNhQ==
Date: Sat, 24 Oct 2026 03:39:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jinseob Kim <kimjinseob88@gmail.com>, linux-iio@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-kernel@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 llvm@lists.linux.dev
Subject: Re: [PATCH] iio: osf: avoid a large stack frame in osf_core_init
Message-ID: <20261024033923.5a32dcbf@jic23-hlaptop>
In-Reply-To: <20261020095039.00004c88@gmail.com>
References: <202610191514.fRYyu0HX-lkp@intel.com>
	<fc593496353a60a15fd5ef1a2786d41dd9bdff3a.1792403576.git.kimjinseob88@gmail.com>
	<20261020095039.00004c88@gmail.com>
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

On Tue, 20 Oct 2026 09:50:39 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 19 Oct 2026 18:58:49 +0900
> Jinseob Kim <kimjinseob88@gmail.com> wrote:
> 
> > Clang reports a 1344-byte stack frame in osf_core_init() for
> > hexagon-allmodconfig, exceeding CONFIG_FRAME_WARN=1280.
> > 
> > The aggregate assignment materializes a temporary struct osf_device on
> > the stack and copies it to the destination. With the mutex and caches
> > added by the IIO support, this structure is 1328 bytes in the reported
> > configuration.
> > 
> > Clear the destination directly, then set dev and initialize latest_lock
> > as before. This preserves zero initialization of all other fields,
> > including when the core is reinitialized for a new session, without the
> > large temporary object.
> > 
> > With the reported Clang 24.0.0git compiler and Hexagon configuration, the
> > frame decreases from 1344 to 8 bytes and the warning disappears.
> > 
> > Fixes: 7329986669f2 ("iio: osf: add IIO devices from capability reports")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202610191514.fRYyu0HX-lkp@intel.com/
> > Assisted-by: LLM
Dropped this lot because it all gets messy with an unstable commit.
I made the Closes into a Link to retain the info.

Applied to the testing branch of iio.git

Thanks,

Jonathan



> > Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> > ---  
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

