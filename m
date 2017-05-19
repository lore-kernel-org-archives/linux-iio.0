Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34782 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdESHgK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 May 2017 03:36:10 -0400
Subject: Re: [PATCH v2] staging: iio: light: Replace symbolic permissions as
 per coding style
To: Greg KH <gregkh@linuxfoundation.org>
References: <20170518090603.GA27644@kroah.com>
 <1495177391-29670-1-git-send-email-surenderpolsani@gmail.com>
 <20170519071558.GA12545@kroah.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregor.boirie@parrot.com,
        singhalsimran0@gmail.com, maitysanchayan@gmail.com,
        eraretuya@gmail.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
From: suri <surenderpolsani@gmail.com>
Message-ID: <cd265f3e-4beb-ef91-9b48-05c409c85fc4@gmail.com>
Date: Fri, 19 May 2017 13:06:04 +0530
MIME-Version: 1.0
In-Reply-To: <20170519071558.GA12545@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Friday 19 May 2017 12:45 PM, Greg KH wrote:
> On Fri, May 19, 2017 at 12:33:11PM +0530, surenderpolsani@gmail.com wrote:
>> From: Surender Polsani <surenderpolsani@gmail.com>
>>
>> Fixed the following checkpatch.pl warnings:
>> octal permissions are more preferable than symbolic permissions
>>
>> Replaced DEVICE_ATTR family macros with DEVICE_ATTR_RW family
>> as suggested by Greg K-H. Changed attributes and function
>> names where ever required to satisfy internal macro definitions
>> like __ATTR__RW().
>
> No you did not:
>
>> -static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
>> +static DEVICE_ATTR(power_state, 0644,
>>  		tsl2x7x_power_state_show, tsl2x7x_power_state_store);
>
> ???
>
> Wrong patch?
>

Sorry i sent wrong patch by mistake. I will send correct patch shortly.
