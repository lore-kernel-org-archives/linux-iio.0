Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48796 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbcEAV0I (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2016 17:26:08 -0400
Subject: Re: [PATCH 2/2] iio: accel: Add triggered buffer support for BMA220
To: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1461928076-22076-1-git-send-email-tiberiu.a.breana@intel.com>
 <1461928076-22076-3-git-send-email-tiberiu.a.breana@intel.com>
 <alpine.DEB.2.02.1604291320170.23132@pmeerw.net>
 <4586F61A4A291F4DA44D32824E7C0F402358932C@IRSMSX109.ger.corp.intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1266e70f-66d6-67f4-024a-a94fa5535a1f@kernel.org>
Date: Sun, 1 May 2016 19:07:51 +0100
MIME-Version: 1.0
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F402358932C@IRSMSX109.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/16 13:41, Breana, Tiberiu A wrote:
>> -----Original Message-----
>> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-
>> owner@vger.kernel.org] On Behalf Of Peter Meerwald-Stadler
>> Sent: Friday, April 29, 2016 2:25 PM
>> To: Breana, Tiberiu A <tiberiu.a.breana@intel.com>
>> Cc: linux-iio@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>
>> Subject: Re: [PATCH 2/2] iio: accel: Add triggered buffer support for BMA220
>>
>>
>>> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
>>
>> comments below
>>
>>> ---
>>>  drivers/iio/accel/bma220_spi.c | 67
>>> ++++++++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 65 insertions(+), 2 deletions(-)
>>>
> 
> <snip>
> 
>>> -70,6 +84,42 @@ static inline int bma220_read_reg(struct spi_device *spi,
>> u8 reg)
>>>  	return spi_w8r8(spi, reg | BMA220_READ_MASK);  }
>>>
>>> +static irqreturn_t bma220_trigger_handler(int irq, void *p) {
>>> +	int i;
>>> +	int ret;
>>> +	int bit;
>>> +	struct iio_poll_func *pf = p;
>>> +	struct iio_dev *indio_dev = pf->indio_dev;
>>> +	struct bma220_data *data = iio_priv(indio_dev);
>>> +	struct spi_device *spi = data->spi_device;
>>> +	u8 tx_buf = BMA220_REG_ACCEL_X | BMA220_READ_MASK;
>>> +	u8 rx_buf[3];
>>
>> alignment requirements for SPI?
> 
> I'm not sure what you mean by this. The chip seems to respond correctly
> to the testing I've done so far.
> 
If an spi master is doing DMA (which you obviously can't control in a generic
driver) then there is no explicit protection of the cacheline.  Thus it is possible
for the dma engine to spat garbage over the top of whatever else is in the cacheline
(usually a case of putting back an older version that is now wrong).

Thus buffers for DMA should existing in their own cacheline.  There are two easy
ways to do this - kmalloc the buffer as ever separate allocation will end up in it's
own cacheline.  Or put the buffer in your bma220_data (at the end) and use the
magic of ____cacheline_aligned markings for tx (with rx after it).  We very carefully
ensure the whole priv data is cacheline aligned to allow this to work in drivers.
> Tiberiu
> 

