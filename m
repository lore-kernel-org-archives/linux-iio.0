Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E42FC433B4
	for <linux-iio@archiver.kernel.org>; Tue, 18 May 2021 12:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ECBC611CE
	for <linux-iio@archiver.kernel.org>; Tue, 18 May 2021 12:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbhERMjr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 18 May 2021 08:39:47 -0400
Received: from first.geanix.com ([116.203.34.67]:33356 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239716AbhERMjr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 08:39:47 -0400
Received: from [192.168.64.199] (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 98D21464055;
        Tue, 18 May 2021 12:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1621341506; bh=N8dF9lNhoA62MtvBLfiXHYsJEDkxAjPBIVcvZZB2w84=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hEbAO8ZmeNTFvzKOciKV7IiVmLhi32RQZ9aMpYS+O8mg4jB8lLEuTPdN1s8Wo4sTf
         FU/5q/SAkbM17psfqdhxBb9Egwd6o0TiLZlqrliN+OTMEM7JlQFhU90ReWqb5v0hI1
         zNR0k9Dxapjmc9TDbhI6EJdAjGFCZ7+xL/COOVQUgfH9QWVwsRVMR0cCGqL5WGCJRf
         QgMpQuGMHlWM9GRHdUgCjNUkOZeM2qunIMAC02bOm7dSJfL3LigxqbW3Sej4dziZfs
         OcNe4mQZQkvCXbBEQ60Bs37YNDZBzlpecEKOptYoyyXuTikpz/SO/jLhbpNJIiuKv5
         hpZ5p9RcfcE2A==
Subject: Re: [PATCH v1 1/1] iio: Drop Duplicated "mount-matrix" parameter
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Robertson <dan@dlrobertson.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <20210518112546.44592-1-andriy.shevchenko@linux.intel.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <66a1a5e2-181d-bcc6-b453-357fcfd5e5f1@geanix.com>
Date:   Tue, 18 May 2021 14:38:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518112546.44592-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 18/05/2021 13.25, Andy Shevchenko wrote:
> All of the users of iio_read_mount_matrix() are using the very same
> property name. Moreover, the property name is hard coded in the API
> documentation.
> 
> Make this clear and avoid duplication now and in the future.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---Good idea :)
