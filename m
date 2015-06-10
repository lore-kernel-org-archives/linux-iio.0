Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44394 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204AbbFJUty (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jun 2015 16:49:54 -0400
Message-ID: <5578A2EC.4030300@kernel.org>
Date: Wed, 10 Jun 2015 21:49:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	irina.tirdea@intel.com, daniel.baluta@intel.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: iio: what does in_accel_x_thresh_rising_en ?
References: <55770E56.5070701@theobroma-systems.com>
In-Reply-To: <55770E56.5070701@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/06/15 17:03, Martin Kepplinger wrote:
> hi
> 
> Is the in_accel_thresh_rising_value (or falling) threshold value signed
> or unsigned?
> 
> In other words: Is a RISING event fired on an absolute growing value in
> the positive range, and a FALLING event on an absolute growing value in
> the negative acceleration range (< 0g)?
> 
> Or is a RISING event fired on a signed rising value, no matter if the
> threshold is positive or negative, and a FALLING event on a decreasing
> signed value, also when the threshold is positive?
> 
> thanks
> 
>                                 martin
> 
Hi Martin,

The two relevant abi elements are:
in_accel_thresh_rising_value and
in_accel_mag_rising_value
Once you know the second one exists then you can probably work out the
meaning of thresh ;)

Thresh is the value, mag(nitude) is the absolute value, so if you get one
that is thresh, then if the channel can go negative, negative values are
definitely possible.  On an accelerometer, you can get either implemented.
mag_rising is typically to allow motion detection, thresh_rising might
be used to detect a change of orientation (put bounds around each axis
at a particular point in time.

There are also roc (rate of change) type event detectors on some accelerometers.

Hope that clear the mud up ;)

Jonathan
