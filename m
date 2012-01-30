Return-Path: <jic23@kernel.org>
Message-ID: <4F26FCE2.1030705@kernel.org>
Date: Mon, 30 Jan 2012 20:26:10 +0000
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
References: <1327837614-24176-1-git-send-email-jic23@kernel.org> <1327837614-24176-6-git-send-email-jic23@kernel.org> <20120130193350.GA9672@opensource.wolfsonmicro.com>
In-Reply-To: <20120130193350.GA9672@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/30/2012 07:33 PM, Mark Brown wrote:
> On Sun, Jan 29, 2012 at 11:46:54AM +0000, Jonathan Cameron wrote:
> 
>> +static struct iio_map max1363_consumer_map[] = { +	{ +
>> .adc_channel_label = "AIN1", +		.consumer_dev =
>> &iio_hwmon_test.dev, +		.consumer_channel = "testchan1",
> 
> I do think it's better to use dev_name here rather than a struct
> device pointer - for several of the buses it's not actually
> possible to get a struct device until a device has been
> instantiated which isn't helpful for setting up the mappings.
We allow both.  In cases like this where the dev pointer is explicitly
available what gain do we get from not using it?

I could easily enough fake an example for using dev_name as well I
suppose or add a commented out version in here to make it obvious that
both options would be fine.  Note this example is actually garbage
anyway as that particular chip is simply wired to some screw terminals
on the side of this board.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPJvy+AAoJEFSFNJnE9BaI8GwQAIRQ2MP+UhVUGiPVQpTIVxIV
B+3GvoDhdF8GEaWLMb5jXS6p1kQ9m1IxSfTfzBPa/lLDMpZMH72FD2nguNFID0qK
aRu2zv7ooEAdhBMPYJJC9XUlq1vl7Mas82zH8zK2z/iIuIUJTJlO/l+vgpu+EhFJ
H5DODW9oRuWpbNMbpTKExf+fyMRkp/o+0It++Zk4eJPs4q1ajAYnDpDeIeUVyyIM
5OTQSvrGVL8uRtHhcqaJkVNUizhR+eMgDYef25dgTO2CnKjoO5q3CjikcoG6RYrQ
tVvZw0slGULry2jGcf1K/scxiuIjCtYGIPFkeorxtAow6JB3QRvQP01JYa+4gpb1
HSp0dkvmUF4V0JS52bxzp788C9hpAG7Vd7Mul3M+7BuwYxAOYgD8eL5tfuQWPaCJ
nN/YlXUDw1Oy3obBKZvma1o18zaQvclF74FIAw4AMz/8r8QC3vcpvUqR58YP7B2Z
qYheZKIIII4kZmG09QcYVjXB3O1IvP9B9EN/QPXYTp8vHQ55wVPA6ZQQzpeSnDeC
5PW0TaNMqroYdb2BuPZ4+gVNt3rqmDNTaexxdgWJtHAKiukh6EbNEfEsTk/LTOHn
s+jTnpni3h+z+tgTRvxgGmW40EyUlrmnR/c0vBohvcknOI1ugrViRr88RCsSX01S
Wv/kaVXUcT5visYRcHls
=Z0kq
-----END PGP SIGNATURE-----
