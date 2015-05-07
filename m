Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1431039561.2450.14.camel@spandruv-DESK3.jf.intel.com>
Subject: Re: [PATCH v2] iio: light: hid-sensor-prox: Fix memory leak in
 probe()/remove()
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Jonathan Cameron
	 <jic23@kernel.org>, LinuxTesting Org <khoroshilov@ispras.ru>,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org
Date: Thu, 07 May 2015 15:59:21 -0700
In-Reply-To: <CAOMZO5CaMMNXcG5qKrU10wZRrowGhUPon9oXJ2HXWtO-izMF7A@mail.gmail.com>
References: <1431007798-20807-1-git-send-email-fabio.estevam@freescale.com>
	 <1431035479.2450.9.camel@spandruv-DESK3.jf.intel.com>
	 <CAOMZO5DQCeXVRCT2bz=pGFk-kdyxiyydX6jYkL_9NX9tx9j-rQ@mail.gmail.com>
	 <CAOMZO5CaMMNXcG5qKrU10wZRrowGhUPon9oXJ2HXWtO-izMF7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2015-05-07 at 19:26 -0300, Fabio Estevam wrote:
> On Thu, May 7, 2015 at 7:15 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Thu, May 7, 2015 at 6:51 PM, Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> >> On Thu, 2015-05-07 at 11:09 -0300, Fabio Estevam wrote:
> >>> 'channels' is allocated via kmemdup, so we need to free it after its usage.
> >>>
> >>> This way we fix the memory leak in both probe and remove paths.
> >>>
> >>> Also, as 'indio_dev' is allocated via devm_iio_device_alloc(), so there is
> >>> no need to call kfree for it.
> >> Where is the kfree for indio_dev..?
> >
> > It is kfree(indio_dev->channels) actually.
> >
> >>>
> >>> Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> >>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >>> ---
> >>> Changes since v1:
> >>> - Always call kfree(channel) after its usage.
> >>>
> >>>  drivers/iio/light/hid-sensor-prox.c | 14 ++++++--------
> >>>  1 file changed, 6 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> >>> index 91ecc46..00ce0f6 100644
> >>> --- a/drivers/iio/light/hid-sensor-prox.c
> >>> +++ b/drivers/iio/light/hid-sensor-prox.c
> >>> @@ -278,16 +278,17 @@ static int hid_prox_probe(struct platform_device *pdev)
> >>>               return -ENOMEM;
> >>>       }
> >>>
> >>> +     indio_dev->channels = channels;
> >>> +
> >>>       ret = prox_parse_report(pdev, hsdev, channels,
> >>>                               HID_USAGE_SENSOR_PROX, prox_state);
> >>> +     kfree(channels);iio_dev
> >> You are freeing channels so indio_dev->channels will point to junk.
> >> This will be passed to iio_device_register..
> >
> > No, I am freeing channels, not indio_dev->channels.
> 
> Ops, I see the issue.
> 
> I think it is better if we go with the v1 instead.
What is v1?
