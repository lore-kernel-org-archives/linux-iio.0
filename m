Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-42.csi.cam.ac.uk ([131.111.8.142]:57579 "EHLO
	ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757857Ab3BZQO4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Feb 2013 11:14:56 -0500
Message-ID: <512CDF7A.4050806@jic23.retrosnub.co.uk>
Date: Tue, 26 Feb 2013 16:14:50 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org, fengguang.wu@intel.com
Subject: Re: STMicroelectronics st_sensors fixed warning messages
References: <1361875426-5626-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1361875426-5626-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/02/13 10:43, Denis CIOCCA wrote:
> Hi Jonathan,
>
> as reported by Fengguang Wu, I send to you the patch to fix the warning messages.
> Thanks,
>
> Denis
>
>
IIRC this is a false positive warning?

I'll take the patch either way, but if it's a false positive
I'll queue it for the next cycle rather than send it on as
a fix for this one.
