Return-Path: <SRS0=F8OE=P7=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECF4C282C0
	for <linux-iio@archiver.kernel.org>; Wed, 23 Jan 2019 09:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4332820870
	for <linux-iio@archiver.kernel.org>; Wed, 23 Jan 2019 09:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfAWJO2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:14:28 -0500
Received: from anchovy2.45ru.net.au ([203.30.46.146]:40229 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfAWJO2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Jan 2019 04:14:28 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2019 04:14:28 EST
Received: (qmail 22404 invoked by uid 5089); 23 Jan 2019 09:07:46 -0000
Received: by simscan 1.2.0 ppid: 22372, pid: 22373, t: 0.0433s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.122?) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 23 Jan 2019 09:07:46 -0000
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From:   Phil Reid <preid@electromag.com.au>
Subject: iio scale precision
Message-ID: <ec351562-c263-6550-4c6e-7ba2c605e5c0@electromag.com.au>
Date:   Wed, 23 Jan 2019 17:07:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

What's the best way to handle scale values for very high precision ADC's.

eg a 24 or even a 32 bit dac with a 2.5v full scale range.

Even using the nV conversion param it looses a fair bit of precision.

Would a option to return a rational number would be better?

Or am I doing something wrong.

-- 
Regards
Phil
