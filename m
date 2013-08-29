Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:37373 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284Ab3H2K1N (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2013 06:27:13 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so287840oag.12
        for <linux-iio@vger.kernel.org>; Thu, 29 Aug 2013 03:27:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <521E4E37.20105@kernel.org>
References: <1377372269-4978-1-git-send-email-sachin.kamat@linaro.org>
	<521E4E37.20105@kernel.org>
Date: Thu, 29 Aug 2013 15:57:12 +0530
Message-ID: <CAK9yfHwDuBoniZDhntw=4QpA4_aHQRfifF-oKA8YoYFBTW6jdA@mail.gmail.com>
Subject: Re: [PATCH 1/3] staging: iio: ad7150: Use devm_* APIs
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29 August 2013 00:53, Jonathan Cameron <jic23@kernel.org> wrote:
> On 08/24/13 20:24, Sachin Kamat wrote:
>> devm_* APIs are device managed and make code simpler.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> All 3 of this series applied.

Thanks Jonathan.

>
> Thanks.  I like these patches as I can review them on a mobile phone.
> (though then I have to remember to apply them later ;)

Hope you send them soon to Greg  too :)

>
> Hmm. I really need to update my own MAINTAINERS entries before that email
> address goes away.  For reference, jic23@kernel.org is the right one.
> Somehow updating these things is never urgent enough to get around to doing!

Do you want me to do it for you? :)

-- 
With warm regards,
Sachin
