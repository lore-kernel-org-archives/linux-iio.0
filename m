Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37931 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab3IHNcg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Sep 2013 09:32:36 -0400
Message-ID: <522C8A8C.1020206@kernel.org>
Date: Sun, 08 Sep 2013 15:32:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	"J. August Brenner" <jbrenner@taosinc.com>
Subject: Re: [PATCH 02/12] staging: iio: tsl2583: Use devm_iio_device_alloc
References: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org> <1378373397-22919-2-git-send-email-sachin.kamat@linaro.org> <522B93BB.6030703@kernel.org> <CAK9yfHwd3AcppOhF7OT81R3pOUNwpYZt1U1DW+=tggzx=oU7Xw@mail.gmail.com>
In-Reply-To: <CAK9yfHwd3AcppOhF7OT81R3pOUNwpYZt1U1DW+=tggzx=oU7Xw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/08/13 14:14, Sachin Kamat wrote:
> Hi Jonathan,
> 
> On 8 September 2013 02:29, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 09/05/13 10:29, Sachin Kamat wrote:
>>> devm_iio_device_alloc makes the code simple. While at it also
>>> fixed an uninitialized return with -EINVAL.
>>>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>> Cc: J. August Brenner <jbrenner@taosinc.com>
>> Applied to the togreg branch of iio.git.  Jon mentioned he was very
>> busy so I won't wait for his feedback on this.  Ideally this would have
>> been two patches, the fix and the devm stuff on top of that so that
>> we could push the fix into stable if anyone cares.  Here it is obscure
>> enough I doubt anyone ever will so never mind.
> 
> I can probably still do that. Create a patch just to fix this on top
> of your fixes branch which can go into
> 3.12-rc and below. But you may have to resolve a conflict (I believe
> this one might give) when you merge
> it with your togreg branch. Let me know your opinion in any case.
Don't worry about it.  It is pretty obscure and we don't know if anyone
has ever actually hit it!
> 
>>
>> Applied to the togreg branch of iio.git
> 
> Thanks for applying this and all others :)
> 
