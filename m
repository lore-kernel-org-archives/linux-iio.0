Return-Path: <knaack.h@gmx.de>
Message-ID: <55911519.3060103@gmx.de>
Date: Mon, 29 Jun 2015 11:51:21 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH 2/2] iio:light:ltr501: fix variable in ltr501_init
References: <cover.1435487041.git.knaack.h@gmx.de>	<d0d577c23f2ecb473c776cf6a684e82e07c0ab74.1435487041.git.knaack.h@gmx.de> <CAEnQRZA=P=HOAzzN=Q3uifPxGL0u58F5uk5RHo-vGKERM3Kn=Q@mail.gmail.com>
In-Reply-To: <CAEnQRZA=P=HOAzzN=Q3uifPxGL0u58F5uk5RHo-vGKERM3Kn=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Daniel Baluta schrieb am 29.06.2015 um 09:57:
> On Sun, Jun 28, 2015 at 1:31 PM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>> When filling data->als_contr, the register content read into status needs
>> to be used, instead of the return status value of regmap_read.
>>
>> This fixes:     8592a7eefa540303dd9e60fa49340d09ca9376b4
>>                 "iio: ltr501: Add support for ltr559 chip"
>>
> 
> Ditto, as per previous patch:
> 
> Fixes: 8592a7eefa540 ("iio: ltr501: Add support for ltr559 chip")
> 
> Also, I'm pretty sure that checkpatch.pl should have warned you about
> this.
> 

Unfortunately it doesn't. But I will keep it in mind.

>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>> ---
>>  drivers/iio/light/ltr501.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
>> index 1ef7d37..b5a0e66 100644
>> --- a/drivers/iio/light/ltr501.c
>> +++ b/drivers/iio/light/ltr501.c
>> @@ -1302,7 +1302,7 @@ static int ltr501_init(struct ltr501_data *data)
>>         if (ret < 0)
>>                 return ret;
>>
>> -       data->als_contr = ret | data->chip_info->als_mode_active;
>> +       data->als_contr = status | data->chip_info->als_mode_active;
>>
>>         ret = regmap_read(data->regmap, LTR501_PS_CONTR, &status);
>>         if (ret < 0)
>> --
>> 2.3.6
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
