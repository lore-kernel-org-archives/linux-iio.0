Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38273 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbbKKPDg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Nov 2015 10:03:36 -0500
Received: by wmec201 with SMTP id c201so50403110wme.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2015 07:03:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <564357D5.6030304@st.com>
References: <1447249974-27442-1-git-send-email-giuseppe.barba@st.com>
	<1447249974-27442-2-git-send-email-giuseppe.barba@st.com>
	<CAEnQRZDaZTzVCfVmBgU_u5s+2MBVnXUrGKE8VCzA17JsJW9Jrw@mail.gmail.com>
	<564357D5.6030304@st.com>
Date: Wed, 11 Nov 2015 17:03:34 +0200
Message-ID: <CAEnQRZBP50FPFMoewvsdcA7KA2QQg7zW2k5NFyJcbyyDT_LUzQ@mail.gmail.com>
Subject: Re: [V2] iio: st-accel: add support for lis2dh12
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Giuseppe BARBA <giuseppe.barba@st.com>
Cc: Denis CIOCCA <denis.ciocca@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 11, 2015 at 4:59 PM, Giuseppe BARBA <giuseppe.barba@st.com> wrote:
> Hi Daniel,
>
> thank you for the review.
>
> On 11/11/2015 15:45, Daniel Baluta wrote:
>> On Wed, Nov 11, 2015 at 3:52 PM, Giuseppe Barba <giuseppe.barba@st.com> wrote:
>>> This commit add support for STMicroelectronics lis2dh12 accelerometer.
>>
>> Link to datasheet?
>
> The datasheet link is:
>
> http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/DM00091513.pdf

Care to send v3 with the commit message updated with the link to datasheet?
>
>>
>> The subject should start with [PATCH v2] ...
>>
>>>
>>> Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
>>> ---
>>
>> Here you should add a short changelog with what you changed since v1.
>
> Yes I can do that if needed but it is just a typo on
> LIS2DH12_ACCEL_DEV_NAME macro where I've used a minus instead of
> underscore char.

Usually, it's easier for reviewers to check your patch having
the change log even if there is a minor change like yours.

thanks,
Daniel.
