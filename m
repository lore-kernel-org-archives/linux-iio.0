Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:35493 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbdJASKy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Oct 2017 14:10:54 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id A2FA920C61
        for <linux-iio@vger.kernel.org>; Sun,  1 Oct 2017 20:10:52 +0200 (CEST)
Subject: Re: [PATCH v3 1/3] iio: accel: mma8452: Rename structs holding event
 configuration registers to more appropriate names.
To: Jonathan Cameron <jic23@kernel.org>
Cc: Harinath Nampally <harinath922@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        amsfield22@gmail.com
References: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
 <1506336008-4480-2-git-send-email-harinath922@gmail.com>
 <768af6828fe70f4a0bd7ef402073d9f3@posteo.de>
 <20170930185913.4a2c85e3@archlinux>
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <3dac943e-5c50-363c-2e5b-77b2921e9e91@posteo.de>
Date: Sun, 1 Oct 2017 20:10:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170930185913.4a2c85e3@archlinux>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-09-30 19:59, Jonathan Cameron wrote:
> On Wed, 27 Sep 2017 08:52:54 +0200
> Martin Kepplinger <martink@posteo.de> wrote:
> 
>> Am 25.09.2017 12:40 schrieb Harinath Nampally:
>>> Improves code readability, no impact on functionality.
>>>
>>> Signed-off-by: Harinath Nampally <harinath922@gmail.com>
>>> ---  
>>
>> I'd prefer a shorter subject line here too, see patch 2/3
> 
> Agreed.  I'm unconvinced the change helps.  Perhaps that is
> because I don't fully understand why you are making the change?
> 

It's understandable for me. It simply uses "transient" and "ff_mt" in
order to describe sets of device-registers instead of "rising" and
"falling". That's more appropriate. I'd apply this if possible.

Even though it should be clear after reading the data sheet, this
particular issue sometimes gets confusing for people. Maybe a short
descriptive comment, pointing to the data sheet, would make sense?

                      martin
