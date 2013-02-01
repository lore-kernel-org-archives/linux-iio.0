Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:58876 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756946Ab3BAQkT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Feb 2013 11:40:19 -0500
Message-ID: <510BEFEF.2050800@jic23.retrosnub.co.uk>
Date: Fri, 01 Feb 2013 16:40:15 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>,
	Denis Ciocca <denis.ciocca@gmail.com>
Subject: Re: [RFC] Driver for lis331dlh
References: <1359719147-30231-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <510BAEE6.2060600@metafoo.de> <510BAFF4.5070605@jic23.retrosnub.co.uk> <1844577.EAlljCMzkH@elitebook-8460p>
In-Reply-To: <1844577.EAlljCMzkH@elitebook-8460p>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/02/13 12:35, Denis CIOCCA wrote:
> Hi all,
>
> On 01/02/13 11:45, Manuel Stahl wrote:
>> This patch adds support for the ST microsystems lis331dlh. The lis331dlh is
> a three-axis accelerometer with 16-bit ADC. It has an I2C and SPI interface.
>
> STMicroelectronics :D
>
> the support for lis331dlh is already available in accel driver as Lars and
> Jonathan says.
>
>> Guess the answer to my question is nothing at all needs adding then.
>> Sorry, didn't think to check if it was already there.
>> Denis is looking into supporting the lis3l02dq so we can kill that
>> driver off and just have to handle the driver in misc.  For that
>> we need to have a detailed discussion on their interfaces and how
>> we maintain them going forward (what fun).
>
> I have not started to look it. But I think it is possible to integrate all
> sensors in the same driver.
>
> Jonathan, Lars, what about last patch for code reduction in the library? I
> think it's possible merge it in the library commit...
> http://www.spinics.net/lists/linux-iio/msg07648.html
I'll do that one separately.  It's a nice little tidy up but not
important and the original code is equally correct if a little more
long winded.

Will probably deal with it tomorrow.
>
>
> Thanks,
>
> Denis--
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

