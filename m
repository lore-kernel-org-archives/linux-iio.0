Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbeHSTck (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 15:32:40 -0400
Date: Sun, 19 Aug 2018 17:20:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: cros_ec_accel_legacy: Mark expected switch
 fall-throughs
Message-ID: <20180819172036.5e8d6d28@archlinux>
In-Reply-To: <20180818153416.GA3543@gmail.com>
References: <20180815163852.GA4910@embeddedor.com>
        <20180815172700.GA29039@gmail.com>
        <64cccc17-ebfe-205a-6b2c-2a72aae765b0@embeddedor.com>
        <20180818153416.GA3543@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 18 Aug 2018 17:34:40 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Hi Gutavo,
> 
> Sorry for the delay.
> 
> On Wed, Aug 15, 2018 at 12:50:10PM -0500, Gustavo A. R. Silva wrote:
> > Hi Marcus,
> > 
> > On 8/15/18 12:27 PM, Marcus Folkesson wrote:  
> > > Hi,
> > > 
> > > On Wed, Aug 15, 2018 at 11:38:52AM -0500, Gustavo A. R. Silva wrote:  
> > >> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> > >> where we are expecting to fall through.
> > >>
> > >> Addresses-Coverity-ID: 1462408 ("Missing break in switch")
> > >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > >> ---
> > >>  drivers/iio/accel/cros_ec_accel_legacy.c | 2 ++
> > >>  1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > >> index 063e89e..d609654 100644
> > >> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > >> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > >> @@ -385,8 +385,10 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
> > >>  		switch (i) {
> > >>  		case X:
> > >>  			ec_accel_channels[X].scan_index = Y;
> > >> +			/* fall through */
> > >>  		case Y:
> > >>  			ec_accel_channels[Y].scan_index = X;
> > >> +			/* fall through */
> > >>  		case Z:
> > >>  			ec_accel_channels[Z].scan_index = Z;
> > >>  		}  
> > > 
> > > Hum, I'm not sure we are supposed to fall through here, even if it does
> > > not hurt to do so.  
> > 
> > Yeah. You're right. It doesn't hurt but is actually redundant. I think
> > the original intention was to break instead of falling through.
> >   
> > > I even think we can remove the switch and put that outside the for-loop,
> > > e.g:
> > > 
> > > 	ec_accel_channels[X].scan_index = Y;
> > > 	ec_accel_channels[Y].scan_index = X;
> > > 	ec_accel_channels[Z].scan_index = Z;
> > > 
> > > 	for (i = X ; i < MAX_AXIS; i++) {
> > > 		if (state->sensor_num == MOTIONSENSE_LOC_LID && i != Y)
> > > 			state->sign[i] = -1;
> > > 		else
> > > 			state->sign[i] = 1;
> > > 	}
> > >   
> > 
> > I like this, but the code clearly depends on MAX_AXIS. So, if MAX_AXIS
> > will be always 3, then the change you suggest is just fine. Otherwise,
> > it seems that adding a break to each case is the right way to go.
> > 
> > What do you think?  
> 
> Well, I guess it is a matter of taste after all.
> I don't think the number of axis will change, but just put the break in
> place is good enough.
> 
> Anyway, If we choose to not use the switch, I think we should remove the
> for-loop as well, eg:
> 
> 	ec_accel_channels[X].scan_index = Y;
> 	ec_accel_channels[Y].scan_index = X;
> 	ec_accel_channels[Z].scan_index = Z;
> 
> 	if (state->sensor_num == MOTIONSENSE_LOC_LID) {
> 		state->sign[X] = -1;
> 		state->sign[Y] = 1;
> 		state->sign[Z] = -1;
> 	} else {
> 		state->sign[X] = 1;
> 		state->sign[Y] = 1;
> 		state->sign[Z] = 1;
> 	}
> 
> But someone else may like to give their point of view on this change.

Looks like the right tidy up to me.  The original code was 'novel' :)

Jonathan
> 
> > 
> > Thanks for the feedback.
> > --
> > Gustavo  
> 
> Best regards
> Marcus Folkesson
