Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:56950
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751550Ab2FHH0B (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 Jun 2012 03:26:01 -0400
Message-ID: <4FD1A8D9.6080101@analog.com>
Date: Fri, 8 Jun 2012 09:25:13 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: iio: frequency: New driver for AD9523 SPI Low Jitter Clock Generator
References: <20120607121207.GA4784@elgon.mountain>
In-Reply-To: <20120607121207.GA4784@elgon.mountain>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/07/2012 02:12 PM, Dan Carpenter wrote:
> Hello Michael Hennerich,
>
> The patch cd1678f96329: "iio: frequency: New driver for AD9523 SPI
> Low Jitter Clock Generator" from May 29, 2012, leads to the following
> warning:
>
> drivers/iio/frequency/ad9523.c:378 ad9523_vco_out_map()
> 	 warn: value 2 can't fit into 1 'out'
Ups - good catch - I'll submit a patch shortly.

>
>
>     363  static int ad9523_vco_out_map(struct iio_dev *indio_dev,
>     364                                unsigned ch, bool out)
>                                                     ^^^^^^^^
> Bool.
>
>     365  {
>     366          struct ad9523_state *st = iio_priv(indio_dev);
>     367          int ret;
>     368          unsigned mask;
>     369
>     370          switch (ch) {
>     371          case 0 ... 3:
>     372                  ret = ad9523_read(indio_dev, AD9523_PLL1_OUTPUT_CHANNEL_CTRL);
>     373                  if (ret<  0)
>     374                          break;
>     375                  mask = AD9523_PLL1_OUTP_CH_CTRL_VCXO_SRC_SEL_CH0<<  ch;
>     376                  if (out) {
>     377                          ret |= mask;
>     378                          out = 2;
>                                  ^^^^^^^
> Should be either true or false.  Two implies FileNotFound.
> http://thedailywtf.com/Articles/What_Is_Truth_0x3f_.aspx
>
>     379                  } else {
>     380                          ret&= ~mask;
>     381                  }
>
> regards,
> dan carpenter
>
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


