Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53261 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab2FKSO5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jun 2012 14:14:57 -0400
Message-ID: <4FD635A0.7050507@kernel.org>
Date: Mon, 11 Jun 2012 19:14:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: iio: vcnl4000 ALS/proximity driver
References: <1339367961-22456-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339367961-22456-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/10/2012 11:39 PM, Peter Meerwald wrote:
> I'm submitting a minimal, work-in-progress driver for the 
> Vishay VCNL4000 combined ambient light/proximity sensor to -staging
> 
> the driver is missing a way to adjust the IR current determining 
> the range for proximity sensing
> 
> is scale/calibscale desirable?
> I am lost with the meaning and use of IIO modifiers...
Quick and dirty summary.
Calibscale is internally applied within the hardware (or occasionally
software but looks like it was in the hardware from point of view
of userspace!)

scale is applied in userspace to convert to SI units.
> 
> ultimately, periodic proximity sensing and thresholding with event 
> handling should be implemented... I do have a misc/input driver for 
> that but want to built upon IIO
cool.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

