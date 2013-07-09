Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43478 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722Ab3GISFX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jul 2013 14:05:23 -0400
Message-ID: <51DC50E1.30007@kernel.org>
Date: Tue, 09 Jul 2013 19:05:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Alexandre Relange <alexandre@relange.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: mechanical: new category of sensors
References: <1370962336-20739-1-git-send-email-alexandre@relange.org> <1370962336-20739-2-git-send-email-alexandre@relange.org> <51D9896A.5080701@kernel.org> <51DAD459.3090802@relange.org>
In-Reply-To: <51DAD459.3090802@relange.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/08/2013 04:01 PM, Alexandre Relange wrote:
> Le 07/07/2013 17:29, Jonathan Cameron a écrit :
>> On 06/11/2013 03:52 PM, Alexandre Relange wrote:
>>> adds the category of mechanical sensors (switches,...)
>>>
>>> Signed-off-by: Alexandre Relange <alexandre@relange.org>
>> Support like this should be introduced with the first driver, i.e. in
>> the same patch in my view.
>>
>> The outstanding issue not answered yet for these is how a mechanical
>> switch is different from a general purpose input?
> 
> Sorry not to have taken the time to solve this earlier.
> Moving this driver in "gpio" is fine for me.

> But I finally do not really like to create this one-driver-catergory for
> some reasons:
> - we should be more confident that category will be useful for other drivers
Whilst we might not have any straight gpio devices, there are plenty of compound
devices out there with GPIs alongside other forms of sensor.  Right now I don't
think we have any where it is truely sampled alongside the main channels, but
this is common on data capture cards so is sure to be integrated on some parts.

> - hid-sensors-switch might not stay for long. I guess our maintainer
> will not like to have one hid-sensor driver for each one of the hundred
> of sensor classes, especially since this architecture is not fully
> compliant. I will send details on this issue later.
> Unless you think this simple driver is a good reason to create a 'gpio'
> category that will be useful for other drivers, I suggest to give it up
> and I will work on the architecture issue as soon as I have the time to
> do it, but it seems it will not be for the 3.11...

Up to you either way.
> 
>>
>>> --- drivers/iio/Kconfig             | 1 + drivers/iio/Makefile
>>> | 1 + drivers/iio/mechanical/Kconfig  | 6 ++++++
>>> drivers/iio/mechanical/Makefile | 3 +++ 4 files changed, 11
>>> insertions(+) create mode 100644 drivers/iio/mechanical/Kconfig
>>> create mode 100644 drivers/iio/mechanical/Makefile
>>>
>>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig index
>>> b2f963b..dbed2f1 100644 --- a/drivers/iio/Kconfig +++
>>> b/drivers/iio/Kconfig @@ -70,5 +70,6 @@ source
>>> "drivers/iio/gyro/Kconfig" source "drivers/iio/imu/Kconfig" source
>>> "drivers/iio/light/Kconfig" source
>>> "drivers/iio/magnetometer/Kconfig" +source
>>> "drivers/iio/mechanical/Kconfig"
>>>
>>> endif # IIO diff --git a/drivers/iio/Makefile
>>> b/drivers/iio/Makefile index a0e8cdd..78ec75b 100644 ---
>>> a/drivers/iio/Makefile +++ b/drivers/iio/Makefile @@ -21,3 +21,4 @@
>>> obj-y += frequency/ obj-y += imu/ obj-y += light/ obj-y +=
>>> magnetometer/ +obj-y += mechanical/ diff --git
>>> a/drivers/iio/mechanical/Kconfig b/drivers/iio/mechanical/Kconfig
>>> new file mode 100644 index 0000000..b536fa2 --- /dev/null +++
>>> b/drivers/iio/mechanical/Kconfig @@ -0,0 +1,6 @@ +# +# Mechanical
>>> sensors +# +menu "Mechanical sensors" + +endmenu diff --git
>>> a/drivers/iio/mechanical/Makefile
>>> b/drivers/iio/mechanical/Makefile new file mode 100644 index
>>> 0000000..716098f --- /dev/null +++
>>> b/drivers/iio/mechanical/Makefile @@ -0,0 +1,3 @@ +# +# Makefile
>>> for IIO Mechanical sensors +#
>>>
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
