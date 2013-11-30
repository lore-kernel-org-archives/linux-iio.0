Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49036 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851Ab3K3MCH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 07:02:07 -0500
Message-ID: <5299D3BA.8080700@kernel.org>
Date: Sat, 30 Nov 2013 12:02:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Denis CIOCCA <denis.ciocca@st.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Brian Lilly <brian@crystalfontz.com>,
	Brent-Crosby <brent@crystalfontz.com>, Jim Wall <jimwall@q.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC PATCH 0/3] DT support for ST micro accelerometers and gyroscopes
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com> <528DF164.8060009@st.com> <20131121131402.GF1029@lukather> <52926901.9080004@kernel.org> <20131125094044.GE3176@lukather>
In-Reply-To: <20131125094044.GE3176@lukather>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/25/13 09:40, Maxime Ripard wrote:
> Hi Jonathan,
> 
> On Sun, Nov 24, 2013 at 09:00:49PM +0000, Jonathan Cameron wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> On 11/21/13 13:14, Maxime Ripard wrote:
>>> Hi Denis,
>>> 
>>> On Thu, Nov 21, 2013 at 12:41:24PM +0100, Denis CIOCCA wrote:
>>>> only one point: it's possible to use the same names with DT? (using _ instead of -)
>>> 
>>> Yes, it is, but only for i2c as far as I'm aware, and usually the DT compatibles are with - as a separator (I
>>> looked into the ePAPR, but couldn't get any explanations or requirements on this, even though it's used in all
>>> of their examples)
>> 
>> In other discussions, where the defacto i2c device tree bindings have been followed, the conclusion has been that
>> to change to a - from _ would result in userspace ABI changes, so whilst no one wants _ the discussion has
>> concluded we can't really avoid it.
> 
> What kind of userspace ABI changes are we talking about?
IIRC:

i2c has a generic binding that matches to the name bit of the i2c_device_id
array.  That is then exported in sysfs.  There are quite a lot of instances
of underscores out there in these names.  Thus unforutnately they can't
be changed without possibly breaking userspace.  Typically those same names
are also output by IIO though obviously we could keep that the same whilst
changing the dt binding.

Also the i2c binding allows binding after dropping the vendor prefix which
is even more 'interesting'. See of_modialias_node in drivers/of/base.c

I'd therefore argue in favour of just leaving the underscores in existing
drivers as a nasty bit of legacy and doing our best to not introduce any
new ones!

Jonathan

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSmdOzAAoJEFSFNJnE9BaIilUP/RPwSswdYi9wWtN0tBEFfZvo
JO0bybjw342LE2xt3DXd7fo04v1+LspWxatw6kht1mJ/aU6O4HwNHQpPO7Md5pDm
4HPoPSREaDbYEOqhVSjXaBUOXIOYSe392KtqKJMRSxRs3XiIeqYPfojqtIE2KF7a
W3EEjud5wrWuOLKtdQWjRt+UpDnewImR+qORtRUoA7NY2YIHvdarOQFlfDqLXSRK
GvE49O8jCtQvcjI1rsybMRXQkUF3GE8hLyATaf/SbvgVeILbHSl6OvaN7O7nNJ+b
DGGrzAzmKwj56G47imQ7z2v/D9ExWNwr1DZ2CMPt+yXQ15OBXDnAmWGXTr45/dUl
G8PjaZA9GKsp0dE713b0RN/eJnsoFsJd8bDCeXh9IpVblmkQzW3HsvI8p2Uj8xga
5d/txeXytLNvHj+3OiiVTaKA3Y9/dFNq9dwI+QAMbLY87T4ft70z533liTZRnMWG
2O8x2oHYnoFRH3qmpg6jy3/qCFe6wTTXy1yMFQ0Ds/bJ93vhrv7SiXXsxX3CNl9X
KI8t74zx51GMxBV5pMixgX9aBH7Wrn+WSXmUKkMkm7JGbeicZEjk259EjAluuohD
HHh0cehjCuVPY6PTUhkXTfCFDfpFtwOkXsZb6fOMS2wDKK4BLwb3SPwyn+ID7XJs
u/RQzwNNjvdsR2hmBQOw
=lpwt
-----END PGP SIGNATURE-----
