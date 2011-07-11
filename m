Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:48122 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757926Ab1GKPvW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2011 11:51:22 -0400
Message-ID: <4E1B1BF9.4000707@cam.ac.uk>
Date: Mon, 11 Jul 2011 16:51:21 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Splitting trigger header in two and barriers.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

The trigger.h file merges elements I'd really rather were separate.
There are some parts that belong to drivers acting as consumers
and others to those acting as producers of triggers.
In a few cases  (e.g. lis3l02dq_ring.c) the consumer and trigger
are in the same file, but in many others the driver only supports
one or the other or has them in separate source files.

The main block to this bit of reorganization ist that some drivers
explicitly put the trigger and detach from it in their 'ring cleanup'
functions (see ad7298_ring.c ad7298_ring_cleanup.)

My original intent was that if a trigger had not been detached from
in userspace, it would not be possible to remmove the driver, so
no cleanup would occur. (basically it counts as being 'in use').

Is there a usecase that demands this explicity disconnect, or
is it simply a case that the reference counting is going wrong
somewhere and hence this was needed in the drivers?

Failing a good description of why this is there in these drivers,
I'd like to clean it out.  Will give us a much easier to follow
interface for the triggers.

Thanks,

Jonathan
