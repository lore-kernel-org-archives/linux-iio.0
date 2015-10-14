Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34044 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932580AbbJNPOg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 14 Oct 2015 11:14:36 -0400
Received: by wicgb1 with SMTP id gb1so134031498wic.1
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2015 08:14:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <561E70FC.4010206@metafoo.de>
References: <1444752327-2629-1-git-send-email-lars@metafoo.de>
	<1444752327-2629-4-git-send-email-lars@metafoo.de>
	<CAEnQRZBaVnf4NGHAwmFigWNnirAgNsczSQTfUGAY4fcvn3Edyg@mail.gmail.com>
	<561E70FC.4010206@metafoo.de>
Date: Wed, 14 Oct 2015 18:14:34 +0300
Message-ID: <CAEnQRZCU8bDpjnkXgz4xn1VyxkJ4ic_-LdjvHfcsQndggj4r1w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] iio: Add support for indicating fixed watermarks
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Octavian Purdila <octavian.purdila@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 14, 2015 at 6:13 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 10/14/2015 04:04 PM, Daniel Baluta wrote:
>> On Tue, Oct 13, 2015 at 7:05 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> For buffers which have a fixed wake-up watermark the watermark attribute
>>> should be read-only. Add a new FIXED_WATERMARK flag to the
>>> struct iio_buffer_access_funcs, which can be set by a buffer
>>> implementation.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> ---
>>>  drivers/iio/industrialio-buffer.c | 5 +++++
>>>  include/linux/iio/buffer.h        | 8 ++++++++
>>>  2 files changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>>> index 5f2c8c8..98a6447 100644
>>> --- a/drivers/iio/industrialio-buffer.c
>>> +++ b/drivers/iio/industrialio-buffer.c
>>> @@ -998,6 +998,8 @@ static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
>>>                    iio_buffer_show_enable, iio_buffer_store_enable);
>>>  static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
>>>                    iio_buffer_show_watermark, iio_buffer_store_watermark);
>>> +static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
>>> +       S_IRUGO, iio_buffer_show_watermark, NULL);
>>
>> I think we can use DEVICE_ATTR_RO here.
>
> The problem is that this will generate a variable with the name
> dev_attr_watermark, which we already have for the rw version. So there would
> be a name conflict.

I see.
