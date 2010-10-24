Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:46722 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491Ab0JXLDy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Oct 2010 07:03:54 -0400
Message-ID: <4CC413F8.1030908@cam.ac.uk>
Date: Sun, 24 Oct 2010 12:09:44 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [Device-drivers-devel] [PATCH 1/3] staging: iio: new adis16201
 driver
References: <1287830963-18377-1-git-send-email-vapier@gentoo.org> <4CC320D2.6030300@cam.ac.uk> <AANLkTim+czzJ__zuMCpjv4nV6rOJ9n50_4MR2VkQk6T_@mail.gmail.com>
In-Reply-To: <AANLkTim+czzJ__zuMCpjv4nV6rOJ9n50_4MR2VkQk6T_@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/23/10 21:32, Mike Frysinger wrote:
> On Sat, Oct 23, 2010 at 13:52, Jonathan Cameron wrote:
>> On 10/23/10 11:49, Mike Frysinger wrote:
>>> From: Barry Song <barry.song@analog.com>
>>>
>>> IIO driver for dual Axis Accelerometer/inclinometer adis16201 parts.
>>
>> Please check these for building against staging next.  There have been
>> a couple of cleanup and abi fix series merged since the tree you are
>> working against (at least I'm guessing that's what causes...
> 
> testing against current mainline
Unfortunately that isn't where they are going to merge.  The change
required won't be huge, but Greg isn't going to take them if they
don't merge cleanly.

Still, fine to review them against mainline.  

Thanks,

Jonathan
