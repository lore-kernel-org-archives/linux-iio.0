Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35906 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbcFSKD4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2016 06:03:56 -0400
Subject: Re: [PATCH 1/1] staging: iio: initialize data pointer before using it
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
References: <20160618211224.23183-1-nicolas.iooss_linux@m4x.org>
 <576668B7.8080609@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Message-ID: <19e60ec0-87cc-e79e-89a2-39857119640a@m4x.org>
Date: Sun, 19 Jun 2016 12:03:53 +0200
MIME-Version: 1.0
In-Reply-To: <576668B7.8080609@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/19/2016 11:41 AM, Lars-Peter Clausen wrote:
> On 06/18/2016 11:12 PM, Nicolas Iooss wrote:
>> ad7606_spi_read_block() reads SPI big-endian data into a buffer which is
>> then converted to CPU byte-order with a second variable.  This variable,
>> data, has been left unitialized after commit 87787e5ef727 ("Staging:
>> iio: Fix sparse endian warning").
> 
> Hi,
> 
> Thanks for the patch. A similar patch was already merged last week.

Nice :) Actually I sent this patch because the bug is still present in
linux-next tree [1] and I failed to see a reference to a dedicated
development tree in MAINTAINERS.

Thanks for your quick reply!

-- Nicolas

[1]
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/staging/iio/adc/ad7606_spi.c

