Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43643 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754779AbaKRWMe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Nov 2014 17:12:34 -0500
Message-ID: <546BC450.7000000@kernel.org>
Date: Tue, 18 Nov 2014 22:12:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>,
	Vlad Dogaru <vlad.dogaru@intel.com>
CC: linux-iio@vger.kernel.org, mranostay@gmail.com
Subject: Re: [PATCH 0/2] iio: driver for Semtech SX9500
References: <1416237169-10707-1-git-send-email-vlad.dogaru@intel.com> <alpine.DEB.2.02.1411171622140.3424@pmeerw.net> <546BC201.10405@kernel.org>
In-Reply-To: <546BC201.10405@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/11/14 22:02, Jonathan Cameron wrote:
> On 17/11/14 15:25, Peter Meerwald wrote:
>>
>>> The device does not estimate distance, it only outputs a single bit which
>>> indicates proximity.  We use 0 to mean that an object is close and 1 otherwise,
>>> sort of an uncalibrated distance.  From what I understand in the ABI
>>> specification, this is allowed.
>>
>> perhaps the input subsystem would be a better fit for this driver/device?
>> what is it typically used for?
>>
>> regards, p.
>>
> Hi Peter,
> 
> Whilst it may be the case that this particular one might have a reasonable
> home in input, these are often integrated with ambient light sensors
> and as such we already have a quite a few proximity sensors in IIO...
> 
> Interestingly there is one obvious proximity sensor in input and that
> is a dual ambient light/ proximity part though I can't see any way
> of reading the light side of it.  Interesting...
Note that, given it describes itself as a button trip I can entirely see
your point with this one!  I wrote my reply before opening the datasheet.
oops.

The device does seem to provide access to measurements related to
the capacitance sensed so might be rather more flexible than just
a button though.





