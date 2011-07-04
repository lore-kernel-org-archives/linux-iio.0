Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:35784 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379Ab1GDJgy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2011 05:36:54 -0400
Message-ID: <4E118B9D.2070104@cam.ac.uk>
Date: Mon, 04 Jul 2011 10:45:01 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Dan Carpenter <error27@gmail.com>
CC: Chris Forbes <chrisf@ijw.co.nz>, devel@driverdev.osuosl.org,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: staging: iio: adc: fix uninitialized use
References: <1309657621-21711-1-git-send-email-chrisf@ijw.co.nz> <4E118157.3020906@cam.ac.uk> <20110704091016.GM2544@shale.localdomain>
In-Reply-To: <20110704091016.GM2544@shale.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/04/11 10:10, Dan Carpenter wrote:
> On Mon, Jul 04, 2011 at 10:01:11AM +0100, Jonathan Cameron wrote:
>> On 07/03/11 02:47, Chris Forbes wrote:
>>> Fixed an uninitialized variable access. In the first two error paths in
>>> max1363_probe(), 'st' is not yet initialized, but its 'reg' member is
>>> accessed anyway. This would most likely crash.
>> Good spot. Please tech TODO files for staging patches. In this case it would
>> have given you the mailing list, now cc'd.
> 
> It would better to add an entry to MAINTAINERS so that
> ./scripts/get_maintainer.pl gave the right lists.
Perhaps, but Greg KH is anti, so it isn't going to happen.

