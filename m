Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH] staging: iio: ad7606: implement
 IIO_CHAN_INFO_OVERSAMPLING_RATIO
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org,
 outreachy-kernel@googlegroups.com
References: <1475764920-7770-1-git-send-email-eraretuya@gmail.com>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
 pmeerw@pmeerw.net, gregkh@linuxfoundation.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <baef9fc5-c3de-3b47-4e17-de559027e0b4@metafoo.de>
Date: Thu, 6 Oct 2016 17:43:36 +0200
MIME-Version: 1.0
In-Reply-To: <1475764920-7770-1-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 10/06/2016 04:42 PM, Eva Rachel Retuya wrote:
> This driver predates the availability of IIO_CHAN_INFO_OVERSAMPLING_RATIO
> attribute wherein usage has some advantages like it can be accessed by
> in-kernel consumers as well as reduces the code size.
> 
> Therefore, use IIO_CHAN_INFO_OVERSAMPLING_RATIO to implement the
> oversampling_ratio attribute instead of using IIO_DEVICE_ATTR() macro.
> 
> Move code from the functions associated with IIO_DEVICE_ATTR() into
> the read_raw hook as well as add the write_raw hook with both masks set
> to IIO_CHAN_INFO_OVERSAMPLING_RATIO.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>

Looks good, thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

I did some cleanup on this driver last week (not yet submitted), this was
the last bit I hadn't gotten to yet that needs to be done before the driver
can be moved out of staging.
