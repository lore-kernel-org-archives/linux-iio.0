Return-Path: <khali@linux-fr.org>
Date: Tue, 9 Jul 2013 20:29:42 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Harald Geyer <harald@ccbib.org>, linux-iio@vger.kernel.org, Guenter
 Roeck <linux@roeck-us.net>, LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: humidity sensors
Message-ID: <20130709202942.1a290151@endymion.delvare>
In-Reply-To: <51DC4FE0.1080402@kernel.org>
References: <E1UwWkL-0000pI-8V@stardust.g4.wien.funkfeuer.at>
	<51DC4FE0.1080402@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Tue, 09 Jul 2013 19:01:04 +0100, Jonathan Cameron wrote:
> On 07/09/2013 01:10 PM, Harald Geyer wrote:
> > I'm working on a iio driver for the DHT11 (and DHT22)
> > humidity and temperature sensor. I believe this is the
> > first humidity sensor to be supported by the iio framework.
> Sure, previously these have been considered acceptable to hwmon
> (just about ;).  That has always  been controversial and with
> iio-hwmon in place, I doubt anyone will mind having it new
> ones in IIO.  I've cc'd a few people just in case they have
> strong views on this.

This is totally fine with me.

-- 
Jean Delvare
