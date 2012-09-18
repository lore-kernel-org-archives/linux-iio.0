Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39063 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755091Ab2IRE40 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Sep 2012 00:56:26 -0400
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: inkern: put the IIO device when mem alloc gets
 failed
Date: Tue, 18 Sep 2012 04:56:17 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EF53A7@DQHE02.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F41EF50A5@DQHE02.ent.ti.com>
 <5056EE95.6050101@metafoo.de>
 <A874F61F95741C4A9BA573A70FE3998F41EF5120@DQHE02.ent.ti.com>
 <505780D6.3020500@kernel.org>
In-Reply-To: <505780D6.3020500@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> I can see your point, but Lars-Peter's way is the more commonly used
> approach
> so lets go with the ancient arguement of making it look like what those
> reading the code expect to see ;)

Two chained patches were sent.
[PATCH 1/2] iio: inkern: put the IIO device when it fails to allocate memory
[PATCH 2/2] iio: inkern: clean up error return code

The first patch is same as previous one.
The second one is for fixing error return code which Lars had suggested.
I'd like to divide two things for better review.
Many thanks !

Best Regards,
Milo
