Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:64283 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab3CBRJ6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 12:09:58 -0500
Date: Sat, 2 Mar 2013 09:10:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jean Delvare <khali@linux-fr.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/4] staging:iio: Remove adt7410 driver
Message-ID: <20130302171004.GA26334@roeck-us.net>
References: <1361194739-16525-1-git-send-email-lars@metafoo.de>
 <1361194739-16525-4-git-send-email-lars@metafoo.de>
 <51322C9A.5000102@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51322C9A.5000102@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Mar 02, 2013 at 04:45:14PM +0000, Jonathan Cameron wrote:
> On 02/18/2013 01:38 PM, Lars-Peter Clausen wrote:
> > The adt7410 hwmon driver is feature wise more or less on par with the IIO
> > driver. So we can finally remove the IIO driver.
> > 
> I kind of lost touch on where things were with the last few patches adding support in
> the hwmon driver for stuff that was in here.  It looked like there were only nitpicks
> left so I'll assume it gets sorted this coming cycle and take this patch now
> (before I loose it)

I am waiting for a final rev of Lars' patches to add adt7310/adt7320 support and
alarm interrupt support to the hwmon driver, but I don't see a problem getting
it all into 3.10.

Thanks,
Guenter
