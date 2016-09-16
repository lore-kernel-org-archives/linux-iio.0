Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39376 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935708AbcIPPDR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Sep 2016 11:03:17 -0400
Subject: Re: question about IIO buffer interface
To: Jonathan Cameron <jic23@kernel.org>
References: <e388b0fd-85a9-16d6-5ec9-28021f5a5f64@st.com>
 <1033a3e3-51e3-a962-15d5-a7002795033b@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lorenzo BIANCONI <lorenzo.bianconi@st.com>,
        Denis CIOCCA <denis.ciocca@st.com>
From: Armando Visconti <armando.visconti@st.com>
Message-ID: <19a0921b-bc70-bfaa-cbe7-97cf3e37faa5@st.com>
Date: Fri, 16 Sep 2016 17:03:10 +0200
MIME-Version: 1.0
In-Reply-To: <1033a3e3-51e3-a962-15d5-a7002795033b@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan,

Thx for the very long explanation.


>
> Anyhow, the philosophy was:
>
> preenable -> stuff related to getting ready for buffered operation.
> This might be as simple as turning off something else that prevents
> buffered operation. Often this is simply not provided as there
> is nothing useful to be done.
>
> update_scan_mode -> get the scan mode set up right for all the buffers
> being feed by the iio_push_to_buffers calls.
>
> postenable -> Actually start the flow of data now all the flags are
> lined up to say we are enabled.  So in a typical triggered-buffer
> case call iio_trigger_attach_poll_func
>

Usually our drivers use prenable() for starting the data flow
and postdisable() to stop it.

Do you think it is a mistake?
Or acceptable?

>
> For the disable side:
> predisable unwinds postenable and postdisable typically unwinds
> preenable.
>

Yes, that's clear.

Regards,
Arm
