Return-Path: <ico@pruts.nl>
Content-Type: text/plain; charset=UTF-8
From: Ico Doornekamp <ico@pruts.nl>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] io: adc: ad7606_core: fix signed/unsigned number comparison
In-reply-to: <c4a0a801-14d6-7ea9-ec4f-958449a9dcb6@kernel.org>
References: <20160928134149.2563-1-ico@pruts.nl> <c4a0a801-14d6-7ea9-ec4f-958449a9dcb6@kernel.org>
Date: Sat, 01 Oct 2016 18:17:02 +0200
Message-Id: <1475338371-sup-5926@pruts.nl>
List-ID: <linux-iio@vger.kernel.org>

* On 2016-10-01 18:09:44 +0200, Jonathan Cameron wrote:
 
> On 28/09/16 14:41, Ico Doornekamp wrote:
> > reported by 'make W=2' in ad7606_oversampling_get_index()
> > 
> > Signed-off-by: Ico Doornekamp <ico@pruts.nl>
> hmm. It's pretty much a non problem in the first place as we know
> it can't cause issues (can see it is 7).   Also this really just
> moves to typecasting it later when we return i.
> 
> So unless I'm missing something I'm not going to apply this one.

Fair enough. It's one of those little penguin task things again, you
probably guessed already. 'Find a bug reported by sparse and fix it'.
But your IIO tree is simply too high-quality, sparse has nothing to
complain :)

-- 
:wq
^X^Cy^K^X^C^C^C^C
