Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:36372 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbbHEBpY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 21:45:24 -0400
Received: by labgo9 with SMTP id go9so18998339lab.3
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2015 18:45:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150804203537.GA22584@localhost.localdomain>
References: <1438576076-7890-1-git-send-email-mranostay@gmail.com>
	<1438576076-7890-3-git-send-email-mranostay@gmail.com>
	<alpine.DEB.2.02.1508030847190.30782@pmeerw.net>
	<CAKzfze9ogwcNDw2P4WO1WefTJEuze+zkWVUGPCeFLhQrE6nb=g@mail.gmail.com>
	<20150804203537.GA22584@localhost.localdomain>
Date: Tue, 4 Aug 2015 18:45:22 -0700
Message-ID: <CAKzfze8uxGRv=GuTLYCDbZqw4yzF=V1935jfeM8M96sN7T-Oww@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: proximity: add support for PulsedLight LIDAR
From: Matt Ranostay <mranostay@gmail.com>
To: Tristan Lelong <tristan@lelong.xyz>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 4, 2015 at 1:35 PM, Tristan Lelong <tristan@lelong.xyz> wrote:
> On Mon, Aug 03, 2015 at 01:21:08AM -0700, Matt Ranostay wrote:
>> On Sun, Aug 2, 2015 at 11:48 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>> > On Sun, 2 Aug 2015, Matt Ranostay wrote:
>> >
>> >> +
>> >> +static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>> >> +{
>> >> +     struct i2c_client *client = data->client;
>> >> +     int tries = 10;
>> >> +     int ret;
>> >> +
>> >> +     /* start sample */
>> >> +     ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
>> >> +     if (ret < 0) {
>> >> +             dev_err(&client->dev, "cannot send start measurement command");
>> >> +             return ret;
>> >> +     }
>> >> +
>> >> +     while (tries--) {
>> >> +             usleep_range(1000, 2000);
>> >> +
>> >> +             ret = lidar_read_byte(data, LIDAR_REG_STATUS);
>> >> +             if (ret < 0)
>> >> +                     break;
>> >> +
>> >> +             /* return 0 since laser is likely pointed out of range */
>> >> +             if (ret & LIDAR_REG_STATUS_INVALID) {
>> >> +                     *reg = 0;
>> >> +                     ret = 0;
>> >> +                     break;
>> >> +             }
>> >> +
>> >> +             /* sample ready to read */
>> >> +             if (!(ret & LIDAR_REG_STATUS_READY)) {
>> >> +                     ret = lidar_read_measurement(data, reg);
>> >> +                     break;
>> >> +             }
>> >> +     }
>> >> +
>> >
>> > what happens when the timeout occurs?
>> > no error code is set
>>
>> Ah yes it should return an error code.  Would a -EIO be a logical choice?
>>
>
> I would think -ETIMEDOUT to make more sense here.

Isn't that more applicable for a networking driver to use?
