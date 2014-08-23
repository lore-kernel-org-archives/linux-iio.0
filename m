Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:47565 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbaHWPOv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Aug 2014 11:14:51 -0400
Received: by mail-we0-f182.google.com with SMTP id k48so11677494wev.41
        for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2014 08:14:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAN0s7ySG9rbDXZ6XDtQmPWD5QGRdnHf7SwGxjh0er39EZFGO6w@mail.gmail.com>
References: <CAN0s7yTK1_1u65nodysfiGxYbgKTeDS0Vf_+14KQJS92_Di1vg@mail.gmail.com>
 <CAN0s7yRwXGgPLhyucnR+=EybQFjunt66MKYvQuZnR_PSdgjS1Q@mail.gmail.com>
 <CA+BWVUSSO0kA1mW6BJ9F5VrZErK1D7YDOrA-gtuW5ZF3wNNZXA@mail.gmail.com>
 <CAN0s7yTYwEsu2uJ3kUjW-SsvoyqSXebNT3=1D1oNfdJwi=Q5Qw@mail.gmail.com>
 <CA+BWVUSZDb_+gtLY5JeryMMfYRrQCkdYBUfG9m3rzL1P9wawYg@mail.gmail.com>
 <CA+BWVUSvm54_xLeXGf0d5oo1-1DH_z=K1TFsrFLQHMBV_gA7gA@mail.gmail.com>
 <CAN0s7yT017sCS9K4q5avRBz5JM+Oj4RM-M8oYVStbWEDx1yWXg@mail.gmail.com>
 <CA+BWVUSXXhFFTUg_NUu6KochOnpg7LF9L3Q8pZHe4Lt7JJrEXw@mail.gmail.com> <CAN0s7ySG9rbDXZ6XDtQmPWD5QGRdnHf7SwGxjh0er39EZFGO6w@mail.gmail.com>
From: Reyad Attiyat <reyad.attiyat@gmail.com>
Date: Sat, 23 Aug 2014 10:14:29 -0500
Message-ID: <CA+BWVUTraeqgTJqJndzpY6+_c+600q=MKChtA7OdG3uBG7+f6w@mail.gmail.com>
Subject: Re: Resource Temporarily Unavailable error when trying to read from
 the accelerator on a ThinkPad twist
To: Elad Alfassa <elad@fedoraproject.org>
Cc: linux-iio <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey Elad,

That is unfortunate that the patch doesn't work. If the patch did
enable the enum quirk you should no longer see this line in your dmesg
when hid-sensor-hub module is loaded:
hid_sensor_hub:sensor_hub_report_fixup:540: hid-sensor-hub
0003:0483:91D1.0003: No Enum quirks

I'll CC Srinivas for you to try and get additional help.

Hey Srinivas,

Elad has a hid sensor hub from STM that is failing to produce new
data, any ideas what might cause this. He is getting a resource
temporarily unavailable after only one value is read. I had thought it
might need the quirk to change logical minimum to 1 for the state
enums but it had no effect. Any other ideas?

On Fri, Aug 22, 2014 at 4:34 PM, Elad Alfassa <elad@fedoraproject.org> wrote:
> Hey Reyad.
>
> Unfortunately, this patch does not fix the issue.
> The symptoms are exactly like before.
>
> Thanks,
> --
> -Elad Alfassa.
