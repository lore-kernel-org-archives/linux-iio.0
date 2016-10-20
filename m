Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1649 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932416AbcJTRQl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2016 13:16:41 -0400
Message-ID: <5808F86A.4080800@nvidia.com>
Date: Thu, 20 Oct 2016 22:31:30 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: =?UTF-8?B?UGF3ZcWCIEphcm9zeg==?= <paweljarosz3691@gmail.com>
CC: <linux-iio@vger.kernel.org>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: generic-adc: Fix linear temperature approximation
References: <20161018193147.GA14745@vaio-ubuntu> <5808BB3D.2020201@nvidia.com> <8d2a5917-30b4-d9eb-304a-b96780de9f4c@gmail.com> <5808E78B.4060109@nvidia.com> <0412f751-fb88-7b9e-8a8c-501e019de774@gmail.com>
In-Reply-To: <0412f751-fb88-7b9e-8a8c-501e019de774@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Thursday 20 October 2016 10:40 PM, Paweł Jarosz wrote:
>
>> Yes please send patch to replace the 1000 with the temp1 - temp2 as 
>> what you did in your original patch.
>> This will fix the non-sequenced (un-equally spaced) temperature table.
>
> replacing 1000 with (temp1 - temp2) is not enough as for example for 
> val = 9 and table
>
> <7000 8
>  9000 10>


It is Negative Coefficient Thermistor (NCT) and so adc reads are different.
Lower temp gives higher value.

So table should be

<7000 10
9000 8>;

temp1 = gti->lookup_table[2 * i];
temp2 = gti->lookup_table[2 * i - 2];

and then use in following equation.

>
>     adc_hi = gti->lookup_table[2 * i - 1];
>     adc_lo = gti->lookup_table[2 * i + 1];
>     temp = gti->lookup_table[2 * i];
>     temp -= (val - adc_lo) * (temp1 - temp2) / (adc_hi - adc_lo);
>
>

> adc_hi = 8
> adc_lo = 10
> temp = 9000 - (9 - 10) * (7000 - 9000) / (8 - 10)
> temp = 9000 - (-1) * (-2000) / (-2)
> temp = 9000 - (-1000) = 10000
>
> and for val = 9 temp should be 8000.
>
>

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
