Return-Path: <khali@linux-fr.org>
Date: Wed, 22 Jun 2011 18:16:49 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Bryan Freed <bfreed@chromium.org>, linux-kernel@vger.kernel.org,
 jbrenner@taosinc.com, gregkh@suse.de, arnd@arndb.de,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Amit Kucheria
 <amit.kucheria@verdurent.com>
Subject: Re: [PATCH 1/3] light sensor: Add SMBUS support to the tsl2563
 driver.
Message-ID: <20110622181649.2881f439@endymion.delvare>
In-Reply-To: <4E02100C.2000408@cam.ac.uk>
References: <1308696897-25161-1-git-send-email-bfreed@chromium.org>
	<4E01B068.3090102@cam.ac.uk>
	<20110622161035.5bfe2a73@endymion.delvare>
	<4E02100C.2000408@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Wed, 22 Jun 2011 16:53:48 +0100, Jonathan Cameron wrote:
> On 06/22/11 15:10, Jean Delvare wrote:
> > On Wed, 22 Jun 2011 10:05:44 +0100, Jonathan Cameron wrote:
> >> On 06/21/11 23:54, Bryan Freed wrote:
> >>> +	if (use_smbus) {
> >>> +		if (len == 1) {
> >>> +			ret = i2c_smbus_read_byte_data(client, cmd);
> >>> +			buf[0] = ret & 0xff;
> >>> +		} else if (len == 2) {
> >>> +			ret = i2c_smbus_read_word_data(client, cmd);
> >>> +			buf[0] = ret & 0xff;
> >>> +			buf[1] = (ret >> 8) & 0xff;
> > 
> > swab16 is your friend (and the bogus SMBus byte order convention be
> > damned.)
>
> I would imagine the be16_to_cpu etc is even better as we don't know the
> cpu endianess.

No, it has to do with SMBus endianess vs. I2C chip endianess, not host
endianess. SMBus specifies that the low byte of a word goes on the wire
first, but almost all I2C and SMBus devices I've see implement it the
other way around, high byte first. i2c-core's
i2c_smbus_read_word_data() stick to the specs, so for almost all I2C
devices, the driver has to swab16 the result.

(I didn't check the TSL2563 datasheet though... maybe this is one of
the rare chips that don't need it.)

-- 
Jean Delvare
