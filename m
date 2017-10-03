Return-Path: <SRS0=gfAU=BC=gmail.com=harinath922@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171002113510.00002392@huawei.com>
References: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
 <1506336008-4480-2-git-send-email-harinath922@gmail.com> <768af6828fe70f4a0bd7ef402073d9f3@posteo.de>
 <20170930185913.4a2c85e3@archlinux> <3dac943e-5c50-363c-2e5b-77b2921e9e91@posteo.de>
 <20171002113510.00002392@huawei.com>
From: harinath Nampally <harinath922@gmail.com>
Date: Mon, 2 Oct 2017 22:57:09 -0400
Message-ID: <CAAGUq_okQ8hK6geFKm3xQby91He4NLffj9FT_S+OLcaHijeAWg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: accel: mma8452: Rename structs holding event
 configuration registers to more appropriate names.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Martin Kepplinger <martink@posteo.de>, Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
	lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg KH <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alison Schofield <amsfield22@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> > On 2017-09-30 19:59, Jonathan Cameron wrote:
> > > On Wed, 27 Sep 2017 08:52:54 +0200
> > > Martin Kepplinger <martink@posteo.de> wrote:
> > >
> > >> Am 25.09.2017 12:40 schrieb Harinath Nampally:
> > >>> Improves code readability, no impact on functionality.
> > >>>
> > >>> Signed-off-by: Harinath Nampally <harinath922@gmail.com>
> > >>> ---
> > >>
> > >> I'd prefer a shorter subject line here too, see patch 2/3
> > >
> > > Agreed.  I'm unconvinced the change helps.  Perhaps that is
> > > because I don't fully understand why you are making the change?
> > >
> >
> > It's understandable for me. It simply uses "transient" and "ff_mt" in
> > order to describe sets of device-registers instead of "rising" and
> > "falling". That's more appropriate. I'd apply this if possible.
> >
> > Even though it should be clear after reading the data sheet, this
> > particular issue sometimes gets confusing for people. Maybe a short
> > descriptive comment, pointing to the data sheet, would make sense?
> >
>
> With the addition of some description, this should be fine.
Sure will do.

Thanks,
Harinath

On Mon, Oct 2, 2017 at 6:35 AM, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Sun, 1 Oct 2017 20:10:49 +0200
> Martin Kepplinger <martink@posteo.de> wrote:
>
>> On 2017-09-30 19:59, Jonathan Cameron wrote:
>> > On Wed, 27 Sep 2017 08:52:54 +0200
>> > Martin Kepplinger <martink@posteo.de> wrote:
>> >
>> >> Am 25.09.2017 12:40 schrieb Harinath Nampally:
>> >>> Improves code readability, no impact on functionality.
>> >>>
>> >>> Signed-off-by: Harinath Nampally <harinath922@gmail.com>
>> >>> ---
>> >>
>> >> I'd prefer a shorter subject line here too, see patch 2/3
>> >
>> > Agreed.  I'm unconvinced the change helps.  Perhaps that is
>> > because I don't fully understand why you are making the change?
>> >
>>
>> It's understandable for me. It simply uses "transient" and "ff_mt" in
>> order to describe sets of device-registers instead of "rising" and
>> "falling". That's more appropriate. I'd apply this if possible.
>>
>> Even though it should be clear after reading the data sheet, this
>> particular issue sometimes gets confusing for people. Maybe a short
>> descriptive comment, pointing to the data sheet, would make sense?
>>
>
> With the addition of some description, this should be fine.
>
> Thanks,
>
> Jonathan
>
>>                       martin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
