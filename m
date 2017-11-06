Return-Path: <SRS0=cAFL=CE=gmail.com=harinath922@kernel.org>
MIME-Version: 1.0
In-Reply-To: <174aea53-99b0-e400-c2f3-8a7a9fd809d8@posteo.de>
References: <1509904804-4608-1-git-send-email-harinath922@gmail.com>
 <1509904804-4608-3-git-send-email-harinath922@gmail.com> <174aea53-99b0-e400-c2f3-8a7a9fd809d8@posteo.de>
From: harinath Nampally <harinath922@gmail.com>
Date: Sun, 5 Nov 2017 20:04:38 -0500
Message-ID: <CAAGUq_q2=eUSD5S+V8yFVzn5TFSXRfYGow1ZF19LSYTSwGONgA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: accel: mma8452: Rename config structs for readability
To: Martin Kepplinger <martink@posteo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, lars@metafoo.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg KH <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alison Schofield <amsfield22@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Martin,

> I think it'd be great to have the "power_mode" iio ABI interface
> for mma8452 too, and I just found an old patch pf mine for this.
>
> If you say you could test it and check for correct API usage and
> ABI provisioning in sysfs, I'd be happy to publish it for you to
> make any necessary corrections and submit it after testing.
>
> Do we have a deal?
Sure, sounds great!

Thanks,
Harinath

On Sun, Nov 5, 2017 at 3:36 PM, Martin Kepplinger <martink@posteo.de> wrote:
> On 2017-11-05 19:00, Harinath Nampally wrote:
>> Rename structs holding event configuration registers
>> to more appropriate names. This naming is consistent
>> with the event config register names given in the
>> mma845x and fxls8471 datasheets.
>>
>> Signed-off-by: Harinath Nampally <harinath922@gmail.com>
>
> Makes sense to me.
>
> Acked-by: Martin Kepplinger <martink@posteo.de>
>
>
> Hey Harinath,
>
> I think it'd be great to have the "power_mode" iio ABI interface
> for mma8452 too, and I just found an old patch pf mine for this.
>
> If you say you could test it and check for correct API usage and
> ABI provisioning in sysfs, I'd be happy to publish it for you to
> make any necessary corrections and submit it after testing.
>
> Do we have a deal?
>
> thanks
>
>                              martin
