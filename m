Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42772 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbcH2TNv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 15:13:51 -0400
Subject: Re: [PATCH] fix:iio:common:st_sensors:st_sensors_trigger:mark symbols
 static where possible
To: Linus Walleij <linus.walleij@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>
References: <1472279190-23169-1-git-send-email-baoyou.xie@linaro.org>
 <CACRpkdZgXX9v9AZcjb955rf8U2jNNM2J6X_jboDDKGS0z0CQsA@mail.gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, rob@kernel.org,
        maitysanchayan@gmail.com,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@linaro.org>, xie.baoyou@zte.com.cn
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <849dac94-63e1-8e0a-584c-b5c02dd811a7@kernel.org>
Date: Mon, 29 Aug 2016 20:13:49 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdZgXX9v9AZcjb955rf8U2jNNM2J6X_jboDDKGS0z0CQsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/08/16 09:44, Linus Walleij wrote:
> On Sat, Aug 27, 2016 at 8:26 AM, Baoyou Xie <baoyou.xie@linaro.org> wrote:
> 
>> We get 2 warnings when biuld kernel with W=1:
>> drivers/iio/common/st_sensors/st_sensors_trigger.c:69:13: warning: no previous prototype
>> for 'st_sensors_irq_handler' [-Wmissing-prototypes]
>> drivers/iio/common/st_sensors/st_sensors_trigger.c:85:13: warning: no previous prototype
>> for 'st_sensors_irq_thread' [-Wmissing-prototypes]
>>
>> In fact, these functions are only used in the file in which they are
>> declared and don't need a declaration, but can be made static.
>> so this patch marks these functions with 'static'.
>>
>> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git. Initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> 
> Yours,
> Linus Walleij
> 

