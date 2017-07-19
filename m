Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:39233 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751448AbdGSMgc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jul 2017 08:36:32 -0400
Message-ID: <1500467788.25934.37.camel@perches.com>
Subject: Re: [PATCH v3 1/3] Staging: speakup: speakup_keypc.c: usleep_range
 is preferred over udelay
From: Joe Perches <joe@perches.com>
To: Jaya Durga <rjdurga@gmail.com>, gregkh@linuxfoundation.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date: Wed, 19 Jul 2017 05:36:28 -0700
In-Reply-To: <1500467157-14739-1-git-send-email-rjdurga@gmail.com>
References: <1500467157-14739-1-git-send-email-rjdurga@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2017-07-19 at 17:55 +0530, Jaya Durga wrote:
> Fix checkpatch issue: CHECK: usleep_range is preferred over udelay;
[]
> diff --git a/drivers/staging/speakup/speakup_keypc.c b/drivers/staging/speakup/speakup_keypc.c
[]
> @@ -28,7 +28,7 @@
>  
>  #define DRV_VERSION "2.10"
>  #define SYNTH_IO_EXTENT	0x04
> -#define SWAIT udelay(70)
> +#define SWAIT usleep_range(70, 150)

It'd probably be more sensible to remove this define as
SWAIT is used just once and use usleep_range directly.


