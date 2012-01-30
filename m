Return-Path: <jic23@kernel.org>
Message-ID: <4F26FD82.0@kernel.org>
Date: Mon, 30 Jan 2012 20:28:50 +0000
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
Subject: Re: [PATCH 1/5] staging:iio:core add in kernel interface mapping
 and getting IIO channels.
References: <1327837614-24176-1-git-send-email-jic23@kernel.org> <1327837614-24176-2-git-send-email-jic23@kernel.org> <20120130202226.GB9672@opensource.wolfsonmicro.com>
In-Reply-To: <20120130202226.GB9672@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/30/2012 08:22 PM, Mark Brown wrote:
> On Sun, Jan 29, 2012 at 11:46:50AM +0000, Jonathan Cameron wrote:
> 
>> -static struct device_type iio_dev_type = { +struct device_type
>> iio_dev_type = { .name = "iio_device", .release =
>> iio_dev_release, };
> 
> Why is this exported?
oops.  Hangover from previous version I think. Thanks for pointing it out.
> 
>> +	mutex_lock(&iio_map_list_lock); +	while ((maps[i].consumer_dev
>> != NULL) || +	       (maps[i].consumer_dev_name != NULL)) {
> 
> I'd suggest just dropping the struct device - the reason we support
> the struct device directly in the regulator API is that we
> originally had only a struct device and kept the code around as a
> transition measure (though now it's so old we should be able to
> kill it off).  This would simplify the code and the interface a
> bit.
Ah, that explains your comment on the 5th patch.  Alright, I'll let this
sit for a few days and if no one comes up with a good reason not to
we'll go with just the dev_name option.

Jonathan


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPJv2CAAoJEFSFNJnE9BaIfRYP/R9nGQIY7sCm4UsdBZldyW93
8Eu0jPMXJs/YLgc7zSJisFqUQNS4BJjORVDh2AcV/hu7FXaxtD6QhxaC3/RMjwfa
EgElSYU7N2yPThJLXh1w12qgvt6+zxAT+Gnv11pHeaf6gZrXU2IUBy1FlExCudpI
hc+CnDSSHjZk6aJKWmockmcmwlSGLy4WV7nH4S907pzm2yXnI9UqvVaHwPVtO/Yl
rZyrZo6T8C4Xw2GeB5QdZ4GNXRuNUOezc1OfqdK/FKj3lVo23ZsAfoMoKkS33ZWF
zjU8deSJY6VSYhfJtnfv7ucv5GjjhbuWSGZP0VD/BR+eTjWD54EasVv5AqwOz/Iz
wwbvanHTqsVrEBU76733wvWRFelZXgzYhFoQYEucQB5F4KCtqO1OTi62stDCXLLR
Z9ygHH92t7TlsKbxaMGL8gU7jGDeIytuHgJW2BXd8ekwQr4fdY7eBwoW4A+TRSKl
rCNSp5iuKIXjyQ8ZJviOKXlZDJa2/5mYuDO8juQFcYshe+X29pbsrybLPkBBKdhl
GxOi8DtiMVPCiHB63bKGXhqe38jNeHK0hboiREHZgnEt1/a+ZkLDVnWtLQcUBuBo
UfLfuzQju/DrtqnWj8asmRzpsA675Lh1xmdLU0tv/NEb/aOGnIAy3+BAhhiq2g1w
OU87P/vuWQrgl1D/jUEh
=l3HK
-----END PGP SIGNATURE-----
