Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:32921 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499AbbHFRiu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Aug 2015 13:38:50 -0400
Received: by ioii16 with SMTP id i16so88608532ioi.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2015 10:38:49 -0700 (PDT)
Date: Thu, 6 Aug 2015 13:38:44 -0400
From: Matt Porter <mporter@konsulko.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Linux IIO List <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: temperature: add max6675 thermocouple converter
 driver
Message-ID: <20150806173844.GI23173@beef>
References: <1438635410-3757-1-git-send-email-mporter@konsulko.com>
 <1438635410-3757-3-git-send-email-mporter@konsulko.com>
 <alpine.DEB.2.02.1508032313380.17732@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1508032313380.17732@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 03, 2015 at 11:26:12PM +0200, Peter Meerwald wrote:
> On Mon, 3 Aug 2015, Matt Porter wrote:

...

> > +static int max6675_read(struct max6675_state *st, int *val)
> > +{
> > +	int ret;
> > +
> > +	ret = spi_read(st->spi, val, 2);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Temperature is bits 14..3 */
> > +	*val = (*val >> 3) & 0xfff;
> 
> what about endianness conversion?
> use be16_to_cpu()

Apologies, I spoke before engaging the brain on my first reply to this
As specified by the SPI subsystem docs, SPI buffers are always stored
in native endian order. There is no need for endianness conversion here.

-Matt
