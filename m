Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:32957 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938679AbcJTRYw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2016 13:24:52 -0400
Received: by mail-lf0-f45.google.com with SMTP id x79so99850193lff.0
        for <linux-iio@vger.kernel.org>; Thu, 20 Oct 2016 10:24:51 -0700 (PDT)
Subject: Re: [PATCH] thermal: generic-adc: Fix linear temperature
 approximation
To: Laxman Dewangan <ldewangan@nvidia.com>
References: <20161018193147.GA14745@vaio-ubuntu> <5808BB3D.2020201@nvidia.com>
 <8d2a5917-30b4-d9eb-304a-b96780de9f4c@gmail.com>
 <5808E78B.4060109@nvidia.com>
 <0412f751-fb88-7b9e-8a8c-501e019de774@gmail.com>
 <5808F86A.4080800@nvidia.com>
Cc: linux-iio@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com
From: =?UTF-8?Q?Pawe=c5=82_Jarosz?= <paweljarosz3691@gmail.com>
Message-ID: <bd01678c-5cf4-e50c-2dff-5aea04040e29@gmail.com>
Date: Thu, 20 Oct 2016 19:26:03 +0200
MIME-Version: 1.0
In-Reply-To: <5808F86A.4080800@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> It is Negative Coefficient Thermistor (NCT) and so adc reads are 
> different.
> Lower temp gives higher value.
>
> So table should be
>
> <7000 10
> 9000 8>;
>
> temp1 = gti->lookup_table[2 * i];
> temp2 = gti->lookup_table[2 * i - 2];
>
> and then use in following equation.
>
>>
>>     adc_hi = gti->lookup_table[2 * i - 1];
>>     adc_lo = gti->lookup_table[2 * i + 1];
>>     temp = gti->lookup_table[2 * i];
>>     temp -= (val - adc_lo) * (temp1 - temp2) / (adc_hi - adc_lo);

val = 9
adc_hi = 10
adc_lo = 8
temp = 9000 - (9 - 8)*(7000 - 9000)/(10 - 8)
temp = 9000 - (1)*(-2000)/(2)

temp = 9000 - (-1000) = 10000

still wrong ... temp for val = 9 should be 8000

Maybe we could leave this patch as it is?


Paweł
