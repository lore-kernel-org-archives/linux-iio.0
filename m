Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3145 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264AbaJOHbA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 15 Oct 2014 03:31:00 -0400
Message-ID: <543E2435.8090704@intel.com>
Date: Wed, 15 Oct 2014 10:37:25 +0300
From: Daniel Baluta <daniel.baluta@intel.com>
MIME-Version: 1.0
To: Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org
CC: jic23@kernel.org, laurentiu.palcu@intel.com
Subject: Re: RFC Introducing Heart Monitors for IIO
References: <1413314032-923-1-git-send-email-dmurphy@ti.com>
In-Reply-To: <1413314032-923-1-git-send-email-dmurphy@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 10/14/2014 10:13 PM, Dan Murphy wrote:
> All
>
> I am introducing a new sensor category for IIO.  This is for
> heart rate monitors.
>
> Putting this out as a RFC to see if anyone else is developing the
> same and we can build upon each others patches.
>
> I have another sensor to follow up on this series but don't want
> to start that driver until I understand if there is anyone else
> doing the same.
>
> The first patch introduces the heart rate monitoring into the IIO
> sub-systems
>
> The second patch introduces the DT documentation heart_monitors directory
> along with the documentation for the TI AFE4403 part.
>
> The final patch introduces the heart_monitors directory along with the source
> for the TI AFE4403 device

We are happy to see this! What is your second sensor?

Daniel.


