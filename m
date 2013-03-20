Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:58132 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab3CTXoE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Mar 2013 19:44:04 -0400
Date: Wed, 20 Mar 2013 16:44:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lm-sensors@lm-sensors.org,
	khali@linux-fr.org
Subject: Re: [PATCH] hwmon: Move the IIO client driver for hwmon out of
 staging
Message-ID: <20130320234405.GA29172@roeck-us.net>
References: <1363818079-31470-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363818079-31470-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 20, 2013 at 10:21:19PM +0000, Jonathan Cameron wrote:
> This driver uses channel maps, defined either through device tree
> or platform data, to create a hwmon driver which acts as a client
> for the underlying IIO device channels.  Thus a general purpose
> IIO adc driver can be used to provide hardware monitoring using a subset
> of its channels.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> cc: Guenter Roeck <linux@roeck-us.net>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> 
> --
>  The only non move changes here concern the description and changes to the
>  dependencies to IIO explicit and hwmon implicit.
> 
>  I'm proposing moving this into hwmon on the basis of placing drivers
>  based on what they provide rather than what their underlying hardware
>  is.
> 
That is what I would suggest as well.

I assume you will take this through the iio tree, as it depends
on my previous patch, correct ?

Thanks,
Guenter
