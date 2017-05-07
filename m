Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57476 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbdEGV4B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 17:56:01 -0400
Subject: Re: [PATCH v3] iio: adc: Add support for TI ADC108S102 and ADC128S102
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>
References: <6d6bf102-1bc9-7019-13fa-b8f86b002dc8@siemens.com>
 <3ebf6029-aba6-d572-c618-32166a005f0f@kernel.org>
 <1494011349.30052.42.camel@linux.intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <65e819ec-0723-cd10-7546-09ee50434762@kernel.org>
Date: Sun, 7 May 2017 12:17:24 +0100
MIME-Version: 1.0
In-Reply-To: <1494011349.30052.42.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/17 20:09, Andy Shevchenko wrote:
> On Fri, 2017-05-05 at 19:55 +0100, Jonathan Cameron wrote:
>> On 05/05/17 07:31, Jan Kiszka wrote:
> 
>>> +
>>> +	/*
>>> +	 * SPI message buffers:
>>> +	 *  tx_buf: |C0|C1|C2|C3|C4|C5|C6|C7|XX|
>>> +	 *  rx_buf: |XX|R0|R1|R2|R3|R4|R5|R6|R7|tt|tt|tt|tt|
>>> +	 *
>>> +	 *  tx_buf: 8 channel read commands, plus 1 dummy command
>>> +	 *  rx_buf: 1 dummy response, 8 channel responses, plus 64-
>>> bit timestamp
>>> +	 */
>>> +	__be16				rx_buf[13]
>>> ____cacheline_aligned;
>>> +	__be16				tx_buf[9]
>>> ____cacheline_aligned;
>>
>> I would have thought the SPI dma wouldn't take itself out so you
>> should be
>> good with just the one cacheline_aligned?  Maybe I'm missing
>> something.
> 
> It was my idea for sake of consistency. Just to explicitly show that
> buffers a cache aligned.
> 
> If you insist to remove one, it's your call at the end ;-)
> 
As far as I know the only reason the 'need' to be cacheline aligned
is to avoid corruption issues if any other elements sharing the
cacheline (ie.earlier elements in our structure) change whilst the
dma is progress.  Doesn't matter if the second is also so aligned
as we should only have one dma type transfer going on at a time
(plenty of locking in spi to ensure this).

It's not a big point though so doesn't really matter as it is
safe either way!

Jonathan
