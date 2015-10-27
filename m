Return-Path: <jeff.dagenais@gmail.com>
From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Michael.Hennerich@analog.com
Subject: iio:dac: fix i2c_master_send return code misuse
Date: Tue, 27 Oct 2015 12:25:38 -0400
Message-Id: <1445963139-2158-1-git-send-email-jeff.dagenais@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


See commit description. Note that I have only tested this on a ad5622 (i2c),
on an intel CPU.

I don't have the hardware to do further testing. The error though is pretty
blatant, so several reviews and signed-offs could be enough for application.

Your call!
