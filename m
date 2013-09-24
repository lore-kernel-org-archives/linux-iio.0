Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42377 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab3IXNN3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2013 09:13:29 -0400
In-Reply-To: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org>
References: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 0/8] iio: Introduce devm_iio_device_{register,unregister}
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 24 Sep 2013 14:13:14 +0100
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Message-ID: <838c737b-62a6-453c-bd4d-644ee3b07eb4@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Sachin Kamat <sachin.kamat@linaro.org> wrote:
>With the conversion of iio drivers to use device managed APIs, most of
>the
>drivers now have a remove function with only the
>iio_device_unregister()
>call.
I am not sure this is a good idea if there is anything else in those functions. The unregister is responsible for marking the device as going away so until it has happened all interfaces should still work.
In at least two of this small set that is not the case...

 Thus introduce device managed version of iio_device_register() to
>clean up lot of such code.
>Have shown the usage in a few drivers to illustrate the cleanup. Will
>do
>for the rest too.
>This is only compile tested as I do not have any actual hardware to
>test ATM.
>
>
>Sachin Kamat (8):
>  iio: core: Implement devm_iio_device_{register,unregister}
>  iio: accel: kxsd9: Use devm_iio_device_register
>  iio: adc: mcp320x: Use devm_iio_device_register
>  iio: adc: mcp3422: Use devm_iio_device_register
>  iio: adc: ti-adc081c: Use devm_iio_device_register
>  iio: adc: twl6030-gpadc: Use devm_iio_device_register
>  iio: adc: viperboard: Use devm_iio_device_register
>  iio: amplifiers: ad8366: Use devm_iio_device_register
>
> Documentation/driver-model/devres.txt |    2 ++
> drivers/iio/accel/kxsd9.c             |   10 +---------
> drivers/iio/adc/mcp320x.c             |    3 +--
> drivers/iio/adc/mcp3422.c             |    9 +--------
> drivers/iio/adc/ti-adc081c.c          |    3 +--
> drivers/iio/adc/twl6030-gpadc.c       |    5 +----
> drivers/iio/adc/viperboard_adc.c      |   12 +----------
> drivers/iio/amplifiers/ad8366.c       |    4 +---
>drivers/iio/industrialio-core.c       |   35
>+++++++++++++++++++++++++++++++++
> include/linux/iio/iio.h               |   25 +++++++++++++++++++++++
> 10 files changed, 69 insertions(+), 39 deletions(-)

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
