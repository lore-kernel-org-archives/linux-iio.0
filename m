Return-Path: <SRS0=fOpU=6W=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 19 Jul 2017 14:45:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Joe Perches <joe@perches.com>
Cc: Jaya Durga <rjdurga@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] Staging: speakup: speakup_keypc.c: usleep_range
 is preferred over udelay
Message-ID: <20170719124554.GA17490@kroah.com>
References: <1500467157-14739-1-git-send-email-rjdurga@gmail.com>
 <1500467788.25934.37.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500467788.25934.37.camel@perches.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jul 19, 2017 at 05:36:28AM -0700, Joe Perches wrote:
> On Wed, 2017-07-19 at 17:55 +0530, Jaya Durga wrote:
> > Fix checkpatch issue: CHECK: usleep_range is preferred over udelay;
> []
> > diff --git a/drivers/staging/speakup/speakup_keypc.c b/drivers/staging/speakup/speakup_keypc.c
> []
> > @@ -28,7 +28,7 @@
> >  
> >  #define DRV_VERSION "2.10"
> >  #define SYNTH_IO_EXTENT	0x04
> > -#define SWAIT udelay(70)
> > +#define SWAIT usleep_range(70, 150)
> 
> It'd probably be more sensible to remove this define as
> SWAIT is used just once and use usleep_range directly.
> 

I asked for that last time :(

I guess I'll just reject this again...
