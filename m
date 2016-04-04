Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:60671 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434AbcDDNXF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 4 Apr 2016 09:23:05 -0400
Message-ID: <57026B0B.1020003@parrot.com>
Date: Mon, 4 Apr 2016 15:24:27 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: ak8975: Fix NULL pointer exception on early interrupt
References: <1459749299-6745-1-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1459749299-6745-1-git-send-email-k.kozlowski@samsung.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/04/2016 07:54 AM, Krzysztof Kozlowski wrote:
> In certain probe conditions the interrupt came right after registering
> the handler causing a NULL pointer exception because of uninitialized
> waitqueue:
>
> $ udevadm trigger
> i2c-gpio i2c-gpio-1: using pins 143 (SDA) and 144 (SCL)
> i2c-gpio i2c-gpio-3: using pins 53 (SDA) and 52 (SCL)
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = e8b38000
> [00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in: snd_soc_i2s(+) i2c_gpio(+) snd_soc_idma snd_soc_s3c_dma snd_soc_core snd_pcm_dmaengine snd_pcm snd_timer snd soundcore ac97_bus spi_s3c64xx pwm_samsung dwc2 exynos_adc phy_exynos_usb2 exynosdrm exynos_rng rng_core rtc_s3c
> CPU: 0 PID: 717 Comm: data-provider-m Not tainted 4.6.0-rc1-next-20160401-00011-g1b8d87473b9e-dirty #101
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> (...)
> (__wake_up_common) from [<c0379624>] (__wake_up+0x38/0x4c)
> (__wake_up) from [<c0a41d30>] (ak8975_irq_handler+0x28/0x30)
> (ak8975_irq_handler) from [<c0386720>] (handle_irq_event_percpu+0x88/0x140)
> (handle_irq_event_percpu) from [<c038681c>] (handle_irq_event+0x44/0x68)
> (handle_irq_event) from [<c0389c40>] (handle_edge_irq+0xf0/0x19c)
> (handle_edge_irq) from [<c0385e04>] (generic_handle_irq+0x24/0x34)
> (generic_handle_irq) from [<c05ee360>] (exynos_eint_gpio_irq+0x50/0x68)
> (exynos_eint_gpio_irq) from [<c0386720>] (handle_irq_event_percpu+0x88/0x140)
> (handle_irq_event_percpu) from [<c038681c>] (handle_irq_event+0x44/0x68)
> (handle_irq_event) from [<c0389a70>] (handle_fasteoi_irq+0xb4/0x194)
> (handle_fasteoi_irq) from [<c0385e04>] (generic_handle_irq+0x24/0x34)
> (generic_handle_irq) from [<c03860b4>] (__handle_domain_irq+0x5c/0xb4)
> (__handle_domain_irq) from [<c0301774>] (gic_handle_irq+0x54/0x94)
> (gic_handle_irq) from [<c030c910>] (__irq_usr+0x50/0x80)
>
> The bug was reproduced on exynos4412-trats2 (with a max77693 device also
> using i2c-gpio) after building max77693 as a module.
I confirm I've just reproduced this onto raspberry pi 2 / bcm2836 with 
custom
add-on daughter board. Same fix.


> Cc:<stable@vger.kernel.org>
> Fixes: 94a6d5cf7caa ("iio:ak8975 Implement data ready interrupt handling")
> Signed-off-by: Krzysztof Kozlowski<k.kozlowski@samsung.com>
> ---
>   drivers/iio/magnetometer/ak8975.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 9c5c9ef3f1da..3b23a850c930 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -462,6 +462,8 @@ static int ak8975_setup_irq(struct ak8975_data *data)
>   	int rc;
>   	int irq;
>   
> +	init_waitqueue_head(&data->data_ready_queue);
> +	clear_bit(0, &data->flags);
>   	if (client->irq)
>   		irq = client->irq;
>   	else
> @@ -477,8 +479,6 @@ static int ak8975_setup_irq(struct ak8975_data *data)
>   		return rc;
>   	}
>   
> -	init_waitqueue_head(&data->data_ready_queue);
> -	clear_bit(0, &data->flags);
>   	data->eoc_irq = irq;
>   
>   	return rc;

