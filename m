Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway24.websitewelcome.com ([192.185.50.91]:24185 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751253AbdGQE5v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2017 00:57:51 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 9D8FE15A8DB
        for <linux-iio@vger.kernel.org>; Sun, 16 Jul 2017 23:57:51 -0500 (CDT)
Subject: Re: [PATCH] iio: adc: rockchip_saradc: add NULL check on
 of_match_device() return value
To: Jonathan Cameron <jic23@kernel.org>
References: <20170707065131.GA23382@embeddedgus>
 <20170709191007.5d79c950@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Heiko Stuebner <heiko@sntech.de>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <d3f15aae-160a-1cc9-14dd-c021c2d5a490@embeddedor.com>
Date: Sun, 16 Jul 2017 23:57:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170709191007.5d79c950@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 07/09/2017 01:10 PM, Jonathan Cameron wrote:
> On Fri, 7 Jul 2017 01:51:31 -0500
> "Gustavo A. R. Silva" <garsilva@embeddedor.com> wrote:
>
>> Check return value from call to of_match_device()
>> in order to prevent a NULL pointer dereference.
>>
>> In case of NULL print error message and return -ENODEV
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> Applied.
>

Thank you, Jonathan.

-- 
Gustavo A. R. Silva
