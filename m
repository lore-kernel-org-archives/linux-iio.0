Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mta1.parkeon.com ([91.121.43.66]:36250 "EHLO mta1.parkeon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753090AbaG2JBe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 29 Jul 2014 05:01:34 -0400
Subject: [PATCH V2 0/8] iio: mma8452 enhancements
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: pmeerw@pmeerw.net
Date: Tue, 29 Jul 2014 11:01:29 +0200
Message-ID: <20140729090128.4618.92936.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series adds some additional features to the mma8452 accelerometer driver
	* debugfs register access
	* transient threshold events
	* highpass filter
	* interrupt driven sampling (trigger)

The highpass filter attributes are added to the core.

In addition a latent bug in the device initialisation is fixed.

V2: Address review comments from Peter Meerwald
