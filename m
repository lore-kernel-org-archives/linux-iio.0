Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35028 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbcBHPRW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2016 10:17:22 -0500
Received: by mail-yw0-f178.google.com with SMTP id g127so103829315ywf.2
        for <linux-iio@vger.kernel.org>; Mon, 08 Feb 2016 07:17:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56B85C88.7040506@metafoo.de>
References: <cover.1454913458.git.bhumirks@gmail.com>
	<74ee6d155e15fbfe06512c7caa52f1575727402e.1454913458.git.bhumirks@gmail.com>
	<56B85C88.7040506@metafoo.de>
Date: Mon, 8 Feb 2016 17:11:44 +0200
Message-ID: <CAHp75Vf4V1w3_8rF3ukf9Lydd9OGg7pTeAsiUXiqognD4Mp36g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Staging:iio:Prefer using BIT macro
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Bhumika Goyal <bhumirks@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	jic23@kernel.org, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 8, 2016 at 11:14 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 02/08/2016 07:48 AM, Bhumika Goyal wrote:

>>               value = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
>>               data &= AD7816_TEMP_FLOAT_MASK;
>>               if (value < 0)
>> -                     data = (1 << AD7816_TEMP_FLOAT_OFFSET) - data;
>> +                     data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
>
>
> But in this case this is a false positive. The intended semantic meaning
> here is 2**... not BIT(...). Using BIT() here in my opinion only causes
> confusion.

+1. Here clearly the intention is to change sign of the value which
fits less than 32/16/8 bits. 1 << OFFSET represents '-0'.

-- 
With Best Regards,
Andy Shevchenko
