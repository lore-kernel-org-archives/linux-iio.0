Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50752 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932328Ab2ENUNw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 May 2012 16:13:52 -0400
Received: by pbbrp8 with SMTP id rp8so6561266pbb.19
        for <linux-iio@vger.kernel.org>; Mon, 14 May 2012 13:13:52 -0700 (PDT)
Date: Mon, 14 May 2012 13:13:48 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: michael.hennerich@analog.com
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 3/3] iio: amplifiers: New driver for AD8366 Dual-Digital
 Variable Gain Amplifier
Message-ID: <20120514201348.GA21542@kroah.com>
References: <1336729014-26855-1-git-send-email-michael.hennerich@analog.com>
 <1336729014-26855-3-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336729014-26855-3-git-send-email-michael.hennerich@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, May 11, 2012 at 11:36:54AM +0200, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Changes since V1:
> 
> Apply review feedback:
> 	Introduce and use IIO_CHAN_INFO_HARDWAREGAIN
> 	Introduce and use Use IIO_VAL_INT_PLUS_MICRO_DB
> 
> Modify out of staging include paths.
> Convert to new iio core API naming.
> 
> Changes since V2:
> 
> more sanity checking in write_raw
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Acked-by: Jonathan Cameron<jic23@kernel.org>
> ---
>  drivers/iio/Kconfig             |    2 +
>  drivers/iio/Makefile            |    2 +
>  drivers/iio/amplifiers/Kconfig  |   17 +++
>  drivers/iio/amplifiers/Makefile |    5 +
>  drivers/iio/amplifiers/ad8366.c |  222 +++++++++++++++++++++++++++++++++++++++

Woah, the first "real" iio driver?  Congrats!

greg k-h
