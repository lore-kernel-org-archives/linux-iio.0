Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45979 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeBDRKf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Feb 2018 12:10:35 -0500
Received: by mail-pl0-f67.google.com with SMTP id p5so10168956plo.12
        for <linux-iio@vger.kernel.org>; Sun, 04 Feb 2018 09:10:35 -0800 (PST)
Date: Sun, 4 Feb 2018 22:40:26 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, daniel.baluta@gmail.com,
        amsfield22@gmail.com, lars@metafoo.de
Subject: Re: [TODO] Potential Staging Clean-up: accel:adis16201.
Message-ID: <20180204171026.GA32244@himanshu-Vostro-3559>
References: <20180204152303.577edb42@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180204152303.577edb42@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On Sun, Feb 04, 2018 at 03:23:03PM +0000, Jonathan Cameron wrote:
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

I would love to clean this up as I have just started learning about IIO
subsytem.

Do you want incremental patches everyday or all work done in a patchset
while taking time ?

Though I'm not new to kernel development but yes I am new to IIO
community.

-- 
Thanks
Himanshu Jha
