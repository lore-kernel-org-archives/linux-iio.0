Return-Path: <SRS0=GBpQ=ZO=axentia.se=peda@kernel.org>
Subject: Re: [PATCH 1/2] iio: pressure: mpl3115: do not rely on structure
 field ordering
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1485936567-3367-1-git-send-email-peda@axentia.se>
 <1485936567-3367-2-git-send-email-peda@axentia.se>
 <alpine.DEB.2.02.1702010956370.3042@pmeerw.net>
CC: <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Alison Schofield <amsfield22@gmail.com>, Gregor Boirie
	<gregor.boirie@parrot.com>, Sanchayan Maity <maitysanchayan@gmail.com>, Ken
 Lin <ken.lin@advantech.com>, <linux-iio@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <ef02efd6-d0da-9310-ba1b-ab3133637f6b@axentia.se>
Date: Wed, 1 Feb 2017 10:13:18 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1702010956370.3042@pmeerw.net>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2017-02-01 10:10, Peter Meerwald-Stadler wrote:
> Hello,
> 
>> Fixes a regression triggered by a change in the layout of
>> struct iio_chan_spec, but the real bug is in the driver which assumed
>> a specific structure layout in the first place.
> 
> I don't think that this is a proper fix
> 
> maybe the driver is unique in that it uses mask_separate for INFO_SCALE 
> and not by_type, but since there is just one PRESSURE channel, it should 
> be equivalent
> 
> what do you mean by 'driver which assumed a specific structure'?

Look again, the two bits are not OR:ed together as implied by the
indentation. There is a comma between them, which put the ..._SCALE
bit in the next field. That next field was .info_mask_shared_by_type
before the patch adding the available attribute that triggered the
regression and .info_mask_separate_available after it.

Cheers,
peda

> thanks, p.
> 
>> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
>> index cc3f84139157..525644a7442d 100644
>> --- a/drivers/iio/pressure/mpl3115.c
>> +++ b/drivers/iio/pressure/mpl3115.c
>> @@ -190,7 +190,7 @@ static const struct iio_chan_spec mpl3115_channels[] = {
>>  	{
>>  		.type = IIO_PRESSURE,
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> -			BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>>  		.scan_index = 0,
>>  		.scan_type = {
>>  			.sign = 'u',
>> @@ -203,7 +203,7 @@ static const struct iio_chan_spec mpl3115_channels[] = {
>>  	{
>>  		.type = IIO_TEMP,
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> -			BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>>  		.scan_index = 1,
>>  		.scan_type = {
>>  			.sign = 's',
>>
> 
