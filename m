Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35824 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbcHCFFE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2016 01:05:04 -0400
Received: by mail-yw0-f182.google.com with SMTP id j12so217543963ywb.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Aug 2016 22:04:56 -0700 (PDT)
Date: Tue, 2 Aug 2016 21:57:18 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: linux-iio@vger.kernel.org
Subject: smbus read help needed
Message-ID: <20160803045710.GA3907@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I'm blocked on this smbus read problem. 

hdc100x triggered buffer review feedback pointed out that I cannot rely
on i2c_master_recv() since this driver currently only requires smbus funcs. 
That led me to create an alternative path using smbus byte reads like the
driver was doing in direct mode.

I found the reads don't work.  hdc100x does not expect a stop condition
after sending the first byte which is what smbus_read_byte gives you. So,
when you do the second read, you are getting the first byte again.  Net
effect is that of the 14 bits used for the measurement, the 8 most
significant bits are correct, the lower 6 are not.

hdc100x only wants this:
	S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P 

I tried by testing, and by inspection, each flavor of smbus read and none 
match the pattern that hdc100x wants.  (read_byte, read_word_data, 
read_word_swapped, read_block_data, read_i2c_block_data all fail) 
The read_byte is actually the only smbus read command the sensor accepts.

Texas Instruments publishes this doc explaining its SMBus (in)compatibility.
http://www.ti.com/lit/an/sloa132/sloa132.pdf
I did get one lead out of it.  It suggests using the write block protocol,
with the READ bit set. That does look like it could work.  I tried using
i2c_smbus_xfer() directly, thinking maybe I could fool it, but that doesn't
get me down to the low level of control I think I would need to pull this off. 

I see flags for i2c_msg that might be helpful...if they worked at the
smbus level: 
I2C_M_REV_DIR_ADDR reverses r/w bit 
I2C_M_NOSTART strips off that beginning segment we don't want

If we could use a NOSTOP flag on the read byte command then i could
go back and get the next byte.  I don't see such a flag.  I don't see
any flags, other than for PEC, on smbus.

Also, saw an MDELAY flag that seemed interesting, as if I could program
the delay between starting and reading the measurement, so it could all
be done in one block data command. Again, not smbus.

I guess these ideas are all breaking the idea of being smbus compliant
anyway. 

Is this fixable with smbus? 
If not, how do you 'graciously' change a drivers requirements?

Thanks,
alisons  
