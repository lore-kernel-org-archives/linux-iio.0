Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754517AbeCGVTQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Mar 2018 16:19:16 -0500
Date: Wed, 7 Mar 2018 21:19:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Removal of iio (staging) meter/ade7753, ade7754, ade7758, ade7759
 and ade7854
Message-ID: <20180307211912.68752ce0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

All of these parts are apparently marked as not being for new designs
and we have no known access to hardware suitable for testing the major changes
needed for these drivers to graduate from staging.

Given this, unless someone expresses an interest (and has hardware for
testing) I propose to drop these drivers from staging next kernel cycle
(so in around 3 months time).

Of course I hope that someone can help us keep support for these parts
and we won't end up dropping them, but they are old and several generations
behind the current Analog Devices offerings.

Please share this with anyone you happen to know who is using any
of these energy meters.

Thanks,
	
Jonathan
