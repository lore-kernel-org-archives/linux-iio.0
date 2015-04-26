Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:61317 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbbDZVuT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 26 Apr 2015 17:50:19 -0400
Message-ID: <553D5D90.30403@gmx.de>
Date: Sun, 26 Apr 2015 23:50:08 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH v2 00/17] Fixes for the mma9553 driver
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Irina Tirdea schrieb am 13.04.2015 um 17:40:
> This is a set of follow-up patches for the mma9553 driver that fixes
> issues as suggested by Hartmut and Daniel.
> 

Finally, I got around to this series. Looks good to me.
Thanks,

Hartmut

> Changes in v2:
>  - split some of the the v1 patches into smaller patches
> as suggested by Jonathan
>  - reordered the series to have bug fixes first followed by style fixes
>  - use Reported-by for bug fixes
>  - added more fixes for issues detected by checkpatch.pl --strict
> 
> Irina Tirdea (17):
>   iio: accel: mma9553: fix endianness issue when reading status
>   iio: accel: mma9553: check input value for activity period
>   iio: accel: mma9551_core: prevent buffer overrun
>   iio: accel: mma9553: add enable channel for activity
>   iio: accel: mma9551_core: wrong doc fixes
>   iio: accel: mma9551_core: typo fix in RSC APP ID
>   iio: accel: mma9553: check for error in reading initial activity and
>     stepcnt
>   iio: accel: mma9553: return 0 as indication of success
>   iio: accel: mma9553: comment and error message fixes
>   iio: accel: mma9553: use GENMASK
>   iio: accel: mma9553: prefix naming fixes
>   iio: accel: mma9553: fix gpio bitnum init value
>   iio: accel: mma9553: refactor mma9553_read_raw
>   iio: accel: mma9551_core: use size in words for word buffers
>   iio: accel: mma9553: fix alignment issues
>   iio: accel: mma9553: document use of mutex
>   iio: accel: mma9553: use unsigned counters
> 
>  drivers/iio/accel/mma9551_core.c |  70 ++++++-----
>  drivers/iio/accel/mma9551_core.h |   8 +-
>  drivers/iio/accel/mma9553.c      | 253 ++++++++++++++++++---------------------
>  3 files changed, 160 insertions(+), 171 deletions(-)
> 

