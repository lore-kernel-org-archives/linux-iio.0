Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:34553 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab1DRPrQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2011 11:47:16 -0400
Message-ID: <4DAC5D7A.1010307@cam.ac.uk>
Date: Mon, 18 Apr 2011 16:49:14 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 1/1] IIO-onwards: ADC: AD799x: Convert to new channel
 registration method.
References: <1303139431-27849-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1303139431-27849-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/18/11 16:10, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Convert to new channel registration method
> Update copyright header
> Add missing call to iio_trigger_notify_done()
Again, you could use a pointer to chan_spec arrays outside the chip info.
Still this works and is nice and clear. Again, will pull it into iio-onwards.

Thanks,
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>


