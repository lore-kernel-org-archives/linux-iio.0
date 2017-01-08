Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43060 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936659AbdAHJuN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:50:13 -0500
Subject: Re: [PATCH 19/19] staging: iio: isl29028: remove legacy device tree
 binding
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
 <1480817983-32359-20-git-send-email-masneyb@onstation.org>
 <927a9b4b-31e5-0f63-4526-97936a578648@kernel.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9cb901ec-8a8b-f37d-e0c4-2231ee33fc57@kernel.org>
Date: Sun, 8 Jan 2017 09:50:10 +0000
MIME-Version: 1.0
In-Reply-To: <927a9b4b-31e5-0f63-4526-97936a578648@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sorry all, appears some replies got stuck in my outbox and have just managed to send for some reason!

Jonathan

On 04/12/16 11:55, Jonathan Cameron wrote:
> On 04/12/16 02:19, Brian Masney wrote:
>> The isl29028 staging driver contains a legacy binding of "isl,isl29028"
>> that is marked as legacy and to not use. There are no in tree references
>> to that binding. This patch removes the legacy binding in preparation
>> for moving the driver out of staging. Otherwise, we will have to support
>> this binding indefinitely.
> Leave this be.  Given it exists there almost certainly device trees out there
> using it. Lets not break them just to save on one line of code.
> 
> Supporting legacy bindings isn't exactly costly!
> 
> I'm happy with all the patches I haven't commented on. Just can't apply
> them because they have dependencies on early patches that I have
> raised questions on.
> 
> Another generally nice bit of cleanup.
> 
> Thanks,
> 
> Jonathan
>>
>> Signed-off-by: Brian Masney <masneyb@onstation.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <Mark.Rutland@arm.com>
>> ---
>>  drivers/staging/iio/light/isl29028.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
>> index ae6896f..6be9aa7 100644
>> --- a/drivers/staging/iio/light/isl29028.c
>> +++ b/drivers/staging/iio/light/isl29028.c
>> @@ -611,7 +611,6 @@ static const struct i2c_device_id isl29028_id[] = {
>>  MODULE_DEVICE_TABLE(i2c, isl29028_id);
>>  
>>  static const struct of_device_id isl29028_of_match[] = {
>> -	{ .compatible = "isl,isl29028", }, /* for backward compat., don't use */
>>  	{ .compatible = "isil,isl29028", },
>>  	{ },
>>  };
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

