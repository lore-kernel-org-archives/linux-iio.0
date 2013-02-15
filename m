Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:54935 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab3BOUGN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Feb 2013 15:06:13 -0500
Date: Fri, 15 Feb 2013 12:06:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/9] hwmon: (adt7410) Clear unwanted bits in the config
 register
Message-ID: <20130215200637.GA32433@roeck-us.net>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360947438-2550-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Feb 15, 2013 at 05:57:10PM +0100, Lars-Peter Clausen wrote:
> Make sure to clear the mode bits from the config register before setting the new
> mode. Otherwise we might end up with a different mode than we want to.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to hwmon-next.

Thanks,
Guenter
