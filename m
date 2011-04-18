Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:56575 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab1DRJzo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2011 05:55:44 -0400
Message-ID: <4DAC0B15.8000803@cam.ac.uk>
Date: Mon, 18 Apr 2011 10:57:41 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH 48/70] staging:iio:ad7606 conversion to irq_chip based
 polling.
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk> <1303067203-4894-49-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D591771375475E5BC@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771375475E5BC@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/18/11 08:52, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-04-17:
>> I'm far from sure what the best way to handle this particular part is,
>> so have (I think) done the absolute minimum to change it to the new
>> interface.
> 
> Typo below "adis16203_consumer%d"
Doh!  I wonder how many times I forgot to update that one.  Time for some grepping.

> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Thanks.
> 
>>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>>  drivers/staging/iio/adc/ad7606_ring.c |   27 +++++++++++++++++++++----
> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
> 
> 

