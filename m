Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:59237 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab1HZL7K (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 07:59:10 -0400
Message-ID: <4E578C79.2030105@cam.ac.uk>
Date: Fri, 26 Aug 2011 13:07:21 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH] iio: accel: ADIS16209: Fix double registration of in_incli0_index
References: <1314358594-2565-1-git-send-email-michael.hennerich@analog.com> <4E578AD1.8080806@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177146E6F62D54@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177146E6F62D54@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/26/11 12:56, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-08-26:
>> On 08/26/11 12:36, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> iio (null): tried to double register : in_incli0_index
>> oops.  That (null) is clearly an issue to.
>>
>> As for the fix.  Yet another bug due to that pesky IIO_CHAN
>> macro. hohum.
>>
>> Thanks and merged.
> 
> I'm currently in progress testing some devices, since I need to update our documentation.
> Will send more patches - would be great if you could take them through your tree.
Will do and thanks for all the testing.

Jonathan
