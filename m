Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:49368 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbdI0Gv2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Sep 2017 02:51:28 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id D6EA320CE1
        for <linux-iio@vger.kernel.org>; Wed, 27 Sep 2017 08:51:27 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 27 Sep 2017 08:51:26 +0200
From: Martin Kepplinger <martink@posteo.de>
To: Harinath Nampally <harinath922@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        amsfield22@gmail.com
Subject: Re: [PATCH v3 2/3] iio: accel: mma8452: Rename time step look up
 struct to generic name as the values are same for all the events.
In-Reply-To: <1506336008-4480-3-git-send-email-harinath922@gmail.com>
References: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
 <1506336008-4480-3-git-send-email-harinath922@gmail.com>
Message-ID: <9e6c13a7d4a6cd342a650b3bd626a162@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 25.09.2017 12:40 schrieb Harinath Nampally:
> Improves code readability, no impact on functionality.
> 
> Signed-off-by: Harinath Nampally <harinath922@gmail.com>

Please make the headline shorter and put some of it in the git commit 
message.
(And please just resend it "--in-reply-to" this conversation, this patch 
nr 2 of 3)
