Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33445 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbcBNTxV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2016 14:53:21 -0500
Received: by mail-lb0-f175.google.com with SMTP id x4so68810175lbm.0
        for <linux-iio@vger.kernel.org>; Sun, 14 Feb 2016 11:53:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56C0BBFF.5040703@metafoo.de>
References: <1455412842-750-1-git-send-email-mranostay@gmail.com>
 <56C096F3.9070908@kernel.org> <56C0BBFF.5040703@metafoo.de>
From: Matt Ranostay <mranostay@gmail.com>
Date: Sun, 14 Feb 2016 11:52:40 -0800
Message-ID: <CAKzfze8Os5zw7F0-RjgsuUob22YH_oR3vwb64ag6fjhE2Up2oQ@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: switch regmap cache
To: Lars-Peter Clausen <lars@metafoo.de>,
	Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Should have CC'ed Mark Brown on the original post.
But anyway after talking to him it seems that REGCACHE_FLAT is
"special" since it a flat tree it won't read it and cache the initial
value, so it then defaults to zero.

Mark, thoughts?

Thanks,

Matt

On Sun, Feb 14, 2016 at 9:40 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 02/14/2016 04:02 PM, Jonathan Cameron wrote:
>> On 14/02/16 01:20, Matt Ranostay wrote:
>>> switch from using REGCACHE_FLAT to REGCACHE_RBTREE so initial hw values
>>> are read from device. This also allows some volatile ranges to be
>>> dropped.
>>>
>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> I'm lost here. Why should changing the storage of the register cache result
>> in different behaviour other than in efficiency of access to cached values?
>
> And if there is really a difference this should probably be addressed at the
> regmap level.
>
> - Lars
>
>>
>> Jonathan
>>> ---
>>>  drivers/iio/chemical/atlas-ph-sensor.c | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
>>> index 06cd49c..71c8e02 100644
>>> --- a/drivers/iio/chemical/atlas-ph-sensor.c
>>> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
>>> @@ -65,8 +65,6 @@ struct atlas_data {
>>>
>>>  static const struct regmap_range atlas_volatile_ranges[] = {
>>>      regmap_reg_range(ATLAS_REG_INT_CONTROL, ATLAS_REG_INT_CONTROL),
>>> -    regmap_reg_range(ATLAS_REG_CALIB_STATUS, ATLAS_REG_CALIB_STATUS),
>>> -    regmap_reg_range(ATLAS_REG_TEMP_DATA, ATLAS_REG_TEMP_DATA + 4),
>>>      regmap_reg_range(ATLAS_REG_PH_DATA, ATLAS_REG_PH_DATA + 4),
>>>  };
>>>
>>> @@ -83,7 +81,7 @@ static const struct regmap_config atlas_regmap_config = {
>>>
>>>      .volatile_table = &atlas_volatile_table,
>>>      .max_register = ATLAS_REG_PH_DATA + 4,
>>> -    .cache_type = REGCACHE_FLAT,
>>> +    .cache_type = REGCACHE_RBTREE,
>>>  };
>>>
>>>  static const struct iio_chan_spec atlas_channels[] = {
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
