Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760182F7EE9;
	Sat, 17 Oct 2026 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792267068; cv=none; b=t7HCyo/UNqb6fJlCYg9kE4vN+MNUZk2GORnpS2vC9c++VJ4fN/cKddV0cGKqymJJ0lkgvlxGP1XV4J02o2O/n9gS2vRuborHBcONHJdALp6VfguPR+3vEZzhiqDUiol1ZRanO8UWMaHXnuS8LkZPtJGy4pwwPNy7X1bIpWHa3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792267068; c=relaxed/simple;
	bh=jFOUbJRvmwljNYLP9C7pwCtr2ez3Y5BqXrI1SrvhAMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+fWKTSOMiVMb7u0l+YqMbRqEEeIjfuxJHrvCxSiZNePLvIED/UB5YAGkHzTQhLTCUAfg/gCaV4upGkJz86ASuGE29QibUkHVXjgGqRLFJAnESbzUPx4C6Gec8kF7HGgaiIO5Jia82AhI500fp/CHH01dGPoG8fncKPBsJnl+40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyIXQHzO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyIXQHzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA721F000C4;
	Sat, 17 Oct 2026 19:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792267066;
	bh=QAUmvDdepyf61uGzRBrDNnO+jYriELG3v08EYg7DsEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WyIXQHzOu3fFThGzU6OEhBdHNiY0pHw/3dnt1V+be30jbf/pNnFlLWD1Pjr+iy15r
	 5Yx7BL5tt2wXaOrck14OS/1aRs/0QJcxm8JxqQpuNr/HIL+FFL2VkWJclWSxXdg3CW
	 IGjd8v4mcX+PYYSXLnyZPEXG02ZUzCmpuAHOMf6azHuI/ARkq/yKTKajcuiZV2Thzg
	 qt+kU1LN0xhPPMwouOE+i8DRxZT6St8HppChNyiNXBd+rYTdYcTMlUSH7uDPlzXBDf
	 QbWxBj+Xr6+vj7BRXIPpVmvo3/yjxWLUMvsCNHkv1CU2PnYnZTxEDzWilA7DXvqp64
	 3cp168M/UBjnw==
Date: Sat, 17 Oct 2026 20:57:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Myeonghun Pak <mhun512@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] iio: proximity: hx9023s: Allocate trigger before
 requesting IRQ
Message-ID: <20261017205742.146b18c2@jic23-hlaptop>
In-Reply-To: <20261016202524.6193abcd@systembl0wer>
References: <20261016024735.3667060-1-mhun512@gmail.com>
	<20261016202524.6193abcd@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 20:25:24 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Thu, 15 Oct 2026 22:47:35 -0400
> Myeonghun Pak <mhun512@gmail.com> wrote:
> 
> > An IRQ handler that already read trigger_enabled can poll data->trig
> > after buffer disable. Detaching the virtual IRQ does not join this
> > physical IRQ, and trigger deselection can drop the consumer reference.
> > Devres may then free the trigger before joining the handler.
> > 
> > Allocate the trigger before requesting the IRQ so devres joins the
> > handler before dropping the allocation reference.
> > 
> > This issue was identified as part of our ongoing research while
> > reviewing kernel code.
> > 
> > Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
> > Assisted-by: LLM
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---  
> 
> LGTM.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked
for stable.

Thanks,

Jonathan

> 

