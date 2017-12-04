Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36347 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdLDKXi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Dec 2017 05:23:38 -0500
Received: by mail-wm0-f67.google.com with SMTP id b76so13300337wmg.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Dec 2017 02:23:37 -0800 (PST)
Subject: Re: [PATCH 0/2] iio: accel: bmc150: Check for a second i2c resource
To: Steven Presser <steve@pressers.name>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Jeremy Cline <jeremy@jcline.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <0100016009e7c075-ae3eb98f-22d0-4fae-bcff-93102508b227-000000@email.amazonses.com>
 <CA+Q+rdwpgoiHVqvkF-gTb8g1BsVRqQucNRm0nWcmtJvzeeyqHQ@mail.gmail.com>
 <53d5f05c-ac77-3a43-81fc-239be814bbca@pressers.name>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <c4dfe8e2-dcb9-ee02-9bb7-d34f08155fb4@redhat.com>
Date: Mon, 4 Dec 2017 11:23:35 +0100
MIME-Version: 1.0
In-Reply-To: <53d5f05c-ac77-3a43-81fc-239be814bbca@pressers.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 02-12-17 17:32, Steven Presser wrote:
> Seconding this question.  Or does this merely require some configuration?
> 
> I also have a Yoga 11e to try this on.  I built this last night and gave it a try this morning.  The screen rotations I'm getting are reasonably correct, but don't seem to be accounting for the relative positions of the screen and keyboard.  That is, I'm getting screen rotation in laptop mode and the keyboard isn't disabled in tent or tablet mode.
> 
> I should note this is definitely an improvement over what used to happen - screen rotations used to be 90 degrees off correct.

So the tablet-switch stuff (which will disable the keyboard if you've a really
recent gnome3 userland) is separate from the accelerometers and
fully handled in ACPI, proper tablet-switch reporting is fixed by
this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=dda3ec0aa631d15b12a42438d23336354037e108

But iio-sensor-proxy may need some changes so that it only uses
the accelerometer in the screen, not the one in the base to
provide information for screen rotation.

Regards,

Hans



> 
> Thanks for all your work on this,
> 
> Steve
> 
> 
> On 11/30/2017 04:19 PM, Lars Kellogg-Stedman wrote:
>> On Wed, Nov 29, 2017 at 5:31 PM, Jeremy Cline <jeremy@jcline.org <mailto:jeremy@jcline.org>> wrote:
>>
>>     Some BOSC0200 ACPI devices, like the one in the Yoga 11e, have two i2c
>>     accelerometers listed under a single ACPI device. This checks to see if
>>     there is an ACPI companion and if so handles a second i2c client.
>>
>>
>> I am going to try this out (on a yoga 11e) over the weekend.
>>
>> Will this require an additional patch to iio-sensor-proxy in order to provide the appropriate input events to enter/exit tablet mode? I believe these need to be generated based on the relative position indicated by the two accelerometers.
>> -- 
>> Lars Kellogg-Stedman <lars@oddbit.com <mailto:lars@oddbit.com>> | larsks@{twitter, irc, github, ...}
> 
