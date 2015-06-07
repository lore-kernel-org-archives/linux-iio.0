Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47996 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbbFGQ7X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 12:59:23 -0400
Message-ID: <55747869.8030803@kernel.org>
Date: Sun, 07 Jun 2015 17:59:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>,
	Daniel Baluta <daniel.baluta@gmail.com>
CC: Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2 v2] iio: st_accel: support 8bit channel data
References: <1432042622-26703-1-git-send-email-linus.walleij@linaro.org> <55606596.5050804@kernel.org> <CACRpkdYGcin2Y=dJ=-4_ozONwEJwqrLcpcxQfhj1Bi+RxY+3BQ@mail.gmail.com> <AD0852EA-9390-4EC9-A46B-F9FA18CD72D3@st.com> <CAEnQRZALbKufXCq3VD04LxNXRsu47NxW-frWFwSq2ZbBaMByxQ@mail.gmail.com> <32F6C877-9D5C-41A5-A2A3-CE5BAB7381A9@st.com>
In-Reply-To: <32F6C877-9D5C-41A5-A2A3-CE5BAB7381A9@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/06/15 08:27, Denis CIOCCA wrote:
> Hi Daniel,
> 
> Yes I know, I'm just using mobile phone...:)...not so easy to write.
> 
> Acked-by: Denis Ciocca <denis.ciocca@st.com>
> 
> Denis
I know the feeling!  

Anyhow, applied to the togreg branch of iio.git - pushed out as testing
for the autobuilders to try breaking it.

Thanks,

Jonathan
> 
> 
> 
>> On Jun 4, 2015, at 15:24, Daniel Baluta <daniel.baluta@gmail.com> wrote:
>>
>>> On Thu, Jun 4, 2015 at 10:14 AM, Denis CIOCCA <denis.ciocca@st.com> wrote:
>>> Sorry I checked but forget to answer...for me it is ok!
>>>
>>> Acked.
>>>
>>> Denis
>>
>> Hi Denis,
>>
>> A formal Ack for a Linux kernel patch should be as follows:
>>
>> Acked-by: Your Name <youremail@address.com>
>>
>> thanks,
>> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

