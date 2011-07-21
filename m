Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:60433 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab1GULIg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2011 07:08:36 -0400
Message-ID: <4E2808B8.90105@cam.ac.uk>
Date: Thu, 21 Jul 2011 12:08:40 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: adt7310 uses two event lines.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Michael,

Right now there are bugs galore in the multiple event line code.
I'm intending to rip it out for now so as to keep things simple.
We can merge it back in when we have a use case.

The only multiple line user I know of is the adt7310.  Now there
are all sorts of other issues with this driver anyway and it
probably shouldn't be in IIO at all (just a temperature sensor).

In the meantime I propose just deleting the second interrupt line.

Is that alright with you?

Jonathan
