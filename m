Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:55696 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab3BOUHK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Feb 2013 15:07:10 -0500
Date: Fri, 15 Feb 2013 12:07:34 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/9] hwmon: (adt7410) Use the SIMPLE_DEV_PM_OPS helper
 macro
Message-ID: <20130215200734.GC32433@roeck-us.net>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
 <1360947438-2550-3-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360947438-2550-3-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Feb 15, 2013 at 05:57:12PM +0100, Lars-Peter Clausen wrote:
> Use the SIMPLE_DEV_PM_OPS macro to declare the driver's pm_ops.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to hwmon-next.

Thanks,
Guenter
