Return-Path: <amsfield22@gmail.com>
Date: Sat, 24 Sep 2016 11:51:08 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org, outreachy-kernel@googlegroups.com
Cc: Sandhya Bankar <bankarsandhya512@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: light: Fix sparse warnings
Message-ID: <20160924185107.GA3190@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9c0fb251-3d55-9da9-0f12-71e2c26231e4@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Sep 24, 2016 at 04:21:01PM +0100, Jonathan Cameron wrote:
> On 24/09/16 13:12, Sandhya Bankar wrote:
> > Fixing below warnings:
> > 
> > drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
> > drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
> > drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
> > drivers/iio/light/max44000.c:217:18: warning: cast to restricted __be16
> > 
> > Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
> This is really just papering over the problem.
> A better solution would be to introduce a __be16 local variable to do
> the initial read into.  Then put it in regval via that be16_to_cpu
> call.
> 
> Jonathan


CC'ing outreachy-kernel@googlegroups.com since this is an Outreachy
task, and others will benefit from Jonathan's feedback to be sure that
we type the data correctly when it enters the system.

Sandhya, There are a few other patches from you in linux-iio that didn't
go to the Outreachy group. Probably not worth bouncing at this point.
Others can find them in linux-iio.  CC group on all future postings.

Outreachy applicant patch creation reminders:
 - use git log commands to decide on the commit path
 - commit message says what is changing
 - changelog says why it is changing
 - changelog makes a reference to the tool used to find the 
   issue and states the warning addresed.

Goal is not to fix checkpatch, sparse, 'insert-your-favorite-tool' warnings.
Goal is to correct the valid coding issues that these tools report.

alisons





> > ---
> >  drivers/iio/light/max44000.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> > index 6511b20..1ea9af9 100644
> > --- a/drivers/iio/light/max44000.c
> > +++ b/drivers/iio/light/max44000.c
> > @@ -214,7 +214,7 @@ static int max44000_read_alsval(struct max44000_data *data)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	regval = be16_to_cpu(regval);
> > +	be16_to_cpus(&regval);
> >  
> >  	/*
> >  	 * Overflow is explained on datasheet page 17.
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
