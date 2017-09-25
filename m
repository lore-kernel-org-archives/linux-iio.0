Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:39541 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932784AbdIYGhW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 Sep 2017 02:37:22 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 5F27D20ADD
        for <linux-iio@vger.kernel.org>; Mon, 25 Sep 2017 08:37:21 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 25 Sep 2017 08:37:13 +0200
From: Martin Kepplinger <martink@posteo.de>
To: Harinath Nampally <harinath922@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        amsfield22@gmail.com
Subject: Re: [PATCH 3/3] iio: accel: mma8452: Add single pulse/tap event
 detection feature for fxls8471.
In-Reply-To: <1506309333-1970-4-git-send-email-harinath922@gmail.com>
References: <1506309333-1970-1-git-send-email-harinath922@gmail.com>
 <1506309333-1970-4-git-send-email-harinath922@gmail.com>
Message-ID: <4958a2c40ffe36b84c15b3573762e537@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 25.09.2017 05:15 schrieb Harinath Nampally:
> This patch adds following changes to support tap feature:
> - defines pulse event related registers
> - enables and handles single pulse interrupt for fxls8471
> - handles IIO_EV_DIR_EITHER in read/write callbacks
>   because event direction for pulse is either rising or
>   falling.
> - configures read/write event value for pulse latency register
>   using IIO_EV_INFO_HYSTERESIS.
> - add multiple events like pulse and tranient event spec
>   as elements of event_spec array named 'mma8452_accel_events'
> 
> Except mma8653 chip all other chips like mma845x and
> fxls8471 have single tap detection feature.
> Tested thoroughly using iio_event_monitor application on
> imx6ul-evk board.
> 

Doesn't fit in your patchset. I'd like to review this (most likely as 
soon
as it applies to -next) so either post this seperately or rename your
cover letter.

thanks

                      martin

