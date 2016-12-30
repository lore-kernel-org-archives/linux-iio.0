Return-Path: <SRS0=KNs1=YN=i2se.com=stefan.wahren@kernel.org>
Date: Fri, 30 Dec 2016 21:16:14 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org,
	ldv-project@linuxtesting.org, linux-iio@vger.kernel.org
Message-ID: <918653344.138229.1483128974311@email.1und1.de>
In-Reply-To: <104b932a-86b3-1ef0-29d2-d27eade1f97d@kernel.org>
References: <1482531319-26935-1-git-send-email-khoroshilov@ispras.ru>
 <1600801097.88831.1482789844722@email.1und1.de>
 <104b932a-86b3-1ef0-29d2-d27eade1f97d@kernel.org>
Subject: Re: [PATCH] iio: mxs-lradc: fix error handling in mxs_lradc_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

> Jonathan Cameron <jic23@kernel.org> hat am 30. Dezember 2016 um 20:09 geschrieben:
> 
> 
> On 26/12/16 22:04, Stefan Wahren wrote:
> > 
> >> Alexey Khoroshilov <khoroshilov@ispras.ru> hat am 23. Dezember 2016 um 23:15 geschrieben:
> >>
> >>
> >> During transition to using devm_input_allocate_device()
> >> goto to resource deallocation block was replaced by return
> >> in case of error in iio_device_register().
> >> That is wrong since resources are left undeallocated.
> >>
> >> Found by Linux Driver Verification project (linuxtesting.org).
> >>
> >> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> >> Fixes: 962ed43a3eac ("iio: mxs-lradc: remove mxs_lradc_ts_unregister")
> > 
> > Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> > 
> > But since Ksenija's patch series [1] (which doesn't have this issue) this patch is only relevant for stable.
> It's slightly doubtful as stable material as well unless it causes
> a crash. Obviously failing to clean up isn't good, but its not critical
> enough to justify the churn. 
> 
> Good find though.
> 
> Should you wish to post it to stable and let the stable maintainers make
> a decision feel free to do so.

No, i don't have any plans for that.

> 
> Jonathan
> > 
> > Thanks
> > 
> > [1] - http://marc.info/?l=linux-iio&m=148131774219426&w=2
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
>
