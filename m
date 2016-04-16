Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:18537 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbcDPJs4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 05:48:56 -0400
Date: Sat, 16 Apr 2016 12:48:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Slawomir Stepien <sst@poczta.fm>
Cc: Matt Ranostay <mranostay@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 01/10] iio: light apds9960: fix wrong use of brace
Message-ID: <20160416094839.GF4298@mwanda>
References: <1460662602-2951-1-git-send-email-sst@poczta.fm>
 <1460662602-2951-2-git-send-email-sst@poczta.fm>
 <CAKzfze8PtR559e2gjbWnZ=KHqETKr56tYUAyH7kJxwfQi=5tFg@mail.gmail.com>
 <20160415145641.GA19346@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160415145641.GA19346@x220.localdomain>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Apr 15, 2016 at 04:56:41PM +0200, Slawomir Stepien wrote:
> On Apr 14, 2016 16:29, Matt Ranostay wrote:
> > On Thu, Apr 14, 2016 at 12:36 PM, Slawomir Stepien <sst@poczta.fm> wrote:
> > > This fixes the error reported by checkpatch.pl:
> > >
> > > ERROR: that open brace { should be on the previous line
> > >
> > > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> > > ---
> > >  drivers/iio/light/apds9960.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> > > index a6af56a..ade18aa 100644
> > > --- a/drivers/iio/light/apds9960.c
> > > +++ b/drivers/iio/light/apds9960.c
> > > @@ -321,8 +321,12 @@ static const struct iio_chan_spec apds9960_channels[] = {
> > >  };
> > >
> > >  /* integration time in us */
> > > -static const int apds9960_int_time[][2] =
> > > -       { {28000, 246}, {100000, 219}, {200000, 182}, {700000, 0} };
> > > +static const int apds9960_int_time[][2] = {
> > > +       { 28000, 246},
> > > +       {100000, 219},
> > > +       {200000, 182},
> > > +       {700000,   0}
> > Extra space between the comma and zero. Or was this intended for alignment?
> 
> Just for alignment. Are you OK with that?

Yeah.  Looks fine.

regards,
dan carpenter

