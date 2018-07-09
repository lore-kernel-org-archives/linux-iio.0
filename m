Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:36561 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754407AbeGIIGi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jul 2018 04:06:38 -0400
Subject: Re: st_accel: iis328dq support?
To: Denis CIOCCA <denis.ciocca@st.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <2bac9ecf-9d2e-967e-9020-1c950487d781@i2se.com>
 <20180706180201.000024a8@huawei.com>
 <a6f99e89de9a47a8b1f97c71c41a8eeb@SFHDAG2NODE1.st.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <6979b17e-a5d6-e506-f4e5-d9335ca0418f@i2se.com>
Date: Mon, 9 Jul 2018 10:06:23 +0200
MIME-Version: 1.0
In-Reply-To: <a6f99e89de9a47a8b1f97c71c41a8eeb@SFHDAG2NODE1.st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,


Am 06.07.2018 um 19:16 schrieb Denis CIOCCA:
> Hi Jonathan, Stefan,
>
> LIS331DLH and IIS327DQ are compatible.
> Mainly difference is the packaging since IIS is designed for industrial applications.
> If you can give it a shot will be great before adding the compatible string.

thanks for confirmation.

>
> Br,
> Denis
>
>
> -----Original Message-----
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: Friday, July 6, 2018 10:02 AM
> To: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>; Denis CIOCCA <denis.ciocca@st.com>; Jonathan Cameron <jic23@kernel.org>; linux-iio@vger.kernel.org
> Subject: Re: st_accel: iis328dq support?
>
> On Fri, 6 Jul 2018 09:18:53 +0200
> Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
>> Hi,
>> i want to use the ST IIS328DQ [1] on a ARM board with Linux. The iio
>> subsystem has this st_accel driver. But i didn't find any reference to
>> the IIS328DQ, so i started comparing the datasheets and found the ST
>> LIS331DLH [2].
> Given it reports the same WHO_AM_I of 0x32 it better be compatible or they are being very unhelpful!
>
>> Since i didn't have the hardware yet, i've the following questions:
>>
>> Does the st_accel driver support the IIS328DQ?
> Not if it's not listed - though it might work.
>
>> Should i choose the st,lis331dlh compatible for devicetree?
> Ideal is to add the addition compatible string and device name etc to the driver to support the part under this part number.
>
> It's always nicer if a DT matches the part number on the part you can see on the board!
>
> Jonathan
>
> p.s. If you don't fancy writing the patch, but will happily test it really is compatible, let us know and I'm sure someone else will pick it up if I don't.

after receiption of the hardware and testing i will send a patch.

Best regards
Stefan

>
>> Thanks in advance
>> Stefan
>>
>> [1] - https://www.st.com/resource/en/datasheet/iis328dq.pdf
>> [2] - https://www.st.com/resource/en/datasheet/cd00213470.pdf
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>

