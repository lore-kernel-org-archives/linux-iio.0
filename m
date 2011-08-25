Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:37106 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980Ab1HYQda (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2011 12:33:30 -0400
Message-ID: <4E567B44.2030006@cam.ac.uk>
Date: Thu, 25 Aug 2011 17:41:40 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: iio-blue.git reorganization.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All

Just a quick heads up that I've reorganized the git tree.

Now in 4 bits.

1) chrdev stuff - will probably push to Greg tomorrow.

2) fixes and cleanups not dependent on anything else.

3) abi changes and new types etc.

4) driver cleanups

Please do take a look. I'm out of time today so will be tomorrow before
I formally send the sets out for review.

Thanks,

Jonathan
