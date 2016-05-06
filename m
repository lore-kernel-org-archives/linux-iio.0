Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33797 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758126AbcEFMLT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 6 May 2016 08:11:19 -0400
Received: by mail-ob0-f182.google.com with SMTP id dm5so50673122obc.1
        for <linux-iio@vger.kernel.org>; Fri, 06 May 2016 05:11:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8cfaa99f-f46e-722a-a96f-9e465f6d9558@intel.com>
References: <1462524763-24566-1-git-send-email-linus.walleij@linaro.org>
	<8cfaa99f-f46e-722a-a96f-9e465f6d9558@intel.com>
Date: Fri, 6 May 2016 14:11:18 +0200
Message-ID: <CACRpkdZ=P6G_6yrP7BnPL=Wep7RoGpoVWvL6E=af0e5Fkt00=w@mail.gmail.com>
Subject: Re: [PATCH v2] iio: st_sensors: switch to a threaded interrupt
From: Linus Walleij <linus.walleij@linaro.org>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, May 6, 2016 at 1:32 PM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:
> On 05/06/2016 11:52 AM, Linus Walleij wrote:
>> commit 98ad8b41f58dff6b30713d7f09ae3834b8df7ded
>> ("iio: st_sensors: verify interrupt event to status") caused
>> a regression when reading ST sensors from a HRTimer trigger
>> rather than the intrinsic interrupts: the HRTimer may
>> trigger faster than the sensor provides new values, and
>> as the check against new values available as a cause of
>> the interrupt trigger was done in the poll function,
>> this would bail out of the HRTimer interrupt with
>> IRQ_NONE.
>>
>> So clearly we need to only check the new values available
>> from the proper interrupt handler and not from the poll
>> function, which should rather just read the raw values
>> from the registers, put them into the buffer and be happy.
>>
>> ---
>> ChangeLog v1->v2:
>> - v1 was missing timestamps since nothing ever stamped them.
>>   Restore the timestamps by simply using
>>   iio_trigger_generic_data_rdy_poll()
>>   as the top half of the threaded interrupt handler.
>
> iio_trigger_generic_data_rdy_poll always returns IRQ_HANDLED. This means
> that the threaded handler is never called.
>
> I think the correct solution would be to call the buffer's hardirq
> handler from the trigger's hardirq and the buffer's threaded handler
> from the trigger's threaded handler, right? I don't know how to do this
> properly with iio. Having "iio_poll_func" create an irq is very strange.

Yeah checkout my v3 of the patch, hope it clears up.

>>               /*
>>                * If this was not caused by any channels on this sensor,
>>                * return IRQ_NONE
>>                */
>> +             if (!indio_dev->active_scan_mask)
>> +                     return IRQ_NONE;
>
> This seems odd. I'm not sure it's even possible for active_scan_mask to
> be NULL, maybe you wanted to check if the mask is all-zero instead? Can
> this really happen?

Yes it happened to me, in the short time between installing the interrupt
handler and registering the sensor there can be a spurious interrupt
(because of static on the line or whatever).

> And if you're going to do such a check you should do it before reading
> the status anyway to avoid the pointless read. It's worth minimizing bus
> operations.

It's fixed in the add-on patch that looks for extra incoming samples,
check out the combo of the two patches I sent, I think together they
make for a pretty elegant solution.

Yours,
Linus Walleij
