Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-224.synserver.de ([212.40.185.224]:1089 "EHLO
	smtp-out-067.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750762AbcAOFBv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jan 2016 00:01:51 -0500
Subject: Re: [PATCH] iio: adc: Add TI ADS1015 ADC driver support
To: Michael Welling <mwelling@ieee.org>,
	Daniel Baluta <daniel.baluta@intel.com>
References: <1452788708-3003-1-git-send-email-daniel.baluta@intel.com>
 <20160114165133.GA20246@deathstar>
Cc: jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	lucas.demarchi@intel.com, eibach@gdsys.de, linux@roeck-us.net
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5697D511.7040301@metafoo.de>
Date: Thu, 14 Jan 2016 18:04:17 +0100
MIME-Version: 1.0
In-Reply-To: <20160114165133.GA20246@deathstar>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/14/2016 05:51 PM, Michael Welling wrote:
> On Thu, Jan 14, 2016 at 06:25:08PM +0200, Daniel Baluta wrote:
>> The driver has sysfs readings with runtime PM support for power saving.
>> It also offers buffer support that can be used together with IIO software
>> triggers.
>>
> 
> It should be noted that the hwmon driver subsystem has support for this device.
> 
> http://lxr.free-electrons.com/source/drivers/hwmon/ads1015.c
> 
> The driver could likely be removed if this is accepted into iio.
> The hwmon subsystem has an iio wrapper driver.

If we do this we should instantiate the hwmon bridge for such drivers by
default, so that the userspace ABI is kept intact.

And of course we'd also need backwards compatibility for those horrible
devicetree bindings.

- Lars
