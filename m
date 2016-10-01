Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:34162 "EHLO fe2.pruts.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750908AbcJAR12 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Oct 2016 13:27:28 -0400
Content-Type: text/plain; charset=UTF-8
From: Ico Doornekamp <ico@pruts.nl>
To: Alison Schofield <amsfield22@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] io: adc: ad7606_core: fix signed/unsigned number comparison
In-reply-to: <20161001164932.GA2815@d830.WORKGROUP>
References: <20160928134149.2563-1-ico@pruts.nl> <c4a0a801-14d6-7ea9-ec4f-958449a9dcb6@kernel.org> <1475338371-sup-5926@pruts.nl> <20161001164932.GA2815@d830.WORKGROUP>
Date: Sat, 01 Oct 2016 19:27:22 +0200
Message-Id: <1475342724-sup-634@pruts.nl>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* On 2016-10-01 18:49:33 +0200, Alison Schofield wrote:
 
> Flattering the maintainer, always good and so true, so true :)

Knowing when to flatter whom is often more imporant then cranking out
sweet code :)

> Here's something found by sparse for little penguin.
> See the Outreachy tasks page.  https://kernelnewbies.org/IIO_tasks
> 
> You'll see I leveraged your IIO_CHAN* patch for the first coding task.
> We have a second coding task for sparse endianness patches.  There are
> some remaining.  If you tell me you're grabbing one, I'll put it on
> our claimed page so an applicant doesn't start on it. 
> 
> I know this one is unclaimed at the moment:
> CHECK   drivers/iio/magnetometer/ak8974.c
> drivers/iio/magnetometer/ak8974.c:403:16: warning: cast to restricted
> __le16
> drivers/iio/magnetometer/ak8974.c:480:24: warning: cast to restricted
> __le16

Ah, great, I missed those. Patch following. Thanks,

-- 
:wq
^X^Cy^K^X^C^C^C^C
