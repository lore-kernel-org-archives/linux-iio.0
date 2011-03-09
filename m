Return-Path: <marten@intuitiveaerial.com>
From: Marten Svanfeldt <marten@intuitiveaerial.com>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	michael.hennerich@analog.com
Subject: [RFC] IIO: trigger: New hrtimer based trigger driver
Date: Wed,  9 Mar 2011 22:00:42 +0800
Message-Id: <1299679243-1318-1-git-send-email-marten@intuitiveaerial.com>
In-Reply-To: <4D70C8AA.4090300@cam.ac.uk>
References: <4D70C8AA.4090300@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I took the time to extract the hrtimer bits of my ugly driver and
transplanted it to a base of the rtc trigger and blackfin trigger.

Consider this driver an early RFC, it has been compile tested for
x86 and ARM, but I haven't had any possibility to run it as I don't
have access to our hardware platform right now.

Regards
Marten Svanfeldt
