Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34666 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbdLBM76 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Dec 2017 07:59:58 -0500
Received: by mail-pl0-f66.google.com with SMTP id d21so7819778pll.1
        for <linux-iio@vger.kernel.org>; Sat, 02 Dec 2017 04:59:58 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] iio: accel: kxsd9: add MODULE_LICENSE
In-Reply-To: <20171202115840.7593e943@archlinux>
References: <20171201022131.26456-1-dja@axtens.net> <20171202115840.7593e943@archlinux>
Date: Sat, 02 Dec 2017 23:59:54 +1100
Message-ID: <87shctffp1.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

> On Fri,  1 Dec 2017 13:21:31 +1100
> Daniel Axtens <dja@axtens.net> wrote:
>
>> This fixes the following warning in an allmodconfig build:
>> WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/accel/kxsd9-i2c.o
>> 
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
> I clearly need to be a bit sharper with sending pull requests upstream.
>
> This is patch 3 for the same issue.

My apologies for the noise then - I was running my builds on linux-next
and the patch musn't have filtered though to there yet.

Regards,
Daniel

>
> Jonathan
>> ---
>>  drivers/iio/accel/kxsd9-i2c.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
>> index 98fbb628d5bd..5e14262248b8 100644
>> --- a/drivers/iio/accel/kxsd9-i2c.c
>> +++ b/drivers/iio/accel/kxsd9-i2c.c
>> @@ -63,3 +63,5 @@ static struct i2c_driver kxsd9_i2c_driver = {
>>  	.id_table	= kxsd9_i2c_id,
>>  };
>>  module_i2c_driver(kxsd9_i2c_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
