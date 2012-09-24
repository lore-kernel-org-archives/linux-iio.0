Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:48433 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab2IXIKh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Sep 2012 04:10:37 -0400
Received: from [81.138.163.57] (port=63297 helo=[10.0.2.15])
	by ppsw-50.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:587)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1TG3kR-0007Zx-qv (Exim 4.72) for linux-iio@vger.kernel.org
	(return-path <jic23@hermes.cam.ac.uk>); Mon, 24 Sep 2012 09:10:35 +0100
Message-ID: <5060157A.805@kernel.org>
Date: Mon, 24 Sep 2012 09:10:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: IIO merge probably closed for 3.7 cycle.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Linus has definitively stated that he won't do another release candidate 
for 3.6, but his rc7 email implied it was unlikely.

Anyhow, that means that I'll be queuing any new stuff up
for the 3.8 cycle from now on. (Given we route through GregKH
we have to obey his one week limit + I agree entirely with his
policy on this so would apply such a limit anyway)

Personally I'll be having another go at the multiple buffered
support patches over the next week or so and really really hope
I can finally get those merged. For the interested the current
version (which is more or less ready for posting is in the wip
branch of iio.git on kernel.org.

I'd also hope that the 3.8 cycle carries on the process of
moving individual drivers out of staging and given
I haven't actually moved any of my own yet I will be
spending some time doing that.

There have been some nice new drivers and also a lot of good cleanup 
work on the exiting code.  Nice to see has been the number of new
contributors to the subsystem and in particular that more and more
people have been willing to get their hands dirty in the core code :)
I won't name any names as I'll just forget someone and the git
log will do the job nicely for me!

Anyhow, looking forward to a productive 3.8 cycle, in particular
merging the various drivers currently mid way through the review
process.

Jonathan
