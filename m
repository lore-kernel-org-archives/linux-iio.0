Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58348 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754237AbcIJPCf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Sep 2016 11:02:35 -0400
Subject: Re: [PATCH v5 1/3] hwmon: iio_hwmon: defer probe when no channel is
 found
To: Guenter Roeck <linux@roeck-us.net>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        jdelvare@suse.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, maxime.ripard@free-electrons.com, wens@csie.org,
        lee.jones@linaro.org
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-2-git-send-email-quentin.schulz@free-electrons.com>
 <c29e256c-7bff-ac45-6ee5-1f21a33f22b2@roeck-us.net>
Cc: thomas.petazzoni@free-electrons.com,
        antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f335adaf-b670-07f0-9578-b18016c3322d@kernel.org>
Date: Sat, 10 Sep 2016 16:02:32 +0100
MIME-Version: 1.0
In-Reply-To: <c29e256c-7bff-ac45-6ee5-1f21a33f22b2@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/09/16 05:26, Guenter Roeck wrote:
> On 09/08/2016 07:28 AM, Quentin Schulz wrote:
>> iio_channel_get_all returns -ENODEV when it cannot find either phandles and
>> properties in the Device Tree or channels whose consumer_dev_name matches
>> iio_hwmon in iio_map_list. The iio_map_list is filled in by iio drivers
>> which might be probed after iio_hwmon.
>>
>> It is better to defer the probe of iio_hwmon if such error is returned by
>> iio_channel_get_all in order to let a chance to iio drivers to expose
>> channels in iio_map_list.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>
>> v5:
>>  - patch re-inserted,
>>
> Grumble ... applied to -next anyway.
> 
> I'll direct any complaints your way ;-)
> 
> Guenter
> 
Thanks.  I'll try and squeeze some time to look at a more general
solution (reworking how we set the maps up in the first place) if
no one else gets to it first!

It's on the list :)

Jonathan

