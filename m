Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36283 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbcDZLsQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Apr 2016 07:48:16 -0400
MIME-Version: 1.0
In-Reply-To: <571F49B0.4060407@metafoo.de>
References: <1461296584-11918-1-git-send-email-sdliyong@gmail.com>
 <43150fbd-37ac-2d51-dd87-f41670417b96@kernel.org> <571E854A.90404@gmail.com>
 <7621197a-95ed-239e-8baa-83014bc27a26@kernel.org> <571F49B0.4060407@metafoo.de>
From: Yong Li <sdliyong@gmail.com>
Date: Tue, 26 Apr 2016 19:47:56 +0800
Message-ID: <CADO9-peu32UCxaep8yZUD6XW=ABLGiTYuQJewn-C3Gedc2JewA@mail.gmail.com>
Subject: Re: [PATCH] iio: tmp006: Set correct iio name
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Crestez Dan Leonard <cdleonard@gmail.com>, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>,
	mranostay@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thanks for your mails. Just FYI, we are testing this tmp006 sensor on
our system. and our application framework is using these device names,
so I submitted this patch.

Yong

2016-04-26 18:57 GMT+08:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 04/25/2016 11:11 PM, Jonathan Cameron wrote:
>> On 25/04/16 21:59, Crestez Dan Leonard wrote:
>>> On 04/25/2016 10:33 PM, Jonathan Cameron wrote:
>>>> On 22/04/16 04:43, Yong Li wrote:
>>>>> When load the driver using the below command:
>>>>> echo tmp006 0x40 > /sys/bus/i2c/devices/i2c-0/new_device
>>>>>
>>>>> In sysfs, the i2c name is tmp006, however the iio name is 0-0040,
>>>>> they are inconsistent. With this patch,
>>>>> the iio name will be the same as the i2c device name
>>>>>
>>>>> Signed-off-by: Yong Li <sdliyong@gmail.com>
>>>> Peter, this looks right to me, but could you take a quick look as I guess
>>>> there might be a reason you did this in an unusual way originally?
>>>>
>>> Is there a "correct" or "usual" way to set indio_dev->name? Some quick grepping shows no clear standard:
>>>
>>> $ git grep -h 'indio_dev->name =' drivers/iio/ | wc -l
>>> 148
>>> $ git grep -h 'indio_dev->name =' drivers/iio/ | grep id | wc -l
>>> 52
>>> $ git grep -h 'indio_dev->name =' drivers/iio/ | grep dev_name | wc -l
>>> 20
>>> $ git grep -h 'indio_dev->name =' drivers/iio/ | grep -i drv | wc -l
>>> 19
>>> $ git grep -h 'indio_dev->name =' drivers/iio/ | grep -i driver | wc -l
>>> 15
>>>
>>> It seems that many devices use dev_name(&i2c_client->dev) or
>>> otherwise some sort of "ABC123_DRIVER_NAME" constant.
>>>
>>> It's also not clear what this "name" field is for. Is it more than
>>> just a cosmetic sysfs attribute? It seems to me that names don't have
>>> to be unique so it would be wrong to use them for identification.
>>>
>> It's a convenience field really as there is no clear standard for where else
>> to find out what a part actually is (i.e. if it is an i2c part you can look
>> in the name attribute i2c supplies - but otherwise you are on your own).
>
> I'd like to argue that it is supposed to be the device type allowing the
> application to identify which kind of device they are talking to. In which
> case the dev_name() initialization is wrong. Unfortunately there seem quite
> a few drivers which use it, especially the the SoC ADC drivers. But we can't
> really change this for existing drivers since there might be applications
> relying on the name.
>
> We should pay more attention to this for new driver submissions and make
> sure we don't get any more of this.
>
> As a side note if you want to know the dev_name() of the parent device you
> can do a readlink() on the iio device in /sys/bus/iio/devices/. The second
> last entry in the path name is the name of the parent device.
