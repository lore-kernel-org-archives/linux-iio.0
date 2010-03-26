Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:47927 "EHLO
	ppsw-6.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab0CZQJ1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2010 12:09:27 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:56126)
	by ppsw-6.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1NvC69-0002IU-M7 (Exim 4.70) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Fri, 26 Mar 2010 16:09:25 +0000
Message-ID: <4BACDCC7.90508@cam.ac.uk>
Date: Fri, 26 Mar 2010 16:11:51 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Cut down on number of attribute macros?
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear All,

As part of the abi changes, we would need a huge number of macros similar
to those currently provided in accel.h, adc.h and friends.

Often these actually lead to longer code that one would have if one called
the underlying IIO_DEVICE_ATTR and similar macros.  

Hence I'm after opinions from those working with the subsystem.  Are these
useful or would we be better served taking the approach of enforcing these
naming conventions via review of submitted drivers (similar to hwmon)?

Thus we rely on abi documentation rather than the current complex mess of
macros.

What do people think?

I'm certainly not inclined to enforce the use of these macros, particularly in
cases like the one I would have added as part of the new abi changes..

IIO_DEV_ATTR_ACCEL_Z_MAG_EITHER_RISING_VALUE(_mode, _show, _store, _reg)

vs just using IIO_DEVICE_ATTR directly in the instansiation

IIO_DEVICE_ATTR(accel_z_mag_either_rising_value,
	S_IRUGO | S_IWUSR,
	sca3000_show_thresh,
	sca3000_write_thresh,
	SCA3000_REG_CTRL_SEL_MD_Z_TH);

If anything the events, particularly the shared cases are even worse.

At some point I'm going to end up with an 80 character macro name using
the current approach.

Jonathan
