Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:52488 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759483AbcHEJfm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Aug 2016 05:35:42 -0400
Subject: Re: [PATCH] iio: humidity: hdc100x: use i2c_master_recv to read
 sensor data
To: Alison Schofield <amsfield22@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>
References: <20160804033253.GA31586@d830.WORKGROUP>
 <CAKzfze9bEdoPTri=+MTK2LPXAJZxwXKP=T_jTKk4aO38ZyANzA@mail.gmail.com>
 <alpine.DEB.2.02.1608040718070.16194@pmeerw.net>
 <CAKzfze8Ane_fR0-MamHFsVXfdORra9wt-qxrWf5yuRRKqQckkg@mail.gmail.com>
 <20160804153551.GA2255@d830.WORKGROUP>
 <CAKzfze_rFyOb+SsU4T68dutQ8rEH2vpoT84bEX5T+_N9QSDp1g@mail.gmail.com>
 <20160804233747.GA15139@d830.WORKGROUP>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <16fc3ac8-5040-57dc-2651-39613899e308@metafoo.de>
Date: Fri, 5 Aug 2016 11:35:37 +0200
MIME-Version: 1.0
In-Reply-To: <20160804233747.GA15139@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/05/2016 01:37 AM, Alison Schofield wrote:
[...]
> 
> No, that's not what this bug & patch is about.
> 
> This patch is about the fact that we are reading the temp &
> humid data registers incorrectly in the current driver and
> we are exposing incorrect numbers via sysfs raw reads.
> 
> I have tried by testing and inspection each read protocol.
> It NAKs all of them - except for read_byte. Problem with
> read_byte is that we are always getting the MSB.   We do 2
> consecutive read_bytes, expecting MSB,LSB, but get MSB,MSB.
> 
> I have been doing msmts w this driver for quite awhile, and
> to my human eye they looked reasonable in integer format.
> But, once I started looking at the byte level, to test moving
> those bytes into buffers, I saw the unmistakable pattern: 
> MSB == LSB always.
> 
> Sorry to be the bearer of bad news.  I still hold out hope that
> we can fix this with some smbus magic and not 'kill backward
> compatibility'.  

If the part is not SMBUS compatible I don't see a reason to try to force it.
It's also not affecting backwards compatibility, the driver never worked
correctly in the first place with SMBUS only, so there is no regression.
After the patch it sill does not work.
