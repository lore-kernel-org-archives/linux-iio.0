Return-Path: <sonnyrao@google.com>
MIME-Version: 1.0
Sender: sonnyrao@google.com
In-Reply-To: <4D9C477E.4050400@cam.ac.uk>
References: <1302057915-13549-1-git-send-email-sonnyrao@chromium.org> <4D9C477E.4050400@cam.ac.uk>
From: Sonny Rao <sonnyrao@chromium.org>
Date: Wed, 6 Apr 2011 15:47:42 -0700
Message-ID: <BANLkTikWBU-uW6xKwNt+zrS0JbDPOzdd0w@mail.gmail.com>
Subject: Re: [PATCH] Enable async suspend/resume on industrial IO devices
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-pm@lists.linux-foundation.org, bleung@chromium.org,
        snanda@chromium.org, Greg Kroah-Hartman <gregkh@suse.de>,
        Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Phillip Kurtenbach <pkurtenbach@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 6, 2011 at 3:59 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 04/06/11 03:45, Sonny Rao wrote:
>> Industrial I/O devices can sometimes take a long time to resume,
>> allowing them to be asynchronus saves 50ms on one light sensor
>>
> Hi Sonny,
>
> cc'd linux-iio
>
> I'm not particularly familiar with this. =A0Are there any disadvantages?
> I just wonder if it would be better to push this into individual drivers
> rather than the core?

Yeah we could do it that way too, I sent out a similar patch for i2c
and people were asking if it was entirely safe.  It sounds like it may
depend on dependencies between devices.

Do you know if any of the devices in iio have inter-device dependencies?
I was under the impression they were mostly stand-alone sensors that
ordinarily wouldn't, but I haven't tried to audit all of them or anything.

Sonny
