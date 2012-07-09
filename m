Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-150.synserver.de ([212.40.185.150]:1092 "EHLO
	smtp-out-150.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab2GIJsu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jul 2012 05:48:50 -0400
Message-ID: <4FFAA9E8.6050906@metafoo.de>
Date: Mon, 09 Jul 2012 11:52:40 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>
CC: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
References: <1341368129-20468-1-git-send-email-marex@denx.de> <201207091119.44952.jbe@pengutronix.de>
In-Reply-To: <201207091119.44952.jbe@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/09/2012 11:19 AM, Juergen Beisert wrote:
> Hi Marek,
> 
> Marek Vasut wrote:
>> This driver is very basic. It supports userland trigger, buffer and
>> raw access to channels. The support for delay channels is missing
>> altogether.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Wolfgang Denk <wd@denx.de>
>> Cc: Juergen Beisert <jbe@pengutronix.de>
>> ---
>>  drivers/staging/iio/adc/Kconfig     |   12 +
>>  drivers/staging/iio/adc/Makefile    |    1 +
>>  drivers/staging/iio/adc/mxs-lradc.c |  619 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 632 insertions(+) 
>>  create mode 100644 drivers/staging/iio/adc/mxs-lradc.c
>>
>> [...]
> 
> sorry for the delay, too much work at the same time. When I try to compile
> your code I get:
> 
> drivers/staging/iio/adc/mxs-lradc.c:42:40: fatal error: linux/iio/triggered_buffer.h: No such file or directory
> 

This file only got added recently, right now it is only in staging/staging-next

- Lars

