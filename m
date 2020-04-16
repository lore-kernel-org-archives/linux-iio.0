Return-Path: <SRS0=XMpF=6A=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C99C2BB55
	for <linux-iio@archiver.kernel.org>; Thu, 16 Apr 2020 03:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D9C2076A
	for <linux-iio@archiver.kernel.org>; Thu, 16 Apr 2020 03:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391658AbgDPDsi (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:48:38 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:39008 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbgDPDsg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 23:48:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id D41862001496
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2020 11:48:32 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M1cWjeya7U_M for <linux-iio@vger.kernel.org>;
        Thu, 16 Apr 2020 11:48:32 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id B252A20129DE
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2020 11:48:32 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.188.146])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 823C1C019EC
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2020 11:48:32 +0800 (HKT)
To:     linux-iio@vger.kernel.org
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: inquiry: where to place iio/ bandpass filter driver
Message-ID: <55472b69-c587-ca04-d3b9-c8615e6a652d@gtsys.com.hk>
Date:   Thu, 16 Apr 2020 11:48:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

I'm working on implementation for ltc6602 dual match bandpass filter spi
driver.
The driver tree has a iio/frequency which has PLLs at time beeing and
I wondering to drop my driver there or have a new directory
freqfilter or bpf ?

This isn't urgent, but would be nice to know.

Regards
Chris
