Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36506 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752966AbcJGGC5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Oct 2016 02:02:57 -0400
Received: by mail-pf0-f195.google.com with SMTP id 128so725250pfz.3
        for <linux-iio@vger.kernel.org>; Thu, 06 Oct 2016 23:02:56 -0700 (PDT)
Date: Fri, 7 Oct 2016 14:02:47 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH] staging: iio: ad7606: implement
 IIO_CHAN_INFO_OVERSAMPLING_RATIO
Message-ID: <20161007060246.GA7872@Socrates-DK>
References: <1475764920-7770-1-git-send-email-eraretuya@gmail.com>
 <baef9fc5-c3de-3b47-4e17-de559027e0b4@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <baef9fc5-c3de-3b47-4e17-de559027e0b4@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Oct 06, 2016 at 05:43:36PM +0200, Lars-Peter Clausen wrote:
> On 10/06/2016 04:42 PM, Eva Rachel Retuya wrote:
> > This driver predates the availability of IIO_CHAN_INFO_OVERSAMPLING_RATIO
> > attribute wherein usage has some advantages like it can be accessed by
> > in-kernel consumers as well as reduces the code size.
> > 
> > Therefore, use IIO_CHAN_INFO_OVERSAMPLING_RATIO to implement the
> > oversampling_ratio attribute instead of using IIO_DEVICE_ATTR() macro.
> > 
> > Move code from the functions associated with IIO_DEVICE_ATTR() into
> > the read_raw hook as well as add the write_raw hook with both masks set
> > to IIO_CHAN_INFO_OVERSAMPLING_RATIO.
> > 
> > Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> 
> Looks good, thanks.
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 

Thank you for the feedback!

> I did some cleanup on this driver last week (not yet submitted), this was
> the last bit I hadn't gotten to yet that needs to be done before the driver
> can be moved out of staging.

Anything else about this driver that needs to be addressed? I'll be glad
to help submit patches for those (and in the process learn something new).

By the way, this particular code took my attention (from write_raw of
this patch):

		gpio_set_value(st->pdata->gpio_os0, (ret >> 0) & 1);
		gpio_set_value(st->pdata->gpio_os1, (ret >> 1) & 1);
		gpio_set_value(st->pdata->gpio_os1, (ret >> 2) & 1);

The last line, st->pdata->gpio_os1, is that really intended or is it a
typo? It could have been st->pdata->gpio_os2. I checked the datasheet
and definition, looks like a typo to me. Just checking with everyone for
confirmation.

Thanks,
Eva
