Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-170.synserver.de ([212.40.185.170]:1079 "EHLO
	smtp-out-170.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab3CANgv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Mar 2013 08:36:51 -0500
Message-ID: <5130AF56.8020407@metafoo.de>
Date: Fri, 01 Mar 2013 14:38:30 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-iio@vger.kernel.org
Subject: Re: IIO_BUFFER - IIO_TRIGGERED_BUFFER circular dependency
References: <20130301043222.GA5606@roeck-us.net>
In-Reply-To: <20130301043222.GA5606@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/01/2013 05:32 AM, Guenter Roeck wrote:
> Hi all,
> 
> IIO_TRIGGERED_BUFFER depends on IIO_BUFFER because of:
> 
> drivers/iio/industrialio-triggered-buffer.c:20:16: error:
> ‘iio_sw_buffer_preenable’ undeclared here (not in a function)
> 
> On the other side, it is often selected as follows.
> 
> 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
> 
> For that reason, selecting IIO_BUFFER in the IIO_TRIGGERED_BUFFER declaration
> results in a circular dependency. Sometimes the "if (IIO_BUFFER)" when selecting
> IIO_TRIGGERED_BUFFER is missing, though, which can result in the compile error.
> 
> What is the proper solution ?
> - Add "if (IIO_BUFFER)" whenever IIO_TRIGGERED_BUFFER is selected
> or
> - Remove "if (IIO_BUFFER)" from IIO_TRIGGERED_BUFFER selection and add "select
>   IIO_BUFFER" to the IIO_TRIGGERED_BUFFER declaration
> 
> I would prefer the latter to solve the problem for good.

Hi,

This is a bit tricky, some drivers have optional buffer support, so they
only select the helper module if buffer support is enabled, since they don't
use the helper module if buffer support is disabled. Other driver though
always want buffer support so they select the helper module unconditionally.
So far it was the responsibility of the driver's Kconfig entry to make sure
that if it selects IIO_TRIGGERED_BUFFER it needs to make sure that
IIO_BUFFER is also selected. As far as I can see all drivers do this
currently. Which one breaks things for you?

If it was for me we would make IIO_BUFFER non-user-selectable and just let
every driver that has support for buffers select it. But when this came up
in the past Jonathon had other views on this.

- Lars
