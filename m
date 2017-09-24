Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752474AbdIXPkv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Sep 2017 11:40:51 -0400
Date: Sun, 24 Sep 2017 16:40:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 0/4] iio: light: vl6180: Several fixes and enhancements
Message-ID: <20170924164047.5f4869f5@archlinux>
In-Reply-To: <20170919031144.4968-1-stefan.bruens@rwth-aachen.de>
References: <20170919031144.4968-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 19 Sep 2017 05:11:40 +0200
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> Currently, the vl6180 driver reports bogus in_illuminance_scale values
> when the integration time or hardware gain are changed from its default
> value, i.e. it always reports a fixed value.
> 
> To avoid readback of the register values in case integration time, gain
> or scale is queried, save the register values. Use the saved values
> to report the correct scale value.

Hmm. I think unfortunately that this set is too large and invasive
to send as a fix.  Hence once the little corners are tidied up I'll
take it via the slow path ready for the next merge window.

Thanks,

Jonathan

> 
> Stefan Brüns (4):
>   iio: light: vl6180: Move range check to integration time setter,
>     cleanup
>   iio: light: vl6180: Avoid readback of integration time register
>   iio: light: vl6180: Cleanup als_gain lookup, avoid register readback
>   iio: light: vl6180: Correct ALS scale for non-default gain/integration
>     time
> 
>  drivers/iio/light/vl6180.c | 125 +++++++++++++++++++++++++--------------------
>  1 file changed, 69 insertions(+), 56 deletions(-)
> 

