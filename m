Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60738 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbdETR5l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2017 13:57:41 -0400
Subject: Re: [PATCH 0/7] twl4030-madc cleanup
To: Sebastian Reichel <sre@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
 <20170520165450.aet2oekjakzorcw3@earth>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2c9e59f1-6bf9-bdd8-eb03-4e46e5333883@kernel.org>
Date: Sat, 20 May 2017 18:57:39 +0100
MIME-Version: 1.0
In-Reply-To: <20170520165450.aet2oekjakzorcw3@earth>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/05/17 17:54, Sebastian Reichel wrote:
> Hi,
> 
>> Here are a few cleanup patches for the twl4030-madc
>> driver, that remove the last users of the driver's
>> legacy API and then remove it.
>>
>> Sebastian Reichel (7):
>>    hwmon: twl4030-madc: drop driver
>>    power: supply: avoid unused twl4030-madc.h
>>    iio: adc: twl4030: Drop twl4030_get_madc_conversion()
>>    iio: adc: twl4030: Unexport twl4030_madc_conversion()
>>    iio: adc: twl4030: Drop struct twl4030_madc_user_parms
>>    iio: adc: twl4030: Remove twl4030_madc_request.func_cb
>>    iio: adc: twl4030: Fold twl4030-madc.h into driver
> 
> Just a reminder, that patch 1 & 2 have been merged into 4.12-rc1
> and Wolfram acked the changes to header in include/linux/i2c,
> so patch 3-7 can be queued by iio for 4.13 :)
> 
> -- Sebastian
> 
Thanks for the reminder.  I'll have to wait until I've fast
forwarded my togreg branch of iio.git (possibly a week or
so) as I have a lot of stuff queued up from prior to and
during the merge window.  That'll pull in the driver drop at
which point the rest should go in nicely.

Anyhow, please feel free to remind me again if I look
like I've forgotten this after the fast forward merge has
occurred.

Jonathan
