Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:37820 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbeHSVMB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Aug 2018 17:12:01 -0400
Subject: Re: [PATCH] iio: adxl345: move null check for i2c id at start of
 probe
To: Himanshu Jha <himanshujha199640@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, eraretuya@gmail.com,
        dan.carpenter@oracle.com
References: <20180807140605.19156-1-alexandru.ardelean@analog.com>
 <20180811101833.GA5243@himanshu-Vostro-3559>
 <20180819183132.4f785935@archlinux>
 <20180819174309.GA14393@himanshu-Vostro-3559>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d0598278-31b6-8b47-6106-259b1d287e42@metafoo.de>
Date: Sun, 19 Aug 2018 19:59:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180819174309.GA14393@himanshu-Vostro-3559>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/19/2018 07:43 PM, Himanshu Jha wrote:
> On Sun, Aug 19, 2018 at 06:31:32PM +0100, Jonathan Cameron wrote:
>> On Sat, 11 Aug 2018 15:48:33 +0530
>> Himanshu Jha <himanshujha199640@gmail.com> wrote:
>>
>>> On Tue, Aug 07, 2018 at 05:06:05PM +0300, Alexandru Ardelean wrote:
>>>> Fixes ef89f4b96a2 ("iio: adxl345: Add support for the ADXL375").
>>>>
>>>> This was found via static checker.
>>>> After looking into the code a bit, it's unlikely that there will be a NULL
>>>> dereference if the `id` object in that specific code path.
>>>> However, it's safe to add a NULL (paranoid) check just to make sure and
>>>> remove any uncertainties.  
>>>
>>> I would like to know when would that case happen actually ?
>>>
>>> Because probe will only be called only when a match occurs either
>>> through DT or id matching. Isn't it ?
>>>
>> Yes. Alternative would have just not been to check it, but this is fine
>> so applied. I'm not going to rush this through stable though given
>> I don't think it can actually happen.
> 
> Thanks for the confirmation.
> 
> So, I have another doubt and it seems to be right time to ask.
> 
> BME680 currently supports both ACPI matching and traditional ID
> matching. So, it there any priority list to which patch the driver
> would choose to match the device.
> 
> ACPI > ID matching ? (In my case this happens)
> 
> Because this matching tends to decide the `name` attribute of loaded
> driver.
> 
> For ACPI: BME0680 (not sure maybe it was I2C0:BME0680)
> For ID: bme680

Yeah, that's wrong. But pretty much all ACPI drivers have that issue.
Maybe we should just deprecate the name attribute.
