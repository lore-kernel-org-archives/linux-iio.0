Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-105.synserver.de ([212.40.185.105]:1044 "HELO
	smtp-out-087.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1754175Ab1JUJmH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 05:42:07 -0400
Message-ID: <4EA13E85.9050608@metafoo.de>
Date: Fri, 21 Oct 2011 11:42:29 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: Userspace event handling and header files
References: <4EA11D7D.80202@metafoo.de> <544AC56F16B56944AEC3BD4E3D59177146E75C17CA@LIMKCMBX1.ad.analog.com> <4EA13439.8060504@cam.ac.uk>
In-Reply-To: <4EA13439.8060504@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/2011 10:58 AM, Jonathan Cameron wrote:
> [...]
> how are you coming with that patch to get rid of the switching on the bit mask?

I have a working patch, but I was waiting for Greg to apply the ad5360
driver to the staging-next branch, so I can base the patch on staging-next,
without missing a driver from the conversion.

- Lars

