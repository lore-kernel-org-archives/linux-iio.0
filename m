Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37050 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754075AbdCKSfJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 13:35:09 -0500
Subject: Re: [PATCH v1 00/10] staging: iio: Remove exceptional & on functions
 name
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <1489242404-12352-1-git-send-email-singhalsimran0@gmail.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <51f4d827-550d-fb4f-0fc3-a5ba9b3c16f8@kernel.org>
Date: Sat, 11 Mar 2017 18:35:06 +0000
MIME-Version: 1.0
In-Reply-To: <1489242404-12352-1-git-send-email-singhalsimran0@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/03/17 14:26, simran singhal wrote:
> This patch-series removes exceptional & on functions name.
> 
> v1:
>   -Change the commit message of all the patches of the patch-series
Usual convention is to call the first (unlabelled) revision v1
implicitly which would have made this V2.  Doesn't really matter
though!

Jonathan
> 
> simran singhal (10):
>   staging: iio: ad7192: Remove exceptional & on function name
>   staging: iio: ad7780: Remove exceptional & on function name
>   staging: iio: cdc: ad7746: Remove exceptional & on function name
>   staging: iio: cdc: ad7152: Remove exceptional & on function name
>   staging: iio: adis16240: Remove exceptional & on function name
>   staging: iio: adis16201: Remove exceptional & on function name
>   staging: iio: adis16209: Remove exceptional & on function name
>   staging: iio: adis16203: Remove exceptional & on function name
>   staging: iio: resolver: Remove exceptional & on function name
>   staging: iio: gyro: Remove exceptional & on function name
> 
>  drivers/staging/iio/accel/adis16201.c     |  4 ++--
>  drivers/staging/iio/accel/adis16203.c     |  4 ++--
>  drivers/staging/iio/accel/adis16209.c     |  4 ++--
>  drivers/staging/iio/accel/adis16240.c     |  4 ++--
>  drivers/staging/iio/adc/ad7192.c          | 12 ++++++------
>  drivers/staging/iio/adc/ad7780.c          |  2 +-
>  drivers/staging/iio/cdc/ad7152.c          |  6 +++---
>  drivers/staging/iio/cdc/ad7746.c          |  4 ++--
>  drivers/staging/iio/gyro/adis16060_core.c |  2 +-
>  drivers/staging/iio/resolver/ad2s1200.c   |  2 +-
>  drivers/staging/iio/resolver/ad2s90.c     |  2 +-
>  11 files changed, 23 insertions(+), 23 deletions(-)
> 

