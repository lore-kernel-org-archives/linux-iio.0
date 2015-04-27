Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58163 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932705AbbD0Ogf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Apr 2015 10:36:35 -0400
Message-ID: <553E4949.5040100@ti.com>
Date: Mon, 27 Apr 2015 09:35:53 -0500
From: Dan Murphy <dmurphy@ti.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: heart_monitors: Add support for heart rate monitors
References: <1429720331-1900-1-git-send-email-dmurphy@ti.com> <1429720331-1900-2-git-send-email-dmurphy@ti.com> <553D2073.9020803@kernel.org>
In-Reply-To: <553D2073.9020803@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jpnathan

Thanks for the review

On 04/26/2015 12:29 PM, Jonathan Cameron wrote:
> On 22/04/15 17:32, Dan Murphy wrote:
>> Add a type for heart rate monitors
>> Add the modifier name in beats per minute.
> I know it seems illogical for heart rate monitors, but to keep our unit sane
> as we get more frequency measuring devices could we change this to units
> of beats per second?

Old commit message.  I removed the modifier so that statement will be removed.


Dan

-- 
------------------
Dan Murphy

