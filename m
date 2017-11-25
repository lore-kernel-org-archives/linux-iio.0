Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751716AbdKYOVV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 09:21:21 -0500
Date: Sat, 25 Nov 2017 14:18:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 11/13] iio: health: max30102: Prepare for copying
 varying number of measurements
Message-ID: <20171125141818.5525f3a5@archlinux>
In-Reply-To: <CAJCx=gn9LYzCANjrp1hAVJuMOET8=H+F97Hx2+jENSqTU3=yxg@mail.gmail.com>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
        <1509133543-4597-12-git-send-email-pmeerw@pmeerw.net>
        <CAJCx=gn9LYzCANjrp1hAVJuMOET8=H+F97Hx2+jENSqTU3=yxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 19 Nov 2017 12:52:56 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Fri, Oct 27, 2017 at 12:45 PM, Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
> > Current code assumes always 2 measurements (6 bytes) have to be copied,
> > prepare for more flexibility  
> 
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied.
> 
> >
> > Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  drivers/iio/health/max30102.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> > index 1c7fe63..86058f0 100644
> > --- a/drivers/iio/health/max30102.c
> > +++ b/drivers/iio/health/max30102.c
> > @@ -58,7 +58,7 @@ enum max3012_led_idx {
> >  #define MAX30102_REG_FIFO_OVR_CTR              0x05
> >  #define MAX30102_REG_FIFO_RD_PTR               0x06
> >  #define MAX30102_REG_FIFO_DATA                 0x07
> > -#define MAX30102_REG_FIFO_DATA_ENTRY_LEN       6
> > +#define MAX30102_REG_FIFO_DATA_BYTES           3
> >
> >  #define MAX30102_REG_FIFO_CONFIG               0x08
> >  #define MAX30102_REG_FIFO_CONFIG_AVG_4SAMPLES  BIT(1)
> > @@ -198,6 +198,11 @@ static inline int max30102_fifo_count(struct max30102_data *data)
> >         return 0;
> >  }
> >
> > +#define MAX30102_COPY_DATA(i) \
> > +       memcpy(&data->processed_buffer[(i)], \
> > +              &buffer[(i) * MAX30102_REG_FIFO_DATA_BYTES], \
> > +              MAX30102_REG_FIFO_DATA_BYTES)
> > +
> >  static int max30102_read_measurement(struct max30102_data *data)
> >  {
> >         int ret;
> > @@ -205,13 +210,13 @@ static int max30102_read_measurement(struct max30102_data *data)
> >
> >         ret = i2c_smbus_read_i2c_block_data(data->client,
> >                                             MAX30102_REG_FIFO_DATA,
> > -                                           MAX30102_REG_FIFO_DATA_ENTRY_LEN,
> > +                                           2 * MAX30102_REG_FIFO_DATA_BYTES,
> >                                             buffer);
> >
> > -       memcpy(&data->processed_buffer[0], &buffer[0], 3);
> > -       memcpy(&data->processed_buffer[1], &buffer[3], 3);
> > +       MAX30102_COPY_DATA(0);
> > +       MAX30102_COPY_DATA(1);
> >
> > -       return (ret == MAX30102_REG_FIFO_DATA_ENTRY_LEN) ? 0 : -EINVAL;
> > +       return (ret == 2 * MAX30102_REG_FIFO_DATA_BYTES) ? 0 : -EINVAL;
> >  }
> >
> >  static irqreturn_t max30102_interrupt_handler(int irq, void *private)
> > --
> > 2.7.4
> >  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

