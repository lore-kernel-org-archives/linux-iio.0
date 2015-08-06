Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46825 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156AbbHFQkG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Aug 2015 12:40:06 -0400
In-Reply-To: <CACRpkdauLeQbVpOiN3G6dttRKrhV4yyu_K-how-hHHXjSQN9dA@mail.gmail.com>
References: <1438766895-15824-1-git-send-email-linus.walleij@linaro.org> <9F97DF0A-7CD3-4A1B-8B41-9B060A080F47@jic23.retrosnub.co.uk> <CACRpkdauLeQbVpOiN3G6dttRKrhV4yyu_K-how-hHHXjSQN9dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: st_common: use standard trigger suffix
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 06 Aug 2015 17:39:42 +0100
To: Linus Walleij <linus.walleij@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis Ciocca <denis.ciocca@st.com>
Message-ID: <CE60A24A-92B5-44AB-B326-3A03261023E4@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 6 August 2015 16:03:56 BST, Linus Walleij <linus.walleij@linaro.org> wrote:
>On Wed, Aug 5, 2015 at 10:15 PM, Jonathan Cameron
><jic23@jic23.retrosnub.co.uk> wrote:
>> On 5 August 2015 10:28:15 BST, Linus Walleij
><linus.walleij@linaro.org> wrote:
>>>
>>>The triggers from ST sensors are named <iio_device_name>-trigger
>>>instead of the standard <iio_device_name>-dev<iio_dev_id> as
>>>used by most and also in the iio-tools. Change this to match
>>>the norm.
>>>
>>>After this I can do tests with generic_buffer -n <dev_name>
>>>without having to manually specify the trigger with the -t
>>>option.
>>
>> Hmm ABI change... Not a requirement that this naming be followed...
>
>Unless someone can provide a userspace that actually have the
>ST sensors working (with mainline) I think we can make this change.
>
>I've really struggled to get generic_buffer going with the ST sensors
>to no avail. Right now it seems to be because the *_en files in
>/scan_elements are not ever written with "1" so consequently
>iio_buffer_store_enable
>__iio_update_buffers
>iio_buffer_request_update
>iio_buffer_update_bytes_per_datum
>
>Doesn't happen and bytes per datum is zero and it bails out.
>
>I don't know if it's a problem with generic_buffer though, is there
>another userspace that everyone is using without telling me?
Documentation problem rather than anything else. Those need setting manually
prior to run as adding a configurable interface to enable them in generic buffer
 is way too fiddly.
>
>> Could register the trigger twice I suppose so as to keep old name
>available....
>
>Hm there are a couple of more actually using -trigger if there is a
>single one.
>
>Maybe we should have generic_buffer looking for both rather, or
>do you want to keep that tool simple?
No objection to the little bit of extra code that would need.
>
>Yours,
>Linus Walleij

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
