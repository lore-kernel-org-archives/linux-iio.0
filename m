Return-Path: <SRS0=+jZ6=2B=wanadoo.fr=christophe.jaillet@kernel.org>
Subject: Re: [PATCH] iio: adc: xilinx: Fix error handling
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 michal.simek@xilinx.com, soren.brinkmann@xilinx.com
References: <20170219202928.20296-1-christophe.jaillet@wanadoo.fr>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <63f3a01d-4b78-f069-5aa1-c7f703b4e78e@wanadoo.fr>
Date: Mon, 20 Feb 2017 21:25:58 +0100
MIME-Version: 1.0
In-Reply-To: <20170219202928.20296-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Le 20/02/2017 à 09:35, Lars-Peter Clausen a écrit :
> On 02/19/2017 09:29 PM, Christophe JAILLET wrote:
>> Reorder error handling labels in order to match the way resources have
>> been allocated.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
> Thanks, looks good.
>
> Acked-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
>
> I think there is one more issue
>
>      ret = xadc->ops->setup(pdev, indio_dev, irq);
>      if (ret)
>          goto err_free_samplerate_trigger;
>
> should be
>
> 	goto err_clk_disable_unprepare;
>
I agree.

Would you like me to send a V2 with both fixes or a sepparate patch?

CJ
