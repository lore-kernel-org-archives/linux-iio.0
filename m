Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60723 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab2LLPiH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Dec 2012 10:38:07 -0500
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: Jiri Kosina <jkosina@suse.cz>,
	Alexander Holler <holler@ahsoftware.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: RE: [PATCH 1/2] HID: autodetect USB HID sensor hubs.
Date: Wed, 12 Dec 2012 15:37:48 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A91C960B9C@ORSMSX108.amr.corp.intel.com>
References: <50C47811.7010503@ahsoftware.de>
 <1355053470-3939-1-git-send-email-holler@ahsoftware.de>
 <alpine.LNX.2.00.1212121042100.19767@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1212121042100.19767@pobox.suse.cz>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I also liked it. You can add my ACK.

Thanks,
Srinivas

-----Original Message-----
From: Jiri Kosina [mailto:jkosina@suse.cz] 
Sent: Wednesday, December 12, 2012 1:43 AM
To: Alexander Holler
Cc: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org; linux-iio@vger.kernel.org; Jonathan Cameron; Pandruvada, Srinivas
Subject: Re: [PATCH 1/2] HID: autodetect USB HID sensor hubs.

On Sun, 9 Dec 2012, Alexander Holler wrote:

> It should not be necessary to add IDs for HID sensor hubs to lists in 
> hid-core.c and hid-sensor-hub.c. So instead of a whitelist, autodetect 
> such USB HID sensor hubs, based on a collection of type physical 
> inside a useage page of type sensor. If some sensor hubs stil must be 
> usable as raw devices, a blacklist might be created.
> 
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>

I like this change and would like to merge it, but I'd appreciate Ack from Srinivas first.

Srinivas?

Thanks,

--
Jiri Kosina
SUSE Labs
