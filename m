Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:51854 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeCIIEE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Mar 2018 03:04:04 -0500
Received: by mail-wm0-f51.google.com with SMTP id h21so2272798wmd.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Mar 2018 00:04:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180309005200.pj6ez2xgrxjwhvxe@smtp.gmail.com>
References: <20180309005200.pj6ez2xgrxjwhvxe@smtp.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 9 Mar 2018 10:04:02 +0200
Message-ID: <CAEnQRZCYuP5K97=6uKJsepcQz+3gP9U67kZw7M8cd=gX3Cag6A@mail.gmail.com>
Subject: Re: Work plan to move AD2S1210 out of staging
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        graff.yang@gmail.com, davidjulianveenstra@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Rodrigo,

Thanks for your effort on analyzing this.

On Fri, Mar 9, 2018 at 2:52 AM, Rodrigo Siqueira
<rodrigosiqueiramelo@gmail.com> wrote:
> Hi,
>
> Today I looked at the AD2S1210 code and datasheet. As a result, I present here
> the following work plan for discussion:
>
> 0) Checkpach free
>
> There are just two 'CHECKs' in this module. Fix it is easy.

Great.

>
> 1) Update the channels definition
>
> After a first read of the datasheet, I believe the AD2S1210 need an update to
> the iio_chan_spec already defined and also requires another channel for
> velocity. I am not 100% sure, but I also think that other channels have to be
> defined because of this chip has many features (absolute position and velocity,
> system fault detect, programmable sinusoidal, etc.); however, I prefer to keep
> things simple now.
>

> 2) Events for handling error detections
>
> The AD2S1210 provide many fault detection thresholds. The chip triggers some
> faults, and I believe the AD2S1210 module can handle it with events interface.
> If I am right, I to start by adding LOS  handler.
>
> 3) Use IIO ABI
>
> From what I understood from the documentation, I believe the write using sysfs
> interface is not right. The AD2S1210 module should use iio_info for this tasks
> (even for read). If I am right, I want to fix it.
>
> Is my work plan to move AD2S1210 out of staging make sense?

Yup. It does makes sense.

For the moment no need to add new features. We should just concentrate
on supporting the existing functionality but with the standard IIO interface.

>
> Finally, I want to work on AD2S1210, but David Veenstra has priority on
> this task because he already expressed his interest in working on
> AD2S1210 and AD2S1200.  I proposed to him that we divided this task in
> two: I work in the  AD2S1210 and him in the AD2S1200.
>
> Best regards,
> Siqueira
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
