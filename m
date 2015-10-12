Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36631 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbbJLR77 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Oct 2015 13:59:59 -0400
MIME-Version: 1.0
In-Reply-To: <561A63EE.5040206@kernel.org>
References: <33d5396ef3a2c8ebe9a076a611bda60f9a1ae1e0.1444396827.git.cristina.opriceana@gmail.com>
	<561A63EE.5040206@kernel.org>
Date: Mon, 12 Oct 2015 20:59:57 +0300
Message-ID: <CAEnQRZDanmW90PifFcsTWLEzFNBUK25vDbcR9_iYVCJh3w4FYA@mail.gmail.com>
Subject: Re: [PATCH] iio: Move IIO Dummy Driver out of staging
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Cristina Opriceana <cristina.opriceana@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

<snip>

>> +static unsigned instances = 1;
>> +module_param(instances, uint, 0);

One concern about this. We will still create a default number of 'instances'
when using configuration via configfs?

I'm not sure we can remove this parameter once the module is moved
out of staging, since we break the ABI (?)

The rest looks good to me. I'm pretty sure that moving this out of staging
will make the module more visible and people will jump with enhancements.


thanks,
Daniel
