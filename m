Return-Path: <error27@gmail.com>
Date: Mon, 4 Jul 2011 12:10:16 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Chris Forbes <chrisf@ijw.co.nz>, devel@driverdev.osuosl.org,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: staging: iio: adc: fix uninitialized use
Message-ID: <20110704091016.GM2544@shale.localdomain>
References: <1309657621-21711-1-git-send-email-chrisf@ijw.co.nz>
 <4E118157.3020906@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E118157.3020906@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jul 04, 2011 at 10:01:11AM +0100, Jonathan Cameron wrote:
> On 07/03/11 02:47, Chris Forbes wrote:
> > Fixed an uninitialized variable access. In the first two error paths in
> > max1363_probe(), 'st' is not yet initialized, but its 'reg' member is
> > accessed anyway. This would most likely crash.
> Good spot. Please tech TODO files for staging patches. In this case it would
> have given you the mailing list, now cc'd.

It would better to add an entry to MAINTAINERS so that
./scripts/get_maintainer.pl gave the right lists.

regards,
dan carpenter
