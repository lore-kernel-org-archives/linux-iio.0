Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: inkern: add error case in iio_channel_get()
Date: Mon, 17 Sep 2012 08:46:15 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EF50BA@DQHE02.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F41EF45EB@DQHE02.ent.ti.com>
 <504DAFF7.1070902@jic23.retrosnub.co.uk>
 <A874F61F95741C4A9BA573A70FE3998F41EF4C19@DQHE02.ent.ti.com>
 <5052E9A3.9030200@kernel.org>
In-Reply-To: <5052E9A3.9030200@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> Fine, I'm convinced.  Certainly less weird doing it your way ;)
> Please do fix up the get all case as well.

Please refer to chained patches.
[PATCH 1/2] iio: inkern: add error case in iio_channel_get()
[PATCH 2/2] iio: inkern: put the IIO device when mem alloc gets failed

I'd like to mention that these patches are dependent on another fix as belo=
w.
[PATCH RESEND] iio: inkern: allocate zeroed memory

Please let me know if any conflicts.

Thanks !

Best Regards,
Milo
