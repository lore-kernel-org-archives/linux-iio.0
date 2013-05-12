Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-232.synserver.de ([212.40.185.232]:1032 "EHLO
	smtp-out-231.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754569Ab3ELQh7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 12 May 2013 12:37:59 -0400
Message-ID: <518FC54B.3090009@metafoo.de>
Date: Sun, 12 May 2013 18:37:31 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] staging:iio:triggers:interrupt trigger - one per
 platform device.
References: <1367860863-6863-1-git-send-email-jic23@kernel.org> <1367860863-6863-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1367860863-6863-4-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

[...]
>  
> @@ -39,57 +36,48 @@ static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
>  static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>  {
>  	struct iio_interrupt_trigger_info *trig_info;
> -	struct iio_trigger *trig, *trig2;
> +	struct iio_trigger *trig;
>  	unsigned long irqflags;
>  	struct resource *irq_res;
>  	int irq, ret = 0, irq_res_cnt = 0;
>  [...]
> +	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, irq_res_cnt);

irq_res_cnt is always zero.

> [...]
