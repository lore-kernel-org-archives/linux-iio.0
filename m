Return-Path: <masneyb@onstation.org>
Date: Sat, 12 Nov 2016 11:37:24 -0500
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org, lars@metafoo.de, pmeerw@pmeerw.net,
	knaack.h@gmx.de, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: Re: [PATCH v3 03/28] staging: iio: tsl2583: check if chip is
 suspended in in_illuminance_calibrate_store
Message-ID: <20161112163724.GA31082@basecamp.onstation.org>
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
 <1478769964-7065-4-git-send-email-masneyb@onstation.org>
 <36ad2571-c49d-09ca-fbc7-23a13fa15056@kernel.org>
 <b30b4883-07ff-b2aa-7034-e9713e1dfca2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <b30b4883-07ff-b2aa-7034-e9713e1dfca2@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Nov 12, 2016 at 04:27:32PM +0000, Jonathan Cameron wrote:
> On 12/11/16 16:24, Jonathan Cameron wrote:
> > On 10/11/16 09:25, Brian Masney wrote:
> >> in_illuminance_calibrate_store() did not check to see if the chip is
> >> suspended. This patch adds the proper check. The return value from
> >> taos_als_calibrate() was also not checked in this function, so the
> >> proper check was also added while changes are being made here.
> >>
> >> Signed-off-by: Brian Masney <masneyb@onstation.org>
> > Applied.
> And backed out. It doesn't build :(
> 
> drivers/staging/iio/light/tsl2583.c:511:10: error: ‘struct tsl2583_chip’ has no member named ‘suspended’
>   if (chip->suspended) {
>           ^~

Bummer! I'll get this fixed and send out an updated series in a little
bit.

Brian
