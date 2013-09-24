Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41736 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708Ab3IXJcW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 24 Sep 2013 05:32:22 -0400
Date: Tue, 24 Sep 2013 11:32:17 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	jic23@kernel.org, holler@ahsoftware.de
Subject: Re: [PATCH 1/3] HID: Delay opening HID device
In-Reply-To: <1379524399-16995-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1309241131510.18703@pobox.suse.cz>
References: <1379524399-16995-1-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 18 Sep 2013, Srinivas Pandruvada wrote:

> Don't call hid_open_device till there is actually an user. This saves
> power by not opening underlying transport for HID. Also close device
> if there are no active mfd client using HID sensor hub.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Jonathan, I'd be good if I pass this to you to apply the whole lot.

Thanks.

-- 
Jiri Kosina
SUSE Labs
