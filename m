Return-Path: <david@lechnology.com>
Subject: Re: Linux ELC & OpenIoT Report
To: Alison Schofield <amsfield22@gmail.com>,
 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
References: <20170305235202.GA6202@d830.WORKGROUP>
 <A78098D4-45DA-4D3B-B7EF-06B72FC9DD19@jic23.retrosnub.co.uk>
 <20170306201911.GA4278@d830.WORKGROUP>
Cc: linux-iio@vger.kernel.org
From: David Lechner <david@lechnology.com>
Message-ID: <3d0ff312-fabf-25ad-226e-67508198c412@lechnology.com>
Date: Mon, 6 Mar 2017 15:29:33 -0600
MIME-Version: 1.0
In-Reply-To: <20170306201911.GA4278@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 03/06/2017 02:19 PM, Alison Schofield wrote:
> On Mon, Mar 06, 2017 at 08:04:21AM +0000, Jonathan Cameron wrote:
>>
>>
>> On 5 March 2017 23:52:04 GMT+00:00, Alison Schofield <amsfield22@gmail.com> wrote:
>>> Hi IIO Community,
>>>
>>> I attended the Linux Foundation's Embedded Linux and OpenIoT Summit in
>>> Portland, Oregon recently.
>>>
>>> I've appended a few excerpts from my blog write-up below and the full
>>> text of my report is available here:
>>> https://outreachyiio.blogspot.com/2017/03/embedded-linux-conference-openiot.html
>>>
>>> alisons
>
> 8< ......... snipped a bunch to focus on the ev3 sensor ...............
>
>>> IIO Community Hindsight: David Lechner
>>> When I met David displaying his ev3 devices at the technical showcase,
>>> I
>>> didn't know of him from the IIO community. David has some drivers he
>>> wants upstreamed to IIO.  Potential Outreachy projects?  I'm fuzzy on
>>> this. Can we add support for sensors that basically have no datasheet,
>>> but that David has reverse engineered?
>>
>> Sure we can. Lots of drivers in the wider kernel are reverse engineered. A few in IIO may well have been.
>>
>> Hmm would take a slightly brave outreach y candidate perhaps.
>>
>
> I'm going to try to pull David in here, so he can fill in & correct me.
>
> I think David has kernel drivers he has written (loadable kernel
> modules - not user space drivers) that could be pushed upstream.
> (still could take significant bravery I guess)
>
> David, Am I getting anything right here?  And, are there any destined for IIO?
>

Mostly right. ;-)

When I started hacking on LEGO Mindstorms, I didn't know about the IIO 
subsystem (or about Linux drivers in general). So, I create my own 
subsystem that is very similar to IIO. The TL;DR; is that these drivers 
need to be converted to the IIO subsystem. It is a bit more involved 
than just "cleaning it up".

If you want to learn more about what I have done so far you can find the 
code at 
<https://github.com/ev3dev/lego-linux-drivers/tree/master/sensors> and 
some documentation at <http://www.ev3dev.org/docs/sensors/>.

There are a couple of things needed that I don't think exist in the IIO 
subsystem yet though (I asked Matt during his talk and he didn't know of 
any).

These sensors have "modes". When you change the mode of a sensor, it 
changes the data being received. For example, there is a color sensor 
that can measure ambient light, reflected light or color. But it can't 
do all of these at the same time. You have to set the mode first and 
interpret the data received based on the mode. I have a hunch that if I 
dug into it some more, I could figure out a way to do this using the 
existing iio code though.

Some of these sensors also have "commands". Commands can do things like 
trigger a sensor calibration. This is the part I am not so sure about.

And, FYI, most of these sensors do have some sort of technical 
documentation from the manufacturer.
