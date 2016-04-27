Return-Path: <akinobu.mita@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKzfze_U835vkSvXCpcPxE3wuUZTraFEMy88mouXyExQYhq-9g@mail.gmail.com>
References: <1461505931-21884-1-git-send-email-akinobu.mita@gmail.com>
	<1461505931-21884-2-git-send-email-akinobu.mita@gmail.com>
	<CAKzfze_U835vkSvXCpcPxE3wuUZTraFEMy88mouXyExQYhq-9g@mail.gmail.com>
Date: Wed, 27 Apr 2016 20:33:18 +0900
Message-ID: <CAC5umyh4mQj9ADcF1h4GrGbUbQX89NWio8hTR_eFYyeXL2qthg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: pressure: bmp280: add support for BMP180
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Matt Ranostay <mranostay@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Vlad Dogaru <vlad.dogaru@intel.com>,
	Christoph Mair <christoph.mair@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2016-04-27 12:21 GMT+09:00 Matt Ranostay <mranostay@gmail.com>:
>> @@ -376,13 +711,13 @@ static int bmp280_probe(struct i2c_client *client,
>>         ret = regmap_read(data->regmap, BMP280_REG_ID, &chip_id);
>>         if (ret < 0)
>>                 return ret;
>> -       if (chip_id != BMP280_CHIP_ID) {
>> +       if (chip_id != id->driver_data) {
>>                 dev_err(&client->dev, "bad chip id.  expected %x got %x\n",
>>                         BMP280_CHIP_ID, chip_id);
>
> BMP280_CHIP_ID should be id->driver_data as well

Good catch!  I'll prepare a fix.
