Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nm30.access.bullet.mail.mud.yahoo.com ([66.94.237.95]:27231
	"EHLO nm30.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751876Ab3D0NHt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Apr 2013 09:07:49 -0400
Date: Sat, 27 Apr 2013 06:08:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Axel Lin <axel.lin@ingics.com>, Jonathan Cameron <jic23@cam.ac.uk>,
	Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] hwmon: (iio_hwmon) Fix missing iio_channel_release_all
 call if devm_kzalloc fail
Message-ID: <20130427130826.GA31156@roeck-us.net>
References: <1366708003.10246.1.camel@phoenix>
 <20130423124800.GA29681@roeck-us.net>
 <517B9AFE.9000205@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <517B9AFE.9000205@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Apr 27, 2013 at 10:31:42AM +0100, Jonathan Cameron wrote:
> On 04/23/2013 01:48 PM, Guenter Roeck wrote:
> > On Tue, Apr 23, 2013 at 05:06:43PM +0800, Axel Lin wrote:
> >> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > Good catch.
> >
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> Given the timing this will need to go in through hwmon
> after the merge window is closed.  Sorry, busy week or
> I would have caught up with this earlier.
> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>

Ok.

Thanks,
Guenter
