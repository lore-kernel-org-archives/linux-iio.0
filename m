Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:60915 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab2KXF1G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 Nov 2012 00:27:06 -0500
Date: Fri, 23 Nov 2012 21:27:07 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org
Subject: MAX1363 IIO driver questions
Message-ID: <20121124052707.GA17392@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

What would it take to move the MAX1363 driver out of staging ?

Background is that I need a hardware monitoring driver for MAX1139, and would
like to avoid using a driver from staging if possible (after all, it might
go away anytime). Another option would be to submit a hwmon driver for it,
but that doesn't seem to be the best approach.

Thanks,
Guenter
