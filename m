Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABE0C4320A
	for <linux-iio@archiver.kernel.org>; Tue, 24 Aug 2021 19:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE7061371
	for <linux-iio@archiver.kernel.org>; Tue, 24 Aug 2021 19:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhHXTqY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 24 Aug 2021 15:46:24 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:41101 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhHXTqY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 15:46:24 -0400
Received: from [192.168.1.18] ([90.126.253.178])
        by mwinf5d35 with ME
        id lXle250083riaq203XleLH; Tue, 24 Aug 2021 21:45:38 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 24 Aug 2021 21:45:38 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH] iio: adc128s052: Fix the error handling path of
 'adc128_probe()'
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        angelo.compagnucci@gmail.com,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <85189f1cfcf6f5f7b42d8730966f2a074b07b5f5.1629542160.git.christophe.jaillet@wanadoo.fr>
 <CA+U=DsoTdb3b+LJEtUagKr=LmK8E2M_2yhtNDENKsczqGaUPYA@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <f33069f0-601b-4bbb-3766-026f7a161912@wanadoo.fr>
Date:   Tue, 24 Aug 2021 21:45:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+U=DsoTdb3b+LJEtUagKr=LmK8E2M_2yhtNDENKsczqGaUPYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le 23/08/2021 à 08:42, Alexandru Ardelean a écrit :
> On Sat, Aug 21, 2021 at 1:43 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> A successful 'regulator_enable()' call should be balanced by a
>> corresponding 'regulator_disable()' call in the error handling path of the
>> probe, as already done in the remove function.
>>
>> Update the error handling path accordingly.
> 
> Good catch.
> For the fix:
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> 
> If you want, you can also send a conversion to
> devm_iio_device_register() for this driver.
> And also move the regulator_disable() on a devm_add_action_or_reset() callback.
> Maybe, that's already part of your plan. If so, apologies for the noise :)
> 

Hi,

I hadn't planned another step but I can send a follow-up patch for that.

CJ
