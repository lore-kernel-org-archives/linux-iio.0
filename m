Return-Path: <SRS0=dCcH=3G=gmail.com=amsfield22@kernel.org>
Date: Wed, 29 Mar 2017 09:00:03 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: simran singhal <singhalsimran0@gmail.com>
Cc: jic23@kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] iio: accel: bma180: Set up buffer
 timestamps for non-zero values
Message-ID: <20170329160002.GA21819@d830.WORKGROUP>
References: <20170329141131.GA23646@singhal-Inspiron-5558>
 <20170329151658.GB20663@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170329151658.GB20663@d830.WORKGROUP>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Mar 29, 2017 at 08:16:58AM -0700, Alison Schofield wrote:
> On Wed, Mar 29, 2017 at 07:41:31PM +0530, simran singhal wrote:
> > Use the iio_pollfunc_store_time parameter during triggered buffer set-up
> > to get valid timestamps.
> > 
> > Signed-off-by: simran singhal <singhalsimran0@gmail.com>
> 
> Hi Simran,
> I guess you knew I'd recognize this one ;)
> 
> My first thought were - "Wow that was a short and sweet description!
> Is that all I said when I made similar patches?"  So, I went back
> in history and sure enough - that is all I said in the changelog.
> 
> But I knew I had thought more about it than that changelog showed.
> So, I went back to the mailing list and found the patchset cover
> sheet where I had placed the greater explanation and options.
> 
> Note to myself: don't bury too much stuff in cover letters!
> 
> Note to you: Defects do repeat themselves so your method of hunting
> is fine.  If you haven't done it already, add the step where you go
> find the mailing list discussion of the patch.  That can be helpful.
> 
> Here's a link to the patchset on linux-iio:
> http://marc.info/?l=linux-iio&m=146825066822274&w=2
> 
> The piece of interest is:
> Alternative change would be to use iio_get_time_ns() directly in the
> push_to_buffers call in the handler.  We can do this if you are not
> one of those "devices (who) need a timestamp grabbed as soon as possible
> after the trigger" (from iio_poll_func definition)

Looked at driver.  It's already doing the above mentioned call
to iio_get_time_ns() in the trigger handler.  So, it seems this
change is not needed.

alisons

> 
> This is all just FYI for you now.
> 
> Leave the patch for the reviewers to comment.
> 
> Thanks,
> alisons
> 
> > ---
> >  drivers/iio/accel/bma180.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> > index efc6773..4ae5c80 100644
> > --- a/drivers/iio/accel/bma180.c
> > +++ b/drivers/iio/accel/bma180.c
> > @@ -762,7 +762,7 @@ static int bma180_probe(struct i2c_client *client,
> >  			goto err_trigger_free;
> >  	}
> >  
> > -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> > +	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
> >  			bma180_trigger_handler, NULL);
> >  	if (ret < 0) {
> >  		dev_err(&client->dev, "unable to setup iio triggered buffer\n");
> > -- 
> > 2.7.4
> > 
> > -- 
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170329141131.GA23646%40singhal-Inspiron-5558.
> > For more options, visit https://groups.google.com/d/optout.
