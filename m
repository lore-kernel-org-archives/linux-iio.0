Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49552 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754606AbcIRKyh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 06:54:37 -0400
Subject: Re: question about IIO buffer interface
To: Armando Visconti <armando.visconti@st.com>
References: <e388b0fd-85a9-16d6-5ec9-28021f5a5f64@st.com>
 <1033a3e3-51e3-a962-15d5-a7002795033b@kernel.org>
 <19a0921b-bc70-bfaa-cbe7-97cf3e37faa5@st.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>,
        Denis CIOCCA <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c1c5978a-af55-e0ef-01ae-8df8b313c49d@kernel.org>
Date: Sun, 18 Sep 2016 11:54:35 +0100
MIME-Version: 1.0
In-Reply-To: <19a0921b-bc70-bfaa-cbe7-97cf3e37faa5@st.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/09/16 16:03, Armando Visconti wrote:
> Hello Jonathan,
> 
> Thx for the very long explanation.
> 
> 
>>
>> Anyhow, the philosophy was:
>>
>> preenable -> stuff related to getting ready for buffered operation.
>> This might be as simple as turning off something else that prevents
>> buffered operation. Often this is simply not provided as there
>> is nothing useful to be done.
>>
>> update_scan_mode -> get the scan mode set up right for all the buffers
>> being feed by the iio_push_to_buffers calls.
>>
>> postenable -> Actually start the flow of data now all the flags are
>> lined up to say we are enabled.  So in a typical triggered-buffer
>> case call iio_trigger_attach_poll_func
>>
> 
> Usually our drivers use prenable() for starting the data flow
> and postdisable() to stop it.
> 
> Do you think it is a mistake?
> Or acceptable?
If you don't have a reason to use the update_scan_mode callback
then it doesn't really matter. Conceptually I'd do it postenable and
predisable, but I'm not that fussed!

Jonathan
> 
>>
>> For the disable side:
>> predisable unwinds postenable and postdisable typically unwinds
>> preenable.
>>
> 
> Yes, that's clear.
> 
> Regards,
> Arm
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

