Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:57285 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab3BOUHd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Feb 2013 15:07:33 -0500
Date: Fri, 15 Feb 2013 12:07:58 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/9] hwmon: (adt7410) Use I2C_ADDRS helper macro
Message-ID: <20130215200758.GD32433@roeck-us.net>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
 <1360947438-2550-4-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360947438-2550-4-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Feb 15, 2013 at 05:57:13PM +0100, Lars-Peter Clausen wrote:
> Use the I2C_ADDRS macro to initialize the I2C device's address_list. Doing so
> saves a few lines of boilerplate code.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to hwmon-next.

Thanks,
Guenter
