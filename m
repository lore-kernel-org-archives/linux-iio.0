Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53516 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbbJMFof (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2015 01:44:35 -0400
In-Reply-To: <CAEnQRZDanmW90PifFcsTWLEzFNBUK25vDbcR9_iYVCJh3w4FYA@mail.gmail.com>
References: <33d5396ef3a2c8ebe9a076a611bda60f9a1ae1e0.1444396827.git.cristina.opriceana@gmail.com> <561A63EE.5040206@kernel.org> <CAEnQRZDanmW90PifFcsTWLEzFNBUK25vDbcR9_iYVCJh3w4FYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: Move IIO Dummy Driver out of staging
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 13 Oct 2015 06:44:08 +0100
To: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: Cristina Opriceana <cristina.opriceana@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <2696972F-5414-4DD5-AA66-08254496633D@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 12 October 2015 18:59:57 BST, Daniel Baluta <daniel.baluta@intel.com> wrote:
><snip>
>
>>> +static unsigned instances = 1;
>>> +module_param(instances, uint, 0);
>
>One concern about this. We will still create a default number of
>'instances'
>when using configuration via configfs?
>
>I'm not sure we can remove this parameter once the module is moved
>out of staging, since we break the ABI (?)
I'm not that bothered about ABI breakage on this one. Not going to break anything
real after all!

>
>The rest looks good to me. I'm pretty sure that moving this out of
>staging
>will make the module more visible and people will jump with
>enhancements.
>
>
>thanks,
>Daniel
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
