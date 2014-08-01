Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34787 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbaHAHDW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Aug 2014 03:03:22 -0400
In-Reply-To: <cover.1406861859.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1406861859.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v2 0/1] iio: jsa1212: Add JSA1212 proximity/ALS sensor
From: Jonathan Cameron <jic23@kernel.org>
Date: Fri, 01 Aug 2014 08:03:19 +0100
To: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
CC: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Message-ID: <cadc7fbe-a54d-43e6-9c93-795cb8556283@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On August 1, 2014 4:02:47 AM GMT+01:00, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>Please let me know your review comments.
>
>PATCH v2 changes:
>
>1. Combined ALS/PXS enable/disable functions into a single routine.
>2. Removed extra debug messages.
>3. Also addressed review comments from Peter Meerwald
Ah pesky email client fed me emails in wrong order! Logging changes in a cover letter is fine.

Sorry for the false moan.

J
>
>Kuppuswamy Sathyanarayanan (1):
>  iio: jsa1212: Add JSA1212 proximity/ALS sensor
>
> drivers/iio/light/Kconfig   |   10 +
> drivers/iio/light/Makefile  |    1 +
>drivers/iio/light/jsa1212.c |  490
>+++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 501 insertions(+)
> create mode 100644 drivers/iio/light/jsa1212.c

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
