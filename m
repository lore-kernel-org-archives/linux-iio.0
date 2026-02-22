Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17462253EE;
	Sun, 22 Feb 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771777252; cv=none; b=YV0SNIgcHGsoLGPR0jQCzhMFN8BRy81GyBGk0WI1f7nGjn3bV95XhwPvGVFwXX+iuaCqaP5+NKjJYnGnkradFJUbLfMRpgr7+vyrGs3lwy7evbXHJ4o0BoRNNcqT+mRm2tEOMgm0kdf3GCHzQm8GDAmt6ccgWkx+8+aqRwx/I08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771777252; c=relaxed/simple;
	bh=EBDtDMHLataSPg9RGGeqQDf79U5jLb6sobt7NluFtr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCL18JmapZ+2cSsydVAUzdX4iaLhF9w39rGMl/YNkYIArp7SbxMmnQKwuOCi76uX0Fr7j6PewJoTIhNwao0Izd9Oz2lVlxOK2medLYbiKCgah3T4mTh3u8xBXrUDnc/vJ7SJwfpiz+ZIMPDfPDeT0LYFr+nnF3LePNZmc4QpRfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBztsx3h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBztsx3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D21C116D0;
	Sun, 22 Feb 2026 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771777251;
	bh=EBDtDMHLataSPg9RGGeqQDf79U5jLb6sobt7NluFtr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hBztsx3hrtkQoUnNeFdn7PwqEqSVk2BRSp+Ggdfo3Or7Y7E0NanGFTl2zfQlHrpR7
	 zrrv3S68OASUoSEBQF8dsmnNrf7uf20DKrenukkHy5KmUtaJGhKfYKktz/uOposlf/
	 yqtm70NHmC9f2juRSOZWGCoqdFT/yrHerjWMBmTcXRL+3uJm0k9L1Tem2IhQNw8vBK
	 by6RvIJer0xI58zx/Ln6oW1Oo7blrFSpRyPSqbl3GFB4F/tveytIuqoX7qfbPJm3KJ
	 e+UZyR3lCILlcZMQJVneDaOCFnqk9vV+vVWYfAlqcShLD68T9bkR46YStOjXNGA7qo
	 7Zf6fnG9JKw8A==
Date: Sun, 22 Feb 2026 16:20:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Salah Triki <salah.triki@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: core: Clean up device correctly on
 viio_trigger_alloc() failure
Message-ID: <20260222162043.1791ab3c@jic23-huawei>
In-Reply-To: <e49877b5-2a8d-43d5-9f8b-de37cde9cdcc@baylibre.com>
References: <20260221073301.105080-1-salah.triki@gmail.com>
	<e49877b5-2a8d-43d5-9f8b-de37cde9cdcc@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Feb 2026 11:07:10 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/21/26 1:32 AM, Salah Triki wrote:
> > Once we called device_initialize() we have to call put_device()
> > on it. Refactor the code to make it in the right order.  
> 
> This could be a bit more clear. Something like ...
> 
> Move device_initialize() after all error paths in viio_trigger_alloc().
> Previously, we should have been calling put_device() on any error path
> after device_initialize(), but failed to do so.
> 
> Rather than adding put_device(), we can just move device_initialize()
> to avoid needing to unwind it on error.
> 
> Additional trig->dev initialization is also moved with this just to
> keep the code organized.
> 
> 
I used this but edited to be in imperative:

    Move device_initialize() after all error paths in viio_trigger_alloc().
    Previously, put_device() should have been called on all error paths after
    device_initialize(), but that was not done.
    
    Rather than adding put_device(), move device_initialize() to avoid
    needing to unwind it on error.
    
    In addition move trig->dev initialization to just before device_initialize()
    to related code together
> >   
> 
> Did we decide this doesn't need a Fixes: tag?

We never identified an actual problem.  It's wrong from a best
practice point of view, but I'm not convinced there is a bug
today without the change. Hence not something we'll rush to backport
and no fixes tag.

> 
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > ---  
> No need to send a new revision for this right away. If Jonathan is
> in the mood, he might fix it up for you.
Done ;)

Applied to the testing branch of iio.git

Thanks for the persistence Salah
(and thanks David for the suggestions!)


> 
> With the commit message improved:
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

