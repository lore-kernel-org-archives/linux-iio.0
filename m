Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35628 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbbHTAXM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Aug 2015 20:23:12 -0400
Received: by igbjg10 with SMTP id jg10so117552809igb.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2015 17:23:11 -0700 (PDT)
Date: Wed, 19 Aug 2015 20:23:07 -0400
From: Matt Porter <mporter@konsulko.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Linux IIO List <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: temperature: add max6675 thermocouple converter
 driver
Message-ID: <20150820002307.GD6276@beef>
References: <1438635410-3757-1-git-send-email-mporter@konsulko.com>
 <1438635410-3757-3-git-send-email-mporter@konsulko.com>
 <alpine.DEB.2.02.1508032313380.17732@pmeerw.net>
 <20150806173844.GI23173@beef>
 <55C5EA7C.70906@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C5EA7C.70906@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Aug 08, 2015 at 12:39:40PM +0100, Jonathan Cameron wrote:
> On 06/08/15 18:38, Matt Porter wrote:
> > On Mon, Aug 03, 2015 at 11:26:12PM +0200, Peter Meerwald wrote:
> >> On Mon, 3 Aug 2015, Matt Porter wrote:
> > 
> > ...
> > 
> >>> +static int max6675_read(struct max6675_state *st, int *val)
> >>> +{
> >>> +	int ret;
> >>> +
> >>> +	ret = spi_read(st->spi, val, 2);
> >>> +	if (ret < 0)
> >>> +		return ret;
> >>> +
> >>> +	/* Temperature is bits 14..3 */
> >>> +	*val = (*val >> 3) & 0xfff;
> >>
> >> what about endianness conversion?
> >> use be16_to_cpu()
> > 
> > Apologies, I spoke before engaging the brain on my first reply to this
> > As specified by the SPI subsystem docs, SPI buffers are always stored
> > in native endian order. There is no need for endianness conversion here.
> First of all, which doc say this?
> Secondly how does SPI know the endianness of the sensor which is what
> actually matters here?  I2C can in theory make these guarantees as there
> is an expected byte order on the wire (even if quite a few drivers don't
> conform to the spec anyway). No such guarantee can exist for SPI.

include/linux/spi/spi.h:

 * In-memory data values are always in native CPU byte order, translated
 * from the wire byte order (big-endian except with SPI_LSB_FIRST).  So
 * for example when bits_per_word is sixteen, buffers are 2N bytes long
 * (@len = 2N) and hold N sixteen bit words in CPU byte order.

So, as you mention, there's no standardized byte order but it's
controlled with the per transfer flag and big endian by default.

-Matt
