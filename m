Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41658 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566Ab1BILGX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Feb 2011 06:06:23 -0500
Message-ID: <4D527536.8040602@cam.ac.uk>
Date: Wed, 09 Feb 2011 11:06:30 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4
References: <1297085367-27208-1-git-send-email-michael.hennerich@analog.com> <4D519B30.3060208@cam.ac.uk> <4D52505A.50803@analog.com>
In-Reply-To: <4D52505A.50803@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

<snip>
>>>
>>> +config AD7606
>>> +     tristate "Analog Devices AD7606 ADC driver"
>>> +     depends on GPIOLIB
>>>     
>> Is that the correct depend?  I think we need Generic GPIO but it is at least
>> in theary posible to have that without GPIOLIB.
>>   
> Well - before I utilized gpio_request_one() and friends the dependency
> was on GENERIC_GPIO.
> However  gpio_request_one() is defined as a function only in gpiolib,
> there could have been inline
> replacements in case of !GPIOLIB, but unfortunately thats not the case.
Ah fair enough. I guess these will only move into GENERIC_GPIO if someone
needs them on a board that isn't using GPIOLIB.

