Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43287 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964811AbcDYVLl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Apr 2016 17:11:41 -0400
Subject: Re: [PATCH] iio: tmp006: Set correct iio name
To: Crestez Dan Leonard <cdleonard@gmail.com>,
	Yong Li <sdliyong@gmail.com>
References: <1461296584-11918-1-git-send-email-sdliyong@gmail.com>
 <43150fbd-37ac-2d51-dd87-f41670417b96@kernel.org> <571E854A.90404@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	k.kozlowski@samsung.com, mranostay@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7621197a-95ed-239e-8baa-83014bc27a26@kernel.org>
Date: Mon, 25 Apr 2016 22:11:38 +0100
MIME-Version: 1.0
In-Reply-To: <571E854A.90404@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/04/16 21:59, Crestez Dan Leonard wrote:
> On 04/25/2016 10:33 PM, Jonathan Cameron wrote:
>> On 22/04/16 04:43, Yong Li wrote:
>>> When load the driver using the below command:
>>> echo tmp006 0x40 > /sys/bus/i2c/devices/i2c-0/new_device
>>>
>>> In sysfs, the i2c name is tmp006, however the iio name is 0-0040,
>>> they are inconsistent. With this patch,
>>> the iio name will be the same as the i2c device name
>>>
>>> Signed-off-by: Yong Li <sdliyong@gmail.com>
>> Peter, this looks right to me, but could you take a quick look as I guess
>> there might be a reason you did this in an unusual way originally?
>>
> Is there a "correct" or "usual" way to set indio_dev->name? Some quick grepping shows no clear standard:
> 
> $ git grep -h 'indio_dev->name =' drivers/iio/ | wc -l
> 148
> $ git grep -h 'indio_dev->name =' drivers/iio/ | grep id | wc -l
> 52
> $ git grep -h 'indio_dev->name =' drivers/iio/ | grep dev_name | wc -l
> 20
> $ git grep -h 'indio_dev->name =' drivers/iio/ | grep -i drv | wc -l
> 19
> $ git grep -h 'indio_dev->name =' drivers/iio/ | grep -i driver | wc -l
> 15
> 
> It seems that many devices use dev_name(&i2c_client->dev) or
> otherwise some sort of "ABC123_DRIVER_NAME" constant.
> 
> It's also not clear what this "name" field is for. Is it more than
> just a cosmetic sysfs attribute? It seems to me that names don't have
> to be unique so it would be wrong to use them for identification.
> 
It's a convenience field really as there is no clear standard for where else
to find out what a part actually is (i.e. if it is an i2c part you can look
in the name attribute i2c supplies - but otherwise you are on your own).

For i2c drivers it should typically be the id->name.  Which is what this
patch changes it to for this part.

The constant case should only be used for drivers that only support one
part (which is quite a few of them!)

Jonathan
