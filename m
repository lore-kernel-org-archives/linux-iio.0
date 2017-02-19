Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37312 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbdBSL4C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 06:56:02 -0500
Subject: Re: [PATCH 1/8] iio: stx104: Set parent device
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de>
 <1486816461-28618-2-git-send-email-lars@metafoo.de>
 <20170211125833.GA31343@sophia>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bde4803e-fdcf-e29d-4c33-db539217d0c4@kernel.org>
Date: Sun, 19 Feb 2017 11:55:58 +0000
MIME-Version: 1.0
In-Reply-To: <20170211125833.GA31343@sophia>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/02/17 12:58, William Breathitt Gray wrote:
> On Sat, Feb 11, 2017 at 01:34:14PM +0100, Lars-Peter Clausen wrote:
>> Initialize the parent of the IIO device to the device that registered it.
>> This makes sure that the IIO device appears the right level in the device
>> hierarchy.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Hmm. Took me a few moments to decide whether to push these as fixes or
not.  In the end I concluded that they have always been broken, so whilst
they are clearly a fix we want in, the probably don't need to be rushed
in or applied to old kernels. For drivers that were in this cycle, I
may push them out as straight forward fixes however.

If anyone disagrees then shout quickly!

Applied to the togreg branch of iio.git and pushed out as testing.
>> ---
>> drivers/iio/adc/stx104.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
>> index be2de48..2df84fa5 100644
>> --- a/drivers/iio/adc/stx104.c
>> +++ b/drivers/iio/adc/stx104.c
>> @@ -318,6 +318,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
>> 	}
>>
>> 	indio_dev->name = dev_name(dev);
>> +	indio_dev->dev.parent = dev;
>>
>> 	priv = iio_priv(indio_dev);
>> 	priv->base = base[id];
>> -- 
>> 2.1.4
>>
> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com
> 

