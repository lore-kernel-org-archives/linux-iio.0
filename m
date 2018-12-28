Return-Path: <SRS0=LpUi=PF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE18C43387
	for <linux-iio@archiver.kernel.org>; Fri, 28 Dec 2018 08:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED272146F
	for <linux-iio@archiver.kernel.org>; Fri, 28 Dec 2018 08:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbeL1Iwd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:52:33 -0500
Received: from www381.your-server.de ([78.46.137.84]:41416 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbeL1Iwd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Dec 2018 03:52:33 -0500
X-Greylist: delayed 1356 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Dec 2018 03:52:32 EST
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1gcnWl-0007pB-UN; Fri, 28 Dec 2018 09:29:55 +0100
Received: from [188.174.112.20] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1gcnWl-000XW6-OP; Fri, 28 Dec 2018 09:29:55 +0100
Subject: Re: Loging int PlutoSDR
To:     Kerry Miller <n0wiq@comcast.net>, linux-iio@vger.kernel.org
References: <2569cb00-2759-f4c0-28e7-062a3e4a2f19@comcast.net>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <781e2c61-9f57-291a-141e-cdf64bbe936c@metafoo.de>
Date:   Fri, 28 Dec 2018 09:29:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <2569cb00-2759-f4c0-28e7-062a3e4a2f19@comcast.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.2/25246/Fri Dec 28 02:06:38 2018)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 12/23/18 12:40 PM, Kerry Miller wrote:
> I have forgotten the PlutoSDR
> ssh login and I don't remember where on the web I found that information
> a year ago.

You can find the ssh login details at
https://wiki.analog.com/university/tools/pluto/drivers/linux#ssh_config

- Lars

