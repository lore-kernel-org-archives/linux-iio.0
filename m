Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:59467 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab1JUJoy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 05:44:54 -0400
Message-ID: <4EA13F1B.3070809@cam.ac.uk>
Date: Fri, 21 Oct 2011 10:44:59 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: Userspace event handling and header files
References: <4EA11D7D.80202@metafoo.de> <544AC56F16B56944AEC3BD4E3D59177146E75C17CA@LIMKCMBX1.ad.analog.com> <4EA13439.8060504@cam.ac.uk> <4EA13E85.9050608@metafoo.de>
In-Reply-To: <4EA13E85.9050608@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/11 10:42, Lars-Peter Clausen wrote:
> On 10/21/2011 10:58 AM, Jonathan Cameron wrote:
>> [...]
>> how are you coming with that patch to get rid of the switching on the bit mask?
> 
> I have a working patch, but I was waiting for Greg to apply the ad5360
> driver to the staging-next branch, so I can base the patch on staging-next,
> without missing a driver from the conversion.
> 

Just state that it is dependent on that and post to list.  I want it locally in my
tree before merging it in later becomes a nightmare!  You can then send it on to
Greg with that dependency stated.  He's very good at merging things in the order
they hit his inbox anyway, but best to be sure.

Thanks,

Jonathan
