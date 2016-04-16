Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33507 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbcDPOFg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 10:05:36 -0400
Received: by mail-oi0-f53.google.com with SMTP id r78so15137983oie.0
        for <linux-iio@vger.kernel.org>; Sat, 16 Apr 2016 07:05:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <57123402.4000003@kernel.org>
References: <1460451311-9819-1-git-send-email-linus.walleij@linaro.org>
	<57123402.4000003@kernel.org>
Date: Sat, 16 Apr 2016 16:05:35 +0200
Message-ID: <CACRpkdaHmZf=fKznQk4jXYig8pE7v3RSE--QeeCnk=ucVxdvEA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: tools: generic_buffer: auto-enable channels
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Apr 16, 2016 at 2:45 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 12/04/16 09:55, Linus Walleij wrote:

>> ChangeLog v1->v2:
>> - Provide for using the -a flag to indicate that you want all
>>   available channels enabled.
>
> Good plan.  I'll wait for the updated version but am fine with this
> in principle.

I think I sent out v3 already, you have mail ;)

Yours,
Linus Walleij
