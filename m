Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:60383 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab1GYQg6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2011 12:36:58 -0400
Message-ID: <4E2D9BB0.30500@cam.ac.uk>
Date: Mon, 25 Jul 2011 17:37:04 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: outofstaging branch of iio-blue.git.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Kernel.org mirroring is being particularly slow today so
it might not be visible yet.

The outofstaging branch is there to allow the building up of
a patch set for the proposed posting to lkml or the various
series needed to start the move out of staging.

Right now it has the very core of IIO (sysfs only) and
a minimal max1363 driver + some fairly minimal abi docs.

Once I have feedback on the large patch sets posted today
I'll start moving a select few other drivers across before
moving on to the next stage of bringing the core across.
This also requires resolving the sysfs directory issue.

I'll take the various stages, then people can tell me
where the drivers they are bringing across in the initial
move slot in.  Please carry the docs as well, but I'll merge
all those patches into a single coherent patch before posting.
(i.e. I want ABI doc patches separate form the drivers, so
they can all be merge together into a single patch.)

Note any changes / spelling fixes to docs should be proposed
for the staging tree first. That way it should be easy to keep
cutting and pasting the relevant documentation cross as we go.

Thanks,

Jonathan
