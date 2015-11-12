Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37557 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbbKLJiQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2015 04:38:16 -0500
Received: by wmww144 with SMTP id w144so79873680wmw.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2015 01:38:15 -0800 (PST)
Subject: Re: [RFC 1/4] iio: ina2xx: add direct IO support for TI INA2xx Power
 Monitors
To: Daniel Baluta <daniel.baluta@gmail.com>
References: <1447171653-12756-1-git-send-email-mtitinger@baylibre.com>
 <1447171653-12756-2-git-send-email-mtitinger@baylibre.com>
 <CAEnQRZBeZpBxSCf85MRmByguHA8kXTNp9+NPD2d3cdsMRb+74w@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	mturquette@baylibre.com, bcousson@baylibre.com,
	ptitiano@baylibre.com
From: Marc Titinger <mtitinger@baylibre.com>
Message-ID: <56445E05.6070604@baylibre.com>
Date: Thu, 12 Nov 2015 10:38:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZBeZpBxSCf85MRmByguHA8kXTNp9+NPD2d3cdsMRb+74w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/11/2015 13:09, Daniel Baluta wrote:
> <snip>
>
>> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
>> ---
>>   drivers/iio/adc/Kconfig      |   9 +
>>   drivers/iio/adc/Makefile     |   1 +
>>   drivers/iio/adc/ina2xx-iio.c | 404 +++++++++++++++++++++++++++++++++++++++++++
>
> One more thing. In IIO we do not prefer generic names for files.
> Lets name this after the first device in the family.
>
> Here I would say we should call it drivers/iio/adc/ina219.c. Skip the
> -iio suffix
> from file name, because it is already under the iio/ directory.

I get your point, but in this specific case there is already support for 
this chip family in hwmon and both drivers make sense because both 
applications exist (hardware monitoring or power measurement equipement).

To avoid confusion it may be good to have at least a common radix for 
the CONFIG option, so that searching returns both options.

>
> If there is a module name conflict with hwmon module we can name the
> .ko resulted
> from this file ina219-iio.ko.
>

