Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C428CDB465
	for <linux-iio@archiver.kernel.org>; Sat, 14 Oct 2023 12:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjJNMxp (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 14 Oct 2023 08:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjJNMxp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Oct 2023 08:53:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A8EB7;
        Sat, 14 Oct 2023 05:53:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC811C433C8;
        Sat, 14 Oct 2023 12:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697288023;
        bh=uUtGBAb/1IWM5+oLfn00HVz1r6IegTXwDfThcfuAGic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tvLTWYW2s2FXTsZFdCWXoC5NdCYb1b9Y92KiCSkX2OewK0Ink5FfKBSpvg1Dljnw3
         z+JHf4hI7vL50CB3+Pokl7c/YJgWV88FoKZva6o0BYawDuau8bbKZkGnZe9kCKXTTy
         J1DMJx4wyug74B5LjATNjvLH/7kMveXEDB/Mpocm0b/om++UrjGmtV5eUbjMiLzBqt
         8VPGZ9q5qrFWmLgFwK5gA+F7ZhX42jCUmVbod22zpv62NOp3SfH0/ibmoVftgnn4Fu
         sVZoe4FSIXuDo/gp3BDMVt1HkSR0ecwznEu+GWcxfTjOq9gzH457ZtTQRgztz0wRtv
         82dlYshXnpYZA==
Date:   Sat, 14 Oct 2023 13:54:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: resolver: ad2s1210: small cleanups
Message-ID: <20231014135400.51ebaac3@jic23-huawei>
In-Reply-To: <20231012-ad2s1210-mainline-v1-0-b2ee31c0e9dd@baylibre.com>
References: <20231012-ad2s1210-mainline-v1-0-b2ee31c0e9dd@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 12 Oct 2023 11:18:11 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This series contains a few small cleanups for the ad2s1210 resolver
> driver following up from the previous series[1].
> 
> [1] https://lore.kernel.org/linux-iio/20231012092522.27ef48dd@jic23-huawei
> 
> ---
> David Lechner (2):
>       iio: resolver: ad2s1210: remove DRV_NAME macro
>       iio: resolver: ad2s1210: remove of_match_ptr()
> 
>  drivers/iio/resolver/ad2s1210.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> ---
> base-commit: 291e45eeeb901b1d22b74ac5ea48cab3c407c705
> change-id: 20231012-ad2s1210-mainline-d80cc13acdce
> 
> Best regards,

Applied.  Thanks,

J
