Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334CBC433ED
	for <linux-iio@archiver.kernel.org>; Mon, 10 May 2021 17:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F294E60FE3
	for <linux-iio@archiver.kernel.org>; Mon, 10 May 2021 17:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhEJREa (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 10 May 2021 13:04:30 -0400
Received: from first.geanix.com ([116.203.34.67]:58216 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232428AbhEJRCz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 May 2021 13:02:55 -0400
Received: from [192.168.100.11] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id 89702468AE9;
        Mon, 10 May 2021 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620666107; bh=LKy8OQTkl07agMs2pFKdU/h8MoiiMScr94KCEERxjKI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=h6PxvhbrZXthkkdbEO39z1Ld1mvrwnt39i2CtuChOC2BSv47IXRmIJhaMoUtT5dp4
         iyaK+SG9kd27bqjJvj18u6kHVHo8Zju411TGRXh0uuKedry4jaOtUSY1Ra9v6Ehpy5
         ePa9jiRMvZlXpv7cyzvBCfXBdtNIFt9GVvZN2v7ibJ5tPkBw4sR38fBVOQxQUC2T4s
         KYe/ETdgXYFfefoyZ1g4FU7tRV7c9+xyI3p3cwYejgW7YQ+Uq09w+ZMs4epGB2+OJm
         O/wwEiWSJDI0JWb99ngNEYotivZnZnphVjfn51DasbFiHZxTrmcPIZEL2NGn8fSJbn
         7PagJjsJxmw2A==
Subject: Re: [PATCH v5 5/6] iio: accel: fxls8962af: add hw buffered sampling
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <20210506070940.312959-1-sean@geanix.com>
 <20210506070940.312959-5-sean@geanix.com>
 <20210508173947.47d18328@jic23-huawei>
 <f50d0b0f-f00d-35c9-9cf5-2a9e9ffaa8ca@geanix.com>
 <20210510143921.00001774@Huawei.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <0142ff9d-02e6-5433-c8b9-53cd304e16ff@geanix.com>
Date:   Mon, 10 May 2021 19:01:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210510143921.00001774@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/05/2021 15.39, Jonathan Cameron wrote:
>> Guess it's okay, but I can't find the patches here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=togreg
>>
> Gah. As happens far too often I forgot to push.  It's now there as testing to
> actually let the autobuilders poke a it.
> 
> 
Thanks :)
