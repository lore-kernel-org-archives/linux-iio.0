Return-Path: <bigeasy@linutronix.de>
Date: Tue, 14 Jul 2015 16:28:46 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xander Huff <xander.huff@ni.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org, joe.hershberger@ni.com,
	joshc@ni.com, nathan.sullivan@ni.com, jaeden.amero@ni.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Push interrupts into threaded
 context
Message-ID: <20150714142846.GB21820@linutronix.de>
References: <5574633F.7090004@kernel.org>
 <1436391502-2604-1-git-send-email-xander.huff@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1436391502-2604-1-git-send-email-xander.huff@ni.com>
List-ID: <linux-iio@vger.kernel.org>

* Xander Huff | 2015-07-08 16:38:22 [-0500]:

> drivers/iio/adc/xilinx-xadc-core.c | 35 ++++++++++++-----------------------
> 1 file changed, 12 insertions(+), 23 deletions(-)
>
>diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
>index ce93bd8..b309ad3 100644
>--- a/drivers/iio/adc/xilinx-xadc-core.c
>+++ b/drivers/iio/adc/xilinx-xadc-core.c
>@@ -1225,7 +1214,7 @@ static int xadc_probe(struct platform_device *pdev)
> 	if (ret)
> 		goto err_free_samplerate_trigger;
> 
>-	ret = request_threaded_irq(irq, xadc->ops->interrupt_handler,
>+	ret = request_threaded_irq(irq, 0,

NULL not 0
Other than that, it looks good. Thanks.
If you managed to get this merged upstream then feel free to ping me and
I pick this into -RT.

> 				xadc->ops->threaded_interrupt_handler,
> 				0, dev_name(&pdev->dev), indio_dev);
> 	if (ret)

Sebastian
