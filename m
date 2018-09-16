Return-Path: <SRS0=uMcX=L6=gmail.com=natechancellor@kernel.org>
Date: Sun, 16 Sep 2018 08:15:13 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] iio: adc: max9611: Avoid implicit enum conversion warning
Message-ID: <20180916151513.GA10200@flashbox>
References: <20180915052511.2243-1-natechancellor@gmail.com>
 <20180916105351.1bf859ee@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180916105351.1bf859ee@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Sep 16, 2018 at 10:53:51AM +0100, Jonathan Cameron wrote:
> On Fri, 14 Sep 2018 22:25:11 -0700
> Nathan Chancellor <natechancellor@gmail.com> wrote:
> 
> > Clang warns when an enumerated type is implicitly converted to another.
> > 
> > drivers/iio/adc/max9611.c:292:16: warning: implicit conversion from
> > enumeration type 'enum max9611_conf_ids' to different enumeration type
> > 'enum max9611_csa_gain' [-Wenum-conversion]
> >                         *csa_gain = gain_selectors[i];
> >                                   ~ ^~~~~~~~~~~~~~~~~
> > 1 warning generated.
> > 
> > Change the type of the variable 'gain_selectors' to int so that Clang
> > understands this is expected behavior.
> > 
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> How does this interact with the patch that Stefan Agner sent for
> the same issue last week?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=b1ec0802503820ccbc894aadfd2a44da20232f5e
> 
> Thanks,
> 
> Jonathan
> 

Hi Jonathan,

Sorry for the overlap. My patch is not necessary. I was working off
of linux-next so I didn't catch this. I'll be better about checking
maintainer trees before sending patches in the future.

Thanks for the quick response!
Nathan

> > ---
> >  drivers/iio/adc/max9611.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > index 0538ff8c4ac1..3c358b16a8fa 100644
> > --- a/drivers/iio/adc/max9611.c
> > +++ b/drivers/iio/adc/max9611.c
> > @@ -275,7 +275,7 @@ static int max9611_read_csa_voltage(struct max9611_dev *max9611,
> >  				    u16 *adc_raw,
> >  				    enum max9611_csa_gain *csa_gain)
> >  {
> > -	enum max9611_conf_ids gain_selectors[] = {
> > +	int gain_selectors[] = {
> >  		CONF_SENSE_1x,
> >  		CONF_SENSE_4x,
> >  		CONF_SENSE_8x
> 
