Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH 1/4] iio: mxs-lradc: change the realbits to 12
Date: Fri, 5 Jul 2013 15:10:28 +0200
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "alexandre.belloni@free-electrons.com" <alexandre.belloni@free-electrons.com>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "jic23@kernel.org" <jic23@kernel.org>,
 "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <201307051337.39215.marex@denx.de> <51D6BED7.6060703@digi.com>
In-Reply-To: <51D6BED7.6060703@digi.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307051510.29011.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Hector Palacios,

> Dear Marek,
> 
> On 07/05/2013 01:37 PM, Marek Vasut wrote:
> > Dear Hector Palacios,
> > 
> >> The LRADC virtual channels have an 18 bit field to store the sum of up
> >> to 2^5 accumulated samples. The read_raw function however only operates
> >> over a single sample (12 bit resolution).
> >> In order to use this field for scaling operations, we need it to be the
> >> exact resolution value of the LRADC.
> > 
> > How would this work once the accumulation is supported?
> 
> As I see it, when you read a channel the driver should give you the 12-bit
> value either of one single sample or of N samples.

The hardware will always give you 18 bit value, let's call it A of N accumulated 
samples, each 12 bit long. N is in range of 1 to 32 .

The driver currently supports N = 1.

Do I understand it correctly that if we want to support N > 1, we have to do the 
division of A / N in the driver and therefore we will again report only a 12-bit 
value to the userland ?

If so,

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
