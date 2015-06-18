Return-Path: <simon@mungewell.org>
Message-ID: <a740eca098128c7a830db825d7c0288c.squirrel@mungewell.org>
In-Reply-To: <557DC084.6090205@kernel.org>
References: <195dff9bd065db7e618280cb7c6eb5a9.squirrel@mungewell.org>
    <1434034458-1968-1-git-send-email-simon@mungewell.org>
    <557D9564.9090800@kernel.org>
    <d6702f5d19d2baea80132666fcf7654a.squirrel@mungewell.org>
    <557DC084.6090205@kernel.org>
Date: Thu, 18 Jun 2015 02:15:46 -0400
Subject: Re: [RFC] HID: hid-sony: Add basic iio-subsystem reading of SixAxis
 Accelerometers
From: simon@mungewell.org
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: simon@mungewell.org,
 linux-input@vger.kernel.org,
 "Frank Praznik" <frank.praznik@oh.rr.com>,
 linux-iio@vger.kernel.org,
 "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <linux-iio@vger.kernel.org>


>> I have further advanced the patch to include reading via buffer, but I'm
>> having trigger 'conceptual' problems getting my head around the HID
>> device
>> issuing an interrupt when a input report is received. Looking at
>> iio_dummy_event and iios_sysfs for inspiration....
> You can skip the triggers.  It's not obligatory, you can push directly
> into a buffer.
> Triggers are nice for 'data ready' type signals (which is closest to what
> we
> have here) if you might want to hang other sensors off the timing (so read
> on demand ADCs etc.  They aren't actually 'required' as such.

After a bit of poking around I got the triggers working as well, I can
self trigger and even trigger another (iio-dummy) device.

However I couldn't trigger two devices at the same time from a single
trigger, is this normal for IIO?


Next is a little code clean-up and I'll post what I have for some more
comments,
Simon.
