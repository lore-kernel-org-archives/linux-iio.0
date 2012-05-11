Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:43485 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab2EKMcA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 08:32:00 -0400
Message-ID: <4FAD06BC.7020905@cam.ac.uk>
Date: Fri, 11 May 2012 13:31:56 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] iio: frequency: New driver for Analog Devices ADF4350/ADF4351
 Wideband Synthesizers
References: <1336398556-5360-1-git-send-email-michael.hennerich@analog.com> <4FA932D9.5010006@cam.ac.uk> <4FA93D00.2070906@analog.com> <4FABB647.3090200@kernel.org> <4FACC2B2.9000601@analog.com> <4FACC306.8000504@cam.ac.uk> <4FACC37E.20900@cam.ac.uk> <4FACF459.3020800@analog.com>
In-Reply-To: <4FACF459.3020800@analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/11/2012 12:13 PM, Michael Hennerich wrote:
> On 05/11/2012 09:45 AM, Jonathan Cameron wrote:
>> On 5/11/2012 8:43 AM, Jonathan Cameron wrote:
>>> On 5/11/2012 8:41 AM, Michael Hennerich wrote:
>>>> On 05/10/2012 02:36 PM, Jonathan Cameron wrote:
>>>>> On 5/8/2012 4:34 PM, Michael Hennerich wrote:
>>>>>> On 05/08/2012 04:51 PM, Jonathan Cameron wrote:
>>>>>>> On 5/7/2012 2:49 PM, michael.hennerich@analog.com wrote:
>>>>>>>> From: Michael Hennerich<michael.hennerich@analog.com>
>>>>>>>>
>>>>>>>>
>>>>>>>> +
>>>>>>>> +static const struct iio_chan_spec_ext_info adf4350_ext_info[] = {
>>>>>>>> + /* Ideally we use IIO_CHAN_INFO_FREQUENCY, but there are
>>>>>>>> + * values> 2^32 in order to support the entire frequency range
>>>>>>>> + * in Hz. Using scale is a bit ugly.
>>>>>>>> + */
>>>>>>> hmm.. Add IIO_VAL_MEGA_PLUS_INT.. We were always going to need a
>>>>>>> bigger
>>>>>>> version at somepoint...
>>>>>> Well - we then need an s64, however read|write_raw feature s32 for
>>>>>> val and val2. So shall we pass low word in val and high word in val2?
>>>>> I was thinking
>>>>> val*1e6 + val2 would fit with what we have done elsewhere? Is that
>>>>> enough room?
>>>> Hi Jonathan,
>>>>
>>>> IIO_VAL_MEGA_PLUS_INT versus IIO_VAL_LONG_LONG
>>>>
>>>> It is enough room. But I wonder why we would do costly divide and
>>>> modulus operations, when we can do sifts and ANDs? Splitting a s64
>>>> would
>>>> give is the maximum available room with very little overhead.
>>> human readability. I'm anti breaking that if we can possibly avoid it.
>> That an consistency with the others. There it makes sense because of
>> breaking round the decimal point.
> Hi Jonathan,
>
> Ideally I leave the driver as is.
Leave it for now. Lets revisit this in the future...
>
> If we really want the keep consistency, I would need to make integer
> type s64, that will add a lot of unnecessary overhead.
Agreed.  Might need it for other reasons at somepoint, but we put
a fair bit of effort into avoiding this in the first place, so would
be nice not to have to add it now!
>
>
>>>> Thoughts?
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>
>

