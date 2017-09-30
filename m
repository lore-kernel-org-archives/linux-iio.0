Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51795 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdI3SV1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Sep 2017 14:21:27 -0400
MIME-Version: 1.0
In-Reply-To: <20170930190511.2832064c@archlinux>
References: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
 <1506336008-4480-3-git-send-email-harinath922@gmail.com> <9e6c13a7d4a6cd342a650b3bd626a162@posteo.de>
 <20170930190511.2832064c@archlinux>
From: harinath Nampally <harinath922@gmail.com>
Date: Sat, 30 Sep 2017 14:20:45 -0400
Message-ID: <CAAGUq_qhYseQN12cqcgGFgtrONg1nyRfvp8YZxNK1nYm+xJwpA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: accel: mma8452: Rename time step look up
 struct to generic name as the values are same for all the events.
To: Jonathan Cameron <jic23@kernel.org>
Cc: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
        lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alison Schofield <amsfield22@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Obviously drop any patches that have already been taken.
> In this case it will be a v4 series containing patches 1 and 2 only.
Sure will do.

Thanks,
Harinath

On Sat, Sep 30, 2017 at 2:05 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed, 27 Sep 2017 08:51:26 +0200
> Martin Kepplinger <martink@posteo.de> wrote:
>
>> Am 25.09.2017 12:40 schrieb Harinath Nampally:
>> > Improves code readability, no impact on functionality.
>> >
>> > Signed-off-by: Harinath Nampally <harinath922@gmail.com>
>>
>> Please make the headline shorter and put some of it in the git commit
>> message.
>> (And please just resend it "--in-reply-to" this conversation, this patch
>> nr 2 of 3)
>
> From a patch management point of view I actually disagree with this.
> I would prefer to see a clean fresh series.  Otherwise it very rapidly
> gets hard to be sure that I am picking up the latest versions.
>
> Obviously drop any patches that have already been taken.
> In this case it will be a v4 series containing patches 1 and 2 only.
>
> Thanks
>
> Jonathan
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
