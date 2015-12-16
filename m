Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34691 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523AbbLPJn5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2015 04:43:57 -0500
MIME-Version: 1.0
In-Reply-To: <CAOhV88NP+bpN6oVk3_DbszNqKAo4T9z-umfVQAcyS3QArwguTA@mail.gmail.com>
References: <CAOhV88NP+bpN6oVk3_DbszNqKAo4T9z-umfVQAcyS3QArwguTA@mail.gmail.com>
Date: Wed, 16 Dec 2015 11:43:56 +0200
Message-ID: <CAEnQRZACu89UR2w=rN3mve8DFniqdf2=Y69FuBnoyXUber=kZA@mail.gmail.com>
Subject: Re: Issues with Lenovo Yoga 900 IIO devices (accelerometer, etc.)
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Dec 15, 2015 at 9:19 PM, Nish Aravamudan
<nish.aravamudan@gmail.com> wrote:
> So, I apologize in advance for this relatively vague report, but I'm fairly sure
> the Yoga 900 has an accelerometer amongst other sensors (ambient light?)
> exported over IIO.
>
> But, these sensors seem to not be updating at all with a 4.4-rc5+ kernel (a
> set of patches from https://lkml.org/lkml/2015/11/30/441 applied to Linus'
> tree).
>
> The odd part is at some point in messing with this, I'm fairly sure it did work!
> That is,
>
> `watch -n 0.1 cat '/sys/bus/iio/devices/iio:device'*/*raw*`

Can you send us a sample of the output? Also, would be
good to identify the exact driver for accel.

Perhaps: cat /sys/bus/iio/devices/iio:device'*/name

>
> showed updating values as I moved the laptop around.
>
> I've not done any accelerometer debugging before, so any suggestion on
> where to start would be greatly appreciated!

Did you applied some patches and recompiled the kernel? Or when it did stopped
working?

thanks,
Daniel.
