Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C50C433B4
	for <linux-iio@archiver.kernel.org>; Tue,  4 May 2021 10:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0534161176
	for <linux-iio@archiver.kernel.org>; Tue,  4 May 2021 10:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhEDKXN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 4 May 2021 06:23:13 -0400
Received: from first.geanix.com ([116.203.34.67]:46996 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhEDKXK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 May 2021 06:23:10 -0400
Received: from [192.168.100.10] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id F1B454672FE;
        Tue,  4 May 2021 10:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620123734; bh=DvjEbdXM+YwK/VtgClqx8F5XvELPDcbwnseD9yD1Ay0=;
        h=To:From:Subject:Date;
        b=j6jqV1YQ8UmstEOZupX1LsiCk6g4sCqpzrhC1oZdnTalqB37aZrcv0JyQJoZwozLT
         7Po52wMyGVbGfdNfW2lN/1vWba+QT8yNQXkny0TqKXkefHs1TxE+JrfPSWeT5S/T3R
         dyN+XQshC2+COsTBgeBo4iW0RZwsOIDxnkryZJLSveZ6id8QEcsgJaRMM2HMjdyt24
         WhcwUuf9MQBqmG/umSA195P2kfggNTOKAmCzwCxazOV9s9BRBIVtfNLu1oAxIYgQOH
         tQLexIY/jnPaiPUU8Tr+yENznB6X+GN4JIPTt3iR3fBtbZuFWuZxgZwMyz3z2im/3S
         sW1zdiF8bYamQ==
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Subject: iio: imu: st_lsm6dsx: sample rate?
Message-ID: <1b645b15-f866-ee45-1b92-8dd32340409a@geanix.com>
Date:   Tue, 4 May 2021 12:22:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Any specific reason to why the 12.5Hz sample rate is implemented as 13Hz ?

Br,
/Sean 
