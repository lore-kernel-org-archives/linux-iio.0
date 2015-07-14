Return-Path: <manfred.schlaegl@gmx.at>
Message-ID: <55A4F848.8060507@gmx.at>
Date: Tue, 14 Jul 2015 13:53:44 +0200
From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
MIME-Version: 1.0
To: Michael Welling <mwelling@ieee.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Subject: Re: [PATCH] iio: mcp320x: Fix NULL pointer dereference
References: <55A03142.1020106@gmx.at> <20150713141607.GB3224@deathray>
In-Reply-To: <20150713141607.GB3224@deathray>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 2015-07-13 16:16, Michael Welling wrote:
> On Fri, Jul 10, 2015 at 10:55:30PM +0200, Manfred Schlaegl wrote:
>> On reading in_voltage_scale of we got an NULL pointer dereference Oops.
>>
>> The reason for this is, that mcp320x_read_raw tries to access
>> chip_info->resolution from struct mcp320x, but chip_info is never set.
>>
>> chip_info was never set since the driver was added, but there was no
>> acute problem, because it was not referenced.
>> The acute problem exists since
>> b12206e917ac34bec41b9ff93d37d8bd53a2b3bc
>> iio: adc: mcp320x. Add support for more ADCs
>>
>> This patch fixes the issue by setting chip_info in mcp320x_probe.
>>
>> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>
>> ---
>>  drivers/iio/adc/mcp320x.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
>> index 8d9c9b9..d819823 100644
>> --- a/drivers/iio/adc/mcp320x.c
>> +++ b/drivers/iio/adc/mcp320x.c
>> @@ -299,6 +299,8 @@ static int mcp320x_probe(struct spi_device *spi)
>>  	indio_dev->channels = chip_info->channels;
>>  	indio_dev->num_channels = chip_info->num_channels;
>>  
>> +	adc->chip_info = chip_info;
>> +
> 
> Looks good to me.
> 
> Reviewed-by: Michael Welling <mwelling@ieee.org>
> 
>>  	adc->transfer[0].tx_buf = &adc->tx_buf;
>>  	adc->transfer[0].len = sizeof(adc->tx_buf);
>>  	adc->transfer[1].rx_buf = adc->rx_buf;
>> -- 
>> 1.7.10.4
>>

Thanks for reviewing!

best regards,
manfred
