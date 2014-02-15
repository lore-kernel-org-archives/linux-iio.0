Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43072 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbaBOJrN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Feb 2014 04:47:13 -0500
Message-ID: <52FF37C2.5030600@kernel.org>
Date: Sat, 15 Feb 2014 09:47:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Denis CIOCCA <denis.ciocca@st.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] iio:accel: call devm_iio_device_free function if
 common_proble fails
References: <1392391005-2719-1-git-send-email-denis.ciocca@st.com> <1392391005-2719-2-git-send-email-denis.ciocca@st.com> <52FE404B.3050307@metafoo.de>
In-Reply-To: <52FE404B.3050307@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/02/14 16:11, Lars-Peter Clausen wrote:
> On 02/14/2014 04:16 PM, Denis CIOCCA wrote:
>> If st_accel_common_probe function fails, the device must be freed.
>> Added devm_iio_device_free also on common_remove function.
>
> When the device is allocated with devm_iio_device... you do not need to manually free the device. If probe fails the device will be freed automatically.
>
> - Lars
Indeed - the handling in these drivers appears entirely correct.
The allocs are done with devm so under any error conditions or
deliberate removal they will be cleared up.

The register should not be done using devm as that would mean the
unregister would occur late.  As the register is done last, there
are no error conditions that can require it being removed in the
probe function.  Hence the code looks fine to me as it stands.

So Denis, do you have an observed problem that prompted these patches?

Jonathan
