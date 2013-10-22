Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:42838 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab3JVGza convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Oct 2013 02:55:30 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so6207159oag.17
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2013 23:55:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <524AEEFC.8010201@gmail.com>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
	<1380299538-22047-12-git-send-email-l.czerwinski@samsung.com>
	<524AF86D.7010200@kernel.org>
	<524AEEFC.8010201@gmail.com>
Date: Tue, 22 Oct 2013 07:55:29 +0100
Message-ID: <CAF2Aj3iZT5J=UQNFahZy2Vngst8mfxGDoV7B0Q6gQNsq2Xg-aw@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 11/14] Documentation: Add st_magn binding documentation
From: Lee Jones <lee.jones@linaro.org>
To: Rob Herring <robherring2@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lukasz Czerwinski <l.czerwinski@samsung.com>, jic23@cam.ac.uk,
	Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ian.campbell@citrix.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 1 October 2013 16:49, Rob Herring <robherring2@gmail.com> wrote:
> On 10/01/2013 11:29 AM, Jonathan Cameron wrote:
>> On 09/27/13 17:32, Lukasz Czerwinski wrote:
>>> This patch adds the document for STMicroeletronics Magnetic Sensors driver under
>>> Documentation/devicetree/bindings/iio/.
>>>
>>> Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> ---
>>
>> So right now we have two different approaches to documenting these bindings.  Lee
>> proposed doing it on a per device name, here you are proposing a single file
>> per type.
>>
>> What is the prefered approach?
>>
>> Lee/Lukasz why would you two favour one way or the other?
>>
>> Device tree maintainers, which is preferred?
>
> If the only difference is compatible string, then I think one doc is
> fine and preferred by me.

I have no strong feelings either way.

-- 
Lee Jones
Linaro ST Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
