Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vegas.theobroma-systems.com ([144.76.126.164]:32817 "EHLO
	mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932367AbbFIQfB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jun 2015 12:35:01 -0400
Message-ID: <55770E56.5070701@theobroma-systems.com>
Date: Tue, 09 Jun 2015 18:03:34 +0200
From: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
MIME-Version: 1.0
To: jic23@kernel.org, irina.tirdea@intel.com, daniel.baluta@intel.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: iio: what does in_accel_x_thresh_rising_en ?
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

hi

Is the in_accel_thresh_rising_value (or falling) threshold value signed
or unsigned?

In other words: Is a RISING event fired on an absolute growing value in
the positive range, and a FALLING event on an absolute growing value in
the negative acceleration range (< 0g)?

Or is a RISING event fired on a signed rising value, no matter if the
threshold is positive or negative, and a FALLING event on a decreasing
signed value, also when the threshold is positive?

thanks

                                martin
