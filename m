Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:53673 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbbIWHkD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Sep 2015 03:40:03 -0400
Subject: Re: [PATCH v4 2/2] iio: mcp4531: Driver for Microchip digital
 potentiometers
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	linux-iio@vger.kernel.org
References: <1442936209-27057-1-git-send-email-peda@lysator.liu.se>
 <1442936209-27057-3-git-send-email-peda@lysator.liu.se>
 <B61434B3-133C-4B9C-B451-85B90E55D77A@jic23.retrosnub.co.uk>
Cc: Peter Rosin <peda@axentia.se>, Crt Mori <cmo@melexis.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Andreas Dannenberg <dannenberg@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org
From: Peter Rosin <peda@lysator.liu.se>
Message-ID: <5602574B.5020205@lysator.liu.se>
Date: Wed, 23 Sep 2015 09:39:55 +0200
MIME-Version: 1.0
In-Reply-To: <B61434B3-133C-4B9C-B451-85B90E55D77A@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2015-09-22 20:22, Jonathan Cameron wrote:
> On 22 September 2015 16:36:49 BST, Peter Rosin <peda@lysator.liu.se> wrote:

*snip* lots of cosmetics that I'll fix in the next spin...

>> +
>> +static int mcp4531_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int *val, int *val2, long mask)
>> +{
>> +	int err;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		err = mcp4531_get_value(indio_dev, chan->address, val);
>> +		if (err < 0)
>> +			return err;
>> +		return IIO_VAL_INT;
>> +	}
> No scale known? Be nice to relate to real world values.  I gather this may need
>  platform data of some type (can't open data sheet on phone for some reason)

...but I need more input on this.

Yes, it would be nice and yes it requires platform data, as there is
no way to retrieve if the driver is dealing with a 5, 10, 50 or 100 kOhms
pot/rheostat. You would also have to expose both the resistance between
A to W and between W to B, as you have no way to know how it's been
connected (or you'd need more platform data). Ok, for rheostats you
know how it's connected, since A isn't available, but for pots there
are two resistance values controlled with a single value X i.e.
X*scale/max and (max-X)*scale/max (ignoring the 75 Ohm wiper resistance).

But, I'd rather not go there, as I don't need any of it. Is it Ok to not
provide scaling?

Cheers,
Peter

