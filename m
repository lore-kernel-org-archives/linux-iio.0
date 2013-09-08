Return-Path: <sachin.kamat@linaro.org>
MIME-Version: 1.0
In-Reply-To: <522B93BB.6030703@kernel.org>
References: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org>
	<1378373397-22919-2-git-send-email-sachin.kamat@linaro.org>
	<522B93BB.6030703@kernel.org>
Date: Sun, 8 Sep 2013 18:44:36 +0530
Message-ID: <CAK9yfHwd3AcppOhF7OT81R3pOUNwpYZt1U1DW+=tggzx=oU7Xw@mail.gmail.com>
Subject: Re: [PATCH 02/12] staging: iio: tsl2583: Use devm_iio_device_alloc
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	"J. August Brenner" <jbrenner@taosinc.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On 8 September 2013 02:29, Jonathan Cameron <jic23@kernel.org> wrote:
> On 09/05/13 10:29, Sachin Kamat wrote:
>> devm_iio_device_alloc makes the code simple. While at it also
>> fixed an uninitialized return with -EINVAL.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: J. August Brenner <jbrenner@taosinc.com>
> Applied to the togreg branch of iio.git.  Jon mentioned he was very
> busy so I won't wait for his feedback on this.  Ideally this would have
> been two patches, the fix and the devm stuff on top of that so that
> we could push the fix into stable if anyone cares.  Here it is obscure
> enough I doubt anyone ever will so never mind.

I can probably still do that. Create a patch just to fix this on top
of your fixes branch which can go into
3.12-rc and below. But you may have to resolve a conflict (I believe
this one might give) when you merge
it with your togreg branch. Let me know your opinion in any case.

>
> Applied to the togreg branch of iio.git

Thanks for applying this and all others :)
-- 
With warm regards,
Sachin
