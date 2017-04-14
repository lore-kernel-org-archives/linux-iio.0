Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56840 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751720AbdDNPoZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2017 11:44:25 -0400
Subject: Re: [PATCH] iio: light: apds9960: add system-wide suspend
To: Matt Ranostay <matt.ranostay@konsulko.com>,
        "open list:IIO SUBSYSTEM AND..." <linux-iio@vger.kernel.org>
References: <20170413021657.30434-1-matt.ranostay@konsulko.com>
 <CAJCx=gkQPWNirL4JazWwVHD41Cpy3=HPDwuD_kmbf6UzzOYvPg@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <30c531f9-6ca6-5a27-e745-3f16389ed100@kernel.org>
Date: Fri, 14 Apr 2017 16:44:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAJCx=gkQPWNirL4JazWwVHD41Cpy3=HPDwuD_kmbf6UzzOYvPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/17 19:21, Matt Ranostay wrote:
> On Wed, Apr 12, 2017 at 7:16 PM, Matt Ranostay
> <matt.ranostay@konsulko.com> wrote:
>> APDS9960 can safefully force runtime suspend if the system wants
> 
> Yikes! Typo should be -> safely
Applied and fixed up typo.

Jonathan
> 
>> to enter system-wide suspend
>>
>> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
>> ---
>>  drivers/iio/light/apds9960.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
>> index a4304edc3e0f..67da1287e987 100644
>> --- a/drivers/iio/light/apds9960.c
>> +++ b/drivers/iio/light/apds9960.c
>> @@ -1112,6 +1112,8 @@ static int apds9960_runtime_resume(struct device *dev)
>>  #endif
>>
>>  static const struct dev_pm_ops apds9960_pm_ops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +                               pm_runtime_force_resume)
>>         SET_RUNTIME_PM_OPS(apds9960_runtime_suspend,
>>                            apds9960_runtime_resume, NULL)
>>  };
>> --
>> 2.11.0
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

