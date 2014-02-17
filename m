Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56677 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbaBQTEz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Feb 2014 14:04:55 -0500
In-Reply-To: <5302501E.3090309@linux.intel.com>
References: <5302501E.3090309@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: CM3218x Ambient Light Sensor
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 17 Feb 2014 19:04:51 +0000
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org
Message-ID: <da46d762-8296-42d8-946b-fb458857ed57@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org





On February 17, 2014 6:08:30 PM GMT+00:00, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>Hi,
>
>Is there any Linux driver for " CM3218x Ambient Light Sensor"?

Drivers/iio/light/cm32181.c
Not sure which other parts are supported but only that one is listed.

>
>Thanks,
>Srinivas
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
