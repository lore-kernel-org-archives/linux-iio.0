Return-Path: <ao2@ao2.it>
Date: Wed, 29 Apr 2015 13:01:32 +0200
From: Antonio Ospite <ao2@ao2.it>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/3] iio: accel: kxcjk-1013: add the "KXCJ9000" ACPI id
Message-Id: <20150429130132.27d00577390a4f0e37fbe1c9@ao2.it>
In-Reply-To: <1430303320.2525.95.camel@hadess.net>
References: <1430298111-20127-1-git-send-email-ao2@ao2.it>
	<1430298111-20127-2-git-send-email-ao2@ao2.it>
	<1430303320.2525.95.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Wed, 29 Apr 2015 12:28:40 +0200
Bastien Nocera <hadess@hadess.net> wrote:

> On Wed, 2015-04-29 at 11:01 +0200, Antonio Ospite wrote:
> > This id has been seen in the DSTD for the Teclast X98 Air 3G tablet
> 
> DSDT.

Right. Thanks :)

Jonathan, let me know if you want me to resend or if you plan to amend
the commit message yourself.

> > based on Intel Bay Trail.
> > 
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Bastien Nocera <hadess@hadess.net>
> > Cc: linux-iio@vger.kernel.org
> > ---
> >  drivers/iio/accel/kxcjk-1013.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/accel/kxcjk-1013.c 
> > b/drivers/iio/accel/kxcjk-1013.c
> > index 51da369..5b7a860 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -1418,6 +1418,7 @@ static const struct dev_pm_ops 
> > kxcjk1013_pm_ops = {
> >  static const struct acpi_device_id kx_acpi_match[] = {
> >       {"KXCJ1013", KXCJK1013},
> >       {"KXCJ1008", KXCJ91008},
> > +     {"KXCJ9000", KXCJ91008},
> 
> I'm guessing it's not a polling one, right?
>

It's not.

> >       {"KXTJ1009", KXTJ21009},
> >       {"SMO8500",  KXCJ91008},
> >       { },


-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
