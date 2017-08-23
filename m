Return-Path: <SRS0=Q0PN=7Z=gmail.com=harinath922@kernel.org>
Subject: Re: [PATCH v4] iio: accel: mma8452: improvements to handle multiple
 events
To: Martin Kepplinger <martink@posteo.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, amsfield22@gmail.com,
 linux-iio-owner@vger.kernel.org
References: <1503245215-12150-1-git-send-email-harinath922@gmail.com>
 <b5ba8c62743486649f99625d7a43e42b@posteo.de>
From: Harinath Nampally <harinath922@gmail.com>
Message-ID: <99ef70c3-64f0-66eb-5c1a-45a034ead5d5@gmail.com>
Date: Tue, 22 Aug 2017 20:29:52 -0400
MIME-Version: 1.0
In-Reply-To: <b5ba8c62743486649f99625d7a43e42b@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

>
> If rising: use transient OR ff_mt device-dependent like before. But 
> now save it in a simple flag,
> whether transient registers are available.
Ok, is it good idea to add the flag to struct mma_chip_info like below?

   * @mma_scales:                        scale factors for converting 
register values
   *                             to m/s^2; 3 modes: 2g, 4g, 8g; 2 integers
   *                             per mode: m/s^2 and micro m/s^2
+ * @transient_supported:       flag indicating whether chip support 
transient
+ *                             event, as not all chips support 
transient event
   */
  struct mma_chip_info {
         u8 chip_id;
         const struct iio_chan_spec *channels;
         int num_channels;
         const int mma_scales[3][2];
+       bool transient_supported;
  };

>
> If falling: switch to ff_mt in any case. (fixing freefall for the 
> transient-devices) 
ok sure.

Thanks,

Hari

On 08/21/2017 04:47 AM, Martin Kepplinger wrote:
>
> If rising: use transient OR ff_mt device-dependent like before. But 
> now save it in a simple flag,
> whether transient registers are available.
>
> If falling: switch to ff_mt in any case. (fixing freefall for the 
> transient-devices) 
