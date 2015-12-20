Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:32988 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262AbbLTLT2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Dec 2015 06:19:28 -0500
MIME-Version: 1.0
In-Reply-To: <5675865F.6050306@kernel.org>
References: <1450272464-13992-1-git-send-email-ricardo.ribalda@gmail.com> <5675865F.6050306@kernel.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Sun, 20 Dec 2015 12:19:06 +0100
Message-ID: <CAPybu_0mp339amnPqbOddMVJ9VRqw7cWLEscyWNi7TTOYbBZTQ@mail.gmail.com>
Subject: Re: [PATCH] iio: add ad5761 DAC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonthan

Thanks for your comments, I have fixed all the style problems in v2,
so we can focus in the range parameter.

On Sat, Dec 19, 2015 at 5:31 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> Range isn't actually specified in the ABI docs.
> Documenation\ABI\testing\sysfs-bus-iio*
> The control interface for this is normally scale rather than range
> (we had to pick one of the two and that is the way it fell out)  Usually
> hardware designers care about range, but userspace programs are often
> most directly interested in scale factors that need to be applied.
> (and that was my most rediculously over generalized statement for the day ;)

What about a first version of the driver where the range is set via
pdata and is not userland configurable?
That way the four chips will be supported and we can have more
feedback from other users about the range issue.

>
> I can see this is rather complex here given the random looking collection
> of associated scales and offsets.  You would have to have _available
> attributes to say what offsets are available at a given scale I think.
> Also we'd have to then define a precedence order in the docs for the
> two attributes (worth doing to make it obvious what to do when this
> sort of setup arises).

The problem with that approach is that there will be two operations to
set the range: one  to change the scale, and another for the offset.  The output
voltage will change twice in this process and may have an intermediate value
that can damage a circuit.

I also believe that my approach with a text description is more user friendly
(but problably because I programmed it :P)

In any case, I will implement whatever we agree ;)

Best regards!
