Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45336 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbdICMCm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Sep 2017 08:02:42 -0400
Date: Sun, 3 Sep 2017 13:02:40 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/7] iio: accel: kxcjk1013: make
 sysfs/sampling_frequency_avail dynamic
Message-ID: <20170903130240.4de58630@archlinux>
In-Reply-To: <20170903125828.6dbca272@archlinux>
References: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
        <a8aa4077637a133a950b436d47b0eef7d22accef.1503352742.git.mirq-linux@rere.qmqm.pl>
        <20170903125828.6dbca272@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 3 Sep 2017 12:58:28 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 22 Aug 2017 00:03:32 +0200
> Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:
> 
> > In preparation for KXTF9 support, make sampling_frequency_avail
> > attribute dynamic.
> > 
> > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>  
> 
> This looks fine,
> 

Actually I would like one really small change...

> Jonathan
> 
> > ---
> >  drivers/iio/accel/kxcjk-1013.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> > index 252004640403..11bf9afbd248 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -155,6 +155,9 @@ static const struct kx_odr_map samp_freq_table[] = {
> >  	{ 1600, 0, 0x07, 0x06 },
> >  };
> >  
> > +static const char *const samp_freq_avail =
> > +	"0.781000 1.563000 3.125000 6.250000 12.500000 25 50 100 200 400 800 1600";
> > +

I'd like this prefixed with one of the supported parts to avoid a potential name
clash down the line (and because it looks weird in patch 7 ;)

Jonathan

> >  /* Refer to section 4 of the specification */
> >  static const struct {
> >  	int odr_bits;
> > @@ -879,13 +882,19 @@ static int kxcjk1013_buffer_postdisable(struct iio_dev *indio_dev)
> >  	return kxcjk1013_set_power_state(data, false);
> >  }
> >  
> > -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
> > -	"0.781000 1.563000 3.125000 6.250000 12.500000 25 50 100 200 400 800 1600");
> > +static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
> > +					     struct device_attribute *attr,
> > +					     char *buf)
> > +{
> > +	return sprintf(buf, "%s\n", samp_freq_avail);
> > +}
> > +
> > +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(kxcjk1013_get_samp_freq_avail);
> >  
> >  static IIO_CONST_ATTR(in_accel_scale_available, "0.009582 0.019163 0.038326");
> >  
> >  static struct attribute *kxcjk1013_attributes[] = {
> > -	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> >  	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
> >  	NULL,
> >  };  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

