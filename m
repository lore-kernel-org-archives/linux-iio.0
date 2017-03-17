Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35878 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdCQJd2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2017 05:33:28 -0400
MIME-Version: 1.0
In-Reply-To: <6e55c61d-7587-4191-1fc5-de43e26986d7@metafoo.de>
References: <20170312133250.GA7772@singhal-Inspiron-5558> <6e55c61d-7587-4191-1fc5-de43e26986d7@metafoo.de>
From: Gargi Sharma <gs051095@gmail.com>
Date: Fri, 17 Mar 2017 15:02:56 +0530
Message-ID: <CAOCi2DH8xVeD8_sZtxg9jqaF_29D9zEQSBR8-pYNRAbnmESNyQ@mail.gmail.com>
Subject: Re: [Outreachy kernel] Re: [PATCH] staging: iio: ade7753: replace
 mlock with driver private lock
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: simran singhal <singhalsimran0@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Pete Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 13, 2017 at 5:30 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 03/12/2017 02:32 PM, simran singhal wrote:
> > The IIO subsystem is redefining iio_dev->mlock to be used by
> > the IIO core only for protecting device operating mode changes.
> > ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> >
> > In this driver, mlock was being used to protect hardware state
> > changes.  Replace it with a lock in the devices global data.
> >
> > Fix some coding style issues related to white space also.
> >
> > Signed-off-by: simran singhal <singhalsimran0@gmail.com>
> > ---
> >  drivers/staging/iio/meter/ade7753.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> > index dfd8b71..ca99d82 100644
> > --- a/drivers/staging/iio/meter/ade7753.c
> > +++ b/drivers/staging/iio/meter/ade7753.c
> > @@ -81,12 +81,14 @@
> >   * @tx:         transmit buffer
> >   * @rx:         receive buffer
> >   * @buf_lock:       mutex to protect tx and rx
> > + * @lock:    protect sensor state
>
> It might make sense to reuse the existing lock which currently protects the
> read/write functions. You can do this by introducing a variant of
> ade7753_spi_{read,write}_reg_16() that does not take a lock and use these to
> implement the read-modify-write cycle in a protected section.

There are other read/write functions for example,
ade7753_spi_{read/write}_reg_8 that use the mutex as well. Should a
variant of these functions be introduced as well? Also, how does one
go about implementing RMW inside a protected section.


>
> Looking through the driver there seem to be other places as well that do
> read-modify-write that should be protected by a lock, but currently are not.
> This might be a good task.

Am I right in understanding that we want to introduce mutex lock for
writes in other drivers as well?

Thanks,
Gargi
>
> >   **/
> >  struct ade7753_state {
> > -         struct spi_device   *us;
> > -                 struct mutex        buf_lock;
> > -                         u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
> > -                                 u8          rx[ADE7753_MAX_RX];
> > +     struct spi_device   *us;
> > +     struct mutex        buf_lock;
> > +     struct mutex        lock;       /* protect sensor state */
> > +     u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
> > +     u8          rx[ADE7753_MAX_RX];
> >  };
> >
> >  static int ade7753_spi_write_reg_8(struct device *dev,
> > @@ -484,7 +486,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
> >       if (!val)
> >               return -EINVAL;
> >
> > -     mutex_lock(&indio_dev->mlock);
> > +     mutex_lock(&st->lock);
> >
> >       t = 27900 / val;
> >       if (t > 0)
> > @@ -505,7 +507,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
> >       ret = ade7753_spi_write_reg_16(dev, ADE7753_MODE, reg);
> >
> >  out:
> > -     mutex_unlock(&indio_dev->mlock);
> > +     mutex_unlock(&st->lock);
> >
> >       return ret ? ret : len;
> >  }
> >
>
> --
