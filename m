Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:57291 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903Ab1HQOUy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2011 10:20:54 -0400
Message-ID: <4E4BD02E.3070801@cam.ac.uk>
Date: Wed, 17 Aug 2011 15:29:02 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH] IIO: ADC: New driver for AD7190/AD7192/AD7195 4 Channel
 SPI ADC
References: <1313152897-13255-1-git-send-email-michael.hennerich@analog.com> <4E452E51.5040203@cam.ac.uk> <4E4BC687.3050504@analog.com>
In-Reply-To: <4E4BC687.3050504@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


>>> +     ret = iio_device_register(indio_dev);
>>> +     if (ret)
>>> +             goto error_unreg_ring;
>>> +     regdone = 1;
>> Hmm..
> Anything bad here?
Bad in a sense, but fault of core rather than driver.
I must have written a large musing on that here, then thought I'd
leave it for another day, but forgotten to remove the Hmm... ;)
> 

