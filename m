Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:57801 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbaBPMTV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 16 Feb 2014 07:19:21 -0500
Received: from [192.168.0.80] ([178.12.50.63]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Md31i-1WXEIP0o66-00IDO6 for
 <linux-iio@vger.kernel.org>; Sun, 16 Feb 2014 13:19:19 +0100
Message-ID: <5300ACC6.90509@gmx.de>
Date: Sun, 16 Feb 2014 13:19:18 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: [RFC]coding style for NULL pointer checks
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi together,
I noticed, that many pointers in the IIO subsystem are checked for successful allocation in the way of "if (pointer == NULL)" or "if (pointer != NULL)", while in a few cases the form of simply "if (!pointer)" or "if (pointer)" is used. So, is there any interest in having a more consistent style, and if so, for which one?
My personal preference is for the latter one.
Thanks

Hartmut
