Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:49994 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470Ab3KLVtw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 12 Nov 2013 16:49:52 -0500
Received: from sirene.lan (83-215-0-241.stadt.dyn.salzburg-online.at [83.215.0.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pmeerw)
	by pmeerw.net (Postfix) with ESMTPSA id DE263C50171
	for <linux-iio@vger.kernel.org>; Tue, 12 Nov 2013 22:49:50 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Subject: [PATCH 0/2] iio: trivial trigger cleanups and RFC
Date: Tue, 12 Nov 2013 22:49:45 +0100
Message-Id: <1384292987-6250-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

two trivial cleanups and a question: the behaviour of 
iio_trigger_write_current() currently is that all strings are 
accepted -- if the string matches a trigger's name, a new trigger
is set for the device (given the trigger passes validation); if the
string doesn't match a trigger's name, then the current trigger
is unset

so arbitrary garbage can be passed and is used to unset a trigger
(I'd have expected -EINVAL for unknown trigger names and a defined 
value such as "" to unset) -- is this what we want?

Peter Meerwald (2):
  iio: Minor kerneldoc fix for iio_trigger_write_current()
  iio: Remove redundant check that new trigger is different from old

 drivers/iio/industrialio-trigger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.8.4.3

