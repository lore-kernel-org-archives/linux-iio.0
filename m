Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:62307 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab3BOUGp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Feb 2013 15:06:45 -0500
Date: Fri, 15 Feb 2013 12:07:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/9] hwmon: (adt7410) Let suspend/resume depend on
 CONFIG_PM_SLEEP
Message-ID: <20130215200708.GB32433@roeck-us.net>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
 <1360947438-2550-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360947438-2550-2-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Feb 15, 2013 at 05:57:11PM +0100, Lars-Peter Clausen wrote:
> Only build the suspend/resume code if CONFIG_PM_SLEEP is selected. Currently the
> code is built if CONFIG_PM is selected, but it will also be selected if only
> runtime PM support is built into the kernel.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to hwmon-next.

Thanks,
Guenter
