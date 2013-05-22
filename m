Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39124 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756729Ab3EVV3f (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 17:29:35 -0400
Message-ID: <519D38BD.2080604@kernel.org>
Date: Wed, 22 May 2013 22:29:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org,
	Jonathan Cameron
	<public-jic23-DgEjT+Ai2ygdnm+yROfE0A@plane.gmane.org>,
	"linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org"
	<public-linux-iio-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org>,
	"lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org"
	<public-lars-Qo5EllUWu/uELgA04lAiVw@plane.gmane.org>,
	"j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org"
	<public-j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@plane.gmane.org>
Subject: Re: [PATCH 3/3] iio:pressure: Add STMicroelectronics pressures driver
References: <1368607493-4843-1-git-send-email-denis.ciocca@st.com> <1368607493-4843-4-git-send-email-denis.ciocca@st.com> <5197ED56.7000405@kernel.org> <4675748.2RFENMIBLW@ctocwl0124> <5199F14A.5040309@samsung.com> <519D3858.8070306@kernel.org>
In-Reply-To: <519D3858.8070306@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/22/2013 10:27 PM, Jonathan Cameron wrote:
> On 05/20/2013 10:47 AM, Jacek Anaszewski wrote:
>> On 05/20/2013 09:51 AM, Denis CIOCCA wrote:
>>> Hi Jonathan,
>>>
>>>> Now going forward I'd of course like to see everyone happy with the
>>>> resulting driver.  Denis do you have plans to implement the threshold
>>>> events that were in the other driver proposal?
>>> Now I'm very full but in the future I have plans to support the threshold
>>> events, I'm very happy if Jacek will help me! ;)
>>
>> Hi Jonathan, Denis,
>>
>> The threshold events weren't supported in my driver proposal - the events were related only to the 'data ready'
>> interrupts. I've been
>> playing with threshold interrupts during development, but I didn't
>> find the device reliable by minimal threshold levels.
> Oops, I missed that you were 'abusing' these entirely in review.
> 
>> I've lately
>> devised a procedure of testing greater pressure differences and
>> I will test it within few weeks, as currently I am working on
>> another driver.
> Given the driver simplicity (as it's adding to the existing drivers that
> are well tested) I'm going to assume it works fine for now
> and merge it based on review.  Do shout if it doesn't of course
> or if you have any improvements to suggest.
Actually no I'm not. I'd completely forgotten that I wasn't happy with some of
the patches during review.  Over to Denis to post a new version or convince
me the review comments were wrong ;)
> 
> I'd definitely like to see full event support for the threshold interrupts
> in these parts (which will be needed to finally kill off the my lis3l02dq
> driver :)  Been trying to get rid of that one for years.).
> 
> Jonathan
>>
>> Thanks,
>> Jacek
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
