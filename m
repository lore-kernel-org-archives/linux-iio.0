Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36602 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbdE1RAW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 May 2017 13:00:22 -0400
MIME-Version: 1.0
In-Reply-To: <CY4PR12MB12549ADA207663849E8DBE8583F20@CY4PR12MB1254.namprd12.prod.outlook.com>
References: <20170523080830.20571-1-nikita.yoush@cogentembedded.com>
 <20170524202735.3cf4e14e@kernel.org> <2e6019f5-94fc-bb13-f616-0c1cfe81a7db@cogentembedded.com>
 <20170528164846.3fa3d4d8@kernel.org> <CY4PR12MB12549ADA207663849E8DBE8583F20@CY4PR12MB1254.namprd12.prod.outlook.com>
From: Chris Healy <cphealy@gmail.com>
Date: Sun, 28 May 2017 10:00:21 -0700
Message-ID: <CAFXsbZp9jJV4hs+kxvDz=YrJkcdo3y0w8RTUrMXZKK8hjrj1UA@mail.gmail.com>
Subject: Re: Fw: [PATCH/RFC] iio: hi8435: do not enable all events by default
To: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        maitysanchayan@gmail.com, gregor.boirie@parrot.com,
        mranostay@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jeff White <jeff.white@zii.aero>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, May 28, 2017 at 9:50 AM, Chris Healy <Chris.Healy@zii.aero> wrote:
>
>
>
> ________________________________
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, May 28, 2017 8:48 AM
> To: Nikita Yoush
> Cc: Hartmut Knaack; Lars-Peter Clausen; Peter Meerwald-Stadler; Sanchayan
> Maity; Gregor Boirie; Matt Ranostay; linux-iio@vger.kernel.org;
> linux-kernel@vger.kernel.org; Chris Healy; Jeff White; Vladimir Barinov
> Subject: Re: [PATCH/RFC] iio: hi8435: do not enable all events by default
>
> On Thu, 25 May 2017 08:47:47 +0300
> Nikita Yushchenko <nikita.yoush@cogentembedded.com> wrote:
>
>> 24.05.2017 22:27, Jonathan Cameron wrote:
>> > On Tue, 23 May 2017 11:08:30 +0300
>> > Nikita Yushchenko <nikita.yoush@cogentembedded.com> wrote:
>> >
>> >> Having all events enabled by default is misleading.
>> >> Userspace should explicitly enable events they want to receive.
>> >>
>> >> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
>> > I agree in principle, but this is a userspace ABI change.  Sadly we
>> > can't do it with out risking breaking userspace code...
>> >
>> > One of those we should have caught in review, but now it's there
>> > we can't actually do anything about it unless we are absolutely
>> > sure no one will notice!
>>
>> I see your point.
>>
>> Still, isn't there subsystem-level default that all events are disabled
>> by default?  If such, then current hi8435 state breaks subsystem-level
>> rules, which is a [userspace-visible] bug.  I'm not sure how far should
>> we go in bug compatibility.
> It is indeed the subsystem default (as much as we have one)
>
> This is a moderately obscure chip for linux systems, do we have a good
> handle
> on where it is being used - i.e. are most of the devices under control of
> people we can discuss this with?

The company I work for funded the initial work to get support for the
this Holt HI-8435 upstream.  We are presently using this driver and
can accommodate this proposed userspace ABI change as we can adjust
userspace if the ABI changes.  Unfortunately, this doesn't answer the
question of the drivers adoption elsewhere.

>>
>> One crazy idea could be - make default selectable via device tree (with
>> default set to all-enabled to keep bug-compatibility).  But perhaps
>> that's over-reaction.
> Yeah, wouldn't fly with the devicetree binding maintainers..
>
> Jonathan
>
> ________________________________
>
>
> This email and any files transmitted with it are confidential & proprietary
> to Zodiac Inflight Innovations. This information is intended solely for the
> use of the individual or entity to which it is addressed. Access or
> transmittal of the information contained in this e-mail, in full or in part,
> to any other organization or persons is not authorized.
