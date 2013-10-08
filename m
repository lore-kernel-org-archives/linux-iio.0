Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52537 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059Ab3JHHuL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Oct 2013 03:50:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1VTS3P-00064F-IN
	for linux-iio@vger.kernel.org; Tue, 08 Oct 2013 09:50:06 +0200
Received: from 202.153.39.235 ([202.153.39.235])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Tue, 08 Oct 2013 09:50:03 +0200
Received: from chskr1016 by 202.153.39.235 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Tue, 08 Oct 2013 09:50:03 +0200
To: linux-iio@vger.kernel.org
From: crzy <chskr1016@gmail.com>
Subject: change device attributes dynamically
Date: Tue, 8 Oct 2013 07:46:21 +0000 (UTC)
Message-ID: <loom.20131008T094235-776@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I want to change device attributes at /sys/iio..... for AD-FMCOMMS1-EBZ.When 
will the driver detects the value is changed?will the driver dynamically 
detects them ?
i want to change values dynamically like
echo 500000000 > out_altvoltage1_DAC_CLK_frequency


