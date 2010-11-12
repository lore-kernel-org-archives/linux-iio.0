Return-Path: <vapier.adi@gmail.com>
MIME-Version: 1.0
Sender: vapier.adi@gmail.com
In-Reply-To: <AANLkTikuw2AYhWpbV8kHq9uJdx1+HYLEkP1HTF+4-_7y@mail.gmail.com>
References: <1288117066-18055-1-git-send-email-vapier@gentoo.org>
 <AANLkTi=-YOdnuQczTD85e7YKuf+OsEbvi4OF6rQnRo7F@mail.gmail.com>
 <4CCEB02D.7090002@cam.ac.uk> <AANLkTikuw2AYhWpbV8kHq9uJdx1+HYLEkP1HTF+4-_7y@mail.gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 12 Nov 2010 13:02:16 -0500
Message-ID: <AANLkTimVNS=GL-Y40vOSBGt=iWj5JasdKQWOGnBBfJ=z@mail.gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 00/36 v2] staging: iio: ADI drivers
 for staging-next
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Nov 2, 2010 at 03:40, Mike Frysinger wrote:
> On Mon, Nov 1, 2010 at 08:18, Jonathan Cameron wrote:
>> On 10/28/10 02:44, Mike Frysinger wrote:
>>> On Tue, Oct 26, 2010 at 14:17, Mike Frysinger wrote:
>>>> Hopefully there shouldn't be any roadblocks now before pushing to Greg=
KH.
>>>> I'll do so in a day or two if there aren't any issues.
>>>
>>> ive bounced it over to him now
>>
>> I'm guessing this lot *just* missed the merge window. =C2=A0Despite all =
Mike's
>> hard work they were proposed for merging very late so we can't really co=
mplain!
>>
>> Anyhow, this is not necessarily a bad thing as it will mean they sit in
>> staging-next for a couple of months and we can do a lot of needed cleani=
ng up
>> before the next merge window. =C2=A0The trick is probably going to be to=
 synchronize
>> this chunk of the blackfin tree against staging-next so that we can appl=
y any
>> accepted/reviewed patches to both trees as we move forward.
>>
>> I can set up an additional 'in between' tree if that is helpful? (kernel=
.org hosted)
>> It would contain whatever we have sent on to Greg KH but based against m=
ainline
>> rather than linux-next (with no rebasing but with merges to move with th=
e release
>> candidates as they appear). Hence it would effectively be iio-next thoug=
h formally
>> that role will still be handled by Greg's staging-next tree.
>
> as long as the patches are in staging-next, i think things are fine.
> with the bulk of the code merged, what we have left should be a lot
> easier to sync/work on.

greg has pulled things into his staging-next tree, so hopefully we can
get back to focusing on technical details and not API thrashing now :)
-mike
