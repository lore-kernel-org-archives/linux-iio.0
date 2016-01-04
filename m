Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33625 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbcADMgh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jan 2016 07:36:37 -0500
Subject: Re: Anyone working on iio/cdc?
To: Shraddha Barke <shraddha.6596@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
References: <alpine.DEB.2.11.1512300036010.23203@shraddha-370R4E-370R4V-370R5E-3570RE-370R5V>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <568A6752.8010807@kernel.org>
Date: Mon, 4 Jan 2016 12:36:34 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1512300036010.23203@shraddha-370R4E-370R4V-370R5E-3570RE-370R5V>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/12/15 19:07, Shraddha Barke wrote:
> Hello all,
> I'm helping Greg do cleanup of drivers in the staging directory as part
> of Outreachy intern program.
> I've sent out checkpatch patches for iio/cdc, meanwhile could you suggest
> what other tasks are left to be done so that iio/cdc can be moved out of
> staging?
> 
> Kind Regards,
> 
> Shraddha
I'll leave this one mostly to Lars to answer.

A quick glance at one of the drivers ad7150 - suggests the main issue
is one of ABI that we don't currently have and of conforming to what what
we do have!

The events on these are 'interesting' as they are adaptive in that we
are looking at a threshold on the absolute  value (rather than a ROC)
but the threshold is adapting based on more or less a moving average
(with the timeout quirk)

This type of event needs to be fully described in some fashion...
We do have thresh_adaptive which is used in this driver, but it's not
properly documented so that would be a good start!
The trick is then to define the ABI to describe how the threshold is
adapting and the controls on it.

I don't think the current ABI for this description is specific or detailed enough..
Timeout is the 'unusual' control parameter.  Hmm. Naming is tricky on this
one.

Perhaps _thresh_tracking_timeout so we'd end up with something like.
in_capacitance0_threshold_adaptive_thresh_tracking_timeout as a value in seconds.

Jonathan

