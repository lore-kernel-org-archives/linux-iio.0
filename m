Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47198 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbcEUTS4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 May 2016 15:18:56 -0400
Subject: Re: [PATCH] iio: light: jsa1212: remove unneeded i2c check
 functionality test
To: Matt Ranostay <mranostay@gmail.com>,
	sathyanarayanan.kuppuswamy@linux.intel.com
References: <20160515183717.GA2674@d830.WORKGROUP>
 <573E07EA.8050007@linux.intel.com>
 <CAKzfze_1yfaz=P3Btxg2TddBvVRSXicK267RH=8zE3-6n7y-ug@mail.gmail.com>
Cc: Alison Schofield <amsfield22@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c6a79cb7-60be-5a2d-02d9-b14dfc652be3@kernel.org>
Date: Sat, 21 May 2016 20:18:52 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze_1yfaz=P3Btxg2TddBvVRSXicK267RH=8zE3-6n7y-ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/16 21:19, Matt Ranostay wrote:
> Reviewed-by: Matt Ranostay <matt.ranostay@intel.com>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> 
> On Thu, May 19, 2016 at 11:37 AM, sathyanarayanan kuppuswamy
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> Looks Good.
>>
>> Reviewed-by:Kuppuswamy Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>>
>> On 05/15/2016 11:37 AM, Alison Schofield wrote:
>>>
>>> This driver does not call i2c_smbus_read|write_byte_data(),
>>> so remove the corresponding functionality test. It uses regmap
>>> to handle byte transfers transparently.
>>>
>>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>>> ---
>>> Found & fixed by inspection based on same defect recently fixed
>>> in light/tpl0102 driver.
>>>
>>>
>>>   drivers/iio/light/jsa1212.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
>>> index 99a6281..e8a8931 100644
>>> --- a/drivers/iio/light/jsa1212.c
>>> +++ b/drivers/iio/light/jsa1212.c
>>> @@ -325,9 +325,6 @@ static int jsa1212_probe(struct i2c_client *client,
>>>         struct regmap *regmap;
>>>         int ret;
>>>   -     if (!i2c_check_functionality(client->adapter,
>>> I2C_FUNC_SMBUS_BYTE_DATA))
>>> -               return -EOPNOTSUPP;
>>> -
>>>         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>>>         if (!indio_dev)
>>>                 return -ENOMEM;
>>
>>
>> --
>> Sathyanarayanan Kuppuswamy
>> Android kernel developer
>>

