Return-Path: <SRS0=jEZM=KF=lechnology.com=david@kernel.org>
Subject: Re: [PATCH 4/4] iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU
 usage
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20180717032052.12273-1-david@lechnology.com>
 <20180717032052.12273-5-david@lechnology.com>
 <20180721185138.673bee00@archlinux>
From: David Lechner <david@lechnology.com>
Message-ID: <e564e3c9-2fea-b203-ca39-ea94ba2b83b0@lechnology.com>
Date: Sat, 21 Jul 2018 14:05:49 -0500
MIME-Version: 1.0
In-Reply-To: <20180721185138.673bee00@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/21/2018 12:51 PM, Jonathan Cameron wrote:
> On Mon, 16 Jul 2018 22:20:52 -0500
> David Lechner <david@lechnology.com> wrote:
> 
>> This changes how the SPI message for the triggered buffer is setup in
>> the TI ADS7950 A/DC driver. By using the SPI_CS_WORD flag, we can read
>> multiple samples in a single SPI transfer. If the SPI controller
>> supports DMA transfers, we can see a significant reduction in CPU usage.
>>
>> For example, on an ARM9 system running at 456MHz reading just 4 channels
>> at 100Hz: before this change, top shows the CPU usage of the IRQ thread
>> of this driver to be ~7.7%. After this change, the CPU usage drops to
>> ~3.8%.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> Hmm. There is a userspace ABI change in here, though it shouldn't matter
> as long as people are using the full ABI rather than running some
> scripts that make assumptions.
> 
> It's quite nice if we have all the relevant emulation in the SPI core
> that this doesn't break things on any spi controllers.
> 
> Jonathan
> 
>> ---
>>
>> Dependency: this patch applies on top of "iio: adc: ti-ads7950: allow
>> simultaneous use of buffer and direct mode"[1]
>>
>> [1]: https://lore.kernel.org/lkml/20180716233550.6449-1-david@lechnology.com/
>>
>>
>>   drivers/iio/adc/ti-ads7950.c | 53 +++++++++++++++++++++---------------
>>   1 file changed, 31 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
>> index ba7e5a027490..60de4cbbd5fc 100644
>> --- a/drivers/iio/adc/ti-ads7950.c
>> +++ b/drivers/iio/adc/ti-ads7950.c
>> @@ -60,7 +60,7 @@
>>   struct ti_ads7950_state {
>>   	struct iio_dev		*indio_dev;
>>   	struct spi_device	*spi;
>> -	struct spi_transfer	ring_xfer[TI_ADS7950_MAX_CHAN + 2];
>> +	struct spi_transfer	ring_xfer;
>>   	struct spi_transfer	scan_single_xfer[3];
>>   	struct spi_message	ring_msg;
>>   	struct spi_message	scan_single_msg;
>> @@ -69,16 +69,16 @@ struct ti_ads7950_state {
>>   	unsigned int		vref_mv;
>>   
>>   	unsigned int		settings;
>> -	__be16			single_tx;
>> -	__be16			single_rx;
>> +	u16			single_tx;
>> +	u16			single_rx;
>>   
>>   	/*
>>   	 * DMA (thus cache coherency maintenance) requires the
>>   	 * transfer buffers to live in their own cache lines.
>>   	 */
>> -	__be16	rx_buf[TI_ADS7950_MAX_CHAN + TI_ADS7950_TIMESTAMP_SIZE]
>> +	u16 rx_buf[TI_ADS7950_MAX_CHAN + 2 + TI_ADS7950_TIMESTAMP_SIZE]
>>   							____cacheline_aligned;
>> -	__be16	tx_buf[TI_ADS7950_MAX_CHAN];
>> +	u16 tx_buf[TI_ADS7950_MAX_CHAN + 2];
>>   };
>>   
>>   struct ti_ads7950_chip_info {
>> @@ -116,7 +116,7 @@ enum ti_ads7950_id {
>>   		.realbits = bits,				\
>>   		.storagebits = 16,				\
>>   		.shift = 12 - (bits),				\
>> -		.endianness = IIO_BE,				\
>> +		.endianness = IIO_CPU,				\
> 
> Hmm. I'm getting a little dubious.  This is a userspace ABI change - it 'might'
> break someone.  We'd have to cross our fingers it doesn't.

Dubious is a good word for this. ;-)

I was hoping that we could try to get away with this anyway. If someone
complains, we can always change it back, right? And if no one complains, then
did we really break anything?

I'll have to play around with the a default SPI_CS_WORD implementation first
to make sure it won't influence this either.
