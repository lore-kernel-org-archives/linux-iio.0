Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:55204 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004Ab0C2NxB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2010 09:53:01 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:52171)
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1NwFOm-00020R-4W (Exim 4.70) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Mon, 29 Mar 2010 14:53:00 +0100
Message-ID: <4BB0B14F.7070700@cam.ac.uk>
Date: Mon, 29 Mar 2010 14:55:27 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/13] staging:iio: ABI documentation (partial)
References: <1269808879-28838-1-git-send-email-jic23@cam.ac.uk> <1269808879-28838-2-git-send-email-jic23@cam.ac.uk> <1269808879-28838-3-git-send-email-jic23@cam.ac.uk> <1269808879-28838-4-git-send-email-jic23@cam.ac.uk> <1269808879-28838-5-git-send-email-jic23@cam.ac.uk> <1269808879-28838-6-git-send-email-jic23@cam.ac.uk> <1269808879-28838-7-git-send-email-jic23@cam.ac.uk> <1269808879-28838-8-git-send-email-jic23@cam.ac.uk> <1269808879-28838-9-git-send-email-jic23@cam.ac.uk> <1269808879-28838-10-git-send-email-jic23@cam.ac.uk> <1269808879-28838-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1269808879-28838-11-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In the great tradition of replying to ones own patches...
...
> +
> +What:		/sys/.../device[n]/device[n]:event[m]
> +KernelVersion:	2.6.35
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Configuration of which hardware generated events are passed up to
> +		userspace. Some of these are a bit complex to generalize so this
> +		section is a work in progress.
> +
> +What:		/sys/.../device[n]:event[m]/dev
> +KernelVersion:	2.6.35
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		major:minor character device numbers for the event line.
> +
> +Taking accel_x0 as an example
> +
> +What:		/sys/.../device[n]:event[m]/accel_x0_thresh[_high|_low]
> +KernelVersion:	2.6.35
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Event generated when accel_x0 passes a threshold in correction direction
> +		(or stays beyond one). If direction isn't specified, either triggers it.
> +		Note driver will assume last p events requested are enabled where p is
> +		however many it supports.  So if you want to be sure you have
> +		set what you think you have, check the contents of these. Drivers
> +		may have to buffer any parameters so that they are consistent when a
> +		given event type is enabled a future point (and not those for whatever
> +		alarm was previously enabled).
> +
> +What:		/sys/.../device[n]:event[m]/accel_x0_roc[_high|_low]
> +KernelVersion:	2.6.35
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Same as above but based on the first differential of the value.
> +
> +
> +What:		/sys/.../device[n]:event[m]/accel_x0[_thresh|_roc][_high|_low]_period
> +KernelVersion:	2.6.35
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		A period of time (microsecs) for which the condition must be broken
> +		before an interrupt is triggered. Applies to all alarms if type is not
> +		specified.
> +
> +What:		/sys/.../device[n]:event[m]/accel_x0[_thresh|_roc][_high|_low]_value
> +KernelVersion:	2.6.35
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The actual value of the threshold in raw device units obtained by
> +		 reverse application of scale and offfset to the acceleration in m/s^2.
> +

These names don't actually conform to those I sent out out in the RFC following the the main
ABI posting and just for a complete inconsistency the naming in lis3l02dq doesn't conform
to either version.  I haven't yet checked the other drivers, but I would guess they are a random
mix of the various options as well.

Oops.

I'll fix this up for V2.

Jonathan
