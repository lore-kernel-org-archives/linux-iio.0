Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:39837 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab1HZL5P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 07:57:15 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Date: Fri, 26 Aug 2011 12:56:55 +0100
Subject: RE: [PATCH] iio: accel: ADIS16209: Fix double registration of
 in_incli0_index
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E6F62D54@LIMKCMBX1.ad.analog.com>
References: <1314358594-2565-1-git-send-email-michael.hennerich@analog.com>
 <4E578AD1.8080806@cam.ac.uk>
In-Reply-To: <4E578AD1.8080806@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote on 2011-08-26:
> On 08/26/11 12:36, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> iio (null): tried to double register : in_incli0_index
> oops.  That (null) is clearly an issue to.
>
> As for the fix.  Yet another bug due to that pesky IIO_CHAN
> macro. hohum.
>
> Thanks and merged.

I'm currently in progress testing some devices, since I need to update our documentation.
Will send more patches - would be great if you could take them through your tree.


Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



