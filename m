Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0083.outbound.protection.outlook.com ([104.47.32.83]:56445
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752876AbeEUQOV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 May 2018 12:14:21 -0400
Subject: Re: [PATCH v2 1/2] tools: iio: iio_generic_buffer: fix types to match
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
References: <20180518001446.15607-1-mkelly@xevo.com>
 <20180520145524.092a1d5d@archlinux>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <ee78f7cb-3168-54d9-5cbf-898598ced2c9@xevo.com>
Date: Mon, 21 May 2018 09:14:12 -0700
MIME-Version: 1.0
In-Reply-To: <20180520145524.092a1d5d@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/20/2018 06:55 AM, Jonathan Cameron wrote:
> On Thu, 17 May 2018 17:14:45 -0700
> Martin Kelly <mkelly@xevo.com> wrote:
> 
>> Several types are mismatched and causing implicit conversions.  Fix them
>> up so the types match.
>>
>> Signed-off-by: Martin Kelly <mkelly@xevo.com>
> Whilst I find it hard to care much about these, there might be a possible
> bug as a result, so fair enough to clean them up.
> 
> Applied to the togreg branch of iio.git and pushed out as testing.
> 
> Jonathan

Indeed, I doubt this will cause problems, but it can't hurt. This was a 
"while I was at it" fix for patch 2, which was the change I really 
wanted :).
