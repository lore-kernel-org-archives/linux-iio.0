Return-Path: <amsfield22@gmail.com>
Date: Sat, 1 Oct 2016 09:49:33 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Ico Doornekamp <ico@pruts.nl>
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] io: adc: ad7606_core: fix signed/unsigned number
 comparison
Message-ID: <20161001164932.GA2815@d830.WORKGROUP>
References: <20160928134149.2563-1-ico@pruts.nl>
 <c4a0a801-14d6-7ea9-ec4f-958449a9dcb6@kernel.org>
 <1475338371-sup-5926@pruts.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475338371-sup-5926@pruts.nl>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Oct 01, 2016 at 06:17:02PM +0200, Ico Doornekamp wrote:
> * On 2016-10-01 18:09:44 +0200, Jonathan Cameron wrote:
>  
> > On 28/09/16 14:41, Ico Doornekamp wrote:
> > > reported by 'make W=2' in ad7606_oversampling_get_index()
> > > 
> > > Signed-off-by: Ico Doornekamp <ico@pruts.nl>
> > hmm. It's pretty much a non problem in the first place as we know
> > it can't cause issues (can see it is 7).   Also this really just
> > moves to typecasting it later when we return i.
> > 
> > So unless I'm missing something I'm not going to apply this one.
> 
> Fair enough. It's one of those little penguin task things again, you
> probably guessed already. 'Find a bug reported by sparse and fix it'.
> But your IIO tree is simply too high-quality, sparse has nothing to
> complain :)

Hi Ico,

Flattering the maintainer, always good and so true, so true :)

Here's something found by sparse for little penguin.
See the Outreachy tasks page.  https://kernelnewbies.org/IIO_tasks

You'll see I leveraged your IIO_CHAN* patch for the first coding task.
We have a second coding task for sparse endianness patches.  There are
some remaining.  If you tell me you're grabbing one, I'll put it on
our claimed page so an applicant doesn't start on it. 

I know this one is unclaimed at the moment:
CHECK   drivers/iio/magnetometer/ak8974.c
drivers/iio/magnetometer/ak8974.c:403:16: warning: cast to restricted
__le16
drivers/iio/magnetometer/ak8974.c:480:24: warning: cast to restricted
__le16

alisons






> 
> -- 
> :wq
> ^X^Cy^K^X^C^C^C^C
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
