Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44253 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932824AbdABNEK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Jan 2017 08:04:10 -0500
Date: Mon, 2 Jan 2017 14:04:07 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: jic23@kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] HID: sensor-hub: Move the memset to
 sensor_hub_get_feature()
In-Reply-To: <1482857879-161873-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Message-ID: <alpine.LSU.2.20.1701021403570.28985@cbobk.fhfr.pm>
References: <1482857879-161873-1-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 27 Dec 2016, Srinivas Pandruvada wrote:

> While applying patch d443a0aa3a29: "HID: hid-sensor-hub: clear memory to
> avoid random data", there was some issues in applying correct version of
> the patch. This resulted in the breakage of sensor functions as all
> request like power-up will be reset by the memset() in the function
> sensor_hub_set_feature().
> The reset of caller buffer should be in the function
> sensor_hub_get_feature(), not in the sensor_hub_set_feature().
> 
> Fixes: d443a0aa3a29 ("HID: hid-sensor-hub: clear memory to avoid random data")
> Cc: Stable <stable@vger.kernel.org> # 4.9+
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied to for-4.10/upstream-fixes, and I'll be pushing that out to Linus 
shortly. Thanks for fixing my mistake.

-- 
Jiri Kosina
SUSE Labs

