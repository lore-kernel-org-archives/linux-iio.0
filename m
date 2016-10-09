Return-Path: <masneyb@onstation.org>
Date: Sun, 9 Oct 2016 06:35:11 -0400
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: Re: [PATCH 4/4] staging: iio: isl29018: move out of staging
Message-ID: <20161009103511.GA26215@basecamp.onstation.org>
References: <1475801317-29449-1-git-send-email-masneyb@onstation.org>
 <1475801317-29449-4-git-send-email-masneyb@onstation.org>
 <d940ec91-26e8-9c7c-347f-c8f73eb28e54@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d940ec91-26e8-9c7c-347f-c8f73eb28e54@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Oct 09, 2016 at 10:45:12AM +0100, Jonathan Cameron wrote:
> On 07/10/16 01:48, Brian Masney wrote:
> > Move ISL29018/ISL29023/ISL29035 driver out of staging into mainline.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> Time for a nitpick tastic review ;)
> 
> The nature of a move out of staging patch is that we'll go over it
> with the level of fine toothed comb we apply to a new submission.
> A good part of my aim here is to ensure that once it's out it doesn't
> get a lot of churn from whitespace or comment syntax patches etc.
> 
> I want to be able to ignore it for ever more and have it continue to
> work perfectly and be beautiful code ;)
> 
> Anyhow, nothing of any significance at all in here, but it will need
> a couple of precursor patches to clean up the loose ends before we
> move it out of staging.
> 
> Thanks for doing this and sorry to bounce it back to you over such
> trivial stuff!

Thanks, Jonathan, for taking the time to go through this. I'll send a
second patch series in a day or two.

I'm hoping to have one of these light sensors (along with 2 others in
staging/iio/light/) in a week or so that I can hook it up to a
Raspberry Pi to test the drivers. I ordered the sensors off of
Digi-Key for a few dollars each. One of my friends is mounting them
onto a breakout board for me.

Is my change that renames the Kconfig variable acceptable? After I
emailed that last patch set, I noticed that the description in Kconfig
for this driver has 'ISL 29018' but the neighboring one in mainline has
'Intersil ISL29125' so I assume that should be changed as well for
consistency.

Brian
