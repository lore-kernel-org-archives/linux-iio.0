Return-Path: <sachin.kamat@linaro.org>
MIME-Version: 1.0
In-Reply-To: <838c737b-62a6-453c-bd4d-644ee3b07eb4@email.android.com>
References: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org>
	<838c737b-62a6-453c-bd4d-644ee3b07eb4@email.android.com>
Date: Tue, 24 Sep 2013 20:22:19 +0530
Message-ID: <CAK9yfHwTwxafiM9VhjaP1v1nKjYwF_Afp_sC95NZOUgSX7gveA@mail.gmail.com>
Subject: Re: [PATCH 0/8] iio: Introduce devm_iio_device_{register,unregister}
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 24 September 2013 18:43, Jonathan Cameron <jic23@kernel.org> wrote:
>
>
> Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>With the conversion of iio drivers to use device managed APIs, most of
>>the
>>drivers now have a remove function with only the
>>iio_device_unregister()
>>call.
> I am not sure this is a good idea if there is anything else in those functions. The unregister is responsible for marking the device as going away so until it has happened all interfaces should still work.

This will be done in only those drivers whose remove function contains
nothing other than the unregister call thereby removing it altogether
or where unregister happens to be the last operation in remove.

> In at least two of this small set that is not the case...

I had added these 2 purposefully to get your feedback as I wasn't
fully sure if disabling regulator would cause any ordering related
issues.

-- 
With warm regards,
Sachin
