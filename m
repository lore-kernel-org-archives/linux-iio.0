Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:51256 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756Ab2FSH5y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Jun 2012 03:57:54 -0400
Date: Tue, 19 Jun 2012 09:57:53 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] iio: add vcnl4000 combined ALS and proximity sensor
In-Reply-To: <20120619003259.GA587@kroah.com>
Message-ID: <alpine.DEB.2.01.1206190236340.29755@pmeerw.net>
References: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net> <20120619003259.GA587@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Greg,

> On Mon, Jun 18, 2012 at 08:33:00PM +0200, Peter Meerwald wrote:
> > minimal driver, no IR current control and proximity/event handling
> 
> Care to fix up the basic checkpatch.pl warnings and errors it produces?

it gives me 4 warning, but no errors:

WARNING: line over 80 characters
+#define VCNL4000_PS_MEAS_FREQ	0x89 /* Proximity measurement signal frequency */
WARNING: line over 80 characters
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, req_mask);

ok

WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
+		msleep(1);

this is indeed interesting; a sensor measurement/conversion can take up to 
100 ms and the data ready loop with msleep(1) and 20 retries is depending on the 
behaviour that msleep(1) actually takes >= 20 ms 

checkpatch is happy with msleep(20)

I wonder how often this warning is worked around with something like 
msleep(SOME_DELAY) with #define SOME_DELAY 1...

WARNING: quoted string split across lines
#241: FILE: drivers/iio/light/vcnl4000.c:172:
+	dev_info(&client->dev, "VCNL4000 Ambient light/proximity sensor, "
+		"Prod %02x, Rev: %02x\n", ret >> 4, ret & 0xf);

ok, I thought a split line would be more readable; checkpatch is happy 
with the long line

thanks, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
