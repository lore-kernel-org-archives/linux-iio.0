Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42769 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbbFUJuO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 05:50:14 -0400
Message-ID: <558688D3.9000101@kernel.org>
Date: Sun, 21 Jun 2015 10:50:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Tan Nguyen <tan.nqd@gmail.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio/accel: fixed 1 coding style problem
References: <1434771832-13305-1-git-send-email-tan.nqd@gmail.com> <CAEnQRZBFp48M8Q_kBKh_rqCdE_6Dci3NeuxLtHSX1aiKMAikaQ@mail.gmail.com>
In-Reply-To: <CAEnQRZBFp48M8Q_kBKh_rqCdE_6Dci3NeuxLtHSX1aiKMAikaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/06/15 10:47, Daniel Baluta wrote:
> On Sat, Jun 20, 2015 at 6:43 AM, Tan Nguyen <tan.nqd@gmail.com> wrote:
>> Break line to fix "line over 80 characters" style problem.
>>
>> Signed-off-by: Tan Nguyen <tan.nqd@gmail.com>
> 
> Hi Tan,
> 
> The code looks better as it is. I am not in favor of this change.
> 
> Daniel.
Agreed.  Tan, always take the 80 character limit as a soft restriction.
You need to look at the result and decide if it helps or hurts readability.
Here it is not clear either way so we'll leave it as it currently is.

Thanks

Jonathan

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
