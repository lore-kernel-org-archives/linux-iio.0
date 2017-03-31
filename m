Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43750 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbdCaGGN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2017 02:06:13 -0400
Date: Fri, 31 Mar 2017 08:05:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: simran singhal <singhalsimran0@gmail.com>
Cc: lars@metafoo.de, devel@driverdev.osuosl.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, jic23@kernel.org
Subject: Re: [PATCH] iio: gyro: adis16060: Change the function's name
Message-ID: <20170331060557.GC5554@kroah.com>
References: <20170330190225.GA18838@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170330190225.GA18838@singhal-Inspiron-5558>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 31, 2017 at 12:32:26AM +0530, simran singhal wrote:
> Change the name of function from adis16060_spi_write_than_read()
> to adis16060_spi_write_then_read(). change "than" to "then" as
> its time depended.
> ---
>  drivers/staging/iio/gyro/adis16060_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

No signed-off-by:?

Always run your patches through checkpatch.pl to see if you did
something wrong.

thanks,

greg k-h
