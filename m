Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:60282 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbaKWWQQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 23 Nov 2014 17:16:16 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so3979602wiv.6
        for <linux-iio@vger.kernel.org>; Sun, 23 Nov 2014 14:16:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54725879.6030602@gmx.de>
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
	<1416246966-3083-3-git-send-email-octavian.purdila@intel.com>
	<54725879.6030602@gmx.de>
Date: Mon, 24 Nov 2014 00:16:15 +0200
Message-ID: <CAE1zotKbN_cL+Z4d0Q1eLZY7NfZeB5qwHebEsTCycAZJv76gSQ@mail.gmail.com>
Subject: Re: [RFC 2/8] iio: bmc150: refactor slope duration and threshold update
From: Octavian Purdila <octavian.purdila@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Nov 23, 2014 at 11:58 PM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>
> Octavian Purdila schrieb am 17.11.2014 18:56:
> > Move the slope duration and threshold update in separate functions
> > to reduce code duplicate between chip init and motion interrupt setup.
> >
> > The patch also moves the update from the motion interrupt setup
> > function to the write event function so that we can later refactor the
> > interrupt code.
> >
> > Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> > ---
> >  drivers/iio/accel/bmc150-accel.c | 109 ++++++++++++++++++++++-----------------
> >  1 file changed, 62 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> > index 22c096c..5bfb09d 100644
> > --- a/drivers/iio/accel/bmc150-accel.c
> > +++ b/drivers/iio/accel/bmc150-accel.c
> > @@ -266,6 +266,51 @@ static int bmc150_accel_set_bw(struct bmc150_accel_data *data, int val,
> >       return -EINVAL;
> >  }
> >
> > +static int bmc150_accel_update_slope_threshold(struct bmc150_accel_data *data,
> > +                                            int val)
> > +{
> > +     int ret = 0;
> > +
> > +     val &= 0xFF;
> > +
> > +     ret = i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_6,
> > +                                     val);
> > +     if (ret < 0) {
> > +             dev_err(&data->client->dev, "Error writing reg_int_6\n");
> > +             return ret;
> > +     }
> > +     data->slope_thres = val;
> > +
> > +     dev_dbg(&data->client->dev, "%s: %x\n", __func__, val);
> > +
> > +     return ret;
> > +}
> > +
> > +static int bmc150_accel_update_slope_duration(struct bmc150_accel_data *data,
> > +                                           int val)
> > +{
> > +     int ret;
> > +
> > +     val &= BMC150_ACCEL_SLOPE_DUR_MASK;
> > +
> > +     ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_INT_5);
> > +     if (ret < 0) {
> > +             dev_err(&data->client->dev, "Error reading reg_int_5\n");
> > +             return ret;
> > +     }
> > +     ret = i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_5,
> > +                                     val | ret);
> You will have more joy if you clear the appropriate bits in ret before setting new ones.

Yes, Daniel caught as well. I will fix it in v2.
