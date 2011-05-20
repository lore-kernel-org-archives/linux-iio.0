Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:33787 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934797Ab1ETIkO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 20 May 2011 04:40:14 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:56338)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1QNLFj-0003e4-D2 (Exim 4.72) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Fri, 20 May 2011 09:40:11 +0100
Message-ID: <4DD62994.4080701@cam.ac.uk>
Date: Fri, 20 May 2011 09:43:00 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: GENERIC_HARDIRQS does anyone have a platform that doesn't enable
 this?
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Just occurred to me whilst reading some other patches that technically
we now depend on CONFIG_GENERIC_HARDIRQS

Just wondering if anyone knows of a platform to build tests on
that doesn't have this?

Thanks,

Jonathan
