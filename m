Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:41820 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885Ab3BAMBk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Feb 2013 07:01:40 -0500
Message-ID: <510BAEA2.6040807@jic23.retrosnub.co.uk>
Date: Fri, 01 Feb 2013 12:01:38 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: jic23@cam.ac.uk, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [RFC] Driver for lis331dlh
References: <1359719147-30231-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <510BAE4D.6090802@jic23.retrosnub.co.uk>
In-Reply-To: <510BAE4D.6090802@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/02/13 12:00, Jonathan Cameron wrote:
> On 01/02/13 11:45, Manuel Stahl wrote:
>> The following patch adds support for the ST Microelectronics lis331dlh
>> accelerometer.
>> It is very similar to the lis3l02dq driver in staging (but updated to
>> the current API)
>> and there is also a driver in misc supporting a larger range of these
>> devices.
>> So sure, these should be merged, but I'm not sure how to do it properly.
> Just to make it more 'exciting' I have a driver from Denis queued up to
> handle a whole load of ST sensors. The intent there is to eventually
> cover all this sort of part.  So Denis, what is needed to add support
> for this chip? I would imagine, not a whole lot.
Forgot to say. The driver in question is in the togreg branch
of iio.git on kernel.org. I'll be sending it to Greg sometime over
the weekend I expect.
>>
>> Manuel Stahl (1):
>>    iio: accel: Add driver for lis331dlh
>>
>>   drivers/iio/Kconfig                  |    1 +
>>   drivers/iio/accel/Kconfig            |   16 ++
>>   drivers/iio/accel/Makefile           |    5 +
>>   drivers/iio/accel/lis331dlh_buffer.c |  132 +++++++++++
>>   drivers/iio/accel/lis331dlh_core.c   |  429
>> ++++++++++++++++++++++++++++++++++
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

