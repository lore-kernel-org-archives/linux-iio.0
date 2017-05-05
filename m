Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64794 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdEETJN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 May 2017 15:09:13 -0400
Message-ID: <1494011349.30052.42.camel@linux.intel.com>
Subject: Re: [PATCH v3] iio: adc: Add support for TI ADC108S102 and
 ADC128S102
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>
Date: Fri, 05 May 2017 22:09:09 +0300
In-Reply-To: <3ebf6029-aba6-d572-c618-32166a005f0f@kernel.org>
References: <6d6bf102-1bc9-7019-13fa-b8f86b002dc8@siemens.com>
         <3ebf6029-aba6-d572-c618-32166a005f0f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2017-05-05 at 19:55 +0100, Jonathan Cameron wrote:
> On 05/05/17 07:31, Jan Kiszka wrote:

> > +
> > +	/*
> > +	 * SPI message buffers:
> > +	 *  tx_buf: |C0|C1|C2|C3|C4|C5|C6|C7|XX|
> > +	 *  rx_buf: |XX|R0|R1|R2|R3|R4|R5|R6|R7|tt|tt|tt|tt|
> > +	 *
> > +	 *  tx_buf: 8 channel read commands, plus 1 dummy command
> > +	 *  rx_buf: 1 dummy response, 8 channel responses, plus 64-
> > bit timestamp
> > +	 */
> > +	__be16				rx_buf[13]
> > ____cacheline_aligned;
> > +	__be16				tx_buf[9]
> > ____cacheline_aligned;
> 
> I would have thought the SPI dma wouldn't take itself out so you
> should be
> good with just the one cacheline_aligned?  Maybe I'm missing
> something.

It was my idea for sake of consistency. Just to explicitly show that
buffers a cache aligned.

If you insist to remove one, it's your call at the end ;-)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
