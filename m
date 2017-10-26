Return-Path: <SRS0=/mvU=BZ=oracle.com=dan.carpenter@kernel.org>
Date: Thu, 26 Oct 2017 17:07:43 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-iio@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>,
        Felipe Balbi <balbi@ti.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/light/opt3001: Use common error handling code in
 opt3001_get_lux()
Message-ID: <20171026140743.wfstmoy3lbolm7xv@mwanda>
References: <c0b3ce73-db0d-c481-51be-2047b07c9f63@users.sourceforge.net>
 <20171026134852.bprrrv3htfyryyy4@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171026134852.bprrrv3htfyryyy4@piout.net>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 26, 2017 at 03:48:52PM +0200, Alexandre Belloni wrote:
> On 26/10/2017 at 14:17:30 +0200, SF Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Thu, 26 Oct 2017 14:06:49 +0200
> > 
> > * Add jump targets so that two error messages are stored only once
> >   at the end of this function implementation.
> > 
> > * Adjust condition checks.
> > 
> > * Replace string literals by references to two global constant variables
> >   in eight functions.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  drivers/iio/light/opt3001.c | 88 +++++++++++++++++++--------------------------
> >  1 file changed, 36 insertions(+), 52 deletions(-)
> > 
> > diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> > index 54d88b60e303..23d7d4e6ae61 100644
> > --- a/drivers/iio/light/opt3001.c
> > +++ b/drivers/iio/light/opt3001.c
> > @@ -77,6 +77,9 @@
> >  #define OPT3001_RESULT_READY_SHORT	150
> >  #define OPT3001_RESULT_READY_LONG	1000
> >  
> > +static char const read_failure[] = "failed to read register %02x\n";
> > +static char const write_failure[] = "failed to write register %02x\n";
> > +
> 
> If you are going to do that

The answer to that question is we're not going to do that...  Please
stop taking bad ideas and making them even more complicated and worse.

regards,
dan carpenter
