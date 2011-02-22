Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49551 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab1BVOAy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Feb 2011 09:00:54 -0500
Message-ID: <4D63C1B2.1050507@cam.ac.uk>
Date: Tue, 22 Feb 2011 14:01:22 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Cai, Cliff" <Cliff.Cai@analog.com>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [Device-drivers-devel] [PATCH] IIO driver for Analog Devices
 Digital Output Gyroscope ADXRS450
References: <1297676849-28704-1-git-send-email-test@ten.analog.com> <4D5914A8.9030809@analog.com>
In-Reply-To: <4D5914A8.9030809@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/14/11 11:40, Michael Hennerich wrote:
> Hi Cliff,
> 
> Exposing every single register to user space is not an acceptable driver.
> Ideally a user of this driver doesn't need to read the datasheet, only
> the IIO ABI Documentation.
> This driver can also benefit from triggered sampling/ring buffer support.
At some point.... I wouldn't necessarily advocate this for an initial merge. doing
it in two steps can make for bite sized reviews which definitely have their
advantages!

Given Michael has done a thorough review (thanks) I'll leave looking at this until
you've addressed his comments.  Please be careful to avoid dead email addresses (test@analog.com)

Thanks,

Jonathan
