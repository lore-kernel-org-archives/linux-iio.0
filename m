Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:58163 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751723AbcGZIVp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 04:21:45 -0400
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: linux-kernel@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
	jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Subject: Re: [PATCH v3 1/4] hwmon: iio_hwmon: delay probing with late_initcall
Date: Tue, 26 Jul 2016 10:21:37 +0200
Message-ID: <209942367.uny0GxrY2s@ws-stein>
In-Reply-To: <1469519027-11387-2-git-send-email-quentin.schulz@free-electrons.com>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com> <1469519027-11387-2-git-send-email-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tuesday 26 July 2016 09:43:44, Quentin Schulz wrote:
> iio_channel_get_all returns -ENODEV when it cannot find either phandles and
> properties in the Device Tree or channels whose consumer_dev_name matches
> iio_hwmon in iio_map_list. The iio_map_list is filled in by iio drivers
> which might be probed after iio_hwmon.

Would it work if iio_channel_get_all returning ENODEV is used for returning 
EPROBE_DEFER in iio_channel_get_all? Using late initcalls for driver/device 
dependencies seems not right for me at this place.

Best regards,
Alexander

