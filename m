Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36746 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab3CBQiy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:38:54 -0500
Message-ID: <51322B1C.7070500@kernel.org>
Date: Sat, 02 Mar 2013 16:38:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"fengguang.wu@intel.com" <fengguang.wu@intel.com>
Subject: Re: STMicroelectronics st_sensors fixed warning messages
References: <1361875426-5626-1-git-send-email-denis.ciocca@st.com> <512CDF7A.4050806@jic23.retrosnub.co.uk> <512CE081.4080501@st.com>
In-Reply-To: <512CE081.4080501@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/26/2013 04:19 PM, Denis CIOCCA wrote:
>> IIRC this is a false positive warning?
> Yeah, only false positive warning.
> 
> 
>> I'll take the patch either way, but if it's a false positive
>> I'll queue it for the next cycle rather than send it on as
>> a fix for this one.
>>
> Thanks,
Being a contrary type (and because its early in the cycle and we
have a whole load of fixes going anyway) I've applied to this to
fixes-togreg rather than waiting for the next cycle ;)

> 
> Denis--
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
