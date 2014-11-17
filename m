Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59263 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbaKQO7W (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Nov 2014 09:59:22 -0500
In-Reply-To: <1416230316-14511-1-git-send-email-daniel.baluta@intel.com>
References: <1416230316-14511-1-git-send-email-daniel.baluta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 0/2] kmx61: Small cleanups
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 17 Nov 2014 14:59:14 +0000
To: Daniel Baluta <daniel.baluta@intel.com>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <F244A294-8B78-4A9C-BB0B-268AFCC3EC5C@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On November 17, 2014 1:18:34 PM GMT+00:00, Daniel Baluta <daniel.baluta@intel.com> wrote:
>This is a small cleanup patchset, that:
>	* makes it clear that kmx61 uses only the micro part of scale
>	* use macro instead of hardcoded value for driver name
>
>Jonathan, if you think it's worth it, these could be squased together
>with
>the initial patch submitted in testing:
>	61ef04a496 (iio: imu: Add support for Kionix KMX61 sensor)
>

Given the additional bits from Peter, I don't mind pulling the original and applying an updated patch.

Additional changes like this are fine as well if you prefer.

J
>Daniel Baluta (2):
>  kmx61: Use uscale instead of scale
>  kmx61: Use KMX61_DRV_NAME instead of hardcoded value
>
> drivers/iio/imu/kmx61.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
