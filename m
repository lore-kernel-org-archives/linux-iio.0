Return-Path: <SRS0=gXbi=6U=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111F1C28CBC
	for <linux-iio@archiver.kernel.org>; Wed,  6 May 2020 17:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB968206B8
	for <linux-iio@archiver.kernel.org>; Wed,  6 May 2020 17:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgEFRbo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 6 May 2020 13:31:44 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:30972 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgEFRbo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 May 2020 13:31:44 -0400
Received: from [192.168.1.41] ([92.148.185.155])
        by mwinf5d27 with ME
        id bVXe2200R3MbWjg03VXfnK; Wed, 06 May 2020 19:31:41 +0200
X-ME-Helo: [192.168.1.41]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 06 May 2020 19:31:41 +0200
X-ME-IP: 92.148.185.155
Subject: Re: [PATCH] iio: sca3000: Remove an erroneous 'get_device()'
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <20200506035206.192173-1-christophe.jaillet@wanadoo.fr>
 <CAHp75Vdi+ZYpQPHgoREQ6LTaUHTPmNkR7ULZaVNTJr7Bvh-q9Q@mail.gmail.com>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <0a8cd600-2b21-2076-1355-8c97d7ceb709@wanadoo.fr>
Date:   Wed, 6 May 2020 19:31:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdi+ZYpQPHgoREQ6LTaUHTPmNkR7ULZaVNTJr7Bvh-q9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Le 06/05/2020 à 12:38, Andy Shevchenko a écrit :
> On Wed, May 6, 2020 at 6:55 AM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>> This looks really unusual to have a 'get_device()' hidden in a 'dev_err()'
>> call.
>> Remove it.
>>
>> While at it add a missing \n at the end of the message.
>>
> It should have Fixes tag because it is a quite an issue (get_device()
> breaks reference counting with all problems we may expect).

Agreed and I usually do, but here, I've lost track when this driver has 
gone out of staging.

Based on:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/iio/accel/sca3000.c
The issue was already there on 2016/10/23, but when I try to go one step 
further:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/iio/accel/sca3000.c?id=2ccf61442ff142d2dde7c47471c2798a4d78b0ad
^^^^         ^^^^^^^
works but if I try to see the log for that:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/staging/iio/accel/sca3000.c
^^^         ^^^^^^^
is empty.

Most of the time, when I do it like that it works just fine, but not on 
this file.

Any other way to navigate in history of moved file would be appreciated.

CJ

>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> This patch is purely speculative.
>> I've looked a bit arround and see no point for this get_device() but other
>> eyes are welcomed :)
>> ---
>>   drivers/iio/accel/sca3000.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
>> index 66d768d971e1..6e429072e44a 100644
>> --- a/drivers/iio/accel/sca3000.c
>> +++ b/drivers/iio/accel/sca3000.c
>> @@ -980,7 +980,7 @@ static int sca3000_read_data(struct sca3000_state *st,
>>          st->tx[0] = SCA3000_READ_REG(reg_address_high);
>>          ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
>>          if (ret) {
>> -               dev_err(get_device(&st->us->dev), "problem reading register");
>> +               dev_err(&st->us->dev, "problem reading register\n");
>>                  return ret;
>>          }
>>
>> --
>> 2.25.1
>>
>
