Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0078.outbound.protection.outlook.com ([104.47.33.78]:54473
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756506AbeDZRAO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Apr 2018 13:00:14 -0400
Subject: Re: Patch process question
To: Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
References: <80821ad8-08fe-2a2a-ea2d-08db094dcf4b@xevo.com>
 <0d12f947-30be-6289-776b-f9dd22e04766@metafoo.de>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <83b1f705-c427-dc86-53d2-fbfcff14258a@xevo.com>
Date: Thu, 26 Apr 2018 10:00:06 -0700
MIME-Version: 1.0
In-Reply-To: <0d12f947-30be-6289-776b-f9dd22e04766@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/25/2018 11:09 AM, Lars-Peter Clausen wrote:
> On 04/25/2018 07:49 PM, Martin Kelly wrote:
>> Hi,
>>
>> I have a quick question regarding the patch submission process for IIO.
>> Let's say I have a patch that I know will hit conflicts against other
>> accepted patches that are in linux-iio testing and/or togreg but have
>> not yet landed in torvalds master.
>>
>> Which of these things should I do?
>>
>> - Make patch against torvalds master (then it will have merge conflicts
>> when accepted).
>>
>> - Make patch against testing or togreg (whichever branch contains the
>> conflicts).
> 
> Either this...
> 
>> - Wait to test/send the patch until the patches with conflicts make it
>> into torvalds master (this could be a while, and depending on which
>> patches get accepted, more conflicts may arise again in testing/togreg).
> 
> or this.
> 

Thanks!
