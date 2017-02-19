Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37327 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdBSL7A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 06:59:00 -0500
Subject: Re: [PATCH 3/8] iio: cio-dac: Set parent device
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de>
 <1486816461-28618-4-git-send-email-lars@metafoo.de>
 <20170211125950.GC31343@sophia>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d19f1483-7686-1881-dc31-75f7acb957a1@kernel.org>
Date: Sun, 19 Feb 2017 11:58:58 +0000
MIME-Version: 1.0
In-Reply-To: <20170211125950.GC31343@sophia>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/02/17 12:59, William Breathitt Gray wrote:
> On Sat, Feb 11, 2017 at 01:34:16PM +0100, Lars-Peter Clausen wrote:
>> Initialize the parent of the IIO device to the device that registered it.
>> This makes sure that the IIO device appears the right level in the device
>> hierarchy.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>> drivers/iio/dac/cio-dac.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
>> index 5a743e2..a046422 100644
>> --- a/drivers/iio/dac/cio-dac.c
>> +++ b/drivers/iio/dac/cio-dac.c
>> @@ -119,6 +119,7 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
>> 	indio_dev->channels = cio_dac_channels;
>> 	indio_dev->num_channels = CIO_DAC_NUM_CHAN;
>> 	indio_dev->name = dev_name(dev);
>> +	indio_dev->dev.parent = dev;
>>
>> 	priv = iio_priv(indio_dev);
>> 	priv->base = base[id];
>> -- 
>> 2.1.4
>>
> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with.

Thanks,

Jonathan
