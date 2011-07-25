Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:36833 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab1GYNmc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2011 09:42:32 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:37207)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1QlLQV-0008RC-G0 (Exim 4.72) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Mon, 25 Jul 2011 14:42:31 +0100
Message-ID: <4E2D72CE.7040508@cam.ac.uk>
Date: Mon, 25 Jul 2011 14:42:38 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: iio-blue.git - contents.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio-blue.git

1: Misc fixes
2: Last removal of dev_data usage and removal of field (long since reviewed)
3: Trigger registration and removal cleanup (already posted).
4: General cleanup
5: chrdev combining
6: abi rework to have in and out prefixes for all channel attributes.
7: Scaling issue related changes to allow for lots of channels.
8: Misc fixes and cleanups.

Please do note the tree will be rebased.

As ever all reviews welcome!

Thanks,

Jonathan
