Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:56844 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab2LFT6g (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Dec 2012 14:58:36 -0500
Message-ID: <50C0F8E0.6040601@ahsoftware.de>
Date: Thu, 06 Dec 2012 20:58:24 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Henrik Rydberg <rydberg@euromail.se>
CC: linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: HID-sensor(-hub.c) and device IDs
References: <20121206143212.GA610@polaris.bitmath.org>
In-Reply-To: <20121206143212.GA610@polaris.bitmath.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 06.12.2012 15:32, schrieb Henrik Rydberg:
> Hi Alexander,
>
>> I think the first step would be to identify devices usable by
>> hid-sensor-hub, sensor_hub_check_for_sensor_page() looks like the
>> way to go, at least for the current state of the hid-sensor-framework.
>
> If you can get the gist of that function into hid_scan_usage(), you should be able to drop both the list in hid-core.c and the list in hid-sensor-hub.c

Thats what I wanted to suggest. ;)

It's just that I only have one self-made HID sensor device and 
absolutely no knowledge about what HID sensor devices are in the wild 
and how they are used.

Regards,

Alexander
