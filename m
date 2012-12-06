Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:40612 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2LFO6y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Dec 2012 09:58:54 -0500
From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Thu, 6 Dec 2012 15:32:12 +0100
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: HID-sensor(-hub.c) and device IDs
Message-ID: <20121206143212.GA610@polaris.bitmath.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Alexander,

> I think the first step would be to identify devices usable by
> hid-sensor-hub, sensor_hub_check_for_sensor_page() looks like the
> way to go, at least for the current state of the hid-sensor-framework.

If you can get the gist of that function into hid_scan_usage(), you should be able to drop both the list in hid-core.c and the list in hid-sensor-hub.c

Henrik
