Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:54502 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121AbcDNQAK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Apr 2016 12:00:10 -0400
Subject: Re: generic_buffer and 24 bits samples
To: Gregor Boirie <gregor.boirie@parrot.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <570FB712.5070903@parrot.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <570FBE87.9050006@metafoo.de>
Date: Thu, 14 Apr 2016 18:00:07 +0200
MIME-Version: 1.0
In-Reply-To: <570FB712.5070903@parrot.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/14/2016 05:28 PM, Gregor Boirie wrote:
> Greetings,
> 
> I'm trying to use an st_pressure based sensor to sample pressure
> data using generic_buffer tool. However it seems that it does not
> support data packed onto 24 bits samples.
> st_pressure driver defines scan_type for my device as:
> <code>
> /* ... */
>     .scan_type = {
>         .sign = 'u',
>         .realbits = 24,
>         .storagebits = 24,
>         .endianness = IIO_LE,
>     },
> </code>
> 
> What is the proper way to make this work ? Using 32 bits storagebits
> field ? Enhance generic_buffer to support 24 bits samples ? Anything
> else ??
> 
> It seems iio_compute_scan_bytes consider sample data as a simple byte
> stream. So I'm wondering what are the alignment constraints for sample
> start address ? Should they be aligned onto their natural "word"
> boundaries, i.e. 16 bits for u16, 32 bits for u32, etc... ? And for
> 24 bits samples ?

IIO really only supports powers of two >= 8 for the storagebits size.
Everything else is undefined.

Samples are aligned to their storage size.

