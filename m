Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59890 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbC1MSq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 08:18:46 -0400
Message-ID: <55169C21.1000509@kernel.org>
Date: Sat, 28 Mar 2015 12:18:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: Lee Jones <lee.jones@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH RESEND] iio: st-sensors: add support for lis3lv02d accelerometer
References: <1426672326-6292-1-git-send-email-linus.walleij@linaro.org>	<20150318153948.GQ3318@x1>	<550D5B65.10906@kernel.org> <CACRpkdYuWL_rs9nzg8ivRehG6-yFOheo+ZugZ-1iqmAyhwVaLQ@mail.gmail.com>
In-Reply-To: <CACRpkdYuWL_rs9nzg8ivRehG6-yFOheo+ZugZ-1iqmAyhwVaLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/03/15 09:21, Linus Walleij wrote:
> On Sat, Mar 21, 2015 at 12:52 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> We aren't going to move forward without doing something.
>> Hence applied to the togreg branch of iio.git.
> 
> Thanks!
> 
>>  Lets see
>> whether anyone cares enough to add the stuff the other driver supports
>> and this one doesn't.
> 
> The one really interesting feature I saw was the free-fall detection.
> I think it'd be nice if we had the ability to register for listening
> to such events from the IIO accelerometer subsystem, but I'm
> scared to even try to test it, god knows how many boards I'd
> break before I had this properly supported...
I used to have a couple of accelerometers on the end of really long cables
for this sort of thing ;)

Mind you we regularly put whole boards through accelerations well past
the limits of most of these devices.  Never broke one yet - though did
break a lot of battery cables..

You raise a good point though.  We really need a generic framework for handling
freefall events.  Various sources exist not all in IIO (and not all should be)
but a slim lined interface /dev/freefall was discussed to allow a really fast
response would probably make sense - afterall the point is usual to park mechanical
parts before the device hits the ground.

On second thoughts how many of the devices we care about actually have spinning disks
anymore?  Maybe we are 10 years too late on this one ;) 
> 
> Yours,
> Linus Walleij
> 

