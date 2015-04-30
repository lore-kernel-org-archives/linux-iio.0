Return-Path: <ao2@ao2.it>
Date: Thu, 30 Apr 2015 16:25:52 +0200
From: Antonio Ospite <ao2@ao2.it>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 2/3] iio: accel: kxcjk-1013: rename is_smo8500_device to
 polling_mode
Message-Id: <20150430162552.f42e3caa42a44a7e04204d8e@ao2.it>
In-Reply-To: <CAEnQRZANgZM8in1WS_22Lcpf2oG_8aLO80p__=6CFJBbW2rHKA@mail.gmail.com>
References: <1430298111-20127-1-git-send-email-ao2@ao2.it>
	<1430298111-20127-3-git-send-email-ao2@ao2.it>
	<CAEnQRZANgZM8in1WS_22Lcpf2oG_8aLO80p__=6CFJBbW2rHKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Wed, 29 Apr 2015 18:08:41 +0300
Daniel Baluta <daniel.baluta@gmail.com> wrote:

> On Wed, Apr 29, 2015 at 12:01 PM, Antonio Ospite <ao2@ao2.it> wrote:
> > The purpose of the variable is to remember when an interrupt cannot be
> > requested and hence the driver must work in polling mode, so tell that
> > instead of mentioning the specific case when this is needed.
> >
> > This makes the variable name to be still meaningful when some other
> > devices requiring this show up.
> >
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Bastien Nocera <hadess@hadess.net>
> > Cc: linux-iio@vger.kernel.org
> > ---
> >  drivers/iio/accel/kxcjk-1013.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> > index 5b7a860..eccec0e 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -108,7 +108,7 @@ struct kxcjk1013_data {
> >         bool motion_trigger_on;
> >         int64_t timestamp;
> >         enum kx_chipset chipset;
> > -       bool is_smo8500_device;
> > +       bool polling_mode;
> 
> I would prefer to call this field use_poll, as introduced in:
>
> http://marc.info/?l=linux-iio&m=142980650422289&w=2
>

Looking at it again I realize that the current meaning  of
is_smo8500_device is more like "gpio interrupt not available" rather
than an explicit indication to use polling mode, which right now is a
userspace thing anyway.

It was mainly to prevent error messages being printed in the logs when
trying to getting a gpio descriptor, is that correct Bastien?

> Also use_poll its it's a better suggestion on the type than polling_mode.
> 

Agreed, polling_mode was not the best name.

How about we drop this patch 2/3 altogether for now and I just resend 1
and 3?

Renaming (or even removing) is_smo8500_device can be re-evaluated when
use_poll gets added.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
