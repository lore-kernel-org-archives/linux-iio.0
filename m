Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:50309 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130Ab1JXMFE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2011 08:05:04 -0400
Message-ID: <4EA55475.9080200@cam.ac.uk>
Date: Mon, 24 Oct 2011 13:05:09 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] staging:iio:events: Make sure userspace buffer is large
 enough
References: <1319457163-15889-1-git-send-email-lars@metafoo.de> <4EA5521D.90403@cam.ac.uk> <4EA5533E.40703@metafoo.de>
In-Reply-To: <4EA5533E.40703@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/11 12:59, Lars-Peter Clausen wrote:
> On 10/24/2011 01:55 PM, Jonathan Cameron wrote:
>> On 10/24/11 12:52, Lars-Peter Clausen wrote:
>>> Make sure that the userspace buffer is large enough to hold a iio_event_data
>>> struct before writing to it.
>>>
>> Good catch.  Shall I tack this on the end of the two fixes sets I sent earlier?
> 
> Fine with me. Thanks.
> 
Cool, both this and the iio_utils.h one are in the github master branch now
(I'll rebase the others in a sec).  I switched to Signed-off-by as they are
passing through my hands.  Thanks for these.

Jonathan.
