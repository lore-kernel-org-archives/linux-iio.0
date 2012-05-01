Return-Path: <josephdanielwalter@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120430201855.GN6447@mwanda>
References: <1335813977-8096-1-git-send-email-josephdanielwalter@gmail.com>
	<20120430200444.GM6447@mwanda>
	<20120430201855.GN6447@mwanda>
Date: Tue, 1 May 2012 10:09:46 +0600
Message-ID: <CAFDqYy3GYch+C2c7Kvg3zvryCvY9d-rk=xi2KfbHb34dVz+Jzw@mail.gmail.com>
Subject: Re: [PATCH] staging/iio/meter: fix the coding style problem
From: joseph daniel <josephdanielwalter@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <w.sang@pengutronix.de>,
	linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Tue, May 1, 2012 at 2:18 AM, Dan Carpenter <dan.carpenter@oracle.com> wr=
ote:
> On Mon, Apr 30, 2012 at 11:04:44PM +0300, Dan Carpenter wrote:
>> On Tue, May 01, 2012 at 01:26:17AM +0600, joseph daniel wrote:
>> >
>> > Signed-off-by: joseph daniel <josephdanielwalter@gmail.com>
>> > ---
>> > Hi Lars,
>> > =A0 =A0 Thanks for review. how about the below change?
>
> Lar's review is the correct one. =A0It's cleaner to use
> get_unaligned_be32(). =A0You'll need to include <asm/unaligned.h>
>
Thanks For the info Dan. i will be taking your comments in the code change.
> regards,
> dan carpenter
>
Thanks,
Joseph.
