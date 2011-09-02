Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:54835 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941Ab1IBQXG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2011 12:23:06 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:53761)
	by ppsw-50.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1QzWWH-0001bu-pz (Exim 4.72) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Fri, 02 Sep 2011 17:23:05 +0100
Message-ID: <4E6104D9.2090508@cam.ac.uk>
Date: Fri, 02 Sep 2011 17:31:21 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: IIO: rest of cycle todo list.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

I've now sent everything that was in iio-blue.git master branch
on to Greg (note that not everything is on kernel.org yet for
obvious reasons but it has all been on list).  So what is on
the todo list for the rest of this cycle?

1) More cleanups + make sure that in_ out_ prefix stuff propagates
down into the drivers (only done for chan_spec stuff so far).

2) Documentation updates / rewrite for out of staging.

3) Review / improvement of the outofstaging tree.  I'd like to post
it widely fairly soon so please can anyone with any spare time take
a look - suggest and add more drivers to the example set.

Just thought I'd keep people up to date with where things are as
the absence of hera means development is not as open as normal!

Jonathan
