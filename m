Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45631 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbcHLMke (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2016 08:40:34 -0400
Subject: Re: [PATCH v3 2/9] hwmon: (core) New hwmon registration API
To: Keerthy <a0393675@ti.com>, Jean Delvare <jdelvare@suse.com>
References: <1469417552-9749-1-git-send-email-linux@roeck-us.net>
 <1469417552-9749-3-git-send-email-linux@roeck-us.net>
 <57AD85C4.5020409@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Punit Agrawal <punit.agrawal@arm.com>,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"R, Vignesh" <vigneshr@ti.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ccf1b5d0-0dd0-cc9f-40e6-27f3bbae3bbf@roeck-us.net>
Date: Fri, 12 Aug 2016 05:40:25 -0700
MIME-Version: 1.0
In-Reply-To: <57AD85C4.5020409@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/12/2016 01:16 AM, Keerthy wrote:
> On Monday 25 July 2016 09:02 AM, Guenter Roeck wrote:
>> Up to now, each hwmon driver has to implement its own sysfs attributes.
>> This requires a lot of template code, and distracts from the driver's core
>> function to read and write chip registers.
>>
>> To be able to reduce driver complexity, move sensor attribute handling
>> and thermal zone registration into hwmon core. By using the new API,
>> driver code and data size is typically reduced by 20-70%, depending
>> on driver complexity and the number of sysfs attributes supported.
>>
>> With this patch, the new API only supports thermal sensors. Support for
>> other sensor types will be added with subsequent patches.
>>
> Hi Guenter,
>
> Seems like this patch introduces a cycling dependency between
> thermal_sys and hwmon:
>
> DEPMOD 4.8.0-rc1-next-20160811-00001-g2f84cf7854e7
> depmod: ERROR: Found 2 modules in dependency cycles!
> depmod: ERROR: Cycle detected: hwmon -> thermal_sys -> hwmon
>
> As reported by R, Vignesh <vigneshr@ti.com>.
>

Hmm ... interesting. Thanks for letting me know. I'll have to think about that.

Guenter

