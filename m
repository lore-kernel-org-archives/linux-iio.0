Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49181 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab2F3Mik (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jun 2012 08:38:40 -0400
Received: from [192.168.0.6] (cpc1-cmbg6-0-0-cust492.5-4.cable.virginmedia.com [81.101.137.237])
	by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 4E31340410
	for <linux-iio@vger.kernel.org>; Sat, 30 Jun 2012 13:38:39 +0100 (BST)
Message-ID: <4FEEF34F.8060507@kernel.org>
Date: Sat, 30 Jun 2012 13:38:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: IIO new flow for patches into kernel.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

At Greg's suggestion I'm moving to a more conventional
work flow.  Hence I'll merge patches that I am happy with
Sign-off on them etc and send pull requests to Greg.

I think I've just sent everything that was ready to go
that Greg hasn't already merged, but if anything fell
through the cracks please do point it out to me!

For reference my tree is at:

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

the branches that matter are

fixes-togreg. Stuff for the current cycle.
togreg. New stuff for the next cycle.

Jonathan
