Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34276 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbbLOTTR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Dec 2015 14:19:17 -0500
MIME-Version: 1.0
Date: Tue, 15 Dec 2015 11:19:16 -0800
Message-ID: <CAOhV88NP+bpN6oVk3_DbszNqKAo4T9z-umfVQAcyS3QArwguTA@mail.gmail.com>
Subject: Issues with Lenovo Yoga 900 IIO devices (accelerometer, etc.)
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

So, I apologize in advance for this relatively vague report, but I'm fairly sure
the Yoga 900 has an accelerometer amongst other sensors (ambient light?)
exported over IIO.

But, these sensors seem to not be updating at all with a 4.4-rc5+ kernel (a
set of patches from https://lkml.org/lkml/2015/11/30/441 applied to Linus'
tree).

The odd part is at some point in messing with this, I'm fairly sure it did work!
That is,

`watch -n 0.1 cat '/sys/bus/iio/devices/iio:device'*/*raw*`

showed updating values as I moved the laptop around.

I've not done any accelerometer debugging before, so any suggestion on
where to start would be greatly appreciated!

-Nish
