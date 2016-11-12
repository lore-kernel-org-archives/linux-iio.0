Return-Path: <masneyb@onstation.org>
Date: Sat, 12 Nov 2016 11:59:35 -0500
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org, lars@metafoo.de, pmeerw@pmeerw.net,
	knaack.h@gmx.de, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: Re: [PATCH v3 16/28] staging: iio: tsl2583: updated code comment to
 match what the code does
Message-ID: <20161112165935.GB31082@basecamp.onstation.org>
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
 <1478769964-7065-17-git-send-email-masneyb@onstation.org>
 <67166adf-5a89-3283-8a16-9a0a9a57e770@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <67166adf-5a89-3283-8a16-9a0a9a57e770@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Nov 12, 2016 at 04:36:37PM +0000, Jonathan Cameron wrote:
> On 10/11/16 09:25, Brian Masney wrote:
> > If channel 0 does not have any data, then the code sets the lux to zero.
> > The corresponding comment says that the last value is returned. This
> > updates the comment to correctly reflect what the code does.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> Better perhaps to just return an error, -EAGAIN perhaps?
> I'm not sure why it would not give a value.

This check is to avoid a division by zero. Here is the relevant code
that wasn't shown in the diff:

	if (!ch0) {
		/* have no data, so return 0 */
		ret = 0;
		chip->als_cur_info.lux = 0;
		goto done;
	}

	/* calculate ratio */
	ratio = (ch1 << 15) / ch0;

Channel 0 is sensitive to both infrared and visible light. In total
darkness, the sensor should return 0. Correct me if I am wrong, but
I believe that returning 0 here is more correct than -EAGAIN.

Brian
