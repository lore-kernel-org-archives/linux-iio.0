Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:58535 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab3BAMHS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Feb 2013 07:07:18 -0500
Message-ID: <510BAFF4.5070605@jic23.retrosnub.co.uk>
Date: Fri, 01 Feb 2013 12:07:16 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>, jic23@cam.ac.uk,
	linux-iio@vger.kernel.org,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>,
	Denis Ciocca <denis.ciocca@gmail.com>
Subject: Re: [RFC] Driver for lis331dlh
References: <1359719147-30231-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <510BAEE6.2060600@metafoo.de>
In-Reply-To: <510BAEE6.2060600@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/02/13 12:02, Lars-Peter Clausen wrote:
> On 02/01/2013 12:45 PM, Manuel Stahl wrote:
>> The following patch adds support for the ST Microelectronics lis331dlh accelerometer.
>> It is very similar to the lis3l02dq driver in staging (but updated to the current API)
>> and there is also a driver in misc supporting a larger range of these devices.
>> So sure, these should be merged, but I'm not sure how to do it properly.
>>
>
> Hi Manuel,
>
> We recently merged the generic ST Microelectronics accelerometer driver, which
> also has, as far as I can see, support for the lis331dlh.
>
> See http://www.spinics.net/lists/linux-iio/msg07608.html
Guess the answer to my question is nothing at all needs adding then.
Sorry, didn't think to check if it was already there.
Denis is looking into supporting the lis3l02dq so we can kill that 
driver off and just have to handle the driver in misc.  For that
we need to have a detailed discussion on their interfaces and how
we maintain them going forward (what fun).

Jonathan
>
>
>> Manuel Stahl (1):
>>    iio: accel: Add driver for lis331dlh
>>
>>   drivers/iio/Kconfig                  |    1 +
>>   drivers/iio/accel/Kconfig            |   16 ++
>>   drivers/iio/accel/Makefile           |    5 +
>>   drivers/iio/accel/lis331dlh_buffer.c |  132 +++++++++++
>>   drivers/iio/accel/lis331dlh_core.c   |  429 ++++++++++++++++++++++++++++++++++
>>   drivers/iio/accel/lis331dlh_i2c.c    |  150 ++++++++++++
>>   drivers/iio/accel/lis331dlh_spi.c    |  129 ++++++++++
>>   include/linux/iio/accel/lis331dlh.h  |  243 +++++++++++++++++++
>>   8 files changed, 1105 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/iio/accel/lis331dlh_buffer.c
>>   create mode 100644 drivers/iio/accel/lis331dlh_core.c
>>   create mode 100644 drivers/iio/accel/lis331dlh_i2c.c
>>   create mode 100644 drivers/iio/accel/lis331dlh_spi.c
>>   create mode 100644 include/linux/iio/accel/lis331dlh.h
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

