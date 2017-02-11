Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45151 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932097AbdBKKXa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 05:23:30 -0500
Subject: Re: [PATCH v1 0/2] iio: Add parent_trigger attribute to triggers
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <1486390912-24362-1-git-send-email-benjamin.gaignard@st.com>
 <ea85bd0e-90c5-ca08-172f-91d48e35f369@metafoo.de>
 <CA+M3ks5DzaXwmnnoin9kVUtV+sX5wXiiDz54=c541Huggi4a-Q@mail.gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d6bc74a2-9899-5f33-f04e-66da6209daf9@kernel.org>
Date: Sat, 11 Feb 2017 10:23:27 +0000
MIME-Version: 1.0
In-Reply-To: <CA+M3ks5DzaXwmnnoin9kVUtV+sX5wXiiDz54=c541Huggi4a-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/02/17 14:43, Benjamin Gaignard wrote:
> 2017-02-06 15:26 GMT+01:00 Lars-Peter Clausen <lars@metafoo.de>:
>> On 02/06/2017 03:21 PM, Benjamin Gaignard wrote:
>>> Thoses patches add parent_trigger attribute to IIO triggers.
>>> The goal is to allow triggers to use triggers like is this done for iio
>>> devices.
>>> With this patch it will be possible to chain triggers, for example
>>> stm32 triggers could be used as clock of an other triggers:
>>> echo "tim1_trgo" > trigger0/parent_trigger.
>>
>> Can you explain how this is different to assigning the parent_trigger
>> directly to the device?
>>
> 
> It is the same but done on trigger structure without need to have an iio device.
> 
> While writing stm32 trigger driver Jonathan explain me that I can't use an iio
> device without channel to chain my hardware blocks.
> Since my hardware allows to chain triggers, Jonathan suggest to create this
> parent_trigger attribute to ab able to link the triggers.
> 
I think Lars was looking for the more general explanation.  How does
one trigger drive another one?  What does that mean?


