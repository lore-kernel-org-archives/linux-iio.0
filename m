Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33376 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbbHDUf7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 16:35:59 -0400
Received: by ioii16 with SMTP id i16so29380249ioi.0
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2015 13:35:58 -0700 (PDT)
Date: Tue, 4 Aug 2015 13:35:38 -0700
From: Tristan Lelong <tristan@lelong.xyz>
To: Matt Ranostay <mranostay@gmail.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: proximity: add support for PulsedLight LIDAR
Message-ID: <20150804203537.GA22584@localhost.localdomain>
References: <1438576076-7890-1-git-send-email-mranostay@gmail.com>
 <1438576076-7890-3-git-send-email-mranostay@gmail.com>
 <alpine.DEB.2.02.1508030847190.30782@pmeerw.net>
 <CAKzfze9ogwcNDw2P4WO1WefTJEuze+zkWVUGPCeFLhQrE6nb=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKzfze9ogwcNDw2P4WO1WefTJEuze+zkWVUGPCeFLhQrE6nb=g@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 03, 2015 at 01:21:08AM -0700, Matt Ranostay wrote:
> On Sun, Aug 2, 2015 at 11:48 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> > On Sun, 2 Aug 2015, Matt Ranostay wrote:
> >
> >> +
> >> +static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
> >> +{
> >> +     struct i2c_client *client = data->client;
> >> +     int tries = 10;
> >> +     int ret;
> >> +
> >> +     /* start sample */
> >> +     ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
> >> +     if (ret < 0) {
> >> +             dev_err(&client->dev, "cannot send start measurement command");
> >> +             return ret;
> >> +     }
> >> +
> >> +     while (tries--) {
> >> +             usleep_range(1000, 2000);
> >> +
> >> +             ret = lidar_read_byte(data, LIDAR_REG_STATUS);
> >> +             if (ret < 0)
> >> +                     break;
> >> +
> >> +             /* return 0 since laser is likely pointed out of range */
> >> +             if (ret & LIDAR_REG_STATUS_INVALID) {
> >> +                     *reg = 0;
> >> +                     ret = 0;
> >> +                     break;
> >> +             }
> >> +
> >> +             /* sample ready to read */
> >> +             if (!(ret & LIDAR_REG_STATUS_READY)) {
> >> +                     ret = lidar_read_measurement(data, reg);
> >> +                     break;
> >> +             }
> >> +     }
> >> +
> >
> > what happens when the timeout occurs?
> > no error code is set
> 
> Ah yes it should return an error code.  Would a -EIO be a logical choice?
> 

I would think -ETIMEDOUT to make more sense here.
