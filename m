Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:34227
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751038AbdILSGs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Sep 2017 14:06:48 -0400
Date: Tue, 12 Sep 2017 20:06:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: himanshi <himshijain.hj@gmail.com>
cc: Daniel Baluta <daniel.baluta@gmail.com>,
        outreachy-kernel <outreachy-kernel@googlegroups.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        driverdev <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nick.desaulniers@gmail.com
Subject: Re: [Outreachy kernel] [PATCH] Fixed IIO_DEVICE_ATTR_NAMED API to
 take name as a string and added "" around names
In-Reply-To: <20170912180132.GB4607@himanshi-Inspiron-5558>
Message-ID: <alpine.DEB.2.20.1709122004550.3149@hadrien>
References: <20170911224348.GA13259@himanshi-Inspiron-5558> <CAEnQRZDgXj85OTQAoEpij_3bSUnmcx1owNyeg10WCmiBGURURg@mail.gmail.com> <20170912180132.GB4607@himanshi-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Tue, 12 Sep 2017, himanshi wrote:

> Thanks for the review Daniel! I will change the imperative mood for the commit
> message once the other changes are finalised too and as suggested by Julia,
> would try to make the description specific than general.
>
> I tried to think of adding subsystem to the commit subject but could not
> conclude any because of the files involved.
> I like the idea of splitting the patch into 2 as you suggested but I
> have a doubt that adding the new MACROS to different sysfs files can be put into 1
> patch with the subsystem you mentioned but changing the existing
> IIO_DEVICE_ATTR_NAMED to use IIO_ATTR_NAMED (sysfs file again) would be included
> in the second patch if I am not wrong. So would it be fine to keep the
> subsystem as iio for the second patch?

Indeed, the kernel has to compile after every commit.  Unless you change
the name of the macro, to allow the old and new versions to co-exist, it
seems hard to break up such a patch.

julia

>
> On Tue, Sep 12, 2017 at 10:53:26AM +0300, Daniel Baluta wrote:
> > Hi Himanshi,
> >
> > On Tue, Sep 12, 2017 at 1:43 AM, Himanshi Jain <himshijain.hj@gmail.com> wrote:
> > > Fixed IIO_DEVICE_ATTR_NAMED API to take name as a
> > > string instead of implicit conversion to string using
> > > preprocessors. Added double quotes around names in
> > > existing usage of IIO_DEVICE_ATTR_NAMED.
> >
> > Always use imperative mood in commit subject (Fix instead of Fixed).
> >
> > The subject should contain a tag, which describes the subsytem/files affected.
> >
> > I would split this patch into:
> >
> > 1) sysfs: iio: Introduce *_ATTR_NAMED
> >
> > and explain here why do we need  __ATTR_NAMED and IIO_ATTR_NAMED
> >
> > 2) iio: Use new IIO_DEVICE_ATTR_NAMED API
> >
> > But of course, lets wait to see Lars and Jonathan's opinions.
> > thanks,
> > Daniel.
> >
> > >
> > > Signed-off-by: Himanshi Jain <himshijain.hj@gmail.com>
> > > ---
> > >  drivers/iio/adc/ad7793.c          | 2 +-
> > >  drivers/staging/iio/adc/ad7192.c  | 2 +-
> > >  drivers/staging/iio/adc/ad7280a.c | 4 ++--
> > >  include/linux/iio/sysfs.h         | 6 +++++-
> > >  include/linux/sysfs.h             | 7 +++++++
> > >  5 files changed, 16 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> > > index e6706a0..d74e324 100644
> > > --- a/drivers/iio/adc/ad7793.c
> > > +++ b/drivers/iio/adc/ad7793.c
> > > @@ -420,7 +420,7 @@ static ssize_t ad7793_show_scale_available(struct device *dev,
> > >  }
> > >
> > >  static IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available,
> > > -               in_voltage-voltage_scale_available, S_IRUGO,
> > > +               "in_voltage-voltage_scale_available", S_IRUGO,
> > >                 ad7793_show_scale_available, NULL, 0);
> > >
> > >  static struct attribute *ad7793_attributes[] = {
> > > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > > index d11c6de..daff38c 100644
> > > --- a/drivers/staging/iio/adc/ad7192.c
> > > +++ b/drivers/staging/iio/adc/ad7192.c
> > > @@ -341,7 +341,7 @@ static int ad7192_setup(struct ad7192_state *st,
> > >  }
> > >
> > >  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> > > -                            in_voltage-voltage_scale_available,
> > > +                            "in_voltage-voltage_scale_available",
> > >                              0444, ad7192_show_scale_available, NULL, 0);
> > >
> > >  static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
> > > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > > index f85dde9..fd32e9a 100644
> > > --- a/drivers/staging/iio/adc/ad7280a.c
> > > +++ b/drivers/staging/iio/adc/ad7280a.c
> > > @@ -750,14 +750,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
> > >  }
> > >
> > >  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> > > -               in_voltage-voltage_thresh_low_value,
> > > +               "in_voltage-voltage_thresh_low_value",
> > >                 0644,
> > >                 ad7280_read_channel_config,
> > >                 ad7280_write_channel_config,
> > >                 AD7280A_CELL_UNDERVOLTAGE);
> > >
> > >  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> > > -               in_voltage-voltage_thresh_high_value,
> > > +               "in_voltage-voltage_thresh_high_value",
> > >                 0644,
> > >                 ad7280_read_channel_config,
> > >                 ad7280_write_channel_config,
> > > diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
> > > index ce9426c..49c81a4 100644
> > > --- a/include/linux/iio/sysfs.h
> > > +++ b/include/linux/iio/sysfs.h
> > > @@ -55,6 +55,10 @@ struct iio_const_attr {
> > >         { .dev_attr = __ATTR(_name, _mode, _show, _store),      \
> > >           .address = _addr }
> > >
> > > +#define IIO_ATTR_NAMED(_name, _mode, _show, _store, _addr)             \
> > > +       { .dev_attr = __ATTR_NAMED(_name, _mode, _show, _store),        \
> > > +         .address = _addr }
> > > +
> > >  #define IIO_ATTR_RO(_name, _addr)       \
> > >         { .dev_attr = __ATTR_RO(_name), \
> > >           .address = _addr }
> > > @@ -85,7 +89,7 @@ struct iio_const_attr {
> > >
> > >  #define IIO_DEVICE_ATTR_NAMED(_vname, _name, _mode, _show, _store, _addr) \
> > >         struct iio_dev_attr iio_dev_attr_##_vname                       \
> > > -       = IIO_ATTR(_name, _mode, _show, _store, _addr)
> > > +       = IIO_ATTR_NAMED(_name, _mode, _show, _store, _addr)
> > >
> > >  #define IIO_CONST_ATTR(_name, _string)                                 \
> > >         struct iio_const_attr iio_const_attr_##_name                    \
> > > diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> > > index aa02c32..20321cf 100644
> > > --- a/include/linux/sysfs.h
> > > +++ b/include/linux/sysfs.h
> > > @@ -104,6 +104,13 @@ struct attribute_group {
> > >         .store  = _store,                                               \
> > >  }
> > >
> > > +#define __ATTR_NAMED(_name, _mode, _show, _store) {                    \
> > > +       .attr = {.name = _name,                                         \
> > > +                .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },             \
> > > +       .show = _show,                                                  \
> > > +       .store = _store,                                                \
> > > +}
> > > +
> > >  #define __ATTR_PREALLOC(_name, _mode, _show, _store) {                 \
> > >         .attr = {.name = __stringify(_name),                            \
> > >                  .mode = SYSFS_PREALLOC | VERIFY_OCTAL_PERMISSIONS(_mode) },\
> > > --
> > > 1.9.1
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170911224348.GA13259%40himanshi-Inspiron-5558.
> > > For more options, visit https://groups.google.com/d/optout.
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170912180132.GB4607%40himanshi-Inspiron-5558.
> For more options, visit https://groups.google.com/d/optout.
>
