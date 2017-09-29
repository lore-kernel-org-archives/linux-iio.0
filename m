Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:45924 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbdI2Ow1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Sep 2017 10:52:27 -0400
Received: by mail-oi0-f41.google.com with SMTP id f3so2416780oia.2
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2017 07:52:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <40d29879-54ee-f7eb-ce83-bedd066c0fa3@metafoo.de>
References: <20170928105641.11793-1-brgl@bgdev.pl> <40d29879-54ee-f7eb-ce83-bedd066c0fa3@metafoo.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 29 Sep 2017 16:52:26 +0200
Message-ID: <CAMRc=Md=EkmMevbn-a3K9=Tk67f4tuvqsLu2sGmD6swV9sYe2w@mail.gmail.com>
Subject: Re: [PATCH v2] iio: dummy: evgen: use irq_sim
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2017-09-29 15:15 GMT+02:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 09/28/2017 12:56 PM, Bartosz Golaszewski wrote:
>> Switch to using the recently added interrupt simulator for dummy irqs.
>>
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> Tested-by: Lars-Peter Clausen <lars@metafoo.de>
>
> I've backported irq_sim to v4.9 for testing and got compile errors due to a
> missing slab.h include. In upstream this include comes implicit through
> irq.h (coincidentally added by you), I wonder if we should still add it to
> irq_sim.c since it is explicitly using the allocation API.

Thanks for the hint, I'll send it together with other updates (e.g.
the reverse irq lookup).
