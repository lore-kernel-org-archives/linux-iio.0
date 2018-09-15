Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr50121.outbound.protection.outlook.com ([40.107.5.121]:5088
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbeIOQx4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Sep 2018 12:53:56 -0400
Subject: Re: [PATCH -next] iio: potentiometer: mcp4018: merge calls to
 of_match_device and of_device_get_match_data
To: YueHaibing <yuehaibing@huawei.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20180915105241.22584-1-yuehaibing@huawei.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <9f3c9f9a-6bb4-19ba-65ad-53f7edd2af20@axentia.se>
Date: Sat, 15 Sep 2018 13:35:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180915105241.22584-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2018-09-15 12:52, YueHaibing wrote:
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
