Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:34187 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757755Ab2EJNST (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 10 May 2012 09:18:19 -0400
Date: Thu, 10 May 2012 15:18:15 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH 1/8] iio: fix access to hmc5843 private data
In-Reply-To: <4FAB860B.8020809@kernel.org>
Message-ID: <alpine.DEB.2.01.1205101459480.28284@pmeerw.net>
References: <1336515606-12364-1-git-send-email-pmeerw@pmeerw.net> <1336515606-12364-2-git-send-email-pmeerw@pmeerw.net> <4FAB860B.8020809@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> > i2c_get_clientdata(client) points to iio_dev, not hmc5843_data; fixes
> > issue similar to 62d2feb9803f18c4e3c8a1a2c7e30a54df8a1d72

> Hmm.. Really hope there aren't many more of these hiding in the tree.
> (All my fault in the first place ;(

part of the problem is that some (i2c) drivers inconsistently point to 
iio_dev or to private data

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
