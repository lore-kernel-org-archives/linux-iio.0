Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:42299 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab1HLQ1E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2011 12:27:04 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:32975)
	by ppsw-50.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1QruZa-0007tk-sL (Exim 4.72) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Fri, 12 Aug 2011 17:27:02 +0100
Message-ID: <4E45563D.4090204@cam.ac.uk>
Date: Fri, 12 Aug 2011 17:35:09 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: iio-blue.git reorganization.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This dev tree as I warned is not stable.  It's more or less
a dump of my local working tree.

As such I hope no one minds the wholesale reorganization I've just
pushed out to kernel.org.  Basically I've sorted patches
into fixes / cleanups1 / chan spec conversions / cleanups2 / controversial bits / other stuff.

fixes and cleanups1 have gone to Greg for now.

The controversial bits are:

* trigger rework to make removal safe.

* chrdevs merging into one.

* in_ out_ prefix on channnels.

* endian description addition.

* extend scan_mask and event codes to allow for more channels.

Comments on anything and everything welcome!


Jonathan
