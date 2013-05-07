Return-Path: <panto@antoniou-consulting.com>
Subject: Re: [PATCH] ti_tscadc: Update with IIO map interface & deal with partial activation
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
From: Pantelis Antoniou <panto@antoniou-consulting.com>
In-Reply-To: <5187D655.1010402@kernel.org>
Date: Tue, 7 May 2013 16:08:40 +0300
Cc: Jan Luebbe <jlu@pengutronix.de>,
 rachna@ti.com,
 linux-iio@vger.kernel.org,
 linux-omap@vger.kernel.org,
 Koen Kooi <koen@dominion.thruhere.net>
Message-Id: <902E054D-F014-4380-A493-96384AC85DD4@antoniou-consulting.com>
References: <1351698938-3839-1-git-send-email-panto@antoniou-consulting.com> <1367844539-6812-1-git-send-email-jlu@pengutronix.de> <5187D655.1010402@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On May 6, 2013, at 7:12 PM, Jonathan Cameron wrote:

> On 05/06/2013 01:48 PM, Jan Luebbe wrote:
>> Hi Pantelis,
>>=20
>> while trying out your patch on a custom AM335x board, I noticed that =
the
>> sysfs entries ware missing. This is fixed in the first patch, you =
might want
>> to squash that into your original patch.
>>=20
>> The second one makes sure that the iio framework does not read =
invalid data.
>>=20
>> Regards,
>> Jan
>=20
> I don't believe Pantelis ever came back with a response to the various =
issues
> raised with the original patches?
>=20

I am aware. We've been quite busy getting the new beaglebone out. I plan =
to
revisit the full patchset for all the various fixes we had to do in a =
month
or so.

> If Pantelis has moved on, Jan feel free to pick up the patches, respin =
them
> and resend to linux-iio if you like (with appropriate crediting =
naturally)
>=20

I wouldn't mind Jan to pick up the IIO patches.

> Until these are appropriately fixed up and resent, I'm lazy so will =
ignore these.
> (your patches look reasonable to me based on a really superficial =
look)
>=20
> Jonathan

Regards

-- Pantelis
