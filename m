Return-Path: <SRS0=9Qm3=QA=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C7CC282C0
	for <linux-iio@archiver.kernel.org>; Thu, 24 Jan 2019 01:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F58F21872
	for <linux-iio@archiver.kernel.org>; Thu, 24 Jan 2019 01:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfAXBqy (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 23 Jan 2019 20:46:54 -0500
Received: from anchovy1.45ru.net.au ([203.30.46.145]:50584 "EHLO
        anchovy1.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfAXBqx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Jan 2019 20:46:53 -0500
Received: (qmail 5057 invoked by uid 5089); 24 Jan 2019 01:46:51 -0000
Received: by simscan 1.2.0 ppid: 4953, pid: 4954, t: 0.0345s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.122?) (preid@electromag.com.au@203.59.235.95)
  by anchovy1.45ru.net.au with ESMTPA; 24 Jan 2019 01:46:51 -0000
Subject: Re: ti-ads7950.c GPIO Pins
To:     Justin Chen <justinpopo6@gmail.com>, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        lars@metafoo.de, andriy.shevchenko@linux.intel.com,
        david@lechnology.com, Florian Fainelli <f.fainelli@gmail.com>
References: <CAJx26kVrDbxrp+rKQOhao_k5O8LThLcDRs8HibcohVEvhAF3Tg@mail.gmail.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <41ca1578-9bf4-59f1-758e-346d626b7e8a@electromag.com.au>
Date:   Thu, 24 Jan 2019 09:46:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJx26kVrDbxrp+rKQOhao_k5O8LThLcDRs8HibcohVEvhAF3Tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 24/01/2019 3:36 am, Justin Chen wrote:
> Hello,
> 
> I have an use case where I need to configure the 4 GPIO pins on a
> ADS7953. The current driver does not support this. What would be the
> proper way to implement this?
> 
> I created an IIO_VOLTAGE channel for each GPIO to enable or disable
> them, but this doesn't seem right to me.
> 
> Any suggestions?
G'day Justin,


What about using the existing gpio framework.
see iio/adc/stx104.c for an existing example
search for gpiochip


-- 
Regards
Phil
