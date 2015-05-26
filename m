Return-Path: <mwelling79@gmail.com>
Sender: Michael Welling <mwelling79@gmail.com>
Date: Tue, 26 May 2015 13:11:57 -0500
From: Michael Welling <mwelling@ieee.org>
To: dmitry.torokhov@gmail.com, vigneshr@ti.com, bgriffis@ti.com,
	jic23@kernel.org, wsa@the-dreams.de, balbi@ti.com,
	linux-input@vger.kernel.org
Cc: GWilson@sakuraus.com, linux-iio@vger.kernel.org
Subject: AM335x touchscreen issues
Message-ID: <20150526181157.GA8009@deathray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Greetings,

I have been porting Linux to a new AM3554 based SoM and have found issues
with the touchscreen reporting touch releases repeatedly to userspace
without actually touching the screen when running ts_calibrate, ts_test
or other graphical touchscreen applications.

This started happening after updating pulling recent changes.

It has also been confirmed to be happening on the beagle bone black:
http://www.spinics.net/lists/linux-iio/msg18580.html

If you look further into this thread you will see a workaround patch that
I came up with:
http://www.spinics.net/lists/linux-iio/msg18583.html

Though this fix stops the reported events in userspace, interrupts are
still occuring repeatedly.

Does anyone have any suggestions beyond what I have done to remedy this
issue?

Regards,

Michael
