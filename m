Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35889 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbbBQMgm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 17 Feb 2015 07:36:42 -0500
Date: Tue, 17 Feb 2015 13:36:40 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Jonathan Cameron <jic23@kernel.org>
cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/2] HID: hid-sensor-hub: Add collection device
In-Reply-To: <54C01FC8.2040501@kernel.org>
Message-ID: <alpine.LNX.2.00.1502171336080.2279@pobox.suse.cz>
References: <1420655051-6587-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1420655051-6587-3-git-send-email-srinivas.pandruvada@linux.intel.com> <54C01FC8.2040501@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 21 Jan 2015, Jonathan Cameron wrote:

> On 07/01/15 18:24, Srinivas Pandruvada wrote:
> > HID sensor hub exports several sensor which are fusion sensors, where
> > data is interpreted from one or more sensors. Some of them can't be
> > exported via IIO like sysfs as the user space download some firmware,
> > which defines what sensor will look like. They can be a part of a
> > collection.
> This functionality is beginning to turn up on a number of devices.
> I'd argue that where at all possible, we should try for standard
> interfaces on the resulting 'fused sensors'.  Still you do indeed
> always need a means of uploading the firmware!
> > Creating a MFD cell for a collection to write a standalone driver
> > to manage collections. Most of the time they will be propritery drivers
> > may not be even upstreamed. This patch allows framework to have
> > capability to write such drivers.

Srinivas, do you plan to respond to the comments Jonathan had on this 
patch?

Thanks.

-- 
Jiri Kosina
SUSE Labs
