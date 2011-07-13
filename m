Return-Path: <rdunlap@xenotime.net>
Date: Wed, 13 Jul 2011 08:49:09 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: driverdevel <devel@driverdev.osuosl.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: staging/iio/meter/ade7753: 406:19: warning: right shift by bigger
 than source value
Message-Id: <20110713084909.8ee94a75.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


static ssize_t ade7753_read_frequency(struct device *dev,
		struct device_attribute *attr,
		char *buf)
{
	int ret, len = 0;
	u8 t;
	int sps;
	ret = ade7753_spi_read_reg_8(dev, ADE7753_MODE,	&t);
	if (ret)
		return ret;

	t = (t >> 11) & 0x3; /// HUH?

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
