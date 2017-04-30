Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60688 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425335AbdD3Sq5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 14:46:57 -0400
Subject: Re: [PATCH 1/7] hwmon: twl4030-madc: drop driver
To: Jonathan Cameron <jic23@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
 <20170427153012.32310-2-sebastian.reichel@collabora.co.uk>
 <20170427165159.GB30189@roeck-us.net>
 <567f0680-abe9-790e-aea7-65c98ae0698a@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>, J Keerthy <j-keerthy@ti.com>,
        linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <cf349c67-9c40-28ec-3ba3-91779c015425@roeck-us.net>
Date: Sun, 30 Apr 2017 11:46:52 -0700
MIME-Version: 1.0
In-Reply-To: <567f0680-abe9-790e-aea7-65c98ae0698a@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/30/2017 09:41 AM, Jonathan Cameron wrote:
> On 27/04/17 17:51, Guenter Roeck wrote:
>> On Thu, Apr 27, 2017 at 05:30:06PM +0200, Sebastian Reichel wrote:
>>> This driver is no longer needed:
>>>
>>>  * It has no mainline users
>>>  * It has no DT support and OMAP is DT only
>>>  * iio-hwmon can be used for madc, which also works with DT
>>>
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>
>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>
>> ... assuming this will be pushed through the same tree as the rest
>> of the series. Let me know if I should queue it up in hwmon for v4.12.
> We are too late for the series to go through IIO for the 4.12 cycle, so I guess it
> makes sense to take this one through hwmon if you still have time.
>
Ok, done.

Guenter

