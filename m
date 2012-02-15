Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:33957 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755948Ab2BOLCW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Feb 2012 06:02:22 -0500
Message-ID: <4F3B9099.5030508@cam.ac.uk>
Date: Wed, 15 Feb 2012 11:01:45 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Shankarmurthy, Akshay" <akshay.s@ti.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: eCAP driver
References: <6F6B80BD2E18844D97BB4B51FE3705C831768D51@DBDE01.ent.ti.com>
In-Reply-To: <6F6B80BD2E18844D97BB4B51FE3705C831768D51@DBDE01.ent.ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2/15/2012 10:20 AM, Shankarmurthy, Akshay wrote:
>
>  Hi folks,
>
>
>
>  I am developing a driver for eCAP peripheral and I feel it should
>  come under driver/staging/iio directory. Kindly go through the below
>  eCAP brief description and let me know whether I can put the driver
>  inside iio directory.
>
>
>
>  eCAP (enhanced capture) module can be used to compute frequency and
>  duty cycle % of the incoming pwm wave. This module includes
>  dedicated input pin, 32bit up counter and capture registers. PWM wave
>  whose frequency needs to be computed should befed to this dedicated
>  pin. Counter ticks on the reference clock. eCAP latches the counter
>  value to the capture registers depending upon the rising and falling
>  edge of the incoming pwm wave. Values in the counter register are
>  used to calculate the frequency and duty cycle %.
>
>
It is a new device type to us so you'll have to work out the interface.
Comparison with the output stuff for DDS chips may give some help
with that.  Once you have a vague idea of how you want it to work,
put out an RFC of the interface document for us to review.  This can
either happen when the driver is ready or if you want to post it before
that then that is even better.

Otherwise, sounds interesting and fits within the general scope of IIO
as far as I am concerned.  Don't think there is anywhere else in the
kernel where it would fit. Some of the usecases are very similar to
resolvers even if the device operates at a somewhat lower level.

Looking forward to seeing your driver.

Jonathan

