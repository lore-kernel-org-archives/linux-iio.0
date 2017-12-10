Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38179 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbdLJTAx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Dec 2017 14:00:53 -0500
Received: by mail-wm0-f46.google.com with SMTP id 64so10536782wme.3
        for <linux-iio@vger.kernel.org>; Sun, 10 Dec 2017 11:00:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171210150845.51e14aad@archlinux>
References: <20171118091011.9061-1-martink@posteo.de> <20171118155318.6a1f3b3f@archlinux>
 <CAOFm3uE0GsBn1g054rD9iym-kjC2bdsCOVO8WPBe7zZQ0a+Vvg@mail.gmail.com>
 <CAAGUq_pXNMSMAsvtMomHQiCjXhrZ5Yx5agowXAVhWt8Gkb=2ug@mail.gmail.com> <20171210150845.51e14aad@archlinux>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Sun, 10 Dec 2017 20:00:11 +0100
Message-ID: <CAOFm3uH_61C1k3HTL7xmm92omLXriKo2JhjGqNJxwiMU4hBPPg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: mma8452: replace license description with SPDX specifier
To: Jonathan Cameron <jic23@kernel.org>
Cc: harinath Nampally <harinath922@gmail.com>,
        Martin Kepplinger <martink@posteo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Dec 10, 2017 at 4:08 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Sat, 18 Nov 2017 23:23:57 -0500
> harinath Nampally <harinath922@gmail.com> wrote:
>
>> > This replaces the custom license information text with the appropriate
>> > SPDX identifier. While the information here stays the same, it is easier
>> > to read.
>> > Signed-off-by: Martin Kepplinger <martink@posteo.de>
>> > Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
>> Acked-by: Harinath Nampally <harinath922@gmail.com>
>
> Applied.  I still not totally sure that the intent of introducing SPDX
> specifiers was to replace rather than supplement the license text.
> It's been pointed out for instance that some of the BSD licenses have
> explicit names in the text relevant to a particular file.  For GPL v2
> that isn't the case though so I suppose this one does no harm.

Thanks!
There might be indeed a few corner cases that would require some
discussions and the best way would be to have a proper sign off of the
authors when possible in these cases (or all cases)
But to me at least, reducing the boilerplate to the max (such as
replacing 50 lines of legalese with a single SPDX id line) is a big
boost of content/noise ratio that we should thrive for.
-- 
Cordially
Philippe Ombredanne
