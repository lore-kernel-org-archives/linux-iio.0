Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-055.synserver.de ([212.40.185.55]:1214 "EHLO
	smtp-out-057.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752884Ab2IZIDd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 26 Sep 2012 04:03:33 -0400
Message-ID: <5062B6FD.2020302@metafoo.de>
Date: Wed, 26 Sep 2012 10:04:13 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC: Ge Gao <ggao@invensense.com>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: iio_buffer length
References: <C0999E24-1BF1-4B7D-835B-8E3AC76C61F8@gmail.com> <5348d4d4e8f4766e2ed416b6b8318ee5@mail.gmail.com> <5062AE55.4060205@jic23.retrosnub.co.uk>
In-Reply-To: <5062AE55.4060205@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/26/2012 09:27 AM, Jonathan Cameron wrote:
> On 26/09/12 02:32, Ge Gao wrote:
>> To use KFIFO, you need Jonanthan's KFIFO poll patch,
> That's in staging-next now and will merge into mainline in the
> next merge window (about 1 to 2 weeks time).
>> you probably also
>> need a patch from me that fixed the industrial-buffer.c. But that buffer
>> is not well tested and is only used by me.
> There are a lot of drivers using kfifo. It's hidden in many of them as they
> use it via the industrialio-triggered-buffer helper functions that
> deal with the most common use cases.
> 
> With that I count 9 in drivers/iio and 6 in drivers/staging/iio vs 10
> in total for sw_ring most of which will go away once someone has a spare
> couple of hours.

I've already converted all the adis* drivers locally, so it's basically down
to 4 remaining users.

- Lars
