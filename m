Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:7274 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752126AbdBTKkL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 05:40:11 -0500
Date: Mon, 20 Feb 2017 11:40:05 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: "Hendrik v. Raven" <hendrik@consetetur.de>
cc: sayli karnik <karniksayli1995@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] Re: [PATCH v2 2/2] staging: iio: ad7152: Use
 GENMASK() macro for left shifts
In-Reply-To: <20170220094845.GA17071@psyche.fritz.box>
Message-ID: <alpine.DEB.2.20.1702201136490.3114@hadrien>
References: <cover.1487483384.git.karniksayli1995@gmail.com> <b74094e5c94e11cad734b1bde11db0356e6d3aab.1487483384.git.karniksayli1995@gmail.com> <20170220094845.GA17071@psyche.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Mon, 20 Feb 2017, Hendrik v. Raven wrote:

> On Mon, Feb 20, 2017 at 01:30:27AM +0530, sayli karnik wrote:
> > Use GENMASK() macro for left shifting integers.
> >
> > Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
> > ---
> > v2:
> > Used GENMASK() macro instead of BIT() macro for multi-bit bitfields.
> > Removed extra parentheses around argument to macro
> >
> >  drivers/staging/iio/cdc/ad7152.c | 32 ++++++++++++++++----------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> > index e8609b8..ab94fad 100644
> > --- a/drivers/staging/iio/cdc/ad7152.c
> > +++ b/drivers/staging/iio/cdc/ad7152.c
> > @@ -47,28 +47,28 @@
> >  #define AD7152_STATUS_PWDN		BIT(7)
> >
> >  /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
> > -#define AD7152_SETUP_CAPDIFF		(1 << 5)
> > -#define AD7152_SETUP_RANGE_2pF		(0 << 6)
> > -#define AD7152_SETUP_RANGE_0_5pF	(1 << 6)
> > -#define AD7152_SETUP_RANGE_1pF		(2 << 6)
> > -#define AD7152_SETUP_RANGE_4pF		(3 << 6)
> > -#define AD7152_SETUP_RANGE(x)		((x) << 6)
> > +#define AD7152_SETUP_CAPDIFF		GENMASK(1, 5)
> > +#define AD7152_SETUP_RANGE_2pF		GENMASK(0, 6)
> > +#define AD7152_SETUP_RANGE_0_5pF	GENMASK(1, 6)
> > +#define AD7152_SETUP_RANGE_1pF		GENMASK(2, 6)
> > +#define AD7152_SETUP_RANGE_4pF		GENMASK(3, 6)
> > +#define AD7152_SETUP_RANGE(x)		GENMASK(x, 6)
> I am a bit confused about the usage of GENMASK here. Unless I completely
> misunderstand the macro these are not at all equivalent to the previous
> bitshifts as most of them just expand to 0.

Indeed.  Sorry not to have been more attentive.  The comment before the
definition of GENMASK says:

 /*
  * Create a contiguous bitmask starting at bit position @l and ending at
  * position @h. For example
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */

Here is an example of a commit that converts BIT calls to use GENMASK:

408fec3ff8

But it doesn't seem very convenient for the code modified here.

julia

>
> >  /* Config Register Bit Designations (AD7152_REG_CFG) */
> > -#define AD7152_CONF_CH2EN		(1 << 3)
> > -#define AD7152_CONF_CH1EN		(1 << 4)
> > -#define AD7152_CONF_MODE_IDLE		(0 << 0)
> > -#define AD7152_CONF_MODE_CONT_CONV	(1 << 0)
> > -#define AD7152_CONF_MODE_SINGLE_CONV	(2 << 0)
> > -#define AD7152_CONF_MODE_OFFS_CAL	(5 << 0)
> > -#define AD7152_CONF_MODE_GAIN_CAL	(6 << 0)
> > +#define AD7152_CONF_CH2EN		GENMASK(1, 3)
> > +#define AD7152_CONF_CH1EN		GENMASK(1, 4)
> > +#define AD7152_CONF_MODE_IDLE		GENMASK(0, 0)
> > +#define AD7152_CONF_MODE_CONT_CONV	GENMASK(1, 0)
> > +#define AD7152_CONF_MODE_SINGLE_CONV	GENMASK(2, 0)
> > +#define AD7152_CONF_MODE_OFFS_CAL	GENMASK(5, 0)
> > +#define AD7152_CONF_MODE_GAIN_CAL	GENMASK(6, 0)
> >
> >  /* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
> > -#define AD7152_CAPDAC_DACEN		(1 << 7)
> > -#define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
> > +#define AD7152_CAPDAC_DACEN		GENMASK(1, 7)
> same here
> > +#define AD7152_CAPDAC_DACP(x)		GENMASK(x, 0x1F)
> this is more something like ((x) & GENMASK(5,0)).
>
> >  /* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
> > -#define AD7152_CFG2_OSR(x)		(((x) & 0x3) << 4)
> > +#define AD7152_CFG2_OSR(x)		GENMASK((x) & 0x3, 4)
> >
> >  enum {
> >  	AD7152_DATA,
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170220094845.GA17071%40psyche.fritz.box.
> For more options, visit https://groups.google.com/d/optout.
>
