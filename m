Return-Path: <pmeerw@pmeerw.net>
Date: Sat, 19 Dec 2015 17:35:43 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: SF Markus Elfring <elfring@users.sourceforge.net>,
    linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio-light: Use a signed return type for
 ltr501_match_samp_freq()
In-Reply-To: <56757198.6020001@kernel.org>
Message-ID: <alpine.DEB.2.02.1512191734300.3182@pmeerw.net>
References: <56755A4D.7000406@users.sourceforge.net> <56757198.6020001@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Sat, 19 Dec 2015, Jonathan Cameron wrote:

> On 19/12/15 13:23, SF Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sat, 19 Dec 2015 14:14:54 +0100
> > 
> > The return type "unsigned int" was used by the ltr501_match_samp_freq()
> > function despite of the aspect that it will eventually return a negative
> > error code.
> > Improve this implementation detail by deletion of the type modifier then.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Applied to the fixes-togreg branch of iio.git and marked for stable.
> 
> Peter, I'll probably hold this locally for a few days anyway as Greg
> hasn't picked up the previous pull request yet. So if you want
> to add anything give me a shout.

looks good
Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
 
> Jonathan
> > ---
> >  drivers/iio/light/ltr501.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> > index 809a961..6bf89d8 100644
> > --- a/drivers/iio/light/ltr501.c
> > +++ b/drivers/iio/light/ltr501.c
> > @@ -180,7 +180,7 @@ static const struct ltr501_samp_table ltr501_ps_samp_table[] = {
> >  			{500000, 2000000}
> >  };
> >  
> > -static unsigned int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
> > +static int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
> >  					   int len, int val, int val2)
> >  {
> >  	int i, freq;
> > 
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
