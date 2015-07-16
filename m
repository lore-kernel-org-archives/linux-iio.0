Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33927 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbbGPRFJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2015 13:05:09 -0400
Received: by iebmu5 with SMTP id mu5so60068593ieb.1
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 10:05:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55A7771A.9020505@metafoo.de>
References: <CAMHSBOVNOKP=Q32YTL2_vwcW+FfHYNKyOPM4CaesthfoH5xidg@mail.gmail.com>
 <55A7771A.9020505@metafoo.de>
From: Gwendal Grignou <gwendal@google.com>
Date: Thu, 16 Jul 2015 10:04:49 -0700
Message-ID: <CAMHSBOWSSJP0F6jZh78ZCze9y-kYRRw11o_Ohxx3mTx-JVqYOQ@mail.gmail.com>
Subject: Re: Question about IIO_DEGREE_TO_RAD macro in include/linux/iio.h
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Got it, THX,

Gwendal.

On Thu, Jul 16, 2015 at 2:19 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/16/2015 01:24 AM, Gwendal Grignou wrote:
>>
>> Lars,
>>
>> Looking at the macro IIO_DEGREE_TO_RAD() to translate degree/s into rad/s,
>> I don't understand why we add an offset when doing the conversion:
>>
>> #define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) /
>> 18000000ULL)
>>
>> Shouldn't it just be
>> #define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL) / 18000000ULL)
>
>
> Hi,
>
> The offset is for rounding to the nearest integer. Without the offset it
> would round down.
>
> - Lars
>
>
