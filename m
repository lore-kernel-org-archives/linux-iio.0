Return-Path: <SRS0=Tv+h=L6=lechnology.com=david@kernel.org>
Subject: Re: [PATCH v2 3/4] iio: adc: ti-ads7950: use SPI_CS_WORD to reduce
 CPU usage
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20180913003920.30600-1-david@lechnology.com>
 <20180913003920.30600-4-david@lechnology.com>
 <20180916124110.4edfad9d@archlinux>
From: David Lechner <david@lechnology.com>
Message-ID: <b8b6201c-3574-d383-e3e8-9f162206e505@lechnology.com>
Date: Sun, 16 Sep 2018 11:24:16 -0500
MIME-Version: 1.0
In-Reply-To: <20180916124110.4edfad9d@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 09/16/2018 06:41 AM, Jonathan Cameron wrote:
> On Wed, 12 Sep 2018 19:39:19 -0500
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
> 
> Hi David,
> 
> I've managed to forget why we are changing any of the endian related code
> at all.  The change SPI_CS_WORD result in changes between words which is
> fine but it doesn't change any ordering within words?  So as such why
> do we no longer need to do the big endian conversions?
> 

The big-endian stuff was cargo culted from another driver when this driver
was originally written. It used an SPI word size of 8 bits and big-endian
byte ordering to effectively emulate 16 bit words.

Now, in order to inject a CS toggle between each word, we need to use the
correct word size, otherwise we would get a CS toggle half way through
each word 16-bit. The SPI subsystem uses CPU byte ordering for multi-byte
words. So, the data we get back from the SPI is going to be CPU endian now
no matter what. Converting that to big endian will just add overhead on
little endian systems.
