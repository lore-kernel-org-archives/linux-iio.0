Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41804 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbbJKOnQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2015 10:43:16 -0400
Subject: Re: [PATCH 3/6] iio:dac:m62332: use ARRAY_SIZE
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
 <20f1a555b8a1d2f7967041de85ee4335b1ff549d.1440459082.git.knaack.h@gmx.de>
 <CAEnQRZDnFUKpRNS0Qs+cg0dhnp3Uy==pZ8qp6wss=U8B_yn5LQ@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561A7583.3070709@kernel.org>
Date: Sun, 11 Oct 2015 15:43:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZDnFUKpRNS0Qs+cg0dhnp3Uy==pZ8qp6wss=U8B_yn5LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/08/15 13:58, Daniel Baluta wrote:
> On Sat, Aug 29, 2015 at 12:59 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>> Make use of ARRAY_SIZE to prevent buffer issues.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git - pushed out as testing
for now.

J
> 
>> ---
>>  drivers/iio/dac/m62332.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
>> index c61720de8606..fe750982b502 100644
>> --- a/drivers/iio/dac/m62332.c
>> +++ b/drivers/iio/dac/m62332.c
>> @@ -62,8 +62,8 @@ static int m62332_set_value(struct iio_dev *indio_dev,
>>                         goto out;
>>         }
>>
>> -       res = i2c_master_send(client, outbuf, 2);
>> -       if (res >= 0 && res != 2)
>> +       res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
>> +       if (res >= 0 && res != ARRAY_SIZE(outbuf))
>>                 res = -EIO;
>>         if (res < 0)
>>                 goto out;
>> @@ -212,7 +212,7 @@ static int m62332_probe(struct i2c_client *client,
>>         /* establish that the iio_dev is a child of the i2c device */
>>         indio_dev->dev.parent = &client->dev;
>>
>> -       indio_dev->num_channels = M62332_CHANNELS;
>> +       indio_dev->num_channels = ARRAY_SIZE(m62332_channels);
>>         indio_dev->channels = m62332_channels;
>>         indio_dev->modes = INDIO_DIRECT_MODE;
>>         indio_dev->info = &m62332_info;
>> --
>> 2.4.6
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

