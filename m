Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr20128.outbound.protection.outlook.com ([40.107.2.128]:57312
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbeIOQyS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Sep 2018 12:54:18 -0400
Subject: Re: [PATCH -next] iio: potentiometer: mcp4531: merge calls to
 of_match_device and of_device_get_match_data
To: YueHaibing <yuehaibing@huawei.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20180915105430.24052-1-yuehaibing@huawei.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <2e1acb79-cc13-bf11-86e0-5e813921f589@axentia.se>
Date: Sat, 15 Sep 2018 13:35:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180915105430.24052-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2018-09-15 12:54, YueHaibing wrote:
> Drop call to of_match_device, which is subsumed by the subsequent
> call to of_device_get_match_data.  The code becomes simpler, and a
> temporary variable can be dropped.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
