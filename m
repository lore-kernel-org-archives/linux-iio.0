Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37139 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751767AbeBDSu6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Feb 2018 13:50:58 -0500
Received: by mail-wm0-f41.google.com with SMTP id v71so21799585wmv.2
        for <linux-iio@vger.kernel.org>; Sun, 04 Feb 2018 10:50:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180204152303.577edb42@archlinux>
References: <20180204152303.577edb42@archlinux>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Sun, 4 Feb 2018 20:50:56 +0200
Message-ID: <CAEnQRZDuvzahcmxKBN4YvotBvA28-06f6iAzbZQyLWzF+B-8gQ@mail.gmail.com>
Subject: Re: [TODO] Potential Staging Clean-up: accel:adis16201.
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Alison Schofield <amsfield22@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Feb 4, 2018 at 5:23 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> Hi All
>
> I was looking over what we have left in staging for any low hanging fruit
> and came across the adis16201 driver.
>
> I was wondering if anyone would like to clean it up?
>
> This would make a good opportuntity for someone who is fairly new to
> kernel development to make a useful contribution.
>
> To that end I've done a review as if it had been submitted as a new
> driver.
>
> If you want to take this on, please reply to say so in order to avoid
> several people looking at this one driver.  Obviously if things change
> and you then can't get to it reasonably quickly then 'hand it back'
> on the mailing list.
>
> I'm happy to do this for a few more drivers if there are enough
> interested people so do ping me if someone has claimed this one and you
> would like a similar starting point.
>
> Ideally we would find someone who actually has hardware, but for the simple
> stuff in this one I think we are unlikely to break anything that can't be
> picked up in review. Hence I'm not totally bothered about it if no one
> comes forward!
>
> Alison, Daniel. Feel free to add this to the outreachy task list if no
> one else grabs it before the process starts again (just let us know if you are
> doing that).

Hi Jonathan,

Will keep this in mind for next round of Outreachy that starts in March.

I also submitted a proposal for GSoC:

https://wiki.linuxfoundation.org/gsoc/2018-gsoc-iio-driver

Let's see if this is accepted and we can have people working
for the cleanups as a part of their application process.

thanks,
Daniel.
