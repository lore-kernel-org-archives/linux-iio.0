Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33686 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbcCNJYX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Mar 2016 05:24:23 -0400
Received: by mail-wm0-f53.google.com with SMTP id l68so93116980wml.0
        for <linux-iio@vger.kernel.org>; Mon, 14 Mar 2016 02:24:22 -0700 (PDT)
Subject: Re: [PATCH-vs-togreg 1/2] iio: ina2xx-adc: update the CALIB. register
 when RShunt changes
To: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <1457707950-17593-1-git-send-email-marc.titinger@baylibre.com>
 <56E3DF26.8050709@kernel.org>
Cc: afd@ti.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Marc Titinger <mtitinger@baylibre.com>
Message-ID: <56E68343.90904@baylibre.com>
Date: Mon, 14 Mar 2016 10:24:19 +0100
MIME-Version: 1.0
In-Reply-To: <56E3DF26.8050709@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 12/03/2016 10:19, Jonathan Cameron wrote:
> On 11/03/16 14:52, Marc Titinger wrote:
>> The user (or an init script) may setup RShunt via sysfs after the
>> driver was initialized, for instance based on the EEPROM contents
>> of a modular probe. The calibration register must be set accordingly.
>>
>> Signed-off-by: Marc Titinger <marc.titinger@baylibre.com>
> Other than the two little fixes (Andrew's and the autobuilder one)
> this series looks good to me.  Will pick up v2.
>
> I think both of these are fixes that will want to go through the fixes
> tree after the merge window has closed anyway.

Thanks Jon, sending v2 ASAP.

M.

>
> Jonathan
>> ---
>> tested with BeagleBone-black and BayLibre-acme.
>> ---
>>   drivers/iio/adc/ina2xx-adc.c | 36 +++++++++++++++++++++++++-----------
>>   1 file changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c

...
