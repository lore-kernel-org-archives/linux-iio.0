Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35809 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbcENRui (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2016 13:50:38 -0400
Subject: Re: [PATCH] iio: light apds9960: Add the missing dev.parent
To: Matt Ranostay <mranostay@gmail.com>, Yong Li <sdliyong@gmail.com>
References: <1462435849-23364-1-git-send-email-sdliyong@gmail.com>
 <CAKzfze-JO0+D9NW8q-JS=v+=7jnMp-rYsZXk3hD28PXvX_D5mw@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	fengguang.wu@intel.com, Slawomir Stepien <sst@poczta.fm>,
	dan.carpenter@oracle.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d37ae36a-25cb-bca9-ed5f-588013085ea8@kernel.org>
Date: Sat, 14 May 2016 18:50:32 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze-JO0+D9NW8q-JS=v+=7jnMp-rYsZXk3hD28PXvX_D5mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/16 09:18, Matt Ranostay wrote:
> Reviewed-By: Matt Ranostay <mranostay@gmail.com>
> 
> On Thu, May 5, 2016 at 1:10 AM, Yong Li <sdliyong@gmail.com> wrote:
>> Without this, the iio:deviceX is missing in the /sys/bus/i2c/devices/0-0039
>>
>> Signed-off-by: Yong Li <sdliyong@gmail.com>
Applied and marked for stable.
I'd added a brief note that some userspace code may expect this path to work
to justify the stable tag.

Thanks,

Jonathan
>> ---
>>  drivers/iio/light/apds9960.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
>> index 35928fb..f47cc0a 100644
>> --- a/drivers/iio/light/apds9960.c
>> +++ b/drivers/iio/light/apds9960.c
>> @@ -1010,6 +1010,7 @@ static int apds9960_probe(struct i2c_client *client,
>>
>>         iio_device_attach_buffer(indio_dev, buffer);
>>
>> +       indio_dev->dev.parent = &client->dev;
>>         indio_dev->info = &apds9960_info;
>>         indio_dev->name = APDS9960_DRV_NAME;
>>         indio_dev->channels = apds9960_channels;
>> --
>> 2.5.0
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

