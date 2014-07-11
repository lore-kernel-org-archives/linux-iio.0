Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53157 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213AbaGKUKq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jul 2014 16:10:46 -0400
Received: by mail-qc0-f174.google.com with SMTP id x13so1406364qcv.19
        for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2014 13:10:45 -0700 (PDT)
From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Content-Type: text/plain; charset=windows-1252
Subject: ad5622 faulty i2c bus tracking
Date: Fri, 11 Jul 2014 16:10:42 -0400
Message-Id: <1B63ACC2-620E-419A-B346-C156B0059FA2@gmail.com>
Cc: Kevin Cotton <CottonK@Sonatest.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	michael.hennerich@analog.com
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

We are seing odd behaviour with the ad5622.

This is what our bus looks like:
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- UU UU 
10: -- -- -- -- -- -- -- -- UU UU UU UU -- -- UU UU 
20: -- UU -- -- -- -- -- -- -- -- -- -- 2c -- -- -- 
30: UU -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- UU UU UU UU -- -- -- -- 
50: UU UU UU -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- —                         

It is pretty crowded but works well, under normal conditions. All except the two
ad5622 we have at 0x0e and 0x0f.

Recently weve been experimenting with writing more content to one of the eeproms
we have on the bus (at24 driven). This, joint with another condition exacerbated
a problem which has always been present.

Ive shrunk down the procedure to cause the faulty behaviour to its simplest
expression. To close in the the root cause, we physically eliminated all chips
one by one (by lifting pins) until we were practically left with the ad5622 and
one eeprom (0x51). We identified the two DACs as the cause by removing them, and
observing the problem went away. So we are confident the ad5622 is doing
something wrong.

I analyze the bus using a tektronik scope with the bus analysis feature. With
all i2c slave drivers unbound, I do this command:

i2cset -f -y 0 0x51 0x0 0x0 0xff 0x0e 0x1f 0xff i

This normal sequence is a write of 4 bytes at offset 0 of the eeprom. The 0x51
eeprom acks correctly up to 0x1b, then the master tries to write the next byte
(0xff) but a slave (ad5622) is holding the data line to the ground. The master
immediately detects this as a loss of bus arbitration and the transfer halts and
fails.

I can delay the failure by writing non-1s after the 0x1b. Which makes sense
because at that point, even if the ad5622 is grounding the data line, so is the
master.

In another scenario, I manually configure the ad5622 in the iio sysfs directory.
I remove the powerdown bit and setup the max voltage value. I setup a scope trig
on the falling edge of the signal measured on the raw output of the DAC. I issue
this command:

i2cset -y -f 0 0x51 0 0 0xFF 0x0e 0x1c 0x69 0xFF i

The scope trigs at the end of the last 0xFF. The output voltage drops to 2/3 the
ref voltage on the chip. Trying to make sense of this, we reasonned that if the
0x1C69 is lined up correctly in the ad5622s register, it would select the 1k
pull-down in the chip. Our design has a pull up on the Vout. The measured
voltage fits what we should expect if our pull-up was fighting the chips 1k
pull-down. So the chip seems to be grabbing the value and using it. Note: in the
i2cset command, the address can be swapped for 0x52, ou other eeprom. The 0xff
can be any value.

Further, in case this helps those still reading if I write these bytes in the
eeprom at its offset 0 like so: i2cset -f -y 0 0x51 0x0 0x0 0xff 0xff 0xff 0x0e
0x1c 0xff i

Then when I read it back, the fault is also revealed.

Here are two screenshots of this last scenario:
https://drive.google.com/folderview?id=0B-AMxW_pZfvkZS0zMHZXSmF1eVE&usp=drive_web

The purple line if the Vout. The different ground levels are caused by the
master being two board stacks away from the probe point. The voltage levels at
the chips was measured and determined to be well within the ad5622s tolerances.
Nevertheless, we are working to a test gig to isolate the ad5622 with a
bitbanged i2c master so I can reproduce any communication including simulated
ack bits.

Has anything like this been observed/reported? Are there any solutions or
workaround (higher chip rev, etc.)? Aside from support.analog.com, any ideas
who else could provide insight on the matter?

Thanks for your help!