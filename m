Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37456 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbbBYU7I (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Feb 2015 15:59:08 -0500
Message-ID: <54EE3796.9010306@kernel.org>
Date: Wed, 25 Feb 2015 20:59:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: bogdan.m.davidoaia@intel.com, antonel.g.dobre@intel.com,
	alin.g.arhip@intel.com, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Linux IIO test framework
References: <CAEnQRZAwv-=aHWDgN1S+V3O6nzu9801GHvZyXNGMvxMGrKG5bA@mail.gmail.com>
In-Reply-To: <CAEnQRZAwv-=aHWDgN1S+V3O6nzu9801GHvZyXNGMvxMGrKG5bA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/02/15 13:38, Daniel Baluta wrote:
> Hello,
> 
> We are analyzing the possibility of writing a Linux IIO test framework.
cool
> 
> First, we need to know if there is already any work done in this
> area. Didn't find anything on the Internet :).
Not that I know of, but if anyone is going to have such tests (or
know of them) my guess is Lars...
> 
> Second, do you think that this would bring any benefit to the Linux kernel
> IIO subsystem?
Definitely has potential.  Do you have some examples of particular tests
in mind?
> 
> We would like to keep the tests in kernel tree under (tools/testing/selftests)
> and I'm not yet sure if we can make use of libiio [1].
Sounds sensible to me.
> 
> Because we are now gathering requirements for this, any feedback would
> be more than welcomed.
> 
> thanks,
> Daniel.
> 
> [1] https://github.com/analogdevicesinc/libiio
> 

