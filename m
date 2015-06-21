Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43830 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbbFUNV7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:21:59 -0400
Message-ID: <5586BA76.1050809@kernel.org>
Date: Sun, 21 Jun 2015 14:21:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>
Subject: Re: [PATCH 4/7] iio:light:cm3323: drop barely used variable
References: <cover.1434492557.git.knaack.h@gmx.de>	<942e9ba3437c35f946e6979ca63469941f81f289.1434492557.git.knaack.h@gmx.de> <CAEnQRZD0yUgHKgcQ3tmctfYTLVnAKh0y-9yEmZ=EMYprwc5HAw@mail.gmail.com>
In-Reply-To: <CAEnQRZD0yUgHKgcQ3tmctfYTLVnAKh0y-9yEmZ=EMYprwc5HAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/06/15 11:09, Daniel Baluta wrote:
> On Wed, Jun 17, 2015 at 1:17 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>> In cm3323_disable() ret is just used to check for errors during I2C write.
>> Consolidate the write and the check to save a variable and two lines of
>> code.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> I don't really like this. It makes code harder to read.
> 
> Other opinions?
> 
I'm going to side with Daniel on this one...  Lets leave it as is.

Jonathan
>> ---
>>  drivers/iio/light/cm3323.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
>> index f88a0ed..8945e0c 100644
>> --- a/drivers/iio/light/cm3323.c
>> +++ b/drivers/iio/light/cm3323.c
>> @@ -106,12 +106,10 @@ static int cm3323_init(struct iio_dev *indio_dev)
>>
>>  static void cm3323_disable(struct iio_dev *indio_dev)
>>  {
>> -       int ret;
>>         struct cm3323_data *data = iio_priv(indio_dev);
>>
>> -       ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF,
>> -                                       CM3323_CONF_SD_BIT);
>> -       if (ret < 0)
>> +       if (i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF,
>> +                                     CM3323_CONF_SD_BIT) < 0)
>>                 dev_err(&data->client->dev, "Error writing reg_conf\n");
>>  }
>>
>> --

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
