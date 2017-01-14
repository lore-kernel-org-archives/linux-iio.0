Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51418 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdANNKq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2017 08:10:46 -0500
Subject: Re: [PATCH] iio: magnetometer: ak8974: remove redundant zero timeout
 check
To: Linus Walleij <linus.walleij@linaro.org>,
        Colin King <colin.king@canonical.com>
References: <20170111174933.22523-1-colin.king@canonical.com>
 <CACRpkdbGrtRa5=QzzCa6M4hAbLeHwrzRtPd3gbFf=Y84aVON5w@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8fccb220-4254-bc36-e1bc-abfb54a4fda6@kernel.org>
Date: Sat, 14 Jan 2017 13:10:43 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdbGrtRa5=QzzCa6M4hAbLeHwrzRtPd3gbFf=Y84aVON5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/01/17 23:11, Linus Walleij wrote:
> On Wed, Jan 11, 2017 at 6:49 PM, Colin King <colin.king@canonical.com> wrote:
> 
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> At the end of the delay loop timeout will always be zero
>> and hence the check for !timeout will always be true. Remove
>> the redundant check and the redundant return 0 at the end of
>> the function.
>>
>> Fixes CoverityScan CID#1357168 ("Logically dead code")
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Clever Coverity scan.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

