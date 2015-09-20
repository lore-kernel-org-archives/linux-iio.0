Return-Path: <jic23@kernel.org>
Subject: Re: [PATCH] iio: st_common: use standard trigger suffix
To: Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
References: <1438766895-15824-1-git-send-email-linus.walleij@linaro.org>
 <9F97DF0A-7CD3-4A1B-8B41-9B060A080F47@jic23.retrosnub.co.uk>
 <CACRpkdauLeQbVpOiN3G6dttRKrhV4yyu_K-how-hHHXjSQN9dA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55FE914A.1090908@kernel.org>
Date: Sun, 20 Sep 2015 11:58:18 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdauLeQbVpOiN3G6dttRKrhV4yyu_K-how-hHHXjSQN9dA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 06/08/15 16:03, Linus Walleij wrote:
> On Wed, Aug 5, 2015 at 10:15 PM, Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
>> On 5 August 2015 10:28:15 BST, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>
>>> The triggers from ST sensors are named <iio_device_name>-trigger
>>> instead of the standard <iio_device_name>-dev<iio_dev_id> as
>>> used by most and also in the iio-tools. Change this to match
>>> the norm.
>>>
>>> After this I can do tests with generic_buffer -n <dev_name>
>>> without having to manually specify the trigger with the -t
>>> option.
>>
>> Hmm ABI change... Not a requirement that this naming be followed...
> 
> Unless someone can provide a userspace that actually have the
> ST sensors working (with mainline) I think we can make this change.
> 
> I've really struggled to get generic_buffer going with the ST sensors
> to no avail. Right now it seems to be because the *_en files in
> /scan_elements are not ever written with "1" so consequently
> iio_buffer_store_enable
> __iio_update_buffers
> iio_buffer_request_update
> iio_buffer_update_bytes_per_datum
> 
> Doesn't happen and bytes per datum is zero and it bails out.
> 
> I don't know if it's a problem with generic_buffer though, is there
> another userspace that everyone is using without telling me?
> 
>> Could register the trigger twice I suppose so as to keep old name available....
> 
> Hm there are a couple of more actually using -trigger if there is a
> single one.
> 
> Maybe we should have generic_buffer looking for both rather, or
> do you want to keep that tool simple?
> 
sorry Linus, I completely failed to come back to you on this.
I'd have no problem with generic-buffer looking for both as long
as the code is commented to say the 'unusual' one is not
the preferred choice and is for legacy parts.

I guess we also need some documentation to specify preferred naming
of triggers.  As Lars pointed out the various libraries out there
tend to deal with these cases anyway (often by navigating the sysfs
tree to find associated triggers provided by a given device).

Jonathan
