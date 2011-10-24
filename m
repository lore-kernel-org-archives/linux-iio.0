Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:52326 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130Ab1JXMMI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2011 08:12:08 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:35825)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1RIJNv-0005zR-Fz (Exim 4.72) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Mon, 24 Oct 2011 13:12:07 +0100
Message-ID: <4EA55620.5090004@cam.ac.uk>
Date: Mon, 24 Oct 2011 13:12:16 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: github tree cleanup
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Just a quick heads up on state of the branches there.

https://github.com/jic23/linux-iio/branches

master - what has either gone to Greg, or what I intend to
send shortly.

outofstaging - current proposal for code in drivers/iio/
including the pull in kernel interfaces.

inkern-staging - experimental stuff for doing more complex
in kernel interfacing.  Right now, demux code and a
pretty much direct copy to the staging tree of the in kernel
pull interfaces proposed for the outofstaging tree.

Note all three of these will be rebased a random times to
try and keep our history fairly clean whilst we are doing
so many different series at the same time.

I'll be posting updated versions of outofstaging shortly.
I don't really intend to post the patches lifted across
to the inkern-staging tree as they are exactly the same
up to a few renames.

Jonathan
