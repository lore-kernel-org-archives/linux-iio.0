Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:57830 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505Ab2FIIT7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 9 Jun 2012 04:19:59 -0400
Date: Sat, 9 Jun 2012 10:19:55 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Leed Aguilar <leed.aguilar@ti.com>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:magnetometer:hmc5843: use kstrtoul instead of
 strict_strtoul
In-Reply-To: <1339193685-24164-1-git-send-email-leed.aguilar@ti.com>
Message-ID: <alpine.DEB.2.01.1206091018460.20418@pmeerw.net>
References: <1339193685-24164-1-git-send-email-leed.aguilar@ti.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Change strict_strtoul() to kstrtoul() to make checkpatch.pl happy

these changes have already been made in hmc5843 and are in 3.5-rc2

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
