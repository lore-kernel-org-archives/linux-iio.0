Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:37803 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750854AbdI0Gqb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Sep 2017 02:46:31 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 7147820BA3
        for <linux-iio@vger.kernel.org>; Wed, 27 Sep 2017 08:46:29 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 27 Sep 2017 08:46:27 +0200
From: Martin Kepplinger <martink@posteo.de>
To: Harinath Nampally <harinath922@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        amsfield22@gmail.com
Subject: Re: [PATCH v3 3/3] iio: accel: mma8452: Rename read/write event
 value callbacks to generic function name.
In-Reply-To: <1506336008-4480-4-git-send-email-harinath922@gmail.com>
References: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
 <1506336008-4480-4-git-send-email-harinath922@gmail.com>
Message-ID: <6a0f1676591c924b9d93cdb0b98ba7f9@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 25.09.2017 12:40 schrieb Harinath Nampally:
> 'mma8452_read_thresh' and 'mma8452_write_thresh' functions
> does more than just read/write threshold values.
> They also handle  IIO_EV_INFO_HIGH_PASS_FILTER_3DB and
> IIO_EV_INFO_PERIOD therefore renaming to generic names.
> 
> Improves code readability, no impact on functionality.
> 
> Signed-off-by: Harinath Nampally <harinath922@gmail.com>

Acked-by: Martin Kepplinger <martink@posteo.de>
