Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A63A4522;
	Mon, 20 Apr 2026 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691327; cv=none; b=dwAJJb+9wTAyx00dGTn5b6qZmbIejaZY8D6lAHWoauZU94Wum2t7XUwwuWn0XLJrkqcRrkMFJ8cXXqW2li1IGMtVtylOcb6CrBjsVHi4rmhbmnHFLF1mvB7Hc2DXxfeHQk8IAm6tZ0Ol5TSHOi0iZr3ZRvN+jIxxueAUmAKPaRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691327; c=relaxed/simple;
	bh=yuiSdem98UiRqbOnNQzG8mxNhARDmh8Gn3eBQEmicrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYnfc7a+YS+hwddNZUwxLvJelPmO4NXEkykv/rRh7/v8L32DWLYv37VrGPfpyHovlccDjUrvM19RS4mzz3YuAR2dCTEx4aCh61gRfZ4Y1fcLt/GrL4KCU+SKDcErzB169fv1BQlYSrWPft4ToNJ57L2S6qC7JBx6U2NQQS165Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXO9BewK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXO9BewK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55C5C2BCB6;
	Mon, 20 Apr 2026 13:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691327;
	bh=yuiSdem98UiRqbOnNQzG8mxNhARDmh8Gn3eBQEmicrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jXO9BewKWJU7QByNL810y3KIFgr1k882Rz9SA62tq2mXYLtvTYEgguaaOUKFGC537
	 Q5EaqqaEAEBynaA5aePcR4H/U3qMC+TvVzYH/4UFbGC3uBwZXCkyCO4tBofRGFl3BG
	 bkmz3WsiHfeAiWf/wdaLNiQFpHvU7DwT1o9lENZkLohZeKalRjru97cE7bKyrJg2QO
	 7iCeApEVXZREDw5CjJn5lLSB073rdhiDQTS2hgw542HYqUOQKiVHnRxyzOgGNfcjlA
	 bWQqdvQSP31qfcCpQjQn4KCGMms+gCCX1OAmQlwTRC9hvWiDRxtqS00n3k+/Rp60wy
	 E4p+yZFEgYwnw==
Date: Mon, 20 Apr 2026 14:21:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: David Carlier <devnexen@gmail.com>, linux-iio@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, Cosmin Tanislav <cosmin.tanislav@analog.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] iio: dac: Convert several drivers to
 devm_mutex_init()
Message-ID: <20260420142158.2d8b05e9@jic23-huawei>
In-Reply-To: <60c2cdbc-2ee3-49ce-8a94-590230899cbc@baylibre.com>
References: <20260410193737.35905-1-devnexen@gmail.com>
	<60c2cdbc-2ee3-49ce-8a94-590230899cbc@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 15:03:33 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/10/26 2:37 PM, David Carlier wrote:
> > 
> > This series converts seven iio DAC/ADDAC drivers to use devm_mutex_init()
> > instead of mutex_init(). These drivers currently call mutex_init() in
> > probe but have no .remove() callback, so mutex_destroy() is never called
> > on device unbind.
> > 
> > Same pattern already accepted in iio for other drivers (e.g. ad5446,
> > ltc2688, ad7124, ad7606, vcnl4000, etc.).
> > 
> > David Carlier (7):
> >   iio: dac: ad3552r: Use devm_mutex_init()
> >   iio: dac: ad7303: Use devm_mutex_init()
> >   iio: dac: ad5758: Use devm_mutex_init()
> >   iio: dac: ad5755: Use devm_mutex_init()
> >   iio: dac: ad5686: Use devm_mutex_init()
> >   iio: dac: ltc2664: Use devm_mutex_init()
> >   iio: addac: ad74115: Use devm_mutex_init()
> >   
> 
> Jonathan has mentioned before that he doesn't care to take patches like this
> unless we are making other cleanups to the driver too. So we'll see what he
> says this time.
> 

The one time I'm more flexible on taking small changes is when they come
from someone new to the kernel.  A quick look suggests that's not quite true
of David, but David also doesn't seem to be an old hand.  So I'll take
this set, but no more of these please unless part of a more general
cleanup of a driver.  Maybe at somepoint in the future we'll have few enough
of these that it makes sense to do this for all of them, but right now there
are ~300 mutex_init() calls in IIO and don't want anywhere near that level
of churn when there are more useful things to do!

Applied to the testing branch of iio.git.

Thanks,

Jonathan
