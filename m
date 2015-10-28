Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44782 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964913AbbJ1KDL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 28 Oct 2015 06:03:11 -0400
From: Michal Marek <mmarek@suse.cz>
Subject: Duplicate htu21 drivers
To: William Markezana <william.markezana@meas-spec.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org
Message-ID: <56309D5C.30008@suse.cz>
Date: Wed, 28 Oct 2015 11:03:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

commit 2b5c53d2c958 ("Add htu21 meas-spec driver support") introduced a
new implementation of the htu21 driver into drivers/iio/humidity. At
first glance, it provides the same features as drivers/hwmon/htu21 with
a different sysfs interface. What is the plan with these two drivers?
Will the iio driver replace the hwmon one? At a minimum, they should
conflict in kconfig, because module names must be unique.

Thanks,
Michal
