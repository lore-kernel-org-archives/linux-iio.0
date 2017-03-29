Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34998 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbdC2S45 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 14:56:57 -0400
Date: Wed, 29 Mar 2017 11:56:44 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: simran singhal <singhalsimran0@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH 0/4] drivers: iio: Replace ternary
 operator with min macro
Message-ID: <20170329185643.GA23885@d830.WORKGROUP>
References: <1490790791-5694-1-git-send-email-singhalsimran0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490790791-5694-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 29, 2017 at 06:03:07PM +0530, simran singhal wrote:
> Use macro min() to get the minimum of two values for brevity and readability. 
> 
> simran singhal (4):
>   iio: common: st_sensors: Replace ternary operator with min macro
>   iio: imu: st_lsm6dsx: Replace ternary operator with min macro
>   iio: imu: st_lsm6dsx: Replace ternary operator with min macro
>   iio: light: si1145: Replace ternary operator with min macro

Hi Simran,

I'm guessing these were found by Coccinelle. Please reference that
in the changelog.

FYI: 'Mileage will vary' on cleanup patches sent upstream.  Their
acceptance varies by subsystem and the change.  Consider sending
one such patch and await feedback.  Another option is to send one
and be direct. Ask below the line --- if such cleanup patches are
welcome.  Sometimes they create too much churn and are only taken
as part of a larger update to the particular driver.

Just my thoughts for future patches as Outreachy window closes :(
alisons

> 
>  drivers/iio/common/st_sensors/st_sensors_i2c.c | 2 +-
>  drivers/iio/humidity/hts221_core.c             | 2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 2 +-
>  drivers/iio/light/si1145.c                     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1490790791-5694-1-git-send-email-singhalsimran0%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
