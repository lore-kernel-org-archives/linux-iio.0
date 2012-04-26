Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:45814 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214Ab2DZQOX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Apr 2012 12:14:23 -0400
References: <1335443643-20439-1-git-send-email-michael.hennerich@analog.com> <4F9948D7.20109@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917714E7965F942@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917714E7965F942@LIMKCMBX1.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: RE: [PATCH 1/4] iio: Rename iio/dds to iio/frequency
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 26 Apr 2012 17:14:06 +0100
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Message-ID: <dc2ece51-6655-4915-ac3f-39a583c54751@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



"Hennerich, Michael" <Michael.Hennerich@analog.com> wrote:

>Jonathan Cameron wrote on 2012-04-26:
>> On 4/26/2012 1:34 PM, michael.hennerich@analog.com wrote:
>>> From: Michael Hennerich<michael.hennerich@analog.com>
>>>
>>> Generalize naming to allow other frequency synthesis techniques as
>>> well. No functional changes.
>> Other than doing git --format-patch -M to generate this, fine with
>me.
>> One thought though. Do we want a separate directory for frequency
>> measurement devices from frequency generating ones?  If so might want
>to
>> pick a naming that allows for that...
>
>Hi Jonathan,
>
>Right now I'm happy with a single directory, potentially covering both
>type of devices.
>
Works for me so.

Acked-by: Jonathan Cameron <jic23@kernel.org>
>
>Greetings,
>Michael
>
>--
>Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
>Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
>Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
>Margaret Seif

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
