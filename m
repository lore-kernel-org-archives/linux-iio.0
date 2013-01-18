Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:33984 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab3ARKny (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 Jan 2013 05:43:54 -0500
Message-ID: <50F92764.30508@jic23.retrosnub.co.uk>
Date: Fri, 18 Jan 2013 10:43:48 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: STMicroelectronics drivers bugfix
References: <1358501475-5797-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1358501475-5797-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/01/13 09:31, Denis CIOCCA wrote:
> Hi Lars, Jonathan,
>
> I review the driver code in accordance with Lars's review. What do you think about kconfig?
Looking quickly at the library code, the kconfig is fine, but I'd expect
the i2c and spi bits to be built into the main module if they are 
present.  Right now unless I am reading it wrong they'll get built even 
if the main module isn't.

For the drivers, the make file can be a simpler and easy to follow if we
put back some the Kconfig symbols you had before but just have them 
hidden. Basically it moves all the logic into Kconfig and means the
resulting .config is easy to follow.

To my mind that would be a little simpler.


> I have yet to share some part of driver code in the library!
>
> Denis
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

