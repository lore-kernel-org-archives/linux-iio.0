Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A579C433ED
	for <linux-iio@archiver.kernel.org>; Fri,  9 Apr 2021 06:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFE5610FC
	for <linux-iio@archiver.kernel.org>; Fri,  9 Apr 2021 06:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhDIGyL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 9 Apr 2021 02:54:11 -0400
Received: from www381.your-server.de ([78.46.137.84]:49900 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhDIGyL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 02:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=m0u4XcGvYFcZ1UHSFyyZX1Jfe2bc3nmFCI95VAmpg/Y=; b=bPnDJ71ykZh+qpXXKWPEWeesS0
        WLPil5vj03znC6R7KltB9Ojr+UczWFOdzIROqQc8WS5uB12+c9ikHNFORL6OqH76eKH6TuwexOSKc
        C5yK8f1B2L1A0/RUrUDAbtzM3qR9FDwaBzq+jHfbBkthk4vU9x3Z3rLmnyvfTUNLagIOGyz+nGe2T
        DCihPb/6BMMzfMzj+hF43FEHelnphzri0INg9vQMwd0Y7yLjHURcAcal8U/aHQ8e+ULb9kYzFlKLf
        xywpC+a2/gv4+PyYS9pIUOlpIVZLHrJV6pSffmOX/MMHiAajIttTp2d0sJ8oSNsyPpZdYZQYkQU05
        2s9VAmYw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lUl1e-0001w4-R5; Fri, 09 Apr 2021 08:53:54 +0200
Received: from [2001:a61:2bab:901:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lUl1e-0005l9-MY; Fri, 09 Apr 2021 08:53:54 +0200
Subject: Re: [PATCH v4 2/2] iio: temperature: add driver support for ti tmp117
To:     Puranjay Mohan <puranjay12@gmail.com>,
        alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
References: <20210407182147.77221-1-puranjay12@gmail.com>
 <20210407182147.77221-3-puranjay12@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <66a723ee-c04c-a70c-42d3-03f6ffed9733@metafoo.de>
Date:   Fri, 9 Apr 2021 08:53:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210407182147.77221-3-puranjay12@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26134/Thu Apr  8 13:08:38 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/7/21 8:21 PM, Puranjay Mohan wrote:
> TMP117 is a Digital temperature sensor with integrated Non-Volatile memory.
> Add support for tmp117 driver in iio subsystem.
>
> Datasheet: https://www.ti.com/lit/gpn/tmp117
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Looks good to me, thanks.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

