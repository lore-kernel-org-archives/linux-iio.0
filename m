Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:58996 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757215Ab1F0JUm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2011 05:20:42 -0400
Message-ID: <4E084D4E.9060100@cam.ac.uk>
Date: Mon, 27 Jun 2011 10:28:46 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: ManuelStahl <manuel.stahl@iis.fraunhofer.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Dummy device driver
References: <4E084A4E.2020704@iis.fraunhofer.de>
In-Reply-To: <4E084A4E.2020704@iis.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/27/11 10:15, ManuelStahl wrote:
> Hi Jonathan,
> 
> as we have so many changes happening right now, I feel the need for something like a reference driver. One that uses the most recent IIO functions as they are intended.
> This should be a dummy device that does not talk to real hardware, so we can use it on common x86 platforms.
> 
> What do you think?
Excellent idea.

I have a somewhat rubbish version I use for interface testing, but that's very ugly
(and changes from day to day ;)  Not to mention, I can't remember which of my random
branches it is actually in!  Hence you are probably better off starting from scratch.

Big advantage of dummy drivers is also that we can propose any changes with examples
based on that, so everyone can see how they will work. 

The slightly annoying bit with dummy drivers is we can't test the fast path for triggers
(i.e. any with a top half). That's not a great problem though and some of our triggers
(e.g. the user space trigger) can't trigger top halves anyway!

Jonathan
