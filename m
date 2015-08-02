Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44731 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbbHBPpl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 11:45:41 -0400
Subject: Re: [PATCH v4 0/2] iio: light: add support for APDS9660 sensor
To: Matt Ranostay <mranostay@gmail.com>
References: <1437364640-7470-1-git-send-email-mranostay@gmail.com>
 <CAKzfze8tccxiWTcx4DWocdnm4M=W-5fToK-ABELW-JrdKtq-iA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE3B23.8010608@kernel.org>
Date: Sun, 2 Aug 2015 16:45:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze8tccxiWTcx4DWocdnm4M=W-5fToK-ABELW-JrdKtq-iA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/07/15 05:28, Matt Ranostay wrote:
> Jonathan,
> 
> Does this solve the issues in v3 minus the apds9960_regfield_init() cleanup?
> 
> 
> Thanks,
> 
> Matt
> 
Sorry, was on holiday last week.  Catching up now.
> On Sun, Jul 19, 2015 at 8:57 PM, Matt Ranostay <mranostay@gmail.com> wrote:
>> This patchset adds support for the APDS9960 ALS + proximity + gesture
>> sensor.
>>
>> Included support for the various adjustable settings and controls:
>>  * Falling and rising ALS + proximity thresholds events
>>  * Gain controls
>>  * ALS time integration
>>
>> Changes from v3:
>>  * Added interrupt client mode document reference in DT bindings
>>  * Add missing dep for CONFIG_REGMAP_I2C in respective Kconfig
>>  * Changed from iio_trigger_poll_chained() to irq_work queue
>>  * Changed channel masks to prevent channels that can't be polled from
>>    having sysfs entries
>>  * Renamed regmap_field declarations with apds9660_* prefix
>>  * Added available channel masks and removed unneeded buffer copy in
>>    poll function
>>  * Remove unneeded default regmap values in apds9960_reg_defaults
>>  * Clear interrupts from ALS and proximity sensor seperately to avoid
>>    race condition
>>  * Changed max threshold values to a macro define, and prevent values
>>    less than 0
>>  * Avoid needlessly checking the APDS9960_REG_GFLVL value until we read
>>    all the FIFO from the count value. Note this can save up to 32
>>    superfluous i2c reads per gesture engine entry
>>
>> Matt Ranostay (2):
>>   iio: light: DT binding docs for APDS9960 driver
>>   iio: light: add APDS9960 ALS + promixity driver
>>
>>  .../ABI/testing/sysfs-bus-iio-light-apds9960       |    7 +
>>  .../devicetree/bindings/iio/light/apds9960.txt     |   22 +
>>  drivers/iio/light/Kconfig                          |   13 +
>>  drivers/iio/light/Makefile                         |    1 +
>>  drivers/iio/light/apds9960.c                       | 1191 ++++++++++++++++++++
>>  5 files changed, 1234 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-apds9960
>>  create mode 100644 Documentation/devicetree/bindings/iio/light/apds9960.txt
>>  create mode 100644 drivers/iio/light/apds9960.c
>>
>> --
>> 1.9.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

