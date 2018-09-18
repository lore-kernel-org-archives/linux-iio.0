Return-Path: <SRS0=jqtk=MA=lechnology.com=david@kernel.org>
Subject: Re: [PATCH 3/3] iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU
 usage
To: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <20180918170850.2749-1-david@lechnology.com>
 <20180918170850.2749-4-david@lechnology.com>
From: David Lechner <david@lechnology.com>
Message-ID: <7a70711c-5d38-5ba6-ec90-b2506dc0727d@lechnology.com>
Date: Tue, 18 Sep 2018 12:14:50 -0500
MIME-Version: 1.0
In-Reply-To: <20180918170850.2749-4-david@lechnology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 09/18/2018 12:08 PM, David Lechner wrote:
> This changes how the SPI message for the triggered buffer is setup in
> the TI ADS7950 A/DC driver. By using the SPI_CS_WORD flag, we can read
> multiple samples in a single SPI transfer. If the SPI controller
> supports DMA transfers, we can see a significant reduction in CPU usage.
> 
> For example, on an ARM9 system running at 456MHz reading just 4 channels
> at 100Hz: before this change, top shows the CPU usage of the IRQ thread
> of this driver to be ~7.7%. After this change, the CPU usage drops to
> ~3.8%.
> 
> The use of big-endian for the raw data was cargo culted from another
> driver when this driver was originally written. It used an SPI word size
> of 8 bits and big-endian byte ordering to effectively emulate 16 bit
> words.
> 
> Now, in order to inject a CS toggle between each word, we need to use
> the correct word size, otherwise we would get a CS toggle half way
> through each word 16-bit. The SPI subsystem uses CPU byte ordering for
> multi-byte words. So, the data we get back from the SPI is going to be
> CPU endian now no matter what. Converting that to big endian will just
> add overhead on little endian systems so we opt to change the raw data
> format from big endian to CPU endian.
> 
> There is a small risk that this could break some lazy userspace programs
> that use the raw data without checking the data format. We can address
> this if/when it actually comes up.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

And I just realized I forgot to pick up...


Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
