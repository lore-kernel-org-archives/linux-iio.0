Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51656 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbcEVQeX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2016 12:34:23 -0400
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Subject: Note of a bug in st-sensors driver.
Message-ID: <03533353-e4ad-cf67-e646-16dd13a01f73@kernel.org>
Date: Sun, 22 May 2016 17:34:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

This is more of a brief note of a problem than anything else.
Not sure when I'll get a chance to address it (if anyone else wants to clean
it up in the meantime that would be great)

If no platform data supplied then default platform data is assigned
directly to the spi or i2c dev.  This is a very bad idea.
When we remove and reprobe the driver, we now have a platform data pointer
pointing somewhere, unfortunately that may not be a location with anything in
it.  Result is a crash...

Fix is to have a separate local copy of the platform data pointer and don't
go messing with the ones for the spi / i2c devs.  They don't belong to the
i2c driver so we should not be touching them!

Jonathan
