Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:59013 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139Ab2EQA3n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 May 2012 20:29:43 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org
Subject: iio, add support for HMC5883/HMC5883L to HMC5843 driver
Date: Thu, 17 May 2012 02:28:07 +0200
Message-Id: <1337214493-28773-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

submitting the remaining HMC5843 patches to add HMC5883 support 
to staging-next; I was a bit behind and missed commit 527cf71fd04e053983f97c98cf79c622d8d52db9 (Use dev_to_iio_dev())

rebased now

