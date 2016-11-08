Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41892 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754183AbcKHU3P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Nov 2016 15:29:15 -0500
Subject: Re: [PATCH 1/2] iio: gyro: mpu3050: remove duplicate initializer
To: Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20161108135945.2217384-1-arnd@arndb.de>
 <CACRpkdaZhdF5UbUp8L4aVuJmeQd2nD0+rLHXjTtJZ64d_S1hFw@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c01248d3-7d1c-b270-0ef3-51b3ccc6c6e7@kernel.org>
Date: Tue, 8 Nov 2016 20:29:12 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdaZhdF5UbUp8L4aVuJmeQd2nD0+rLHXjTtJZ64d_S1hFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/11/16 15:39, Linus Walleij wrote:
> On Tue, Nov 8, 2016 at 2:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> The newly added mpu3050 driver has two initializations for the
>> module owner, which causes a warning for 'make W=1':
>>
>> include/linux/export.h:37:21: error: initialized field overwritten [-Werror=override-init]
>> drivers/iio/gyro/mpu3050-core.c:749:19: note: in expansion of macro 'THIS_MODULE'
>>
>> This removes one of the two.
>>
>> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git. Initially pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> 
> Yours,
> Linus Walleij
> 

