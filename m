Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:59288 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1IEJe2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2011 05:34:28 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:43689)
	by ppsw-51.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1R0VZT-0007e5-ZC (Exim 4.72) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Mon, 05 Sep 2011 10:34:27 +0100
Message-ID: <4E649994.9030208@cam.ac.uk>
Date: Mon, 05 Sep 2011 10:42:44 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Temporary iio-blue.git location.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Given master.kernel.org is still down, after pestering
of our local admin I can now host repositories on our windows
based web server (oh goody).

So, you should be able to pull from:

 http://www-sigproc.eng.cam.ac.uk/~jic23/iio/.git
(I copied it across so it's not a bare repository).

That'll get you everything I have sent to Greg if you
want to know where we are.

Note this is just a temporary work around and please don't
pull the whole repository too often.

Thanks,

Jonathan
