Return-Path: <sachin.kamat@linaro.org>
MIME-Version: 1.0
In-Reply-To: <51FD41D2.7000405@kernel.org>
References: <1375438128-23219-1-git-send-email-sachin.kamat@linaro.org>
	<1375438128-23219-2-git-send-email-sachin.kamat@linaro.org>
	<51FD41D2.7000405@kernel.org>
Date: Mon, 5 Aug 2013 11:49:09 +0530
Message-ID: <CAK9yfHw9G2q-xHhjiV4u_AODsVG_JCiLsndCWRtDdafiEJ_uxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: magnetometer: st_magn: Use devm_iio_device_alloc
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, jic23@cam.ac.uk, denis.ciocca@st.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On 3 August 2013 23:15, Jonathan Cameron <jic23@kernel.org> wrote:
> On 08/02/13 11:08, Sachin Kamat wrote:
>> Using devm_iio_device_alloc makes code simpler.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Denis Ciocca <denis.ciocca@st.com>
> Applied to the togreg branch of iio.git
>
> Thanks for getting all of these done.
>
> Whilst this sort of change is kind of simple, the reduction in
> complexity makes my life as maintainer easier in the long
> run so I am very much in favour!
>
> Also getting rid of all cases like you are doing means
> that best practice is obvious to anyone writing new drivers.
>

Thanks for your words of encouragement. I appreciate it.
Converting to devm_* APIs is definitely a useful change as it makes
the code simpler and error handling safer and cleaner.
Thanks to all the people involved in implementing and merging iio
specific devm APIs.
I will continue to convert all the remaining drivers of iio to use devm APIs.

-- 
With warm regards,
Sachin
