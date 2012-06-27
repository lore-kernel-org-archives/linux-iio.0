Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38597 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754433Ab2F0PfH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 27 Jun 2012 11:35:07 -0400
Date: Wed, 27 Jun 2012 17:35:00 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"jic23.cam.ac.uk@vger.kernel.org" <jic23.cam.ac.uk@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: RE: [PATCH, 3/6] HID-Sensors: Added accelerometer 3D
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A91933F4DA@ORSMSX104.amr.corp.intel.com>
Message-ID: <alpine.LNX.2.00.1206271733490.17549@pobox.suse.cz>
References: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com> <1340672054-16591-4-git-send-email-srinivas.pandruvada@intel.com> <4FEACE58.20008@metafoo.de> <4FA419E87744DF4DAECD5BCE1214B7A91933F4DA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 27 Jun 2012, Pandruvada, Srinivas wrote:

> <IIO has moved out of staging in 3.5, so this won't build with the latest upstream>
>
> Can you please let me know which tree it is merged? I don't see in 
> Linus's tree. I can see in gregkh/staging.git. But don't see your latest 
> changes.

It's in Linus' tree, in drivers/iio. Commit a980e046 moved it out of 
staging. It first appeared in 3.5-rc1.

-- 
Jiri Kosina
SUSE Labs
