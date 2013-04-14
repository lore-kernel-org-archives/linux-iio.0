Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53860 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab3DNL5d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Apr 2013 07:57:33 -0400
Message-ID: <516A99AA.50905@jic23.retrosnub.co.uk>
Date: Sun, 14 Apr 2013 12:57:30 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: iio: Gpio trigger driver.  Happy with interface?
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

I have no idea how often people are using the GPIO trigger driver but what I am
looking for here is a discussion (hopefully brief) of the interface and means
of registering gpio triggers.  To my mind it makes little sense to have this
via a nice userspace control like the sysfs triggers.  If you are using a gpio
for a trigger it is probably a hardware design related descision.

Anyhow if people don't like what is there please speak up now and if you
do like it then speak up too!

I'd like to get this out of staging in the next cycle (along with lots
of other things ;)

Jonathan
