Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55234 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751644AbcGZIZE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 04:25:04 -0400
Subject: Re: [PATCH v3 1/4] hwmon: iio_hwmon: delay probing with late_initcall
To: Alexander Stein <alexander.stein@systec-electronic.com>,
	linux-kernel@vger.kernel.org
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-2-git-send-email-quentin.schulz@free-electrons.com>
 <209942367.uny0GxrY2s@ws-stein>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <10d14cc4-26f1-8f2d-2997-3b2bc323c40e@free-electrons.com>
Date: Tue, 26 Jul 2016 10:24:48 +0200
MIME-Version: 1.0
In-Reply-To: <209942367.uny0GxrY2s@ws-stein>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/07/2016 10:21, Alexander Stein wrote:
> On Tuesday 26 July 2016 09:43:44, Quentin Schulz wrote:
>> iio_channel_get_all returns -ENODEV when it cannot find either phandles and
>> properties in the Device Tree or channels whose consumer_dev_name matches
>> iio_hwmon in iio_map_list. The iio_map_list is filled in by iio drivers
>> which might be probed after iio_hwmon.
> 
> Would it work if iio_channel_get_all returning ENODEV is used for returning 
> EPROBE_DEFER in iio_channel_get_all? Using late initcalls for driver/device 
> dependencies seems not right for me at this place.

Then what if the iio_channel_get_all is called outside of the probe of a
driver? We'll have to change the error code, things we are apparently
trying to avoid (see v2 patches' discussions).

Thanks,
Quentin
