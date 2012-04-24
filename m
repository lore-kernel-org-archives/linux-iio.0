Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:44073 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784Ab2DXIZP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Apr 2012 04:25:15 -0400
Message-ID: <4F966363.7080203@cam.ac.uk>
Date: Tue, 24 Apr 2012 09:25:07 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: necessity of manual reset attribute in drivers?
References: <4F943EC2.7030707@kernel.org> <544AC56F16B56944AEC3BD4E3D5917714E793C210F@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917714E793C210F@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/24/2012 8:52 AM, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2012-04-22:
>> Hi All,
>>
>> I vaguely recall asking this in response to certain drivers over the
>> years, but what is the usecase for userspace 'resetting' a device via
>> a reset attribute?  It's reasonably common in the drivers but not
>> (as I've kept it out) in the abi docs.
>>
>> It is common in some of Analog's inertial sensor drivers but I think
>> turns up in various other places.
> Ideally we shouldn't have such an attribute.
> Error checking and handling should be all done in the drivers, if possible.
> I don't remember exactly why it went into one of the original inertial sensor drivers.
> But I think it went there to provide error correction, in case plausibility/error checking
> of the delivered data failed.
> I also suspect it then got copied over and over again.
That's what I suspected had happened.  Shall we aim to kill it off in 
these drivers
before they move out of staging? I'm always happy to delete code if no 
one else
gets to them first ;)
