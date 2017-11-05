Return-Path: <SRS0=2mkZ=CD=posteo.de=martink@kernel.org>
Subject: Re: [PATCH v4 2/2] iio: accel: mma8452: Rename config structs for
 readability
To: Harinath Nampally <harinath922@gmail.com>, jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, amsfield22@gmail.com
References: <1509904804-4608-1-git-send-email-harinath922@gmail.com>
 <1509904804-4608-3-git-send-email-harinath922@gmail.com>
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <174aea53-99b0-e400-c2f3-8a7a9fd809d8@posteo.de>
Date: Sun, 5 Nov 2017 21:36:01 +0100
MIME-Version: 1.0
In-Reply-To: <1509904804-4608-3-git-send-email-harinath922@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 2017-11-05 19:00, Harinath Nampally wrote:
> Rename structs holding event configuration registers
> to more appropriate names. This naming is consistent
> with the event config register names given in the
> mma845x and fxls8471 datasheets.
> 
> Signed-off-by: Harinath Nampally <harinath922@gmail.com>

Makes sense to me.

Acked-by: Martin Kepplinger <martink@posteo.de>


Hey Harinath,

I think it'd be great to have the "power_mode" iio ABI interface
for mma8452 too, and I just found an old patch pf mine for this.

If you say you could test it and check for correct API usage and
ABI provisioning in sysfs, I'd be happy to publish it for you to
make any necessary corrections and submit it after testing.

Do we have a deal?

thanks

                             martin
