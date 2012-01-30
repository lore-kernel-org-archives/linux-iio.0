Return-Path: <jic23@kernel.org>
Message-ID: <4F271048.4060608@kernel.org>
Date: Mon, 30 Jan 2012 21:48:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: linux-iio@vger.kernel.org, greg@kroah.com,
 guenter.roeck@ericsson.com, khali@linux-fr.org,
 dmitry.torokhov@gmail.com, alan@lxorguk.ukuu.org.uk, arnd@arndb.de,
 linus.walleij@linaro.org, maxime.ripard@free-electrons.com,
 thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
 w.sang@pengutronix.de, marek.vasut@gmail.com,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 5/5] stargate2: example of map configuration for iio to
 hwmon example.
References: <1327837614-24176-1-git-send-email-jic23@kernel.org> <1327837614-24176-6-git-send-email-jic23@kernel.org> <20120130193350.GA9672@opensource.wolfsonmicro.com> <4F26FCE2.1030705@kernel.org> <20120130212253.GC9672@opensource.wolfsonmicro.com>
In-Reply-To: <20120130212253.GC9672@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/30/2012 09:22 PM, Mark Brown wrote:
> On Mon, Jan 30, 2012 at 08:26:10PM +0000, Jonathan Cameron wrote:
>> On 01/30/2012 07:33 PM, Mark Brown wrote:
>>> On Sun, Jan 29, 2012 at 11:46:54AM +0000, Jonathan Cameron
>>> wrote:
> 
>>>> +static struct iio_map max1363_consumer_map[] = { +	{ + 
>>>> .adc_channel_label = "AIN1", +		.consumer_dev = 
>>>> &iio_hwmon_test.dev, +		.consumer_channel = "testchan1",
> 
>>> I do think it's better to use dev_name here rather than a
>>> struct device pointer - for several of the buses it's not
>>> actually possible to get a struct device until a device has
>>> been instantiated which isn't helpful for setting up the
>>> mappings.
> 
>> We allow both.  In cases like this where the dev pointer is
>> explicitly available what gain do we get from not using it?
> 
> You avoid user confusion from having two ways of doing the same
> thing and you save a little complexity in the implementation.  The
> user confusion does happen in practice.
Good reasoning.  Will drop the dev pointer option.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPJxBHAAoJEFSFNJnE9BaIGUwP/2SQjWhWZP28GWpWemx5Av7O
5CUKvDZ/qk+ehevvp0fOKOD/DvciSNWDd/dTmGRllbYzpz7RkbGmV9sm+BFydqyG
beTzbF5h5vuvCNfvVrXwePh2/fcm3kSMIOYQSnaDmn5rmZTR0qK6nkh1GdBtMa2T
Hbk+qjdQFcrAvQcL1R4FQO+kq2xS/F3zQAt1rqxu4e+JWQjYDmGCK9zeWjJDmakv
2DDeUUezNIA0tjvQy9EUOdybtoKvBlmgTujwCX2qpeyJTll2yxPuWFx8nB7oNGCQ
ljoa9YO6mpRgiAQNpnvOeMLtAwa3EjEZLf1XBRRXUPoAvehcPLdL5C3IaxzpmaTY
r7qXAPWwMPGIj5pTXdP1mQleZiepdKi3oOWygBjG8nKDqcLjuiMBPaE+S6xjIn4O
dseszmeWhOsQgdBr3CpkaqBZrT3NDKcHkaFyThCQCDBIATTEK5LVgGVi9KX3toAe
Emov7mOW+xSTJ2CLtbrmmjRm/mJSCXUVPBurD+LTXJnxOmCipTmd0Gt/s8dzPyd0
uaY4XBSypYjUvakFgazuZ13pgDvfbQe329ShRNzM4CAPboy8q/X1W/JDsZvfJqrj
oo04TKVxjbg44FjzhbxxBIavq+BUIdJMW4/MCt5YRq5rZPHq5E0TAbZ4tQpmvHUJ
I9UZthFWchN/lD2AEteV
=QK3s
-----END PGP SIGNATURE-----
