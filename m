Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58750 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3DIRsw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Apr 2013 13:48:52 -0400
Received: from [192.168.0.5] (cpc4-cmbg6-0-0-cust321.5-4.cable.virginmedia.com [81.107.37.66])
	by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id CA3E840264
	for <linux-iio@vger.kernel.org>; Tue,  9 Apr 2013 18:48:51 +0100 (BST)
Message-ID: <51645483.3090402@kernel.org>
Date: Tue, 09 Apr 2013 18:48:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: iio probably closed for the 3.10 merge window.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Given the comments from Linus it looks like the final rc for
3.9 will be this weekend.  The 3.10 merge window will probably
open the weekend after so Greg will close staging for new
stuff sometime in the next couple of days thus moving one step
futher down the tree that means IIO is pretty much closed now
baring any changes to that schedule.) Plus I cut it too fine
last cycle so I'm not going to stretch Greg's patience again!

Naturally I'm happy to queue anything new up for the 3.11 cycle
or take fixes for sending upstream after 3.10-rc1 is out.

Thanks for everyones good work this cycle.

Jonathan
