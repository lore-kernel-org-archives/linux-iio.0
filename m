Return-Path: <Hector.Palacios@digi.com>
Message-ID: <51D68572.3050705@digi.com>
Date: Fri, 5 Jul 2013 10:36:02 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Otavio Salvador <otavio@ossystems.com.br>, Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>, "fabio.estevam@freescale.com"
	<fabio.estevam@freescale.com>
Subject: Re: [PATCH V2] iio: mxs-lradc: Remove useless check in read_raw
References: <1372886714-25456-1-git-send-email-marex@denx.de> <CAP9ODKq2y6Ttm2gQc+LxJZi1hrYh2E8dQRW2_zsi4dd=xzsi1g@mail.gmail.com>
In-Reply-To: <CAP9ODKq2y6Ttm2gQc+LxJZi1hrYh2E8dQRW2_zsi4dd=xzsi1g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/04/2013 10:22 PM, Otavio Salvador wrote:
> On Wed, Jul 3, 2013 at 6:25 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
>> The removed check in the read_raw implementation was always true,
>> therefore remove it. This also fixes a bug, by closely inspecting
>> the code, one can notice the iio_validate_scan_mask_onehot() will
>> always return 1 and therefore the subsequent condition will always
>> succeed, therefore making the mxs_lradc_read_raw() function always
>> return -EINVAL; .
>>
>> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
>> Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>
> Tested-by: Otavio Salvador <otavio-fKevB0iiKLMBZ+LybsDmbA@public.gmane.org>

Acked-by: Hector Palacios <hector.palacios@digi.com>


Best regards,
--
Hector Palacios
