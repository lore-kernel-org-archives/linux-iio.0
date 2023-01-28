Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA444C38142
	for <linux-iio@archiver.kernel.org>; Sat, 28 Jan 2023 16:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjA1QJs (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 28 Jan 2023 11:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA1QJr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2023 11:09:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D680426595;
        Sat, 28 Jan 2023 08:09:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93DE9B808CC;
        Sat, 28 Jan 2023 16:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B21C433D2;
        Sat, 28 Jan 2023 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674922184;
        bh=RXtsnthzHwcQKd1fePbE4DMN5MTZvBnEsj8VtHyG+XA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u0ZYm4ugChYoWYDfIiFfAsApW96idkkmoI1rANf6atpA8ZEGhHIWgs2QMZx/kTlAD
         beMHixkTX2GceKIxC7X5DYoGPX+wXdsZgGKdfQbcmS9LGtE5wDUJ+GbaVAweMpfjpy
         PeGNeZ4W6fl9XSpMQzFqcrYXEOj+rO5UDL/hJ8Fhecr9xEtQ9tyypvxwmV+bAVtbT+
         XocagBC63cj99o91zabFGV/LwiEqXlMC5nGH+kPk18RtI7S3i0DChSsGwlQP+w9gyb
         RaqJzPBTYONRqcJAiZxRp7RAfL7faPQpzsFhqQEpPnALMVgf+KiCfhzlkwlqMQJA3H
         YqpwUzf7uRccA==
Date:   Sat, 28 Jan 2023 16:23:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     lars@metafoo.de, andrea.merello@iit.it, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: fix spdx format
Message-ID: <20230128162337.64f61d19@jic23-huawei>
In-Reply-To: <20230124194301.656518-1-trix@redhat.com>
References: <20230124194301.656518-1-trix@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Jan 2023 11:43:01 -0800
Tom Rix <trix@redhat.com> wrote:

> checkpatch reports
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> FILE: drivers/iio/imu/bno055/bno055_ser_trace.c:1:
> +//SPDX-License-Identifier: GPL-2.0
> 
> Add a space
> 
> Fixes: 2eef5a9cc643 ("iio: imu: add BNO055 serdev driver")
> Signed-off-by: Tom Rix <trix@redhat.com>
Applied to the togreg branch of iio.git and pushed out as testing
so other patches in my queue get tested (not going to find anything in this one!)

> ---
>  drivers/iio/imu/bno055/bno055_ser_trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bno055/bno055_ser_trace.c b/drivers/iio/imu/bno055/bno055_ser_trace.c
> index 48397b66daef..ab564186d19c 100644
> --- a/drivers/iio/imu/bno055/bno055_ser_trace.c
> +++ b/drivers/iio/imu/bno055/bno055_ser_trace.c
> @@ -1,4 +1,4 @@
> -//SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0
>  
>  /*
>   * bno055_ser Trace Support

